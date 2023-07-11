import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_app/model/data_model.dart';
import 'package:student_app/widgets/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Students List',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const Scaffold(
        body: ScreenSplash(),
      ),
    );
  }
}
