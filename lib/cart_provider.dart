import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<Map<String, dynamic>> cartItems = [];

  void addToCart(Map<String, dynamic> product) {
    bool isExist = false;

    for (var item in cartItems) {
      if (item['name'] == product['name']) {
        item['quantity']++;
        isExist = true;
        break;
      }
    }

    if (!isExist) {
      cartItems.add({
        "name": product['name'],
        "price": product['price'],
        "image": product['image'],
        "quantity": 1,
      });
    }

    notifyListeners();
  }

  void removeItem(int index) {
    cartItems.removeAt(index);
    notifyListeners();
  }

  void increaseQuantity(int index) {
    cartItems[index]['quantity']++;
    notifyListeners();
  }

  void decreaseQuantity(int index) {
    if (cartItems[index]['quantity'] > 1) {
      cartItems[index]['quantity']--;
    }
    notifyListeners();
  }

  double get totalPrice {
    double total = 0.0;
    for (var item in cartItems) {
      total += (double.parse(item['price']) * item['quantity']);
    }
    return total;
  }
}
