import 'package:bloc_pattern/BLoC/bloc_provider.dart';
import 'package:bloc_pattern/BLoC/location_bloc.dart';
import 'package:bloc_pattern/BLoC/location_query_bloc.dart';
import 'package:bloc_pattern/DataLayer/Location.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatelessWidget {
  final bool isFullScreenDialog;

  const LocationScreen({Key key, this.isFullScreenDialog = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = LocationQueryBloc();
    return BlocProvider<LocationQueryBloc>(
      bloc: bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Where do you want to eat?'),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a location',
                ),
                onChanged: (value) => bloc.submitQuery(value),
              ),
            ),
            Expanded(child: _buildResults(bloc)),
          ],
        ),
      ),
    );
  }

  Widget _buildResults(LocationQueryBloc bloc) {
    return StreamBuilder<List<Location>>(
        stream: bloc.locationStream,
        builder: (context, snapshot) {
          final results = snapshot.data;
          if (results == null) {
            return Center(
              child: Text('Enter a location'),
            );
          }
          if (results.isEmpty) {
            return Center(
              child: Text('No Results'),
            );
          }
          return _buildSearchResults(results);
        });
  }

  Widget _buildSearchResults(List<Location> results) {
    return ListView.separated(
        itemBuilder: (context, index) {
          final location = results[index];
          return ListTile(
            title: Text(location.title),
            onTap: () {
              final locationBloc = BlocProvider.of<LocationBloc>(context);
              locationBloc.selectLocation(location);
              if (isFullScreenDialog) {
                Navigator.of(context).pop();
              }
            },
          );
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: results.length);
  }
}
