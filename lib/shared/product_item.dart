import 'package:aevue_technical/providers/products_provider.dart';
import 'package:aevue_technical/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductItem extends ConsumerWidget {
  const ProductItem({super.key, required this.product});
  final Map<String, dynamic> product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref
            .read(productDetailNotifierProvider.notifier)
            .changeProductDetail(product);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProductDetailScreen(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        // constraints:
        //     BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 100),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(5, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['title'],
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product['description'],
                    softWrap: true,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${product['price']}',
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Image.network(
              product['images'][0],
              height: 60,
              width: 60,
              fit: BoxFit.cover,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return const Icon(
                  Icons.error,
                  size: 60,
                  color: Colors.red,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
