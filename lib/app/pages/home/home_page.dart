import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/base_state/base_state.dart';
import '../../core/widgets/app_bar_logo.dart';
import '../../data/models/product_model.dart';
import 'cubit/home_cubit.dart';
import 'widgets/product_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeCubit> {
  @override
  void onReady() {
    cubit.loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarLogo(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocListener<HomeCubit, HomeState>(
          listener: (context, state) => state.maybeWhen(
            loading: () => showLoader(),
            error: (message) {
              hideLoader();
              return showError(message);
            },
            orElse: () => hideLoader(),
          ),
          child: Column(
            children: [
              Expanded(
                child: BlocSelector<HomeCubit, HomeState, List<ProductModel>>(
                  selector: (state) {
                    return state.maybeWhen(
                      loaded: (products) => products,
                      orElse: () => <ProductModel>[],
                    );
                  },
                  builder: (context, products) {
                    return RefreshIndicator(
                      onRefresh: () async => context.read<HomeCubit>().loadProducts(),
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];

                          return ProductTile(product: product);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
