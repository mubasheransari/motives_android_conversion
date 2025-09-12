import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:motives_android_conversion/Bloc/global_bloc.dart';
import 'package:motives_android_conversion/Bloc/global_event.dart';
import 'package:motives_android_conversion/Features/dashboard_screen.dart';
import 'package:motives_android_conversion/widget/build_cell_widget.dart';
import 'package:motives_android_conversion/widget/gradient_text.dart';
import 'package:location/location.dart' as loc;

class TimeCardScreen extends StatefulWidget {
  const TimeCardScreen({super.key});

  @override
  State<TimeCardScreen> createState() => _TimeCardScreenState();
}

class _TimeCardScreenState extends State<TimeCardScreen> {
  @override
  Widget build(BuildContext context) {
    final loc.Location location = loc.Location();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: GradientText("Time Card", fontSize: 24),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Text(
              'Welcome! ${context.read<GlobalBloc>().state.loginModel!.userinfo!.userName.toString()}',style: TextStyle(color: Colors.black,fontSize: 16),
            ),
          ),
          SizedBox(height: 10),

          Center(child: GradientText("Day Start", fontSize: 20)),

          SizedBox(height: 10),

          Table(
            columnWidths: const {0: FlexColumnWidth(1), 1: FlexColumnWidth(1)},
            children: [
              TableRow(
                children: [
                  buildCell(Icons.person, "CheckIn-Time"),
                  buildCell(Icons.access_time, context.read<GlobalBloc>().state.loginModel!.log!.tim.toString() ?? "--"),
                ],
              ),
              TableRow(
                children: [
                  buildCell(Icons.calendar_month,  context.read<GlobalBloc>().state.loginModel!.log!.time.toString() ?? "--"),
                  buildCell(Icons.location_on, "Routes 0"),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
