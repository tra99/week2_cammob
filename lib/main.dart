import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:test_week2/pages/login_screen.dart';
import 'package:test_week2/providers/response_data_provider.dart';

Future<void> main()async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>ResponseProvider()..fetchResponse())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
            errorStyle: TextStyle(color: Colors.black),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home:   const LoginScreen(),
        // home:   HomeScreen(),
      ),
    );
  }
}