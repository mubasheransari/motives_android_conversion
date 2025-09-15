import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart' as loc;
import 'package:motives_android_conversion/Bloc/global_bloc.dart';
import 'package:motives_android_conversion/Bloc/global_event.dart';
import 'package:motives_android_conversion/widget/gradient_text.dart';

class OrderMenuScreen extends StatefulWidget {
  String shopname,miscid;
   OrderMenuScreen({super.key,required this.shopname,required this.miscid});

  @override
  State<OrderMenuScreen> createState() => _OrderMenuScreenState();
}

class _OrderMenuScreenState extends State<OrderMenuScreen> {

      String checkInText = "Check In";
  String iconAsset = "assets/checkin_order.png";
    final loc.Location location = loc.Location();

  void _toggleCheckIn() {
    setState(() {
      if (checkInText == "Check In") {
        checkInText = "Check Out";
        iconAsset = "assets/checkout_order.png";
      } else {
        checkInText = "Check In";
        iconAsset = "assets/checkin_order.png";
      }
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: GradientText("Order Menu", fontSize: 24),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
     
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(5),
        child: SizedBox(
     
          height: MediaQuery.of(context).size.height * 0.78,
          child: Card(
            color: Colors.grey[200],
            elevation: 8,
            shadowColor:  Colors.grey.withOpacity(0.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,

                children: [
                 
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 6,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Row(
                          children: [
                            Image.asset('assets/shop_orderscreen.png',height: 40,width: 40,),
                            SizedBox(width: 5,),
                          GradientText(widget.shopname, fontSize: 18), 
                          ],
                        ),
                      SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async{
                                     final currentLocation = await location.getLocation();
                          _toggleCheckIn();
                          context.read<GlobalBloc>().add(CheckinCheckoutEvent(type: '5', userId:   context.read<GlobalBloc>().state.loginModel!.userinfo!.userId.toString(), lat: currentLocation.latitude.toString(), lng: currentLocation.longitude.toString(), act_type: "SHOP_CHECK", action: "IN", misc: widget.miscid, dist_id:   context.read<GlobalBloc>().state.loginModel!.userinfo!.disid.toString()));
                           
                              },
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height * 0.20,
                                width: MediaQuery.of(context).size.width * 0.40,
                                child: _buildStatCard(
                                  height: 50,
                                  width: 50,
                                  title: checkInText,
                                  iconName: "assets/checkin_order.png",
                                  color1: Colors.purple,
                                  color2: Colors.blue,
                                ),
                              ),
                            ),

                            const SizedBox(width: 12),
                            InkWell(
                              onTap: () {

                              },
                              child: SizedBox(
                                     height: MediaQuery.of(context).size.height * 0.20,
                                width: MediaQuery.of(context).size.width * 0.40,
                                child: _buildStatCard(
                                  height: 55,
                                  width: 80,
                                  title: "Take Order",
                                  iconName:
                                      "assets/take_order.png",
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
                              onTap: () {
},
                              child: SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.20,
                                width: MediaQuery.of(context).size.width * 0.40,
                                child: _buildStatCard(
                                  height: 50,
                                  width: 50,
                                  title: "Hold",
                                  iconName:
                                      "assets/hold.png",
                                  color1: Colors.orange,
                                  color2: Colors.deepOrange,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            InkWell(
                              onTap: () {},
                              child: SizedBox(
                                     height: MediaQuery.of(context).size.height * 0.20,
                                width: MediaQuery.of(context).size.width * 0.40,
                                child: _buildStatCard(
                                  height: 50,
                                  width: 50,
                                  title: "No Order Reason",
                                  iconName: "assets/no_order_reason.png",
                                  color1: Colors.cyan,
                                  color2: Colors.blueAccent,
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
                              onTap: () {
},
                              child: SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.20,
                                width: MediaQuery.of(context).size.width * 0.40,
                                child: _buildStatCard(
                                  height: 50,
                                  width: 50,
                                  title: "Collect Payment",
                                  iconName:
                                      "assets/collect_payment.png",
                                  color1: Color(0xff708993),
                                  color2: Color(0xffA1C2BD)
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            InkWell(
                              onTap: () {},
                              child: SizedBox(
                                     height: MediaQuery.of(context).size.height * 0.20,
                                width: MediaQuery.of(context).size.width * 0.40,
                                child: _buildStatCard(
                                  height: 50,
                                  width: 50,
                                  title: "Sale History",
                                  iconName: "assets/sale_history.png",
                                  color1: Color(0xffA27B5C),
                                  color2: Color(0xffE8BCB9),
                                ),
                              ),
                            ),
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

  
  Widget _buildStatCard({
    required String title,
    required String iconName,
    required Color color1,
    required Color color2,
    required double height,
    required double width,
  }) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width * 0.40,
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
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(iconName, height: height, width: width),
          const SizedBox(height: 4),
          Text(title, style: TextStyle(fontSize: 14, color: Colors.white)),
        ],
      ),
    );
  }
}


