import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motives_android_conversion/Bloc/global_bloc.dart';
import 'package:motives_android_conversion/Bloc/global_state.dart';
import 'package:motives_android_conversion/widget/gradient_text.dart';

class PunchOrderScreen extends StatefulWidget {
  const PunchOrderScreen({super.key});

  @override
  State<PunchOrderScreen> createState() => _PunchOrderScreenState();
}

class _PunchOrderScreenState extends State<PunchOrderScreen> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:context.read<GlobalBloc>().state.loginModel!.journeyPlan!.length != 0 ? AppBar(
       backgroundColor: Colors.transparent,
        centerTitle: true,
              title: GradientText("Punch Order", fontSize: 24),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search by Shop or Adress",
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
        )):AppBar(
       backgroundColor: Colors.transparent,
        centerTitle: true,
              title: GradientText("Punch Order", fontSize: 24),
    
      ),
      body: BlocBuilder<GlobalBloc, GlobalState>(
        builder: (context, state) {
          if (state.status== LoginStatus.success &&
              state.loginModel!.journeyPlan!.isNotEmpty) {
            final items =   state.loginModel!.journeyPlan!;
            final filteredItems = items.where((item) {
              final partyName = item.partyName.toString().toLowerCase() ?? '';
              final custAddress = item.custAddress.toLowerCase() ?? '';
              return partyName.contains(searchQuery) || custAddress.contains(searchQuery);
            }).toList();

            if (filteredItems.isEmpty) {
              return const Center(child: Text("No items found"));
            }
            return ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredItems[index].partyName.toString() ?? "No Brand"),
                  subtitle: Text(filteredItems[index].custAddress ?? "No Name"),
                );
              },
            );
          } else {
            return const Center(
              child:Text('No PJP Available!') //CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

}