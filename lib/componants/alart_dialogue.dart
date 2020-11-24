import 'package:flutter/material.dart';

void showErrorDialog({BuildContext context, String title, Exception e}) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          style: TextStyle(fontSize: 24),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text(
                '${(e as dynamic).message}',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
        actions: [
          styledButton(
            child: Text(
              'OK',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}

//Styled button

Widget styledButton({Widget child, Function onPressed}) => OutlinedButton(
    style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.red)),
    onPressed: onPressed,
    child: child);
