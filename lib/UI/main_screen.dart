import 'package:bloc_pattern/BLoC/bloc_provider.dart';
import 'package:bloc_pattern/BLoC/location_bloc.dart';
import 'package:bloc_pattern/DataLayer/Location.dart';
import 'package:bloc_pattern/UI/location_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Location>(
        stream: BlocProvider.of<LocationBloc>(context).locationStream,
        builder: (context, snapshot) {
          final location = snapshot.data;
          if (location == null) {
            return LocationScreen();
          }
          return Container();
        });
  }
}
