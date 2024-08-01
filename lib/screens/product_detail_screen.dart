import 'package:aevue_technical/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productDetailNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product["title"].toString(),
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(product["thumbnail"].toString()),
              ),
              const SizedBox(height: 16.0),
              Text(
                product["title"].toString(),
                style: const TextStyle(
                    fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(
                "\$${product["price"]}",
                style: const TextStyle(fontSize: 20.0, color: Colors.green),
              ),
              const SizedBox(height: 8.0),
              Text(
                "Rating: ${product["rating"]}",
                style: const TextStyle(fontSize: 16.0, color: Colors.orange),
              ),
              const SizedBox(height: 8.0),
              Text(product["description"].toString()),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Text(
                    "Category: ${product["category"]}",
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(width: 16.0),
                  Text(
                    "Brand: ${product["brand"]}",
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Text(
                "Availability Status: ${product["availabilityStatus"]}",
                style: const TextStyle(fontSize: 16.0, color: Colors.red),
              ),
              const SizedBox(height: 16.0),
              Text(
                "Warranty: ${product["warrantyInformation"]}",
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 16.0),
              Text(
                "Shipping: ${product["shippingInformation"]}",
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 16.0),
              Text(
                "Return Policy: ${product["returnPolicy"]}",
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 16.0),
              Text(
                "Minimum Order Quantity: ${product["minimumOrderQuantity"]}",
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 16.0),
              Text(
                "Dimensions: ${(product["dimensions"] as Map)["width"]} x ${(product["dimensions"] as Map)["height"]} x ${(product["dimensions"] as Map)["depth"]}",
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 16.0),
              Text(
                "Weight: ${product["weight"]}",
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 16.0),
              Text(
                "SKU: ${product["sku"]}",
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 16.0),
              Image.network((product["meta"] as Map)["qrCode"]),
              const SizedBox(height: 16.0),
              const Text(
                "Reviews",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              ...(product["reviews"] as List<dynamic>).map((review) {
                return ListTile(
                  title: Text(review["reviewerName"]),
                  subtitle: Text(review["comment"]),
                  trailing: Text("Rating: ${review["rating"]}"),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
