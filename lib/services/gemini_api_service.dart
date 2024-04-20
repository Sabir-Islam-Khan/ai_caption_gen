import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiAPIService {
  static String vertexKey = "AIzaSyDqk6XOFA4YWlF9YGR54_w5eBB3dZQ7-LA";
  static final genModel = GenerativeModel(
    model: 'gemini-pro-vision',
    apiKey: vertexKey,
    safetySettings: [
      SafetySetting(
        HarmCategory.sexuallyExplicit,
        HarmBlockThreshold.none,
      ),
      SafetySetting(
        HarmCategory.hateSpeech,
        HarmBlockThreshold.none,
      ),
      SafetySetting(
        HarmCategory.harassment,
        HarmBlockThreshold.none,
      ),
      SafetySetting(
        HarmCategory.dangerousContent,
        HarmBlockThreshold.none,
      ),
    ],
  );

  static Future<String> generateCaption(
      Uint8List imageBytes, String tone, String language) async {
    log("language is $language");
    final prompt = TextPart("""
    You are a medical assistant bot.You know everything about human body and its chemistry. You are given the medical report of a patient. Analyize the report to check if everything is okay.
    Explain everything. What is the normal range, what the patient has. What they should do. What disease it can cause, how to control everything.
    Keep it short and precise. Dont do into too much details. People should understand it clearly. 
    """);
    final imageParts = [
      DataPart('image/jpeg', imageBytes),
    ];

    final response = await genModel.generateContent([
      Content.multi([prompt, ...imageParts])
    ]);

    log(response.text!);

    return response.text!;
  }
}
