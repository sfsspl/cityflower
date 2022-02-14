import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget circularProgressIndicator() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircularProgressIndicator(),
    ],
  );
}

void showSnackBarMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

void showToastMessage(BuildContext context, String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
  );
}

Future showProgressLoading(BuildContext context)async{
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          SizedBox(
            width: 10,
          ),
          Text('Please wait')
        ],
      ),
    ),
  );
}
