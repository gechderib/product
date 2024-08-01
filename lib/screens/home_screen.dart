import 'package:aevue_technical/providers/products_provider.dart';
import 'package:aevue_technical/shared/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(allProductProvider);
    final filteredProducts = ref.watch(filteredProductProvider);
    final searchText = ref.watch(searchQuery);

    return Column(
      children: [
        Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 5),
            ),
          ]),
          child: TextFormField(
            onChanged: (value) {
              final prods = products.asData?.value ?? [];
              ref.read(searchQuery.notifier).state = value.toString();
              ref.read(filteredProductProvider.notifier).applyFilter(prods);
            },
            decoration: const InputDecoration(
              hintText: "Search for product",
              prefixIcon: Icon(Icons.search),
              hintStyle: TextStyle(height: 3.5),
              filled: true,
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 209, 209, 209)),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 255, 255, 255))),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: const BoxDecoration(),
            child: products.when(
              data: (products) {
                final displayProducts =
                    searchText.isEmpty ? products : filteredProducts;

                return ListView.builder(
                  itemCount: displayProducts.length,
                  itemBuilder: (context, index) {
                    final productItem = displayProducts[index];
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
