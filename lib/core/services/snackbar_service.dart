import 'package:flutter/material.dart';

class SnackBarService {
  static void showSnackBar({
    required BuildContext context,
    required String message,
    String? boldText,
  }) {
    final SnackBar snackBar = SnackBar(
      duration: const Duration(seconds: 5),
      content: RichText(
        textAlign: TextAlign.justify,
        text: TextSpan(children: <TextSpan>[
          TextSpan(
            text: '${boldText ?? ''} ',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: message,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ]),
      ),
      backgroundColor: Colors.brown,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
