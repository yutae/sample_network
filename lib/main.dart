import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(onPressed: _testPress1, child: const Text('Test press 1')),
        TextButton(onPressed: _testPress2, child: const Text('Test press 2')),
        TextButton(onPressed: _testPress3, child: const Text('Test press 3')),
        TextButton(onPressed: _testPress4, child: const Text('Test press 4')),
      ],
    )));
  }

  _testPress1() async {
    final url = Uri.parse('https://yle.fi');

    final response = await http.get(
      url,
    );

    print(response.body);
  }

  _testPress2() async {
    final url = Uri.parse('https://www.mtvuutiset.fi');

    final response = await http.get(
      url,
    );

    print(response.body);
  }

  void _testPress3() async {
    final dio = Dio()..httpClientAdapter = DefaultHttpClientAdapter();

    final response = await dio.get('https://yle.fi');

    print(response.data);
  }

  void _testPress4() async {
    final dio = Dio()..httpClientAdapter = DefaultHttpClientAdapter();

    final response = await dio.get('https://www.mtvuutiset.fi');

    print(response.data);
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
