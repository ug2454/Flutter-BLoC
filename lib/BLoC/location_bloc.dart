import 'dart:async';

import 'package:bloc_pattern/BLoC/bloc.dart';

import 'package:bloc_pattern/DataLayer/Location.dart';

class LocationBloc extends Bloc {
  Location _location;

  Location get selectedLocation => _location;

  final _locationController = StreamController<Location>();

  Stream<Location> get locationStream => _locationController.stream;

  void selectLocation(Location location) {
    _location = location;
    _locationController.sink.add(location);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _locationController.close();
  }
}
