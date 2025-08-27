import 'package:flutter/material.dart';
import 'package:motives_android_conversion/widget/gradient_text.dart';

class TimeCardScreen extends StatefulWidget {
  const TimeCardScreen({super.key});

  @override
  State<TimeCardScreen> createState() => _TimeCardScreenState();
}

class _TimeCardScreenState extends State<TimeCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GradientText("Time Card", fontSize: 24),
        //centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
       
      ),
    );
  }
}