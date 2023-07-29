import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import '../../data/dto/product_order_dto.dart';
import '../../data/models/payment_type_model.dart';

part 'order_state.g.dart';

@match
enum OrderStatus {
  initial,
  loading,
  loaded,
  updateOrder,
  confirmRemoveProduct,
  emptyCart,
  error,
  success
}

class OrderState extends Equatable {
  final OrderStatus status;
  final List<ProductOrderDto> shoppingCart;
  final List<PaymentTypeModel> paymentTypes;
  final String? errorMessage;

  const OrderState({
    required this.status,
    required this.shoppingCart,
    required this.paymentTypes,
    this.errorMessage,
  });

  const OrderState.initial()
      : status = OrderStatus.initial,
        shoppingCart = const [],
        paymentTypes = const [],
        errorMessage = null;

  double get totalCart => shoppingCart.fold(0.0, (total, element) => total += element.totalPrice);

  OrderState copyWith({
    OrderStatus? status,
    List<ProductOrderDto>? shoppingCart,
    List<PaymentTypeModel>? paymentTypes,
    String? errorMessage,
  }) {
    return OrderState(
      status: status ?? this.status,
      shoppingCart: shoppingCart ?? this.shoppingCart,
      paymentTypes: paymentTypes ?? this.paymentTypes,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, shoppingCart, paymentTypes, errorMessage];

  @override
  String toString() {
    return 'OrderState(status: $status, shoppingCart: $shoppingCart, paymentTypes: $paymentTypes, errorMessage: $errorMessage)';
  }
}

class OrderConfirmDeleteProductState extends OrderState {
  final ProductOrderDto productOrder;
  final int index;

  const OrderConfirmDeleteProductState({
    required super.status,
    required super.shoppingCart,
    required super.paymentTypes,
    super.errorMessage,
    required this.productOrder,
    required this.index,
  });
}
