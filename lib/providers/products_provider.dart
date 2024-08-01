import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

const apiUrl = "https://dummyjson.com/products/";

class ProductDetailNotifier extends Notifier<Map<String, dynamic>> {
  @override
  Map<String, dynamic> build() {
    return {};
  }

  void changeProductDetail(Map<String, dynamic> product) {
    state = product;
  }
}

final allProductProvider = FutureProvider<List<dynamic>>((ref) async {
  final response = await http.get(Uri.parse(apiUrl));
  if (response.statusCode == 200) {
    final List<dynamic> products = json.decode(response.body)['products'];
    // final aaa = products.map((json) => Product.fromJson(json)).toList();
    return products;
  } else {
    throw Exception("Failed to fetch products");
  }
});

final favoriteProductProvider = FutureProvider<List<dynamic>>((ref) async {
  final response = await http.get(Uri.parse(apiUrl));
  if (response.statusCode == 200) {
    final List<dynamic> products = json.decode(response.body)['products'];
    final List<dynamic> favorites =
        products.where((product) => product['rating'] > 4.5).toList();
    // final aaa = products.map((json) => Product.fromJson(json)).toList();
    return favorites;
  } else {
    throw Exception("Failed to fetch products");
  }
});

class ProductFilterNotifier extends Notifier<List<dynamic>> {
  @override
  build() {
    return [];
  }

  void applyFilter(List<dynamic> products) {
    state = products.where((product) {
      return product['title']
              .toLowerCase()
              .contains(ref.watch(searchQuery).toLowerCase()) ||
          product['description']
              .toLowerCase()
              .contains(ref.watch(searchQuery).toLowerCase());
    }).toList();
  }
}

final filteredProductProvider =
    NotifierProvider<ProductFilterNotifier, List<dynamic>>(
  () {
    return ProductFilterNotifier();
  },
);

final searchQuery = StateProvider<String>(
  (ref) => "",
);

final productDetailNotifierProvider =
    NotifierProvider<ProductDetailNotifier, Map<String, dynamic>>(() {
  return ProductDetailNotifier();
});
