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
  final List<ProductOrderDto> shoppingBag;
  final String? errorMessage;

  const HomeState({
    required this.status,
    required this.products,
    required this.shoppingBag,
    this.errorMessage,
  });

  const HomeState.initial()
      : status = HomeStateStatus.initial,
        products = const [],
        shoppingBag = const [],
        errorMessage = null;

  HomeState copyWith({
    HomeStateStatus? status,
    List<ProductModel>? products,
    List<ProductOrderDto>? shoppingBag,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      products: products ?? this.products,
      shoppingBag: shoppingBag ?? this.shoppingBag,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, products, shoppingBag, errorMessage];
}
