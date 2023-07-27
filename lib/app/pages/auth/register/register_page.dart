import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/base_state/base_state.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/widgets/button.dart';
import 'register_cubit.dart';
import 'register_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseState<RegisterPage, RegisterCubit> {
  final _formKey = GlobalKey<FormState>();

  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _nameEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RegisterPage'),
        centerTitle: true,
      ),
      body: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          return state.status.matchAny(
            register: () => showLoader(),
            any: () => hideLoader(),
            error: () {
              hideLoader();
              showError('Erro ao registrar usuário.');
            },
            success: () {
              hideLoader();
              showSuccess('Cadastro realizado com sucesso.');
              Navigator.of(context).pop();
            },
          );
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cadastro',
                    style: context.textStyles.textTitle,
                  ),
                  Text(
                    'Preencha os campos abaixo para criar o seu cadastro.',
                    style: context.textStyles.textMedium.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _nameEC,
                    decoration: const InputDecoration(labelText: 'Nome'),
                    textInputAction: TextInputAction.next,
                    validator: Validatorless.required(context.validatorMessage.required),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _emailEC,
                    decoration: const InputDecoration(labelText: 'e-Mail'),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    validator: Validatorless.multiple([
                      Validatorless.required(context.validatorMessage.required),
                      Validatorless.email(context.validatorMessage.email),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordEC,
                    decoration: const InputDecoration(labelText: 'Senha'),
                    textInputAction: TextInputAction.next,
                    obscureText: true,
                    validator: Validatorless.multiple([
                      Validatorless.required(context.validatorMessage.required),
                      Validatorless.min(6, context.validatorMessage.min(6)),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Confirmar senha'),
                    textInputAction: TextInputAction.send,
                    obscureText: true,
                    validator: Validatorless.multiple([
                      Validatorless.required(context.validatorMessage.required),
                      Validatorless.compare(_passwordEC, context.validatorMessage.compare)
                    ]),
                  ),
                  const SizedBox(height: 32),
                  Button(
                    onPressed: () {
                      final formIsValid = _formKey.currentState?.validate() ?? false;

                      if (formIsValid) {
                        cubit.register(
                          _nameEC.text.trim(),
                          _emailEC.text.trim(),
                          _passwordEC.text.trim(),
                        );
                      }
                    },
                    label: 'Cadastrar',
                    width: double.infinity,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
