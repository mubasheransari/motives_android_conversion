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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
              title: GradientText("Available Items", fontSize: 24),
      ),
      body: BlocBuilder<GlobalBloc, GlobalState>(
  builder: (context, state) {
    if (state.status == LoginStatus.success && state.loginModel?.items != null) {
      return ListView.builder(
        itemCount: state.loginModel!.items!.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              state.loginModel!.items![index].brand.toString(),
            ),
              subtitle: Text(
              state.loginModel!.items![index].name.toString(),
            ),
          );
        },
      );
    } else {
      return const Center(
        child: Text("Loading"),
      );
    }
  },
)

      
      // ListView.builder(
      //   itemCount: context.read<GlobalBloc>().state.loginModel!.items
      //   !.length,
      //   itemBuilder: (context,index){
      //     return ListTile(
      //       title: Text(context.read<GlobalBloc>().state.loginModel!.items![index].brand.toString(),
      //     ));

      // }),
    );
  }
}