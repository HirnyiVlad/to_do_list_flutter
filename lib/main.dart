import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_flutter/pages/HomePage.dart';
import 'package:to_do_list_flutter/pages/MainViewModel.dart';

void main() {
  runApp(
    // const ToDoListApp()
      ChangeNotifierProvider(
        create: (BuildContext context) => MainViewModel(),
        child: const ToDoListApp(),
      ),
  );
}

class ToDoListApp extends StatelessWidget {
  const ToDoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDoListApp',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey
      ),
      home: HomePage(),
    );
  }
}

