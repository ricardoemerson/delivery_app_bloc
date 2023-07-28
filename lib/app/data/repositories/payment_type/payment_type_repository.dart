import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../core/exceptions/repository_exception.dart';
import '../../../core/rest_client/rest_client.dart';
import '../../models/payment_type_model.dart';
import 'i_payment_type_repository.dart';

class PaymentTypeRepository implements IPaymentTypeRepository {
  final RestClient _restClient;

  PaymentTypeRepository({
    required RestClient restClient,
  }) : _restClient = restClient;

  @override
  Future<List<PaymentTypeModel>> findAll() async {
    try {
      final response = await _restClient.authRequest().get('/payment-types');

      return response.data
          .map<PaymentTypeModel>((paymentType) => PaymentTypeModel.fromMap(paymentType))
          .toList();
    } on DioException catch (err, s) {
      const message = 'Erro ao buscar tipos de pagamento.';

      log(message, error: err, stackTrace: s);

      throw RepositoryException(message);
    }
  }
}
