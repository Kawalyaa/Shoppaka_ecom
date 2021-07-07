import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Description extends StatelessWidget {
  static const String id = 'description';

  final List description;
  final List keyFeature;
  final String specs;
  Description({this.description, this.keyFeature, this.specs});
  @override
  Widget build(BuildContext context) {
    final Description args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Description',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 22.0,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black54),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Text(
            //   'Description',
            //   style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.bold),
            // ),
            // args.description.isEmpty
            //     ? Text('No data')
            //     : Card(
            //         child: Column(
            //           children: args.description,
            //         ),
            //       ),
            // SizedBox(
            //   height: 10.0,
            // ),
            // Text(
            //   'Key Features',
            //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.5),
            // ),
            // args.keyFeature.isEmpty
            //     ? Text('No data')
            //     : Card(
            //         child: Column(
            //           children: args.keyFeature,
            //         ),
            //       ),
            // SizedBox(
            //   height: 10.0,
            // ),
            // Text(
            //   'Specification',
            //   style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.bold),
            //
            //   //TODO web view
            // ),
            Container(
              height: 500,
              width: double.infinity,
              child: Column(
                children: [
                  Expanded(
                    child: WebView(
                      initialUrl:
                          'https://www.mi.com/global/product/mi-smart-band-6/overview',
                      javascriptMode: JavascriptMode.unrestricted,
                    ),
                  )
                  //'args.specs',
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
