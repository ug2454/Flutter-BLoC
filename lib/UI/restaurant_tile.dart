import 'package:bloc_pattern/DataLayer/Restaurant.dart';
import 'package:bloc_pattern/UI/restaurant_details_screen.dart';
import 'package:flutter/material.dart';

class RestaurantTile extends StatelessWidget {
  const RestaurantTile({
    Key key,
    @required this.restaurant,
  }) : super(key: key);

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image(
        image: NetworkImage(restaurant.thumbUrl),
      ),
      title: Text(restaurant.name),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => RestaurantDetailsScreen(
              restaurant: restaurant,
            ),
          ),
        );
      },
    );
  }
}
