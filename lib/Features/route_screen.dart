import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:motives_android_conversion/widget/build_cell_widget.dart';
import 'package:motives_android_conversion/widget/gradient_text.dart';
import 'package:location/location.dart' as loc;

class RouteScreen extends StatefulWidget {
  const RouteScreen({super.key});

  @override
  State<RouteScreen> createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    var time = storage.read("checkin_time");
    var date = storage.read("checkin_date");
    var day = storage.read("checkin_day");

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

          // Punch In Row
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            child: Row(
              children: [
                Icon(Icons.person, size: 35, color: Colors.cyan),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    'PunchIn-Time',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          // Date Row
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            child: Row(
              children: [
                Icon(Icons.access_time, size: 35, color: Colors.cyan),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    "$day, $date",
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

        
          Padding(
            padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.20),
            child: const Center(
              child: Text('Route Started!'),
            ),
          ),
        ],
      ),

      // 👇 Buttons fixed at the bottom
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // keep height minimal
          children: [
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Break!',
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
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'End Route',
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
