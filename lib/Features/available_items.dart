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



/*class AvailableItems extends StatefulWidget {
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
      ),
      body: Column(
        children: [
          // 🔎 Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search items...",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
          ),

          // 📦 List of Items
          Expanded(
            child: BlocBuilder<GlobalBloc, GlobalState>(
              builder: (context, state) {
                if (state.status == LoginStatus.success &&
                    state.loginModel?.items != null) {
                  final filteredItems = state.loginModel!.items!
                      .where((item) =>
                          item.brand!.toString().toLowerCase().contains(searchQuery) ||
                          item.name!.toLowerCase().contains(searchQuery))
                      .toList();

                  if (filteredItems.isEmpty) {
                    return const Center(
                      child: Text("No items found"),
                    );
                  }

                  return ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return ListTile(
                        title: Text(item.brand.toString()),
                        subtitle: Text(item.name.toString()),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text("Loading..."),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}*/


// class AvailableItems extends StatefulWidget {
//   const AvailableItems({super.key});

//   @override
//   State<AvailableItems> createState() => _AvailableItemsState();
// }

// class _AvailableItemsState extends State<AvailableItems> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   centerTitle: true,
      //         title: GradientText("Available Items", fontSize: 24),
      // ),
//       body: BlocBuilder<GlobalBloc, GlobalState>(
//   builder: (context, state) {
//     if (state.status == LoginStatus.success && state.loginModel?.items != null) {
//       return ListView.builder(
//         itemCount: state.loginModel!.items!.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(
//               state.loginModel!.items![index].brand.toString(),
//             ),
//               subtitle: Text(
//               state.loginModel!.items![index].name.toString(),
//             ),
//           );
//         },
//       );
//     } else {
//       return const Center(
//         child: Text("Loading"),
//       );
//     }
//   },
// )

      
//       // ListView.builder(
//       //   itemCount: context.read<GlobalBloc>().state.loginModel!.items
//       //   !.length,
//       //   itemBuilder: (context,index){
//       //     return ListTile(
//       //       title: Text(context.read<GlobalBloc>().state.loginModel!.items![index].brand.toString(),
//       //     ));

//       // }),
//     );
//   }
// }