import 'dart:async';

import 'package:bloc_pattern/BLoC/bloc.dart';
import 'package:bloc_pattern/DataLayer/Client.dart';
import 'package:bloc_pattern/DataLayer/Location.dart';
import 'package:bloc_pattern/DataLayer/Restaurant.dart';
import 'package:bloc_pattern/DataLayer/Restaurant.dart';

class RestaurantBloc implements Bloc {
  final Location location;
  final _client = ZomatoClient();
  final _controller = StreamController<List<Restaurant>>();

  Stream<List<Restaurant>> get stream => _controller.stream;
  RestaurantBloc(this.location);

  void submitQuery(String query) async {
    final results = await _client.fetchRestaurants(location, query);

    _controller.sink.add(results);

    
  }

  @override
  void dispose() {
    _controller.close();
  }
}
