import 'package:capgen/providers/gemini_api_provider.dart';
import 'package:capgen/screens/homescreen/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: GeminiAPIProvider(),
        ),
      ],
      child: ResponsiveApp(builder: (context) {
        return MaterialApp(
          title: 'CapGen',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: HomeScreen(),
        );
      }),
    );
  }
}
