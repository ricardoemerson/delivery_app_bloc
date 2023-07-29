import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/widgets/increment_decrement_button.dart';
import '../../../data/dto/product_order_dto.dart';
import '../order_cubit.dart';

class OrderProductTile extends StatelessWidget {
  final int index;
  final ProductOrderDto productOrder;

  const OrderProductTile({
    super.key,
    required this.index,
    required this.productOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(
          productOrder.product.image,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productOrder.product.name,
                style: context.textStyles.textBold.copyWith(fontSize: 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    productOrder.totalPrice.toCurrencyPtBr,
                    style: context.textStyles.textMedium.copyWith(color: context.colors.secondary),
                  ),
                  IncrementDecrementButton.compact(
                    amount: productOrder.amount,
                    onIncrement: () {
                      context.read<OrderCubit>().incrementProduct(index);
                    },
                    onDecrement: () {
                      context.read<OrderCubit>().decrementProduct(index);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
