import 'package:capgen/providers/gemini_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GeminiAPIProvider geminiAPIProvider =
        Provider.of<GeminiAPIProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: geminiAPIProvider.isLoading
              ? [
                  Text("Generating Captions"),
                  Text(
                    "Please wait...",
                    style: TextStyle(fontSize: 12),
                  ),
                ]
              : [
                  Text("Captions Generated"),
                  Text(
                    "1 captions generated.",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
        ),
      ),
      body: Container(
          margin: EdgeInsets.all(12.0),
          child: geminiAPIProvider.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Container(
                        padding: EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(geminiAPIProvider.getResponse!,
                                style: TextStyle(fontSize: 20)),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton.icon(
                                  onPressed: () {},
                                  icon: Icon(Icons.copy),
                                  label: Text("Copy")),
                            )
                          ],
                        ),
                      ),
                    );
                  })),
    );
  }
}
