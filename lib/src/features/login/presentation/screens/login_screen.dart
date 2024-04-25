import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:my_gallery/src/config/routes/app_route.dart';
import 'package:my_gallery/src/core/extenstions/empty_box_extention.dart';
import 'package:my_gallery/src/core/extenstions/navigator_extention.dart';
import 'package:my_gallery/src/core/extenstions/size_extention.dart';
import 'package:my_gallery/src/core/extenstions/toast_extention.dart';
import 'package:my_gallery/src/core/utils/app_colors.dart';
import 'package:my_gallery/src/core/utils/app_images.dart';
import 'package:my_gallery/src/core/utils/app_strings.dart';
import 'package:my_gallery/src/core/utils/app_values.dart';
import 'package:my_gallery/src/core/utils/constants.dart';
import 'package:my_gallery/src/core/widgets/customBottom.dart';
import 'package:my_gallery/src/core/widgets/loader.dart';
import 'package:my_gallery/src/features/login/data/data_source/datasource.dart';
import 'package:my_gallery/src/features/login/data/repository/repository.dart';
import 'package:my_gallery/src/features/login/domain/usecases/loginUseCase.dart';
import 'package:my_gallery/src/features/login/presentation/cubit/login_cubit.dart';
import 'package:my_gallery/src/features/login/presentation/widgets/customTextFormField.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoaderWidget.circularProgressIndicatorCenter();
          } else {
            final sharedPreferences = snapshot.data!;
            return BlocProvider(
              create: (context) => LoginCubit(
                loginUseCase: LoginUseCase(
                  repository: AuthRepository(
                    remoteDataSource: AuthRemoteDataSource(
                      apiClient: ApiClient(),
                    ),
                  ),
                ),
                sharedPreferences: sharedPreferences,
              ),
              child: BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is LoginSuccess) {
                    context.pushAndRemoveNamed(Routes.homeScreen);
                  } else if (state is LoginFailure) {
                    context.errorSnackBar(
                      AppStrings.errorHasOccured,
                      AppConstant.errorSnackbarDuration,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is LoginLoading) {
                    return LoaderWidget.circularProgressIndicatorCenter();
                  } else {
                    return _buildBackground(context, _buildLoginForm(context));
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildBackground(BuildContext context, Widget child) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.loginBackground),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                AppStrings.my,
                style: TextStyle(
                  color: AppColors.textColor,
                  fontSize: AppSize.s45,
                ),
              ),
              const Text(
                AppStrings.gellary,
                style: TextStyle(
                  color: AppColors.textColor,
                  fontSize: AppSize.s45,
                ),
              ),
              (context.height * 0.045).emptyBoxHeight,
              _buildLoginForm(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Container(
      height: context.height * 0.5,
      width: context.width * 0.7,
      padding: const EdgeInsets.symmetric(horizontal: AppSize.s16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s20),
        color: Colors.white.withOpacity(0.5),
      ),
      child: Column(
        children: [
          (context.height * 0.045).emptyBoxHeight,
          const Text(
            AppStrings.login,
            style: TextStyle(
              color: AppColors.textColor,
              fontSize: AppSize.s35,
            ),
          ),
          (context.height * 0.045).emptyBoxHeight,
          CustomTextField(
            labelText: '',
            hintText: AppStrings.userName,
            controller: emailController,
            validator: _validateEmail,
          ),
          (context.height * 0.045).emptyBoxHeight,
          CustomTextField(
            labelText: '',
            hintText: AppStrings.password,
            obscureText: true,
            controller: passwordController,
            validator: _validatePassword,
          ),
          (context.height * 0.045).emptyBoxHeight,
          CustomButton(
            text: AppStrings.submit,
            color: AppColors.buttonBlueColor,
            onPressed: () {
              final email = emailController.text.trim();
              final password = passwordController.text.trim();
              context.read<LoginCubit>().login(email, password);
            },
          ),
        ],
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }
}
