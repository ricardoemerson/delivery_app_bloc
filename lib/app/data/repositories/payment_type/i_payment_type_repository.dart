import '../../models/payment_type_model.dart';

abstract class IPaymentTypeRepository {
  Future<List<PaymentTypeModel>> findAll();
}
