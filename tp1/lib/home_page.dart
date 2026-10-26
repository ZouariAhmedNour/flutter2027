import 'package:flutter/material.dart';
import 'item_home.dart';
import 'offer_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const OfferPage(),
          Expanded(
            child: ListView(
              children: const [
                ItemHome(),
                ItemHome(),
                ItemHome(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}