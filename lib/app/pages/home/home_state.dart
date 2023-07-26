import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import '../../data/dto/product_order_dto.dart';
import '../../data/models/product_model.dart';

part 'home_state.g.dart';

@match
enum HomeStateStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  final HomeStateStatus status;
  final List<ProductModel> products;
  final List<ProductOrderDto> shoppingCart;
  final String? errorMessage;

  const HomeState({
    required this.status,
    required this.products,
    required this.shoppingCart,
    this.errorMessage,
  });

  const HomeState.initial()
      : status = HomeStateStatus.initial,
        products = const [],
        shoppingCart = const [],
        errorMessage = null;

  HomeState copyWith({
    HomeStateStatus? status,
    List<ProductModel>? products,
    List<ProductOrderDto>? shoppingCart,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      products: products ?? this.products,
      shoppingCart: shoppingCart ?? this.shoppingCart,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, products, shoppingCart, errorMessage];

  @override
  String toString() {
    return 'HomeState(status: $status, products: $products, shoppingCart: $shoppingCart, errorMessage: $errorMessage)';
  }
}
