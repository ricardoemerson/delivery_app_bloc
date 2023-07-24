import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../core/exceptions/repository_exception.dart';
import '../../../core/rest_client/rest_client.dart';
import '../../models/product_model.dart';
import 'i_product_repository.dart';

class ProductRepository implements IProductRepository {
  final RestClient _restClient;

  ProductRepository({
    required RestClient restClient,
  }) : _restClient = restClient;

  @override
  Future<List<ProductModel>> findAll() async {
    try {
      final response = await _restClient.publicRequest().get('/products');

      return response.data.map<ProductModel>((product) => ProductModel.fromMap(product)).toList();
    } on DioException catch (err, s) {
      const message = 'Erro ao buscar produtos';

      log(message, error: err, stackTrace: s);

      throw RepositoryException(message);
    }
  }
}
