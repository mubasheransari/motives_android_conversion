import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motives_android_conversion/Features/profile_screen.dart';
import 'package:motives_android_conversion/Features/timecard_popup.dart';
import 'package:motives_android_conversion/theme_change/theme_bloc.dart';
import 'package:motives_android_conversion/theme_change/theme_event.dart';
import 'package:motives_android_conversion/widget/gradient_text.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GradientText("Dashboard", fontSize: 24),
        //centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Transform.scale(
            scale: 0.6,
            child: Switch(
              value: isDark,
              activeColor: Colors.purple,
              onChanged: (value) {
                context.read<ThemeBloc>().add(ToggleThemeEvent(value));
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          height: MediaQuery.of(context).size.height *0.78,
          child: Card(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.grey[200],
            elevation: 8,
            shadowColor: isDark
                ? Colors.purple.withOpacity(0.4)
                : Colors.grey.withOpacity(0.2),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                
                children: [
               
                       Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                         InkWell(
                          onTap:(){
                            showTimeCardPopup(context);
                          },
                           child: SizedBox(
                            height: 130,
                            width: 130,
                             child: _buildStatCard(
                              height: 50,
                              width: 50,
                                title: "Time Card",
                                iconName: "assets/time_card_icon.png",
                                color1: Colors.purple,
                                color2: Colors.blue,
                              ),
                           ),
                         ),
                      
                        const SizedBox(width: 12),
                        InkWell(
                          onTap: (){},
                          child: SizedBox(
                            height: 130,
                            width: 130,
                            child: _buildStatCard(
                               height: 55,
                              width: 80,
                              title: "Start Route",
                              iconName: "assets/new_routes-removebg-preview.png",
                              color1: Colors.green,
                              color2: Colors.teal,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){},
                          child: SizedBox(
                            height: 130,
                            width: 130,
                            child: _buildStatCard(
                               height: 50,
                              width: 50,
                              title: "Punch Order",
                              iconName: "assets/punch_order-removebg-preview.png",
                              color1: Colors.orange,
                              color2: Colors.deepOrange,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        InkWell(
                          onTap: (){},
                          child: SizedBox(
                            height: 130,
                            width: 130,
                            child: _buildStatCard(
                               height: 50,
                              width: 50,
                              title: "Records",
                              iconName: "assets/new_records.png",
                              color1: Colors.cyan,
                              color2: Colors.blueAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          
                     const SizedBox(height: 20),
                      GradientText("Features", fontSize: 24),
                      const SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // InkWell(
                        //   onTap: (){
                        //    // showTimeCardPopup(context);
                        //   },
                        //   child: _buildMenuButton(Icons.access_time, "Time\nCard")),
                         InkWell(
                          onTap:(){
                           Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileScreen()));
                          },
                          child: _buildMenuButton(Icons.person, "Profile\nDetails")),
                        // _buildMenuButton(
                        //   Icons.alt_route,
                        //   "Today's\nRoute",
                        // ),
                        // _buildMenuButton(
                        //   Icons.shopping_cart,
                        //   "Punch\nOrder",
                        // ),
                        _buildMenuButton(
                          Icons.cloud_download,
                          "Sync\nIn",
                        ),
                         _buildMenuButton(Icons.cloud_upload, "Sync\nOut"),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildMenuButton(Icons.cloud_upload, "Sync\nOut"),
                       // _buildMenuButton(Icons.reviews, "Shop\nOwner\nReview"),
                        _buildMenuButton(Icons.add, "Add\nShops"),
                        _buildMenuButton(Icons.calendar_month, "Leave\nRequest"),
                      ],
                    ),
                  ],
                ),
              ),
            
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  
  Widget _buildMenuButton(IconData icon, String label) {
      final isDark = context.watch<ThemeBloc>().state.themeMode == ThemeMode.dark;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.purple, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.purple.withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(2, 4),
              )
            ],
          ),
          child: Icon(icon, size: 24, color: Colors.white),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: isDark ? Colors.white : Colors.black,),
        ),
      ],
    );
  }

    Widget _buildStatCard({
    required String title,
    required String iconName,
    required Color color1,
    required Color color2,
    required double height,
    required double width,
  }) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height *0.15,
             width: MediaQuery.of(context).size.width *0.40,
     //   padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color1, color2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color1.withOpacity(0.4),
              blurRadius: 6,
              offset: const Offset(2, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Image.asset(iconName,height: height,width: width,),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}