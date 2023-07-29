import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/base_state/base_state.dart';
import '../../core/extensions/extensions.dart';
import '../../core/widgets/app_bar_logo.dart';
import '../../core/widgets/increment_decrement_button.dart';
import '../../data/dto/product_order_dto.dart';
import '../../data/models/product_model.dart';
import 'product_detail_cubit.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel product;
  final ProductOrderDto? productOrder;

  const ProductDetailPage({super.key, required this.product, this.productOrder});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends BaseState<ProductDetailPage, ProductDetailCubit> {
  @override
  void initState() {
    super.initState();

    final amount = widget.productOrder?.amount ?? 1;

    cubit.initial(amount, widget.productOrder != null);
  }

  void _navigateBack(BuildContext context, int amount) {
    Navigator.of(context).pop(
      ProductOrderDto(product: widget.product, amount: amount),
    );
  }

  void _showConfirmDelete(int amount) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Deseja excluir o produto?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancelar',
                style: context.textStyles.textBold.copyWith(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();

                _navigateBack(context, amount);
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Text(
                      widget.product.description,
                      style: context.textStyles.textRegular,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.product.price.toCurrencyPtBr,
                    style: context.textStyles.textMedium
                        .copyWith(fontSize: 16, color: context.colors.secondary),
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
          BlocBuilder<ProductDetailCubit, int>(
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
                        style: amount == 0
                            ? ElevatedButton.styleFrom(backgroundColor: Colors.red)
                            : null,
                        onPressed: () {
                          if (amount == 0) {
                            _showConfirmDelete(amount);
                          } else {
                            _navigateBack(context, amount);
                          }
                        },
                        child: Visibility(
                          visible: amount > 0,
                          replacement: const Text('Excluir item'),
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
