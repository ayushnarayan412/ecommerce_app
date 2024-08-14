import 'package:ecommerce_app/models/products.dart';
import 'package:ecommerce_app/provider/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDescription extends StatefulWidget {
  final Products product;
  const ProductDescription({
    super.key,
    required this.product,
  });

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            widget.product.productName,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    widget.product.isFavourite = !widget.product.isFavourite;
                    if (widget.product.isFavourite) {
                      Provider.of<FavoriteProvider>(context, listen: false)
                          .addToFavorite(widget.product);
                    } else {
                      Provider.of<FavoriteProvider>(context, listen: false)
                          .removeFavorite(widget.product);
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: EdgeInsets.zero,
                    elevation: 0,
                    backgroundColor: Colors.white),
                child: Icon(
                  Icons.favorite,
                  color: widget.product.isFavourite
                      ? Colors.pinkAccent
                      : Colors.grey,
                ))),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 64,
          ),
          child: Text(
            widget.product.description,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              
            ),
            maxLines: 8,
          ),
        ),
        const SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 64,
          ),
          child: Text(
            'Price : Rs ${widget.product.price}',
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 20
            ),
          ),
        ),
      ],
    );
  }
}
