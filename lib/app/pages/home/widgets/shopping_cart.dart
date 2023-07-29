import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/extensions/extensions.dart';
import '../../../data/dto/product_order_dto.dart';
import '../home_cubit.dart';

class ShoppingCart extends StatelessWidget {
  final List<ProductOrderDto> shoppingCart;

  const ShoppingCart({super.key, required this.shoppingCart});

  Future<void> _navigateToOrder(BuildContext context) async {
    final navigatorContext = Navigator.of(context);
    final cubit = context.read<HomeCubit>();
    final storage = await SharedPreferences.getInstance();

    if (!storage.containsKey('accessToken')) {
      final response = await navigatorContext.pushNamed('/auth/login');

      if (response == null || response == false) {
        return;
      }
    }

    final updatedShoppingCart = await navigatorContext.pushNamed('/order', arguments: shoppingCart);
    cubit.updateShoppingCart(updatedShoppingCart as List<ProductOrderDto>);
  }

  @override
  Widget build(BuildContext context) {
    final totalCart = shoppingCart.fold(0.0, (total, element) => total += element.totalPrice);

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
