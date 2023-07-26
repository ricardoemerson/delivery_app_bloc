import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../data/dto/product_order_dto.dart';
import '../../data/repositories/product/i_product_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final IProductRepository _productRepository;

  HomeCubit({
    required IProductRepository productRepository,
  })  : _productRepository = productRepository,
        super(const HomeState.initial());

  Future<void> loadProducts() async {
    try {
      emit(state.copyWith(status: HomeStateStatus.loading));

      await Future.delayed(const Duration(seconds: 1));

      final products = await _productRepository.findAll();

      emit(state.copyWith(status: HomeStateStatus.loaded, products: products));
    } on RepositoryException catch (err, s) {
      log('${err.message}', error: err, stackTrace: s);

      emit(state.copyWith(errorMessage: err.message));
    } on Exception catch (err, s) {
      log('Erro ao buscar produtos.', error: err, stackTrace: s);

      emit(state.copyWith(errorMessage: 'Erro ao buscar produtos.'));
    }
  }

  void addOrUpdateBag(ProductOrderDto productOrder) {
    final shoppingBag = [...state.shoppingBag];
    final index = shoppingBag.indexWhere((po) => po.product == productOrder.product);

    if (index > -1) {
      if (productOrder.amount == 0) {
        shoppingBag.removeAt(index);
      } else {
        shoppingBag[index] = productOrder;
      }
    } else {
      shoppingBag.add(productOrder);
    }

    emit(state.copyWith(shoppingBag: shoppingBag));
  }
}
