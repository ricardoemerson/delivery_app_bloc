import 'package:flutter/material.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/widgets/button.dart';

class OrderCompletedPage extends StatelessWidget {
  const OrderCompletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: context.percentHeight(.2)),
                Image.asset('assets/images/logo_rounded.png'),
                const SizedBox(height: 20),
                Text(
                  'Pedido realizado com sucesso, em breve você receberá a confirmação do seu pedido.',
                  style: context.textStyles.textMedium.copyWith(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Button(
                  onPressed: () => Navigator.of(context).pop(),
                  label: 'Fechar',
                  width: double.infinity,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
