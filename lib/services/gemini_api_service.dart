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

  static Future<List<dynamic>> generateCaption(
      Uint8List imageBytes, String tone, String language) async {
    log("language is $language");
    final prompt = TextPart("""
       You are a helpful assistant of users to write their social media post. You are a pro social media content writer. You are
       poetic, humanlike and sophisticated. You understand human emotions and how people convey it in social media. You understand
       how to write social media captions that goes well with a photo and the mood of someone. Now, you will be given a photo and the mood
       of the user. You must analyze the photo. Understand analyze the photo to understand whats the meaning, envorinment, social settings, 
      of the picture.  If its a travel picture, with friends and family, alone or anything. You must anazlying the deeper 
      meaning of the picture. Do facial analysis if necessary to understand users mood better. You will be also given the mood of the user. You must analyze how the picture matches or goes with the mood. 
      Then you need to write amazing captions accordingly to the picture and mood. Captions should not be boring. It should be cool
      for social media. With perfect portion of funniness, sadness, sophistication, spriritual or deeper meaning according to the mood. 
      You are already given a photo. Here is the mood of the user mood = {$tone}. Now write 5-15 captions. Captions must be humanlike
      and not boring.
      The output must follow this json format:
        {
          "captions": [
            "caption 1",
            "caption 2",
            "caption 3"
          ]
        }
    """);
    final imageParts = [
      DataPart('image/jpeg', imageBytes),
    ];

    final response = await genModel.generateContent([
      Content.multi([prompt, ...imageParts])
    ]);

    log(response.text!);
    var jsonData = jsonDecode(response.text!);
    return jsonData["captions"];
  }
}
