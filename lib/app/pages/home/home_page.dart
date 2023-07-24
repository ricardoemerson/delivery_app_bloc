import 'package:flutter/material.dart';

import '../../core/mixins/loader_mixin.dart';
import '../../core/widgets/app_bar_logo.dart';
import '../../data/models/product_model.dart';
import 'widgets/product_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with LoaderMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarLogo(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 15,
                itemBuilder: (context, index) {
                  return ProductTile(
                    product: ProductModel(
                      id: 1,
                      name: 'X-Salada',
                      description:
                          'Lanche acompanha pão, hambúrguer, mussarela, alface, tomate e maionese',
                      price: 15.0,
                      image:
                          'https://assets.unileversolutions.com/recipes-v2/106684.jpg?imwidth=800',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
