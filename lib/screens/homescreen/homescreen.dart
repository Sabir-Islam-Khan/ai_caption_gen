import 'dart:io';

import 'package:capgen/providers/gemini_api_provider.dart';
import 'package:capgen/screens/resultscreen/resultsscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker picker = ImagePicker();
  XFile? pickedimage;
  String language = "english";
  @override
  void initState() {
    super.initState();
  }

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    GeminiAPIProvider geminiAPIProvider =
        Provider.of<GeminiAPIProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CapGen'),
        centerTitle: true,
      ),
      bottomNavigationBar: Container(
        height: 70,
        margin: const EdgeInsets.all(12.0),
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      side: BorderSide(color: Colors.deepPurple)))),
          onPressed: pickedimage == null
              ? null
              : () async {
                  var geminiProvider =
                      Provider.of<GeminiAPIProvider>(context, listen: false);
                  var imageBytes = await pickedimage!.readAsBytes();
                  geminiProvider.genCaption(
                      imageBytes, controller.value.text, language);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ResultsScreen()));
                },
          child: const Text("Generate Captions"),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.only(left: 12, right: 12),
        child: Column(
          children: [
            Card(
                child: Container(
                    height: 35.screenHeight,
                    padding: const EdgeInsets.all(12.0),
                    child: pickedimage == null
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.photo,
                                  size: 100,
                                  color: Colors.deepPurple,
                                ),
                                TextButton(
                                  onPressed: () async {
                                    pickedimage = await picker.pickImage(
                                        source: ImageSource.gallery);
                                    setState(() {});
                                  },
                                  child: Text(
                                    "Click here to select or capture a picture",
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Image.file(File(pickedimage!.path)))),
            Card(
                child: Container(
                    //height: 10.screenHeight,
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, top: 12),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            controller: controller,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Describe the tone of your caption",
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {},
                                child: const Text("See Prompts")),
                          )
                        ],
                      ),
                    ))),
            Card(
              child: Container(
                //height: 10.screenHeight,
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Select Language",
                        ),
                      ),
                      DropdownButton(
                          value: language,
                          items: [
                            const DropdownMenuItem(
                                value: "english", child: Text("English")),
                            const DropdownMenuItem(
                                value: "bengali", child: Text("Bengali"))
                          ],
                          onChanged: (item) {
                            setState(() {
                              language = item!;
                            });
                          })
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
          ],
        ),
      )),
    );
  }
}
