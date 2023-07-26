import 'package:bloc/bloc.dart';

class ProductDetailCubit extends Cubit<int> {
  late final bool _hasProductOrder;

  ProductDetailCubit() : super(1);

  void initial(int amount, bool hasProductOrder) {
    _hasProductOrder = hasProductOrder;

    emit(amount);
  }

  void increment() {
    emit(state + 1);
  }

  void decrement() {
    if (state > (_hasProductOrder ? 0 : 1)) emit(state - 1);
  }
}
