import 'package:flutter/material.dart';

class CartItem {
  final String name;
  int quantity;
  final int price;
  bool isSelected;

  CartItem({
    required this.name,
    required this.quantity,
    required this.price,
    this.isSelected = false,
  });
}