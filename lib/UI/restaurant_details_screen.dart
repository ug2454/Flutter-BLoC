import 'package:bloc_pattern/BLoC/bloc_provider.dart';
import 'package:bloc_pattern/BLoC/favourite_bloc.dart';
import 'package:bloc_pattern/DataLayer/Restaurant.dart';
import 'package:flutter/material.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailsScreen({this.restaurant});
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBanner(),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.cuisines,
                  style: textTheme.subtitle2.copyWith(fontSize: 18),
                ),
                Text(
                  restaurant.address,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
                ),
              ],
            ),
          ),
          _buildDetails(context),
          _buildFavouriteButton(context),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return Image(image: NetworkImage(restaurant.imageUrl));
  }

  Widget _buildDetails(BuildContext context) {
    final style = TextStyle(fontSize: 16.0);

    return Padding(
      padding: EdgeInsets.only(left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Price: ${restaurant.priceDisplay}',
            style: style,
          ),
          SizedBox(
            width: 40.0,
          ),
          Text(
            'Rating ${restaurant.rating}',
            style: style,
          ),
        ],
      ),
    );
  }

  Widget _buildFavouriteButton(BuildContext context) {
    final bloc = BlocProvider.of<FavouriteBloc>(context);

    return StreamBuilder<List<Restaurant>>(
      stream: bloc.favouriteStream,
      initialData: bloc.favourites,
      builder: (context, snapshot) {
        List<Restaurant> favourites =
            (snapshot.connectionState == ConnectionState.waiting)
                ? bloc.favourites
                : snapshot.data;

        bool isFavourite = favourites.contains(restaurant);

        return FlatButton.icon(
            onPressed: () => bloc.toggleRestaurant(restaurant),
            textColor: isFavourite ? Theme.of(context).accentColor : null,
            icon: Icon(isFavourite ? Icons.favorite : Icons.favorite_border),
            label: Text('Favourite'));
      },
    );
  }
}
