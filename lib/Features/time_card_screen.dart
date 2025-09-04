import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:motives_android_conversion/Bloc/global_bloc.dart';
import 'package:motives_android_conversion/Bloc/global_event.dart';
import 'package:motives_android_conversion/Features/dashboard_screen.dart';
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

    final storage = GetStorage();
    var time = storage.read("checkin_time");
    var date = storage.read("checkin_date");
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: GradientText("Time Card", fontSize: 24),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.access_time, size: 35, color: Colors.cyan),
            title: Text(
              'Your Attendence is marked successfully at $time on $date.',
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.90,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                 showDialog(
                context: context,
                builder: (context) {
                  return SizedBox(
                    height: 100,
                    child: AlertDialog(
                      title: const Text("End Route"),
                      content: Text("Are you sure you want to End Route?"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      actions: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Cancel",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),

     

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: ()async {
                 storage.remove("checkin_time");
    storage.remove("checkin_date");
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DashboardScreen(),
                              ),
                              (Route<dynamic> route) => false,
                            );

                                final currentLocation = await location.getLocation();

                                print("LAT ${currentLocation.latitude}");
                                print("LNG ${currentLocation.longitude}");
                                print("USER ID ${context.read<GlobalBloc>().state.loginModel!.userinfo!.userId.toString()}");

                                 context.read<GlobalBloc>().add(
        MarkAttendanceEvent(
          lat: currentLocation.latitude.toString(),
          lng: currentLocation.longitude.toString(),
          type: '0',
          userId: context.read<GlobalBloc>().state.loginModel!.userinfo!.userId.toString(),
        ),
      );

                    

                    


                          },
                          child: const Text(
                            "Confirm",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'End Route',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
