import 'package:flutter/material.dart';

class CartItem {
  final String cartId;
  final String productId;
  final String name;
  int quantity;
  final int stock;
  final int price;
  bool isSelected;
  final String? imageUrl;

  CartItem({
    required this.cartId,
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
    required this.stock,
    this.isSelected = false,
    this.imageUrl,
  });
}