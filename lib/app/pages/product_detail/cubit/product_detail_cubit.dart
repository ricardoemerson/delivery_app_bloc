import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_detail_cubit.freezed.dart';
part 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit() : super(const ProductDetailState.initial(amount: 1));

  void increment() {
    final amount = state.amount;

    emit(ProductDetailState.currentAmount(amount: amount + 1));
  }

  void decrement() {
    final amount = state.amount;

    if (amount > 1) emit(ProductDetailState.currentAmount(amount: amount - 1));
  }
}
