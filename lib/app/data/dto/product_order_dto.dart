import '../models/product_model.dart';

class ProductOrderDto {
  final ProductModel product;
  final int amount;

  ProductOrderDto({
    required this.product,
    required this.amount,
  });

  double get totalPrice => amount * product.price;

  ProductOrderDto copyWith({
    ProductModel? product,
    int? amount,
  }) {
    return ProductOrderDto(
      product: product ?? this.product,
      amount: amount ?? this.amount,
    );
  }

  @override
  String toString() => 'ProductOrderDto(product: $product, amount: $amount)';
}
