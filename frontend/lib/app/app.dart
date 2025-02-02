import 'package:flutter/material.dart';

import '../screens/dashboard/dashboard_screen.dart';

class FlutterApp extends StatelessWidget {
  const FlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WK technology',
      home: const DashboardScreen(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
