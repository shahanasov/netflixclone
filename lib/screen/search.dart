import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: (){

        }, icon: const Icon(Icons.search))],
      ),
      body: const Center(
        child: Icon(Icons.search),
      ),
    );
  }
}