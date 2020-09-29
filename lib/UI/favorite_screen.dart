import 'package:bloc_pattern/BLoC/bloc_provider.dart';
import 'package:bloc_pattern/BLoC/favourite_bloc.dart';
import 'package:bloc_pattern/DataLayer/Restaurant.dart';
import 'package:bloc_pattern/UI/restaurant_tile.dart';
import 'package:flutter/material.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavouriteBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourites'),
      ),
      body: StreamBuilder(
        initialData: bloc.favourites,
        stream: bloc.favouriteStream,
        builder: (context, snapshot) {
          List<Restaurant> favourites =
              (snapshot.connectionState == ConnectionState.waiting)
                  ? bloc.favourites
                  : snapshot.data;
          if (favourites == null || favourites.isEmpty) {
            return Center(
              child: Text('No Favourites'),
            );
          }
          return ListView.separated(
              itemBuilder: (context, index) {
                final restaurant = favourites[index];
                return RestaurantTile(restaurant: restaurant);
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: favourites.length);
        },
      ),
    );
  }
}
