import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

mixin MessageMixin<T extends StatefulWidget> on State<T> {
  void showInfo(String message) {
    _showSnackbar(
      CustomSnackBar.info(message: message),
    );
  }

  void showSuccess(String message) {
    _showSnackbar(
      CustomSnackBar.success(message: message),
    );
  }

  void showError(String message) {
    _showSnackbar(
      CustomSnackBar.error(message: message),
    );
  }

  void _showSnackbar(CustomSnackBar snackBar) {
    showTopSnackBar(
      Overlay.of(context),
      snackBar,
      displayDuration: const Duration(seconds: 5),
    );
  }
}
