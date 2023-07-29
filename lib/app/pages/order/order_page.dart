import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/base_state/base_state.dart';
import '../../core/extensions/extensions.dart';
import '../../core/widgets/app_bar_logo.dart';
import '../../core/widgets/button.dart';
import '../../data/dto/product_order_dto.dart';
import '../../data/models/payment_type_model.dart';
import 'order_cubit.dart';
import 'order_state.dart';
import 'widgets/order_field.dart';
import 'widgets/order_product_tile.dart';
import 'widgets/payment_types.dart';

class OrderPage extends StatefulWidget {
  final List<ProductOrderDto> shoppingCart;

  const OrderPage({
    super.key,
    required this.shoppingCart,
  });

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends BaseState<OrderPage, OrderCubit> {
  final _formKey = GlobalKey<FormState>();

  final _addressEC = TextEditingController();
  final _cpfEC = TextEditingController();
  int? paymentTypeId;

  final paymentTypeValid = ValueNotifier<bool>(true);

  @override
  void onReady() {
    super.onReady();

    cubit.loadShoppingCart(widget.shoppingCart);
  }

  @override
  void dispose() {
    _addressEC.dispose();
    _cpfEC.dispose();

    super.dispose();
  }

  void _showRemoveProductFromCartConfirmation(OrderConfirmDeleteProductState state) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Deseja excluir o produto ${state.productOrder.product.name}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();

                cubit.cancelDeleteProcess();
              },
              child: Text(
                'Cancelar',
                style: context.textStyles.textBold.copyWith(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();

                cubit.decrementProduct(state.index);
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  void _showEmptyCartConfirmation() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Deseja limpar seu carrinho de compras?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancelar',
                style: context.textStyles.textBold.copyWith(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();

                cubit.emptyCart();
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(cubit.state.shoppingCart);

        return false;
      },
      child: Scaffold(
        appBar: AppBarLogo(),
        body: BlocListener<OrderCubit, OrderState>(
          listener: (context, state) {
            state.status.matchAny(
              loading: () => showLoader(),
              any: () => hideLoader(),
              error: () {
                hideLoader();
                showError(state.errorMessage ?? 'Erro não informado.');
              },
              confirmRemoveProduct: () {
                hideLoader();

                if (state is OrderConfirmDeleteProductState) {
                  _showRemoveProductFromCartConfirmation(state);
                }
              },
              emptyCart: () {
                showInfo(
                  'Seu carrinho de compras está vazio. Por favor, adicione mais produtos para realizar seu pedido.',
                );

                Navigator.of(context).pop(<ProductOrderDto>[]);
              },
              success: () {
                hideLoader();

                Navigator.of(context).popAndPushNamed(
                  '/order/completed',
                  result: <ProductOrderDto>[],
                );
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Text(
                        'Carrinho',
                        style: context.textStyles.textTitle,
                      ),
                      IconButton(
                        onPressed: _showEmptyCartConfirmation,
                        icon: Image.asset('assets/images/trashRegular.png'),
                      )
                    ],
                  ),
                ),
                BlocSelector<OrderCubit, OrderState, List<ProductOrderDto>>(
                  selector: (state) {
                    return state.shoppingCart;
                  },
                  builder: (context, shoppingCart) {
                    return SliverList.separated(
                      separatorBuilder: (context, index) =>
                          const Divider(height: 20, color: Colors.grey),
                      itemCount: shoppingCart.length,
                      itemBuilder: (context, index) {
                        final item = shoppingCart[index];

                        return OrderProductTile(
                          index: index,
                          productOrder: ProductOrderDto(
                            amount: item.amount,
                            product: item.product,
                          ),
                        );
                      },
                    );
                  },
                ),
                SliverToBoxAdapter(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        const Divider(height: 20, color: Colors.grey),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total do pedido',
                              style: context.textStyles.textExtraBold.copyWith(fontSize: 16),
                            ),
                            BlocSelector<OrderCubit, OrderState, double>(
                              selector: (state) {
                                return state.totalCart;
                              },
                              builder: (context, totalCart) {
                                return Text(
                                  totalCart.toCurrencyPtBr,
                                  style: context.textStyles.textExtraBold.copyWith(fontSize: 16),
                                );
                              },
                            ),
                          ],
                        ),
                        const Divider(height: 20, color: Colors.grey),
                        OrderField(
                          controller: _addressEC,
                          title: 'Endereço da entrega',
                          hintText: 'Digite o seu endereço',
                          validator: Validatorless.required(context.validatorMessage.required),
                        ),
                        const SizedBox(height: 10),
                        OrderField(
                          controller: _cpfEC,
                          title: 'CPF',
                          hintText: 'Digite o CPF',
                          validator: Validatorless.multiple([
                            Validatorless.required(context.validatorMessage.required),
                            Validatorless.cpf(context.validatorMessage.cpf),
                          ]),
                        ),
                        const SizedBox(height: 10),
                        BlocSelector<OrderCubit, OrderState, List<PaymentTypeModel>>(
                          selector: (state) => state.paymentTypes,
                          builder: (context, paymentTypes) {
                            return ValueListenableBuilder<bool>(
                              valueListenable: paymentTypeValid,
                              builder: (context, paymentTypeValidValue, child) {
                                return PaymentTypes(
                                  paymentTypes: paymentTypes,
                                  valueChanged: (value) {
                                    paymentTypeId = value;
                                  },
                                  valid: paymentTypeValidValue,
                                  selectedValue: paymentTypeId.toString(),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Divider(height: 30, color: Colors.grey),
                      Button(
                        onPressed: () {
                          final formIsValid = _formKey.currentState?.validate() ?? false;
                          final paymentTypeSelected = paymentTypeId != null;
                          paymentTypeValid.value = paymentTypeSelected;

                          if (formIsValid && paymentTypeSelected) {
                            cubit.saveOrder(
                              address: _addressEC.text.trim(),
                              cpf: _cpfEC.text.trim(),
                              paymentTypeId: paymentTypeId!,
                            );
                          }
                        },
                        label: 'Finalizar',
                        width: double.infinity,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
