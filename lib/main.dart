import 'package:flutter/material.dart';
import 'package:movieapp/pages/home_page.dart';

import 'network/dataagents/retrofit_data_agent_impl.dart';

void main() {
  RetrofitDataAgentImpl().getNowPlayingMovies(1);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

