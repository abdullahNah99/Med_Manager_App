import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/core/utils/service_locator.dart';
import 'package:med_manager_app/features/authentication/data/repos/authentication_repo_impl.dart';
import 'package:med_manager_app/features/authentication/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:med_manager_app/features/authentication/presentation/screens/widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        authenticationRepo: getIt.get<AuthenticationRepoImpl>(),
      ),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: const Scaffold(
          body: LoginViewBody(),
        ),
      ),
    );
  }
}
