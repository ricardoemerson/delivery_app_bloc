import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/dto/product_order_dto.dart';
import 'order_cubit.dart';
import 'order_page.dart';

class OrderRouter {
  OrderRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(
            create: (context) => OrderCubit(),
          ),
        ],
        builder: (context, child) {
          final args = ModalRoute.of(context)?.settings.arguments as List<ProductOrderDto>;

          return OrderPage(productOrder: args);
        },
      );
}
