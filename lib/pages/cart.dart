import 'package:ecommerce_app/provider/cart_provider.dart';
import 'package:ecommerce_app/screens/productDetails/product_details.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  late Razorpay razorPay;

  @override
  void initState() {
    super.initState();
    razorPay = Razorpay();
    razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
        ),
        body: Consumer<CartProvider>(
          builder: (context, cartProvider, child) {
            if (cartProvider.cart.isEmpty) {
              return const Center(
                child: Text(
                  'No items added',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: cartProvider.cart.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
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
                                            product:
                                                cartProvider.cart[index])));
                              },
                              leading: SizedBox(
                                height: 100,
                                width: 100,
                                child: Image.asset(
                                  cartProvider.cart[index].productImagePath[0],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(cartProvider.cart[index].productName),
                              subtitle:
                                  Text('Rs ${cartProvider.cart[index].price}'),
                              trailing: IconButton(
                                tooltip: 'Remove from Cart',
                                onPressed: () {
                                  cartProvider
                                      .removeProduct(cartProvider.cart[index]);
                                },
                                icon: const Icon(Icons.remove),
                              ),
                            ),
                          )),
                    );
                  });
            }
          },
        ),
        bottomNavigationBar:
            Consumer<CartProvider>(builder: (context, value, child) {
          if (value.cart.isEmpty) {
            return const SizedBox(height: 10,);
          }
          return Material(
            surfaceTintColor: const Color.fromARGB(255, 255, 191, 0),
            elevation: 100,
            shadowColor: Colors.black,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            child: Container(
                height: 130,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                ),
                child: Padding(
                    padding: const EdgeInsets.only(top: 10, right: 20),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 20),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              value.totalAmount == 0
                                  ? ''
                                  : 'Total : ${value.totalAmount}',
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 85, 36, 5),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Align(
                          alignment: Alignment.topRight,
                          child: ElevatedButton(
                              onPressed: () {
                                if (value.totalAmount != 0) {
                                  var options = {
                                    'key': 'rzp_test_GcZZFDPP0jHtC4',
                                    'amount': value.totalAmount * 100,
                                    'name': 'Learn and Build',
                                    'description': 'Fine T-Shirt',
                                    'prefill': {
                                      'contact': '8888888888',
                                      'email': 'test@razorpay.com'
                                    }
                                  };
                                  razorPay.open(options);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.orange,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: const Row(
                                children: [
                                  Text('Checkout'),
                                  Icon(Icons.shopping_cart_checkout)
                                ],
                              )),
                        )
                      ],
                    ))),
          );
        }));
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(msg: "Payment Success: ${response.paymentId}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Failure: ${response.code} - ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "External Wallet: ${response.walletName}");
  }

  @override
  void dispose() {
    super.dispose();
    razorPay.clear();
  }
}
