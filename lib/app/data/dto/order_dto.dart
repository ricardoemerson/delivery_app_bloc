import 'product_order_dto.dart';

class OrderDto {
  final List<ProductOrderDto> shoppingCart;
  final String address;
  final String cpf;
  final int paymentTypeId;

  OrderDto({
    required this.shoppingCart,
    required this.address,
    required this.cpf,
    required this.paymentTypeId,
  });
}
