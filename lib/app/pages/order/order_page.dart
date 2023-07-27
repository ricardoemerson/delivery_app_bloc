import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/extensions/extensions.dart';
import '../../core/widgets/app_bar_logo.dart';
import '../../core/widgets/button.dart';
import '../../data/dto/product_order_dto.dart';
import 'widgets/order_field.dart';
import 'widgets/order_product_tile.dart';
import 'widgets/payment_types.dart';

class OrderPage extends StatefulWidget {
  final List<ProductOrderDto> productOrder;

  const OrderPage({
    super.key,
    required this.productOrder,
  });

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final _formKey = GlobalKey<FormState>();

  final _enderecoEC = TextEditingController();

  @override
  void dispose() {
    _enderecoEC.dispose();

    super.dispose();
  }

  double totalCart() {
    return widget.productOrder.fold(0.0, (total, element) => total += element.totalPrice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarLogo(),
      body: Padding(
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
                    onPressed: () {},
                    icon: Image.asset('assets/images/trashRegular.png'),
                  )
                ],
              ),
            ),
            SliverList.separated(
              separatorBuilder: (context, index) => const Divider(height: 20, color: Colors.grey),
              itemCount: widget.productOrder.length,
              itemBuilder: (context, index) {
                final item = widget.productOrder[index];

                return OrderProductTile(
                  index: index,
                  productOrder: ProductOrderDto(
                    amount: item.amount,
                    product: item.product,
                  ),
                );
              },
            ),
            SliverToBoxAdapter(
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
                      Text(
                        totalCart().toCurrencyPtBr,
                        style: context.textStyles.textExtraBold.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                  const Divider(height: 20, color: Colors.grey),
                  OrderField(
                    controller: _enderecoEC,
                    title: 'Endereço da entrega',
                    hintText: 'Digite o seu endereço',
                    validator: Validatorless.required(context.validatorMessage.required),
                  ),
                  const SizedBox(height: 10),
                  OrderField(
                    controller: _enderecoEC,
                    title: 'CPF',
                    hintText: 'Digite o CPF',
                    validator: Validatorless.multiple([
                      Validatorless.required(context.validatorMessage.required),
                      Validatorless.cpf(context.validatorMessage.cpf),
                    ]),
                  ),
                  const SizedBox(height: 10),
                  const PaymentTypes(),
                ],
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Divider(height: 30, color: Colors.grey),
                  Button(
                    onPressed: () {},
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
    );
  }
}
