import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  const CartPage({super.key, required this.cartItems});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<Map<String, dynamic>> items;

  @override
  void initState() {
    super.initState();
    // deep copy
    items = widget.cartItems.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  double get subtotal {
    double sum = 0;
    for (var it in items) {
      final price = it['price'] as double? ?? 0.0;
      final qty = it['qty'] as int? ?? 1;
      sum += price * qty;
    }
    return sum;
  }

  void increaseQty(int index) {
    setState(() {
      items[index]['qty'] = (items[index]['qty'] as int) + 1;
    });
  }

  void decreaseQty(int index) {
    setState(() {
      if ((items[index]['qty'] as int) > 1) {
        items[index]['qty'] = (items[index]['qty'] as int) - 1;
      }
    });
  }

  void removeItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    const double shipping = 1.6;
    final double total = subtotal + (items.isEmpty ? 0 : shipping);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text("Shopping Cart",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold)),
      ),

      body: Column(
        children: [
          Expanded(
            child: items.isEmpty
                ? Center(
                child: Text("Your cart is empty",
                    style: TextStyle(fontSize: 16)))
                : ListView.separated(
              padding: EdgeInsets.all(16),
              itemCount: items.length,
              separatorBuilder: (_, __) => SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = items[index];

                return Dismissible(
                  key: ValueKey(item['name'] + index.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                    color: Colors.red,
                    child: Icon(Icons.delete, color: Colors.white),
                  ),

                  // remove item when swiped
                  onDismissed: (_) {
                    removeItem(index);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${item['name']} removed from cart"),
                      ),
                    );
                  },

                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            item['image'],
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "\$${(item['price'] as double).toStringAsFixed(2)} x ${item['qty']}",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 4),
                              Text(item['name'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 4),
                              Text(item['unit'] ?? "1 pcs",
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12)),
                            ],
                          ),
                        ),

                        Column(
                          children: [
                            IconButton(
                              onPressed: () => increaseQty(index),
                              icon: Icon(Icons.add_circle_outline,
                                  color: Colors.green),
                            ),
                            Text("${item['qty']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold)),
                            IconButton(
                              onPressed: () => decreaseQty(index),
                              icon: Icon(Icons.remove_circle_outline,
                                  color: Colors.green),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // SUMMARY + CHECKOUT
          Container(
            padding:
            EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              border:
              Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Subtotal",
                        style: TextStyle(color: Colors.grey[700])),
                    Text("\$${subtotal.toStringAsFixed(2)}"),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Shipping charges",
                        style: TextStyle(
                            color: Colors.grey[700], fontSize: 13)),
                    Text(items.isEmpty
                        ? "\$0.00"
                        : "\$${shipping.toStringAsFixed(2)}"),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    Text("\$${total.toStringAsFixed(2)}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: items.isEmpty
                        ? null
                        : () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text("Checkout pressed")),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Text("Checkout", style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
