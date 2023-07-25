import '../models/product_model.dart';

class ProductOrderDto {
  final ProductModel product;
  final int amount;

  ProductOrderDto({
    required this.product,
    required this.amount,
  });

  double get totalPrice => amount * product.price;
}
