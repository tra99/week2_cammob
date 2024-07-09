import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_week2/pages/register_screen.dart';
import 'package:test_week2/providers/province_provider.dart';

import 'tests/data_info_screen.dart';

void main() {
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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home:   RegisterScreen(),
        // home:   HomeScreen(),
      ),
    );
  }
}