import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/base_state/base_state.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/widgets/app_bar_logo.dart';
import '../../../core/widgets/button.dart';
import 'login_cubit.dart';
import 'login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage, LoginCubit> {
  final _formKey = GlobalKey<FormState>();

  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarLogo(),
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          return state.status.matchAny(
            login: () => showLoader(),
            any: () => hideLoader(),
            loginError: () {
              hideLoader();
              showError(state.errorMessage ?? '');
            },
            error: () {
              hideLoader();
              showError(state.errorMessage ?? '');
            },
            success: () {
              hideLoader();
              showSuccess('Login realizado com sucesso.');
              Navigator.of(context).pop(true);
            },
          );
        },
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Login', style: context.textStyles.textTitle),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _emailEC,
                        decoration: const InputDecoration(labelText: 'e-Mail'),
                        textInputAction: TextInputAction.next,
                        validator: Validatorless.multiple([
                          Validatorless.required(context.validatorMessage.required),
                          Validatorless.email(context.validatorMessage.email),
                        ]),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordEC,
                        decoration: const InputDecoration(labelText: 'Senha'),
                        textInputAction: TextInputAction.send,
                        obscureText: true,
                        validator: Validatorless.required(context.validatorMessage.required),
                      ),
                      const SizedBox(height: 20),
                      Button(
                        onPressed: () {
                          final formIsValid = _formKey.currentState?.validate() ?? false;

                          if (formIsValid) {
                            cubit.login(
                              _emailEC.text.trim(),
                              _passwordEC.text.trim(),
                            );
                          }
                        },
                        label: 'Entrar',
                        width: double.infinity,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Não possui uma conta?'),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/auth/register'),
                      child: Text(
                        'Cadastre-se',
                        style: context.textStyles.textBold.copyWith(color: Colors.blue),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
