import 'package:flutter/material.dart';
import 'package:machinetest/controller/life_controller.dart';
import 'package:machinetest/ui/elevator_main.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => LiftController()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Elevator Demo',
      home: Elevator(),
    );
  }
}
