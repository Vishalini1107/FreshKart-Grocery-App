import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    final p = widget.product;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context)),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // IMAGE
            Center(
              child: Image.network(
                p['image'],
                height: 220,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            // PRICE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "\$${p['price']}",
                style: const TextStyle(fontSize: 22, color: Colors.green, fontWeight: FontWeight.bold),
              ),
            ),

            // NAME
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Text(
                p['name'],
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            // RATING
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 20),
                  Text("${p['rating']}  (${p['reviews']} reviews)",
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // DESCRIPTION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                p['description'] ?? "No description available.",
                style: const TextStyle(fontSize: 15, color: Colors.black87),
              ),
            ),

            const SizedBox(height: 25),

            // QUANTITY SELECTOR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Quantity",
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),

                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            if (qty > 1) setState(() => qty--);
                          },
                          icon: const Icon(Icons.remove_circle_outline)),
                      Text(qty.toString(), style: const TextStyle(fontSize: 18)),
                      IconButton(
                          onPressed: () => setState(() => qty++),
                          icon: const Icon(Icons.add_circle_outline)),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () {},
            child: const Text("Add to Cart", style: TextStyle(fontSize: 18)),
          ),
        ),
      ),
    );
  }
}