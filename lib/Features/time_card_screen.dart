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
                  _buildCell(Icons.person, "CheckIn-Time"),
                  _buildCell(Icons.access_time, time ?? "--"),
                ],
              ),
              TableRow(
                children: [
                  _buildCell(Icons.calendar_month, date ?? "--"),
                  _buildCell(Icons.location_on, "Routes 0"),
                ],
              ),
            ],
          ),

          // ListTile(
          //   leading: Icon(Icons.access_time, size: 35, color: Colors.cyan),
          //   title: Text(
          //     '$time',
          //   ),
          // ),
          //   ListTile(
          //   leading: Icon(Icons.access_time, size: 35, color: Colors.cyan),
          //   title: Text(
          //     '$time',
          //   ),
          // ),
          SizedBox(height: 10),
          //     ListTile(
          //   leading: Icon(Icons.access_time, size: 35, color: Colors.cyan),
          //   title: Text(
          //     'Your Attendence is marked successfully at $time on $date.',
          //   ),
          // ),
          /*   Padding(
            padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height *0.70),
            child: Center(
              child: SizedBox(
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
                              onPressed: () async {
                                storage.remove("checkin_time");
                                storage.remove("checkin_date");
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DashboardScreen(),
                                  ),
                                  (Route<dynamic> route) => false,
                                );
              
                                final currentLocation = await location
                                    .getLocation();
              
                                print("LAT ${currentLocation.latitude}");
                                print("LNG ${currentLocation.longitude}");
                                print(
                                  "USER ID ${context.read<GlobalBloc>().state.loginModel!.userinfo!.userId.toString()}",
                                );
              
                                context.read<GlobalBloc>().add(
                                  MarkAttendanceEvent(
                                    lat: currentLocation.latitude.toString(),
                                    lng: currentLocation.longitude.toString(),
                                    type: '0',
                                    userId: context
                                        .read<GlobalBloc>()
                                        .state
                                        .loginModel!
                                        .userinfo!
                                        .userId
                                        .toString(),
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
            ),
          ),*/
        ],
      ),
      /*
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.70,
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
                          onPressed: () async {
                            storage.remove("checkin_time");
                            storage.remove("checkin_date");
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DashboardScreen(),
                              ),
                              (Route<dynamic> route) => false,
                            );

                            final currentLocation = await location
                                .getLocation();

                            print("LAT ${currentLocation.latitude}");
                            print("LNG ${currentLocation.longitude}");
                            print(
                              "USER ID ${context.read<GlobalBloc>().state.loginModel!.userinfo!.userId.toString()}",
                            );

                            context.read<GlobalBloc>().add(
                              MarkAttendanceEvent(
                                lat: currentLocation.latitude.toString(),
                                lng: currentLocation.longitude.toString(),
                                type: '0',
                                userId: context
                                    .read<GlobalBloc>()
                                    .state
                                    .loginModel!
                                    .userinfo!
                                    .userId
                                    .toString(),
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
      ),*/
    );
  }

  Widget _buildCell(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 35, color: Colors.cyan),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis, // avoids overflow
            ),
          ),
        ],
      ),
    );
  }
}
