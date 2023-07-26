import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/extensions/extensions.dart';
import '../../../data/dto/product_order_dto.dart';

class ShoppingCart extends StatelessWidget {
  final List<ProductOrderDto> productsOrder;

  const ShoppingCart({super.key, required this.productsOrder});

  Future<void> _navigateToOrder(BuildContext context) async {
    final navigatorContext = Navigator.of(context);
    final storage = await SharedPreferences.getInstance();

    if (!storage.containsKey('accessToken')) {
      final response = await navigatorContext.pushNamed('/auth/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalCart = productsOrder.fold(0.0, (total, element) => total += element.totalPrice);

    return Container(
      width: context.screenWidth,
      padding: const EdgeInsets.all(15),
      height: 80,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: ElevatedButton(
        onPressed: () => _navigateToOrder(context),
        child: Stack(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Icon(Icons.shopping_cart_outlined),
            ),
            const Align(child: Text('Ver Compras')),
            Align(
              alignment: Alignment.centerRight,
              child: Text(totalCart.toCurrencyPtBr),
            ),
          ],
        ),
      ),
    );
  }
}
