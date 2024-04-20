import 'dart:typed_data';

import 'package:capgen/services/gemini_api_service.dart';
import 'package:flutter/material.dart';

class GeminiAPIProvider extends ChangeNotifier {
  bool isLoading = false;
  String? response;

  void genCaption(Uint8List imageBytes, String tone, String language) async {
    isLoading = true;
    notifyListeners();

    response =
        await GeminiAPIService.generateCaption(imageBytes, tone, language);
    isLoading = false;
    notifyListeners();
  }

  String? get getResponse => response;
}
