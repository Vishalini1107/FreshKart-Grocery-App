import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  final String name;
  final String price;
  final String image;

  const ProductDetails(
      {super.key, required this.name, required this.price, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.network(image, height: 220),
            const SizedBox(height: 20),
            Text(name,
                style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 26)),
            const SizedBox(height: 8),
            Text(price,
                style: const TextStyle(fontSize: 22, color: Colors.green)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 50)),
              child: const Text("Add to Cart"),
            )
          ],
        ),
      ),
    );
  }
}
