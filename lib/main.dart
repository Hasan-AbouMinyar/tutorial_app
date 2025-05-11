import 'package:flutter/material.dart';

void main(){
  runApp(const NameManagerApp())
}

class NameManagerApp extends StatelessWidget {
  const NameManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "NAME MANAGER",
      theme: ThemeData(primaryColor: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

class _HomeScreen extends StatefulWidget {
  const _HomeScreen({super.key});

  @override
  State<_HomeScreen> createState() => __HomeScreenState();
}

class __HomeScreenState extends State<_HomeScreen> {

  
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}