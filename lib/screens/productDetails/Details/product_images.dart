import 'package:ecommerce_app/models/products.dart';
import 'package:flutter/material.dart';

class ProductImages extends StatefulWidget {
  final bool isSelected = false;
  const ProductImages({
    super.key,
    required this.product,
  });

  final Products product;

  @override
  // ignore: library_private_types_in_public_api
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          shadowColor: Colors.purple,
          elevation: 5,
          child: SizedBox(
            height: 250,
            width: double.infinity,
            child: ListView.builder(
                itemCount: widget.product.productImagePath.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      AspectRatio(
                        aspectRatio: 1.51,
                        child: Image.asset(
                          widget.product.productImagePath[selectedImage=index],
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  );
                }),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(widget.product.productImagePath.length, (j) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.all(8),
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: Colors.orange.withOpacity(selectedImage == j ? 1 : 0)),
                ),
                child: Image.asset(widget.product.productImagePath[j]),
              );
            }),
          ],
        )
      ],
    );
  }
}

class SmallProductImage extends StatefulWidget {
  const SmallProductImage(
      {super.key,
      required this.isSelected,
      required this.press,
      required this.image});

  final bool isSelected;
  final VoidCallback press;
  final String image;

  @override
  State<SmallProductImage> createState() => _SmallProductImageState();
}

class _SmallProductImageState extends State<SmallProductImage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.press,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(8),
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: Colors.orange.withOpacity(widget.isSelected ? 1 : 0)),
        ),
        child: Image.asset(widget.image),
      ),
    );
  }
}
