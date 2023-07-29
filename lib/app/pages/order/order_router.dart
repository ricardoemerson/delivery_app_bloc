import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/dto/product_order_dto.dart';
import '../../data/repositories/order/i_order_repository.dart';
import '../../data/repositories/order/order_repository.dart';
import '../../data/repositories/payment_type/i_payment_type_repository.dart';
import '../../data/repositories/payment_type/payment_type_repository.dart';
import 'order_cubit.dart';
import 'order_page.dart';

class OrderRouter {
  OrderRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<IPaymentTypeRepository>(
            create: (context) => PaymentTypeRepository(restClient: context.read()),
          ),
          Provider<IOrderRepository>(
            create: (context) => OrderRepository(restClient: context.read()),
          ),
          Provider(
            create: (context) => OrderCubit(
              paymentTypeRepository: context.read(),
              orderRepository: context.read(),
            ),
          ),
        ],
        builder: (context, child) {
          final args = ModalRoute.of(context)?.settings.arguments as List<ProductOrderDto>;

          return OrderPage(shoppingCart: args);
        },
      );
}
