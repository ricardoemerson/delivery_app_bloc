import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/base_state/base_state.dart';
import '../../core/extensions/extensions.dart';
import '../../core/widgets/app_bar_logo.dart';
import '../../core/widgets/increment_decrement_button.dart';
import '../../data/models/product_model.dart';
import 'cubit/product_detail_cubit.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends BaseState<ProductDetailPage, ProductDetailCubit> {
  @override
  void onReady() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarLogo(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: context.screenWidth,
            height: context.percentHeight(.4),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  widget.product.image,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              widget.product.name,
              style: context.textStyles.textExtraBold.copyWith(fontSize: 22),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Text(
                  widget.product.description,
                  style: context.textStyles.textRegular,
                ),
              ),
            ),
          ),
          const Divider(),
          BlocSelector<ProductDetailCubit, ProductDetailState, int>(
            selector: (state) {
              return state.maybeWhen(
                currentAmount: (amount) => amount,
                orElse: () => 1,
              );
            },
            builder: (context, amount) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: context.percentWidth(.5),
                    height: 68,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IncrementDecrementButton(
                        onDecrement: cubit.decrement,
                        onIncrement: cubit.increment,
                        amount: amount,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: context.percentWidth(.5),
                    height: 68,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Adicionar'),
                            Expanded(
                              child: AutoSizeText(
                                (widget.product.price * amount).toCurrencyPtBr,
                                maxFontSize: 14,
                                minFontSize: 5,
                                maxLines: 1,
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
