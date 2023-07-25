import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cubit/product_detail_cubit.dart';
import 'product_detail_page.dart';

class ProductDetailRouter {
  ProductDetailRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(
            create: (context) => ProductDetailCubit(),
          ),
        ],
        builder: (context, child) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

          return ProductDetailPage(product: args['product']);
        },
      );
}
