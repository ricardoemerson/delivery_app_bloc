import 'package:bloc/bloc.dart';

class ProductDetailCubit extends Cubit<int> {
  ProductDetailCubit() : super(1);

  void increment() {
    emit(state + 1);
  }

  void decrement() {
    if (state > 1) emit(state - 1);
  }
}
