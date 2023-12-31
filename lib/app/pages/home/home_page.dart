import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/base_state/base_state.dart';
import '../../core/widgets/app_bar_logo.dart';
import 'home_cubit.dart';
import 'home_state.dart';
import 'widgets/product_tile.dart';
import 'widgets/shopping_cart.dart';

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
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          state.status.matchAny(
            any: () => hideLoader(),
            loading: () => showLoader(),
            error: () {
              hideLoader();
              showError(state.errorMessage ?? 'Erro não informado.');
            },
          );
        },
        buildWhen: (previous, current) => current.status.matchAny(
          any: () => false,
          initial: () => true,
          loaded: () => true,
        ),
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async => context.read<HomeCubit>().loadProducts(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        final orders =
                            state.shoppingCart.where((order) => order.product == product);

                        return ProductTile(
                          product: product,
                          productOrder: orders.isNotEmpty ? orders.first : null,
                        );
                      },
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: state.shoppingCart.isNotEmpty,
                child: ShoppingCart(shoppingCart: state.shoppingCart),
              ),
            ],
          );
        },
      ),
    );
  }
}
