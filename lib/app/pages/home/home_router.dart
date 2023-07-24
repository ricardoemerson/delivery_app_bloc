import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/product/i_product_repository.dart';
import '../../data/repositories/product/product_repository.dart';
import 'home_page.dart';

class HomeRouter {
  HomeRouter._();

  static Widget get page => MultiRepositoryProvider(
        providers: [
          RepositoryProvider<IProductRepository>(
            create: (context) => ProductRepository(restClient: context.read()),
          )
        ],
        child: const HomePage(),
      );
}
