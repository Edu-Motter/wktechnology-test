import 'package:flutter/material.dart';

class UIHelper {
  static void showMessage(BuildContext context, {required String message}) {
    showSnackBar(
      context,
      text: message,
      icon: Icons.info_outline,
      iconColor: Colors.white,
    );
  }

  static void showSuccess(BuildContext context, {required String message}) {
    showSnackBar(
      context,
      text: message,
      icon: Icons.check_circle_outline,
      iconColor: Colors.green[300] ?? Colors.green,
    );
  }

  static void showError(BuildContext context, {required String message}) {
    showSnackBar(
      context,
      text: message,
      icon: Icons.error_outline,
      iconColor: Colors.red[300] ?? Colors.red,
    );
  }

  static void showSnackBar(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String text,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16.0),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        content: Row(
          children: [
            Icon(icon, color: iconColor),
            SizedBox(width: 8),
            Flexible(child: Text(text))
          ],
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}
