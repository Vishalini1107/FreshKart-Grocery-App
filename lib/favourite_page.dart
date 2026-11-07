import 'package:flutter/material.dart';

class FavouritePage extends StatelessWidget {
  final List<Map<String, dynamic>> favourites;

  FavouritePage({required this.favourites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favourites"), backgroundColor: Colors.green),
      body: favourites.isEmpty
          ? Center(child: Text("No Favourite Items Yet ❤️"))
          : ListView.builder(
        itemCount: favourites.length,
        itemBuilder: (context, index) {
          final item = favourites[index];
          return Card(
            margin: EdgeInsets.all(12),
            child: ListTile(
              leading: Image.network(item['image'], width: 60),
              title: Text(item['name']),
              subtitle: Text(item['price']),
            ),
          );
        },
      ),
    );
  }
}
