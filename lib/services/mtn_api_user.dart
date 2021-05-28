import 'package:flutterwave/models/requests/authorization.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:ecommerce_app/model/mtn_api_key.dart';

class ApiUser {
  var uuid = Uuid().v4();
  var uuid2 = Uuid().v4();

  var apiKey;
  var jwToken;
  // ApiUser({this.uuid});import 'dart:io';

  createApiUser() async {
    var client = http.Client();
    //String uuid = Uuid().v4().toString();
    var url = Uri.parse('https://sandbox.momodeveloper.mtn.com/v1_0/apiuser');
    Map<String, String> header = {
      'X-Reference-Id': uuid,
      'Content-Type': 'application/json',
      'Ocp-Apim-Subscription-Key': '656267b77aa34e8dbb5d1f78db7941e3',
    };
    final msg = jsonEncode({
      "providerCallbackHost":
          "https://webhook.site/1d941b51-c918-422b-b111-a3ff4af0eb5a"
    });

    try {
      var response = await client.post(url, headers: header, body: msg);
      print(response.statusCode);
      // print(jsonDecode(response.body));
      print(response.contentLength);
      print(response.reasonPhrase);

      ///Get Api User Reference id
      var url2 =
          Uri.parse('https://sandbox.momodeveloper.mtn.com/v1_0/apiuser/$uuid');
      var header2 = {
        'Ocp-Apim-Subscription-Key': '656267b77aa34e8dbb5d1f78db7941e3',
      };
      var getRefId = await client.get(
        url2,
        headers: header2,
      );
      print('${getRefId.statusCode}**********');
      print('${jsonDecode(getRefId.body)}**************');
      print(getRefId.request.method);
      //print(getRefId.request);
      print(getRefId.reasonPhrase);
      print(getRefId.contentLength);
      // print(uuid);

      client.close();
    } catch (e) {
      print(e.toString());
    }
  }

  generateApiKey() async {
    var url = Uri.parse(
        'https://sandbox.momodeveloper.mtn.com/v1_0/apiuser/$uuid/apikey');
    var header = {
      'Ocp-Apim-Subscription-Key': '656267b77aa34e8dbb5d1f78db7941e3'
    };
    try {
      var response = await http.post(url, headers: header);
      // List keyList = [];
      //apiKey = response.body;
      print(response.statusCode);
      print(response.body);
      // keyList.add(response.body);
      //  print(keyList);
      if (response.statusCode == 201) {
        var key = JsonApiKey.fromJson(jsonDecode(response.body));
        apiKey = key.apiKey;
        print(apiKey.toString());
        print(key.apiKey);
      }
      print(response.contentLength);
    } catch (e) {
      print(e.toString());
    }
  }

  generateJwtToken() async {
    var apiUser = uuid;
    print('<<<<<<<<<<<>>>>>>>>$apiKey');
    var apiUserAndApiKey = apiUser + ':' + apiKey;
    //Providing apiUser as userName and apiKey as a password
    var encode = base64Encode(utf8.encode(apiUserAndApiKey));
    var header = {
      'Authorization': 'Basic' + encode,
      'Ocp-Apim-Subscription-Key': '656267b77aa34e8dbb5d1f78db7941e3'
    };

    var url =
        Uri.parse('https://sandbox.momodeveloper.mtn.com/collection/token/');

    try {
      var response = await http.post(url, headers: header);
      print('<<<<<<${response.body}>>>>>>>>>>>>>>');
    } catch (e) {
      print(e.toString());
    }
  }

  generateJwtToken2() async {
    var client = http.Client();

    //Api Key section
    var url = Uri.parse(
        'https://sandbox.momodeveloper.mtn.com/v1_0/apiuser/$uuid/apikey');
    var header = {
      'Ocp-Apim-Subscription-Key': '656267b77aa34e8dbb5d1f78db7941e3'
    };

    var response = await client.post(url, headers: header);
    var key = JsonApiKey.fromJson(jsonDecode(response.body));
    print(key.apiKey);

    //Jwt Token section
    //Providing apiUser as userName and apiKey as a password
    //then encode it to base64
    var apiUserAndApiKey = uuid + ':' + key.apiKey;
    var encode = base64Encode(utf8.encode(apiUserAndApiKey));
    var jwtHeader = {
      HttpHeaders.authorizationHeader: 'Basic ' + encode,
      'Ocp-Apim-Subscription-Key': '656267b77aa34e8dbb5d1f78db7941e3'
    };

    var jwtUrl =
        Uri.parse('https://sandbox.momodeveloper.mtn.com/collection/token/');

    var jwtResponse = await client.post(jwtUrl, headers: jwtHeader);
    print('<<<<<<${jwtResponse.body}>>>>>>>>>>>>>>');
    var accessToken = JwtKey.fromJson(jsonDecode(jwtResponse.body));
    print(accessToken.jwtKey);

    ///Request To Pay
    var payUrl = Uri.parse(
        'https://sandbox.momodeveloper.mtn.com/collection/v1_0/requesttopay');
    var payHeader = {
      HttpHeaders.authorizationHeader: 'Bearer ${accessToken.jwtKey}',
      "providerCallbackHost":
          "https://webhook.site/1d941b51-c918-422b-b111-a3ff4af0eb5a",
      'X-Reference-Id': uuid2,
      'X-Target-Environment': 'sandbox',
      'Content-Type': 'application/json',
      'Ocp-Apim-Subscription-Key': '656267b77aa34e8dbb5d1f78db7941e3'
    };

    var payBody = jsonEncode({
      "amount": "250",
      "currency": "EUR",
      "externalId": "112",
      "payer": {"partyIdType": "MSISDN", "partyId": "0780222251"},
      "payerMessage": "shopping",
      "payeeNote": "pay goods"
    });

    var payResponse =
        await client.post(payUrl, headers: payHeader, body: payBody);
    print(payResponse.statusCode);
    print('${payResponse.body}');

    client.close();

    return accessToken.jwtKey;
  }
}
