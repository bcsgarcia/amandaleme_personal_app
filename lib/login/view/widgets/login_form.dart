import 'package:amandaleme_personal_app/app/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

import '../../cubit/login_cubit.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final _formKey = GlobalKey<FormState>();

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Authentication Failure'),
              ),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _EmailInput(scrollController: _scrollController),
                const SizedBox(height: 10),
                _PasswordInput(),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Recuperar senha',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(height: 34),
                _LoginButton(_formKey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  final ScrollController scrollController;

  const _EmailInput({required this.scrollController});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'E-mail',
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: blackColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
          ),
        ),
        const SizedBox(height: 3),
        BlocBuilder<LoginCubit, LoginState>(
          buildWhen: (previous, current) =>
              previous.emailInput != current.emailInput,
          builder: (context, state) {
            return TextFormField(
              key: const Key('loginForm_emailInput_textField'),
              scrollPadding: EdgeInsets.all(MediaQuery.of(context).size.height),
              onChanged: (email) =>
                  context.read<LoginCubit>().emailChanged(email),
              keyboardType: TextInputType.emailAddress,
              validator: (_) => state.emailInput.displayError?.text(),
              decoration: const InputDecoration(
                hintText: 'Insira seu e-mail',
              ),
            );
          },
        ),
      ],
    );
  }
}

class _PasswordInput extends StatefulWidget {
  @override
  State<_PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<_PasswordInput> {
  bool showPass = true;

  viewPassword() {
    showPass = !showPass;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Senha',
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: blackColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
          ),
        ),
        const SizedBox(height: 3),
        BlocBuilder<LoginCubit, LoginState>(
          buildWhen: (previous, current) =>
              previous.passInput != current.passInput,
          builder: (context, state) {
            return TextField(
              key: const Key('loginForm_passwordInput_textField'),
              onChanged: (password) =>
                  context.read<LoginCubit>().passwordChanged(password),
              obscureText: showPass,
              decoration: InputDecoration(
                hintText: 'Inisra sua senha',
                suffixIcon: showPass
                    ? IconButton(
                        onPressed: viewPassword,
                        icon: const Icon(Icons.remove_red_eye_outlined),
                      )
                    : IconButton(
                        onPressed: viewPassword,
                        icon: const Icon(Icons.remove_red_eye_rounded),
                      ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton(this.formKey);

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  key: const Key('loginForm_continue_raisedButton'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: state.emailInput.isValid &&
                          state.passInput.value.isNotEmpty
                      ? () {
                          if (!formKey.currentState!.validate()) return;
                          context.read<LoginCubit>().authWithEmailAndPassword();
                        }
                      : null,
                  child: const Text('LOGIN'),
                ),
              );
      },
    );
  }
}

extension on EmailValidationError {
  String text() {
    switch (this) {
      case EmailValidationError.invalid:
        return 'Please ensure the email entered is valid';
    }
  }
}
