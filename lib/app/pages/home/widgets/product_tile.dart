import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extensions/extensions.dart';
import '../../../data/dto/product_order_dto.dart';
import '../../../data/models/product_model.dart';
import '../home_cubit.dart';

class ProductTile extends StatelessWidget {
  final ProductModel product;
  final ProductOrderDto? productOrder;

  const ProductTile({
    super.key,
    required this.product,
    this.productOrder,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final cubit = context.read<HomeCubit>();

        final response = await Navigator.pushNamed(
          context,
          '/products/detail',
          arguments: {
            'product': product,
            'productOrder': productOrder,
          },
        );

        if (response != null) {
          cubit.addOrUpdateCart(response as ProductOrderDto);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: context.textStyles.textExtraBold.copyWith(fontSize: 16),
                  ),
                  Text(
                    product.description,
                    style: context.textStyles.textRegular.copyWith(fontSize: 12),
                  ),
                  Text(
                    product.price.toCurrencyPtBr,
                    style: context.textStyles.textMedium.copyWith(
                      fontSize: 14,
                      color: context.colors.secondary,
                    ),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/loading.gif',
                image: product.image,
                imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                  'assets/images/image-error.png',
                  width: 100,
                  height: 100,
                ),
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
