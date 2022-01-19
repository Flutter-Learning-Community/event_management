import 'package:flutter/material.dart';

showAlertDialog(
    {required BuildContext context, String? title, required String content}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        var actions2 = [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Continue'),
            ),
          ),
        ];
        return AlertDialog(
          title: Text(title ?? ""),
          content: Text(content),
          actions: actions2,
        );
      });
}
