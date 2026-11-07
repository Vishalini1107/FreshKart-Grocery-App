import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Categories", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: const [
            categoryTile(Icons.eco, "Vegetables"),
            categoryTile(Icons.local_florist, "Fruits"),
            categoryTile(Icons.local_drink, "Beverages"),
            categoryTile(Icons.store, "Grocery"),
            categoryTile(Icons.cookie, "Edibles"),
            categoryTile(Icons.cleaning_services, "Household"),
          ],
        ),
      ),
    );
  }
}

class categoryTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const categoryTile(this.icon, this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context, title);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.green.shade100,
              child: Icon(icon, color: Colors.green),
            ),
            SizedBox(height: 8),
            Text(title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
