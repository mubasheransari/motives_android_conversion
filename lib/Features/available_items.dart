import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motives_android_conversion/Bloc/global_bloc.dart';
import 'package:motives_android_conversion/Bloc/global_state.dart';
import 'package:motives_android_conversion/widget/gradient_text.dart';


class AvailableItems extends StatefulWidget {
  const AvailableItems({super.key});

  @override
  State<AvailableItems> createState() => _AvailableItemsState();
}

class _AvailableItemsState extends State<AvailableItems> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       backgroundColor: Colors.transparent,
        centerTitle: true,
              title: GradientText("Available Items", fontSize: 24),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search by brand or name",
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
              state.loginModel?.items != null) {
            final items = state.loginModel!.items!;
            final filteredItems = items.where((item) {
              final brand = item.brand.toString().toLowerCase() ?? '';
              final name = item.name?.toLowerCase() ?? '';
              return brand.contains(searchQuery) || name.contains(searchQuery);
            }).toList();

            if (filteredItems.isEmpty) {
              return const Center(child: Text("No items found"));
            }

            return ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredItems[index].brand.toString() ?? "No Brand"),
                  subtitle: Text(filteredItems[index].name ?? "No Name"),
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

