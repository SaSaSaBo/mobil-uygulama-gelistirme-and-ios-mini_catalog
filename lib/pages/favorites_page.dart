import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../widgets/product_card.dart';
import 'detail_page.dart';

class FavoritesPage extends StatelessWidget {
  final List<Product> allProducts; // Ana sayfadan gelen tüm ürünler

  const FavoritesPage({super.key, required this.allProducts});

  @override
  Widget build(BuildContext context) {
    // Sadece favori olanları filtrele
    final favoriteProducts = allProducts.where((p) => p.isFavorite).toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Favorilerim")),
      body: favoriteProducts.isEmpty
          ? const Center(child: Text("Henüz favori ürününüz yok."))
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  product: favoriteProducts[index],
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(product: favoriteProducts[index]),
                    ),
                  ),
                );
              },
            ),
    );
  }
}