import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/exceptions/repository_exception.dart';
import '../../../data/models/product_model.dart';
import '../../../data/repositories/product/i_product_repository.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final IProductRepository _productRepository;

  HomeCubit({
    required IProductRepository productRepository,
  })  : _productRepository = productRepository,
        super(const HomeState.initial());

  Future<void> loadProducts() async {
    try {
      emit(const HomeState.loading());

      await Future.delayed(const Duration(seconds: 1));

      final products = await _productRepository.findAll();

      emit(HomeState.loaded(products: products));
    } on RepositoryException catch (err, s) {
      log('${err.message}', error: err, stackTrace: s);

      emit(HomeState.error(message: err.message ?? 'Erro ao buscar produtos.'));
    } on Exception catch (err, s) {
      log('Erro ao buscar produtos.', error: err, stackTrace: s);

      emit(const HomeState.error(message: 'Erro ao buscar produtos.'));
    }
  }
}
