import 'package:flutter/material.dart';

class LoadingAuth {
  void show(BuildContext context) {
    const Center(
      child: CircularProgressIndicator(),
    );
  }

  void hide() {
    return;
  }
}
