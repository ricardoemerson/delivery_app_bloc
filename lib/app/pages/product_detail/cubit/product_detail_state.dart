part of 'product_detail_cubit.dart';

@freezed
class ProductDetailState with _$ProductDetailState {
  const factory ProductDetailState.initial({required int amount}) = _Initial;
  const factory ProductDetailState.currentAmount({required int amount}) = _CurrentAmount;
}
