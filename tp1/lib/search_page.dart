import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2, // le vert prend 2 parts
            child: Container(
              color: Colors.green,
              child: const Center(child: Text('Flex 2')),
            ),
          ),
          Expanded(
            flex: 1, // l'orange prend 1 part (1 est la valeur par défaut)
            child: Container(
              color: Colors.orange,
              child: const Center(child: Text('Flex 1')),
            ),
          ),
        ],
      ),
    );
  }
}