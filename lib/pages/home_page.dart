import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/product_model.dart';
import '../widgets/product_card.dart';
import 'detail_page.dart';
import 'favorites_page.dart'; // Favoriler sayfasını import etmeyi unutma

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Ürünleri hafızada tutmak için liste (Favori takibi için önemli)
  List<Product>? _products;

  // JSON'dan veri yükleme fonksiyonu
  Future<List<Product>> loadProducts() async {
    // Eğer ürünler zaten yüklendiyse tekrar yükleme (State korunur)
    if (_products != null) return _products!;

    final String response = await rootBundle.loadString(
      'assets/data/products.json',
    );
    final List<dynamic> data = json.decode(response);
    _products = data.map((json) => Product.fromJson(json)).toList();
    return _products!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mini Katalog"), centerTitle: true),
      // SOL AÇILIR MENÜ (SIDEBAR)
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepOrange),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.shopping_cart, color: Colors.white, size: 40),
                  SizedBox(height: 10),
                  Text(
                    "Menü",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Ana Sayfa"),
              onTap: () => Navigator.pop(context), // Sidebar'ı kapat
            ),
            ListTile(
              leading: const Icon(Icons.favorite, color: Colors.red),
              title: const Text("Favorilerim"),
              onTap: () {
                Navigator.pop(context); // Önce sidebar'ı kapat
                if (_products != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FavoritesPage(allProducts: _products!),
                    ),
                  ).then(
                    (_) => setState(() {}),
                  ); // Favoriler sayfasından dönünce kalpleri güncelle
                }
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Product>>(
        future: loadProducts(),
        builder: (context, snapshot) {
          // Yükleme durumu kontrolü
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // Hata kontrolü
          else if (snapshot.hasError) {
            return Center(child: Text("Hata: ${snapshot.error}"));
          }
          // Veri yoksa kontrolü
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Ürün bulunamadı."));
          }

          final products = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Yan yana 2 kart
              childAspectRatio: 0.75, // Kart oranı
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(
                product: product,
                onTap: () {
                  // Detay sayfasına geçiş ve argüman taşıma
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(product: product),
                    ),
                  ).then(
                    (_) => setState(() {}),
                  ); // Detaydan dönünce ana sayfadaki kalpleri güncelle
                },
              );
            },
          );
        },
      ),
    );
  }
}
