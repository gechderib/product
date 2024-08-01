import 'package:aevue_technical/providers/products_provider.dart';
import 'package:aevue_technical/shared/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(favoriteProductProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Favorite Products",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Text("Tap on a product to view details"),
              SizedBox(height: 5),
              Divider(),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: const BoxDecoration(),
            child: products.when(
              data: (product) {
                return ListView.builder(
                  itemCount: product.length,
                  itemBuilder: (context, index) {
                    final productItem = product[index];
                    return Column(
                      children: [
                        ProductItem(product: productItem),
                        const SizedBox(height: 10)
                      ],
                    );
                  },
                );
              },
              error: (err, stackTrace) => const Center(
                child: Text("Faild to load products"),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
