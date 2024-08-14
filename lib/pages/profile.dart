import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Your Profile'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              const Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/logo.jpg'),
                  radius: 60,
                  backgroundColor: Colors.cyan,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              profileMenu(const Icon(Icons.person), 'My account'),
              const SizedBox(
                height: 30,
              ),
              profileMenu(const Icon(Icons.notifications), 'Notification'),
              const SizedBox(
                height: 30,
              ),
              profileMenu(const Icon(Icons.settings), 'Settings'),
              const SizedBox(
                height: 30,
              ),
              profileMenu(const Icon(Icons.shopping_bag_outlined), 'My Orders'),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                },
                child: profileMenu(const Icon(Icons.logout), 'Logout'),
              )
            ],
          ),
        ));
  }

  Padding profileMenu(Icon icon, String menuName) {
    return Padding(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: Material(
          borderRadius: BorderRadius.circular(15),
          shadowColor: Colors.black,
          elevation: 5,
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 198, 112),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                icon,
                const SizedBox(
                  width: 40,
                ),
                Text(
                  menuName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ));
  }
}
