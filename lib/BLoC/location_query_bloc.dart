import 'dart:async';

import 'package:bloc_pattern/BLoC/bloc.dart';
import 'package:bloc_pattern/DataLayer/Client.dart';
import 'package:bloc_pattern/DataLayer/Location.dart';

class LocationQueryBloc implements Bloc {
  final _controller = StreamController<List<Location>>();
  final _client = ZomatoClient();
  Stream<List<Location>> get locationStream => _controller.stream;

  void submitQuery(String query) async {
    // 1
    final results = await _client.fetchLocations(query);
    _controller.sink.add(results);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
