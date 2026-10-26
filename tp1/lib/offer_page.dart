import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class OfferPage extends StatelessWidget {
  const OfferPage({super.key});

  // Liste des images des offres
  final List<String> images = const [
    "assets/home1.jpg",
    "assets/home2.jpeg",
    "assets/home3.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        viewportFraction: 0.8,        // chaque image occupe 80 % de la largeur
        initialPage: 0,
        enableInfiniteScroll: true,   // revient au début après la dernière image
        autoPlay: true,               // défilement automatique
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,      // l'image centrale est agrandie
        enlargeFactor: 0.3,
        scrollDirection: Axis.horizontal,
        onPageChanged: (index, reason) {
          debugPrint("Offre affichée : $index");
        },
      ),
      items: images.map((path) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(path, fit: BoxFit.cover),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.black54,
                    child: const Text(
                      "Offre spéciale -20%",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}