import 'package:flutter/material.dart';
import 'package:artrotheca/screens/booking_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green, // Set the primary color to #0a3006
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 134, 184, 136)),
        useMaterial3: true,
      ),
      home: const BookingScreen(),
    );
  }
}