import 'package:csm_front/ui/pages/home_page/home_page.dart';
import 'package:csm_front/ui/pages/login_page/login_page_cubit.dart';
import 'package:csm_front/ui/pages/login_page/login_page_states.dart';
import 'package:csm_front/ui/widgets/main_layout.dart';
import 'package:csm_front/ui/widgets/my_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginPageCubit>();

    return MainLayout(
      body: BlocListener(
        bloc: cubit,
        listener: (BuildContext context, state) {
          if (state is LoginPageSuccessState) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const HomePage(),
              ),
            );
          }
        },
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              MyTextFormField(
                validator: (value) => cubit.combine(value, [
                  cubit.notEmpty,
                  cubit.isValidEmail,
                ]),
                onSaved: cubit.setEmail,
              ),
              const SizedBox(height: 16.0),
              MyTextFormField(
                validator: (value) => cubit.combine(value, [
                  cubit.notEmpty,
                  cubit.isValidPassword,
                ]),
                onSaved: cubit.setPassword,
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => cubit.onLoginButtonPressed(_formKey),
                  child: const Text('Login'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
