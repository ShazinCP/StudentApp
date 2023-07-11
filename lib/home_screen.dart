import 'package:flutter/material.dart';
import 'functions/db_functions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return const SafeArea(
      child: Scaffold(),
    );
  }
}
