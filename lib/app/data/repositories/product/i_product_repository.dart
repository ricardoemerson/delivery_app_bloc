import '../../models/product_model.dart';

abstract class IProductRepository {
  Future<List<ProductModel>> findAll();
}
