import 'dart:async';
import 'package:ecommerce_app/models/products.dart';
import 'package:ecommerce_app/pages/cart.dart';
import 'package:ecommerce_app/provider/cart_provider.dart';
import 'package:ecommerce_app/provider/favorite_provider.dart';
import 'package:ecommerce_app/screens/productDetails/product_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  late Timer _timer;

  List<Widget> bannerImages = [
    Image.asset('assets/images/logo.jpg'),
    Image.asset(
      'assets/images/o1.jpg',
      fit: BoxFit.cover,
    ),
    Image.asset(
      'assets/images/o2.png',
      fit: BoxFit.cover,
    ),
    Image.asset(
      'assets/images/o3.jpeg',
      fit: BoxFit.cover,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < bannerImages.length) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: SizedBox(
          height: 50,
          width: double.infinity,
          child: TextFormField(
            decoration:  InputDecoration(
              hintText: 'Search',
              prefixIcon: const Icon(Icons.search),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 1)
              ),
              focusedBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 1)
              )
            ),
          ),
        ),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const Cart()));
          }, icon: const Icon(Icons.shopping_cart_outlined))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 200,
              width: double.infinity,
              decoration:  BoxDecoration(
                  border: Border.all(
                    color: Colors.black
                    ),
                  color: Colors.white),
              child: PageView(
                controller: _pageController,
                children: bannerImages,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  row1Elements('assets/images/c1.jpeg', 'Mobiles'),
                  row1Elements('assets/images/m2.jpeg', 'Tv & appliances'),
                  row1Elements('assets/images/m3.jpeg', 'Laptops'),
                  row1Elements('assets/images/m4.jpeg', 'Speakers'),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
             const Padding(padding: EdgeInsets.only(left: 10),
             child: Text('Popular products',
                textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 20
              ),
                         )),
            const SizedBox(height: 10,),
            for (int i = 0; i < products.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Material(
                  borderOnForeground: false,
                  shadowColor:  const Color.fromARGB(255, 0, 8, 255),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(20),
                  ),
                
                  type: MaterialType.card,
                    elevation: 5,
                    child: Center(
                      heightFactor: 1.5,
                      child: ListTile(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  ProductDetails(product: products[i])));
                          },
                          leading: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.asset(
                              products[i].productImagePath[0],
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(products[i].productName),
                          subtitle: Text('Rs ${products[i].price}'),
                          trailing: Wrap(
                            spacing: -10,
                            children: [
                              IconButton(
                                  tooltip: 'Add to cart',
                                  onPressed: () {
                                    Provider.of<CartProvider>(context,
                                            listen: false)
                                        .addProduct(products[i]);
                                  },
                                  icon: const Icon(Icons.add)),
                              IconButton(
                                tooltip: 'Add to Favorites',
                                onPressed: () {
                                  setState(() {
                                    products[i].isFavourite =
                                        !products[i].isFavourite;
                                    if(products[i].isFavourite){
                                      Provider.of<FavoriteProvider>(context,
                                            listen: false)
                                        .addToFavorite(products[i]);
                                    } else{
                                      Provider.of<FavoriteProvider>(context,
                                            listen: false)
                                        .removeFavorite(products[i]);
                                    }
                                  });
                                },
                                icon:  Icon(Icons.favorite,
                                color:products[i].isFavourite ? Colors.pinkAccent : const Color.fromARGB(255, 100, 103, 104)),
                              )
                            ],
                          )),
                    )),
              ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }

  Column row1Elements(String image, String imageName) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage(image),
        ),
        Text(imageName)
      ],
    );
  }
}
