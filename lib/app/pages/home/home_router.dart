import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/repositories/product/i_product_repository.dart';
import '../../data/repositories/product/product_repository.dart';
import 'home_cubit.dart';
import 'home_page.dart';

class HomeRouter {
  HomeRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<IProductRepository>(
            create: (context) => ProductRepository(restClient: context.read()),
          ),
          Provider(
            create: (context) => HomeCubit(productRepository: context.read()),
          ),
        ],
        child: const HomePage(),
      );
}
