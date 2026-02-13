import 'package:flutter/material.dart';
import '../models/product_model.dart';

class DetailPage extends StatefulWidget {
  final Product product;
  const DetailPage({super.key, required this.product});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.product.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset(widget.product.image, height: 250),
            const SizedBox(height: 20),
            Text(
              widget.product.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              widget.product.price,
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 20),
            Text(widget.product.explanation, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  widget.product.isFavorite = !widget.product.isFavorite;
                });
              },
              icon: Icon(
                widget.product.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
              label: Text(widget.product.isFavorite ? "Favorilerden Çıkar" : "Favorilere Ekle"),
            ),
          ],
        ),
      ),
    );
  }
}