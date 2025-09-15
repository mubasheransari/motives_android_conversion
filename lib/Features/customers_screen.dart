import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motives_android_conversion/Bloc/global_bloc.dart';
import 'package:motives_android_conversion/Bloc/global_state.dart';
import 'package:motives_android_conversion/Features/order_menu_screen.dart';
import 'package:motives_android_conversion/widget/gradient_text.dart';


class CustomersScreen extends StatefulWidget {
  const CustomersScreen({super.key});

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Colors.white,
      appBar: AppBar(
       backgroundColor: Colors.white,
        centerTitle: true,
              title: GradientText("Customers", fontSize: 24),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Shop Name",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
        ),
      ),
      body: BlocBuilder<GlobalBloc, GlobalState>(
        builder: (context, state) {
          if (state.status == LoginStatus.success &&
              state.loginModel?.journeyPlan!.length != 0) {
            final items = state.loginModel!.journeyPlan;
            final filteredItems = items!.where((item) {
              final brand = item.partyName.toString().toLowerCase() ?? '';
              return brand.contains(searchQuery);
            }).toList();

            if (filteredItems.isEmpty) {
              return const Center(child: Text("No items found"));
            }

            return ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> OrderMenuScreen(shopname: filteredItems[index].partyName.toString(),miscid: filteredItems[index].accode.toString())));
                  },
                  title: Text(filteredItems[index].partyName.toString() ?? ""),
                  subtitle: Text(filteredItems[index].custAddress ?? ""),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
