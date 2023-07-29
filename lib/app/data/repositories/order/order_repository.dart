import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../core/exceptions/repository_exception.dart';
import '../../../core/rest_client/rest_client.dart';
import '../../dto/order_dto.dart';
import 'i_order_repository.dart';

class OrderRepository implements IOrderRepository {
  final RestClient _restClient;

  OrderRepository({
    required RestClient restClient,
  }) : _restClient = restClient;

  @override
  Future<void> save(OrderDto order) async {
    try {
      await _restClient.authRequest().post(
        '/orders',
        data: {
          'products': order.shoppingCart
              .map(
                (e) => {
                  'id': e.product.id,
                  'amount': e.amount,
                  'total_price': e.totalPrice,
                },
              )
              .toList(),
          'user_id': '#userAuthRef',
          'address': order.address,
          'CPF': order.cpf,
          'payment_method_id': order.paymentTypeId,
        },
      );
    } on DioException catch (err, s) {
      const message = 'Erro ao registrar pedido';

      log(message, error: err, stackTrace: s);

      throw RepositoryException(message);
    }
  }
}
