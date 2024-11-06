import 'package:awesome_app/core/constant/auth_constant.dart';
import 'package:awesome_app/core/route/routes.dart';
import 'package:awesome_app/global/presentation/bloc/auth_cubit.dart';
import 'package:awesome_app/global/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthCubit, AuthState>(
          listener: (_, state) {
            if (state.status == AuthStatus.authenticated) {
              context.goNamed(Routes.home);
            }
          },
        ),
      ],
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Login Page"),
              const SizedBox(height: 32),
              ElevatedButton(
                child: const Text("Login"),
                onPressed: () {
                  context.read<AuthCubit>().authenticate(
                        userId: "dslkfjhsa",
                        accessToken: "dslkjfhsja;",
                      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
