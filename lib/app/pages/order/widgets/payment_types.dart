import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';

import '../../../core/extensions/extensions.dart';
import '../../../data/models/payment_type_model.dart';

class PaymentTypes extends StatelessWidget {
  final List<PaymentTypeModel> paymentTypes;
  final ValueChanged<int> valueChanged;
  final bool valid;
  final String selectedValue;

  const PaymentTypes({
    super.key,
    required this.paymentTypes,
    required this.valueChanged,
    required this.valid,
    required this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Forma de pagamento',
          style: context.textStyles.textMedium.copyWith(fontSize: 16),
        ),
        const SizedBox(height: 10),
        SmartSelect<String>.single(
          title: '',
          selectedValue: selectedValue,
          modalType: S2ModalType.bottomSheet,
          onChange: (selected) => valueChanged(int.parse(selected.value)),
          tileBuilder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: state.showModal,
                  child: Container(
                    width: context.screenWidth,
                    padding: EdgeInsets.only(left: 15, right: 5, top: 10, bottom: valid ? 5 : 10),
                    decoration: !valid
                        ? BoxDecoration(
                            border: Border.all(color: Colors.red),
                            borderRadius: BorderRadius.circular(7),
                          )
                        : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          state.selected.title ?? 'Selecione a forma de pagamento',
                          style: context.textStyles.textRegular
                              .copyWith(fontSize: 16, color: context.colors.greyText),
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: valid,
                  child: const Divider(color: Colors.grey, thickness: 1),
                ),
                Visibility(
                  visible: !valid,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Por favor, selecione uma opção de pagamento',
                      style:
                          context.textStyles.textRegular.copyWith(color: Colors.red, fontSize: 12),
                    ),
                  ),
                ),
              ],
            );
          },
          choiceItems: S2Choice.listFrom<String, Map<String, String>>(
            source: paymentTypes.map((p) => {'value': p.id.toString(), 'title': p.name}).toList(),
            title: (index, item) => item['title'] ?? '',
            value: (index, item) => item['value'] ?? '',
            group: (index, item) => 'Selecione uma forma de pagamento',
          ),
          choiceType: S2ChoiceType.radios,
          choiceGrouped: true,
          modalFilter: false,
          placeholder: 'Teste',
        ),
      ],
    );
  }
}
