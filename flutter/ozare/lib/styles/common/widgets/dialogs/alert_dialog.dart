import 'package:flutter/material.dart';
import 'package:ozare/styles/common/common.dart';

Future<void> showAlertDialog({
  required BuildContext context,
  required String title,
  required String content,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(
          content,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'Okay',
              style: TextStyle(
                color: primary1Color,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
