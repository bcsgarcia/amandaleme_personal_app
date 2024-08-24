import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:helpers/helpers.dart';

import '../../lib.dart';

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
                const KeepConnectedCheckbox(),
                const SizedBox(height: 20),
                _LoginButton(_formKey),
                const SizedBox(height: 20),
                if (context.read<MeetAppCubit>().appVersion != null)
                  Text(
                    'versão: ${context.read<MeetAppCubit>().appVersion}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
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

class KeepConnectedCheckbox extends StatelessWidget {
  const KeepConnectedCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: [
              InkWell(
                onTap: context.read<LoginCubit>().keepConnectedTap,
                child: AnimatedContainer(
                  height: 23,
                  width: 23,
                  duration: const Duration(milliseconds: 400),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: state.keepConnected ? primaryColor : Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: state.keepConnected
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 18,
                        )
                      : Container(),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Manter-me conectado',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Spacer(),
              // Text(
              //   'Recuperar senha',
              //   style: Theme.of(context).textTheme.bodyLarge,
              // ),
            ],
          ),
        );
      },
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
          buildWhen: (previous, current) => previous.emailInput != current.emailInput,
          builder: (context, state) {
            return TextFormField(
              key: const Key('loginForm_emailInput_textField'),
              scrollPadding: EdgeInsets.all(MediaQuery.of(context).size.height),
              onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
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
          buildWhen: (previous, current) => previous.passInput != current.passInput,
          builder: (context, state) {
            return TextField(
              key: const Key('loginForm_passwordInput_textField'),
              onChanged: (password) => context.read<LoginCubit>().passwordChanged(password),
              obscureText: showPass,
              decoration: InputDecoration(
                hintText: 'Insira sua senha',
                suffixIcon: showPass
                    ? IconButton(
                        splashRadius: 20,
                        onPressed: viewPassword,
                        icon: Image.asset('assets/images/icons/eye.png', height: 22),
                      )
                    : IconButton(
                        splashRadius: 20,
                        onPressed: viewPassword,
                        icon: Image.asset('assets/images/icons/eye-off.png', height: 22),
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
        final isValid = state.emailInput.isValid && state.passInput.value.isNotEmpty;

        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  key: const Key('loginForm_continue_raisedButton'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: isValid
                      ? () {
                          if (!formKey.currentState!.validate()) return;
                          context.read<LoginCubit>().authWithEmailAndPassword();
                        }
                      : null,
                  child: Text(
                    'Entrar',
                    style: TextStyle(
                      color: isValid ? Colors.white : Colors.grey,
                    ),
                  ),
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
