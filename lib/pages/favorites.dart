import 'package:ecommerce_app/provider/favorite_provider.dart';
import 'package:ecommerce_app/screens/productDetails/product_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Favorites Products'),
        ),
        body: Consumer<FavoriteProvider>(
          builder: (context, favoriteProvider, child) {
            if (favoriteProvider.favorite.isEmpty) {
              return const Center(
                child: Text('No favorite items',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal
                ),),
              );
            }
            return ListView.builder(
                itemCount: favoriteProvider.favorite.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                        type: MaterialType.card,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 5,
                        child: Center(
                          heightFactor: 1.5,
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductDetails(
                                          product: favoriteProvider.favorite
                                              .elementAt(index))));
                            },
                            leading: SizedBox(
                              height: 100,
                              width: 100,
                              child: Image.asset(
                                favoriteProvider.favorite
                                    .elementAt(index)
                                    .productImagePath[0],
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(favoriteProvider.favorite
                                .elementAt(index)
                                .productName),
                            subtitle: Text(
                                'Rs ${favoriteProvider.favorite.elementAt(index).price}'),
                            trailing: IconButton(
                              tooltip: 'Remove from favorites',
                              onPressed: () {
                                favoriteProvider.favorite
                                        .elementAt(index)
                                        .isFavourite =
                                    !favoriteProvider.favorite
                                        .elementAt(index)
                                        .isFavourite;
                                favoriteProvider.removeFavorite(
                                    favoriteProvider.favorite.elementAt(index));
                              },
                              icon: Icon(
                                Icons.favorite,
                                color: favoriteProvider.favorite
                                        .elementAt(index)
                                        .isFavourite
                                    ? Colors.pink
                                    : const Color.fromARGB(255, 100, 103, 104),
                              ),
                            ),
                          ),
                        )),
                  );
                });
          },
        ));
  }
}
