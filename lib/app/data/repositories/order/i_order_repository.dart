import '../../dto/order_dto.dart';

abstract class IOrderRepository {
  Future<void> save(OrderDto order);
}
