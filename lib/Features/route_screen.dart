import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:motives_android_conversion/Bloc/global_bloc.dart';
import 'package:motives_android_conversion/Bloc/global_event.dart';
import 'package:motives_android_conversion/widget/gradient_text.dart';
import 'package:location/location.dart' as loc;

class RouteScreen extends StatefulWidget {
  const RouteScreen({super.key});

  @override
  State<RouteScreen> createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  String buttonText = "Break";
  String? selectedBreak;
  final loc.Location location = loc.Location();

  void _showBreakPopup(BuildContext context) async {
    final currentLocation = await location.getLocation();
    final storage = GetStorage();
    if (buttonText == "Unbreak") {
      storage.write('break_status', 1);
      context.read<GlobalBloc>().add(
        StartRouteEvent(
          type: '1',
          userId: context
              .read<GlobalBloc>()
              .state
              .loginModel!
              .userinfo!
              .userId
              .toString(),
          lat: currentLocation.latitude.toString(),
          lng: currentLocation.longitude.toString(),
        ),
      );
      setState(() {
        buttonText = "Break";
        selectedBreak = null;
      });
      return;
    }

    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Break"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text("Namaz break"),
                onTap: () => Navigator.pop(context, "Namaz break"),
              ),
              ListTile(
                title: const Text("Lunch break"),
                onTap: () => Navigator.pop(context, "Lunch break"),
              ),
              ListTile(
                title: const Text("Other"),
                onTap: () => Navigator.pop(context, "Other"),
              ),
            ],
          ),
        );
      },
    );

    if (result != null) {
      context.read<GlobalBloc>().add(
        StartRouteEvent(
          type: '0',
          userId: context
              .read<GlobalBloc>()
              .state
              .loginModel!
              .userinfo!
              .userId
              .toString(),
          lat: currentLocation.latitude.toString(),
          lng: currentLocation.longitude.toString(),
        ),
      );
      storage.write('break_status', 0);

      setState(() {
        selectedBreak = result;
        buttonText = "Unbreak";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    var time = storage.read("checkin_time");
    var date = storage.read("checkin_date");
    var day = storage.read("checkin_day");
    var break_status = storage.read('break_status');
    var isLoggedIn = storage.read('isLoggedIn');

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: GradientText("Routes", fontSize: 24),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            child: Row(
              children: [
                Icon(Icons.person, size: 35, color: Colors.cyan),
                const SizedBox(width: 6),
                Flexible(
                  child: Text('PunchIn-Time ${context.read<GlobalBloc>().state.loginModel!.log!.time.toString()}', overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            child: Row(
              children: [
                Icon(Icons.access_time, size: 35, color: Colors.cyan),
                const SizedBox(width: 6),
                Flexible(
                  child: Text("$day, $date", overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.20,
            ),
            child: Center(
              child: Text(
                break_status == 1 ? 'Route Started!' : 'Start Your Route!',
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  _showBreakPopup(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  buttonText, // 'Break!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () async {
                  final currentLocation = await location.getLocation();

                  setState(() {
                    storage.remove('isLoggedIn');
                    storage.write('break_status', 1);
                    context.read<GlobalBloc>().add(
                      StartRouteEvent(
                        type: '1',
                        userId: context
                            .read<GlobalBloc>()
                            .state
                            .loginModel!
                            .userinfo!
                            .userId
                            .toString(),
                        lat: currentLocation.latitude.toString(),
                        lng: currentLocation.longitude.toString(),
                      ),
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  isLoggedIn == true ? 'Start Route' : 'End Route',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
