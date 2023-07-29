import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../data/dto/order_dto.dart';
import '../../data/dto/product_order_dto.dart';
import '../../data/repositories/order/i_order_repository.dart';
import '../../data/repositories/payment_type/i_payment_type_repository.dart';
import 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final IPaymentTypeRepository _paymentTypeRepository;
  final IOrderRepository _orderRepository;

  OrderCubit({
    required IPaymentTypeRepository paymentTypeRepository,
    required IOrderRepository orderRepository,
  })  : _paymentTypeRepository = paymentTypeRepository,
        _orderRepository = orderRepository,
        super(const OrderState.initial());

  Future<void> loadShoppingCart(List<ProductOrderDto> shoppingCart) async {
    try {
      emit(state.copyWith(status: OrderStatus.loading));

      final paymentTypes = await _paymentTypeRepository.findAll();

      emit(
        state.copyWith(
          status: OrderStatus.loaded,
          shoppingCart: shoppingCart,
          paymentTypes: paymentTypes,
        ),
      );
    } on RepositoryException catch (err, s) {
      const message = 'Erro ao carregar página.';

      log(err.message ?? message, error: err, stackTrace: s);

      emit(state.copyWith(status: OrderStatus.error, errorMessage: err.message ?? message));
    }
  }

  void incrementProduct(int index) {
    final shoppingCart = [...state.shoppingCart];
    final productOrder = shoppingCart[index];

    shoppingCart[index] = productOrder.copyWith(amount: productOrder.amount + 1);

    emit(state.copyWith(status: OrderStatus.updateOrder, shoppingCart: shoppingCart));
  }

  void decrementProduct(int index) {
    final shoppingCart = [...state.shoppingCart];
    final productOrder = shoppingCart[index];
    final amount = productOrder.amount;

    if (amount == 1) {
      if (state.status != OrderStatus.confirmRemoveProduct) {
        emit(
          OrderConfirmDeleteProductState(
            index: index,
            productOrder: productOrder,
            status: OrderStatus.confirmRemoveProduct,
            paymentTypes: state.paymentTypes,
            shoppingCart: state.shoppingCart,
            errorMessage: state.errorMessage,
          ),
        );

        return;
      } else {
        shoppingCart.removeAt(index);
      }
    } else {
      shoppingCart[index] = productOrder.copyWith(amount: productOrder.amount - 1);
    }

    if (shoppingCart.isEmpty) {
      emit(state.copyWith(status: OrderStatus.emptyCart));

      return;
    }

    emit(state.copyWith(status: OrderStatus.updateOrder, shoppingCart: shoppingCart));
  }

  void cancelDeleteProcess() {
    emit(state.copyWith(status: OrderStatus.loaded));
  }

  void emptyCart() {
    emit(state.copyWith(status: OrderStatus.emptyCart));
  }

  Future<void> saveOrder({
    required String address,
    required String cpf,
    required int paymentTypeId,
  }) async {
    try {
      emit(state.copyWith(status: OrderStatus.loading));

      await _orderRepository.save(
        OrderDto(
          shoppingCart: state.shoppingCart,
          address: address,
          cpf: cpf,
          paymentTypeId: paymentTypeId,
        ),
      );

      emit(state.copyWith(status: OrderStatus.success));
    } on RepositoryException catch (err, s) {
      const message = 'Erro ao salvar pedido.';

      log(err.message ?? message, error: err, stackTrace: s);

      emit(state.copyWith(status: OrderStatus.error, errorMessage: err.message ?? message));
    }
  }
}
