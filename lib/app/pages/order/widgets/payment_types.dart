import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';

import '../../../core/extensions/extensions.dart';

class PaymentTypes extends StatelessWidget {
  const PaymentTypes({super.key});

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
          selectedValue: '',
          modalType: S2ModalType.bottomSheet,
          onChange: (value) {},
          tileBuilder: (context, state) {
            return InkWell(
              onTap: state.showModal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: context.screenWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          state.selected.title ?? 'Selecione a forma de pagamento',
                          style: context.textStyles.textRegular.copyWith(fontSize: 16),
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          choiceItems: S2Choice.listFrom<String, Map<String, String>>(
            source: [
              {'value': 'VA', 'title': 'Vale Alimentação'},
              {'value': 'VR', 'title': 'Vale Refeição'},
              {'value': 'CC', 'title': 'Cartão de Crédito'},
            ],
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
