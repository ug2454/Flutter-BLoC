import 'dart:async';

import 'package:bloc_pattern/BLoC/bloc.dart';
import 'package:bloc_pattern/DataLayer/Restaurant.dart';

class FavouriteBloc implements Bloc {
  var _restaurants = <Restaurant>[];
  List<Restaurant> get favourites => _restaurants;

  final _controller = StreamController<List<Restaurant>>.broadcast();

  Stream<List<Restaurant>> get favouriteStream => _controller.stream;

  void toggleRestaurant(Restaurant restaurant) {
    if (_restaurants.contains(restaurant)) {
      _restaurants.remove(restaurant);
    } else {
      _restaurants.add(restaurant);
    }
    _controller.sink.add(_restaurants);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
