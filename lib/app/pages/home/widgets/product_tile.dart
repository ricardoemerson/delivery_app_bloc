import 'package:flutter/material.dart';

import '../../../core/extensions/extensions.dart';
import '../../../data/models/product_model.dart';

class ProductTile extends StatelessWidget {
  final ProductModel product;

  const ProductTile({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
