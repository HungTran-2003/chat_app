import 'package:chat_app/core/constants/ui_constants.dart';
import 'package:chat_app/core/extensions/num_extension.dart';
import 'package:chat_app/core/theme/app_text_styles.dart';
import 'package:chat_app/core/utlis/validator.dart';
import 'package:chat_app/core/widgets/button/app_back_button.dart';
import 'package:chat_app/core/widgets/button/app_filled_button.dart';
import 'package:chat_app/core/widgets/loading/app_loading_overlay.dart';
import 'package:chat_app/core/widgets/text/app_text_rich.dart';
import 'package:chat_app/core/widgets/text_field/app_text_field.dart';
import 'package:chat_app/core/widgets/text_field/password_text_field.dart';
import 'package:chat_app/domain/models/enum/status_type.dart';
import 'package:chat_app/features/auth/register/register_cubit.dart';
import 'package:chat_app/features/auth/register/register_navigator.dart';
import 'package:chat_app/features/auth/widgets/auth_text/auth_text_high_light.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterCubit>(
      create: (context) {
        return RegisterCubit(
          navigator: RegisterNavigator(context: context),
          authRepository: context.read(),
        );
      },
      child: const RegisterChildPage(),
    );
  }
}

class RegisterChildPage extends StatefulWidget {
  const RegisterChildPage({super.key});

  @override
  State<RegisterChildPage> createState() => _RegisterChildPageState();
}

class _RegisterChildPageState extends State<RegisterChildPage> {
  late RegisterCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<RegisterCubit, RegisterState>(
          listenWhen: (previous, current) =>
              previous.loadDataStatus != current.loadDataStatus,
          listener: (context, state) {
            if (state.loadDataStatus.isLoading) {
              AppLoadingOverlay.show(context);
            } else {
              AppLoadingOverlay.hide();
            }
          },
          child: Padding(
            padding: UiConstants.horizontalPaddingLarge,
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: _buildBodyPage(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBodyPage() {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [AppBackButton()],
        ),
        60.height,
        AuthTextHighLight(rawText: S.of(context).auth_register_title),
        26.height,
        Text(
          S.of(context).auth_register_description,
          style: AppTextStyle.grey.s14.w500,
          textAlign: TextAlign.center,
        ),
        60.height,
        _buildAuthTextField(),
        60.height,
        BlocBuilder<RegisterCubit, RegisterState>(
          buildWhen: (previous, current) =>
              previous.nameError != current.nameError ||
              previous.emailError != current.emailError ||
              previous.passwordError != current.passwordError ||
              previous.confirmPasswordError != current.confirmPasswordError,
          builder: (context, state) {
            return AppFilledButton(
              label: S.of(context).common_sign_up,
              onPress: () {
                _cubit.registerAccount();
              },
              enable: _cubit.setStatusButtonSignUp(),
            );
          },
        ),
        16.height,
        AppTextRich(
          rawText: S.of(context).common_have_account_login,
          styles: [AppTextStyle.primary.s14.w700],
          defaultStyle: AppTextStyle.grey.s14.w500,
          onPress: [
            () {
              _cubit.navigator.pop();
            },
          ],
        ),
        10.height,
      ],
    );
  }

  Widget _buildAuthTextField() {
    return Column(
      spacing: 20,
      children: [
        BlocBuilder<RegisterCubit, RegisterState>(
          buildWhen: (previous, current) =>
              previous.nameError != current.nameError,
          builder: (context, state) {
            return AppTextField(
              label: S.of(context).common_label_name,
              controller: _cubit.nameController,
              focusNode: _cubit.nameFocusNode,
              errorText: state.nameError,
              onFocusChange: (hasFocus) {
                if (!hasFocus) {
                  final name = _cubit.nameController.text;
                  if (name.isEmpty) {
                    _cubit.setNameError("Please enter your name");
                  } else {
                    _cubit.setNameError("");
                  }
                }
              },
            );
          },
        ),
        BlocBuilder<RegisterCubit, RegisterState>(
          buildWhen: (previous, current) =>
              previous.emailError != current.emailError,
          builder: (context, state) {
            return AppTextField(
              label: S.of(context).common_your_email,
              controller: _cubit.emailController,
              focusNode: _cubit.emailFocusNode,
              errorText: state.emailError,
              onFocusChange: (hasFocus) {
                if (!hasFocus) {
                  final email = _cubit.emailController.text;
                  _cubit.setEmailError(AppValidator.validateEmail(email) ?? "");
                }
              },
            );
          },
        ),
        BlocBuilder<RegisterCubit, RegisterState>(
          buildWhen: (previous, current) =>
              previous.passwordError != current.passwordError ||
              previous.isPasswordVisible != current.isPasswordVisible,
          builder: (context, state) {
            return PasswordTextField(
              label: S.of(context).common_password,
              controller: _cubit.passwordController,
              focusNode: _cubit.passwordFocusNode,
              isObscure: !state.isPasswordVisible,
              errorText: state.passwordError,
              onToggleVisibility: () {
                _cubit.togglePasswordVisibility();
              },
              onFocusChange: (hasFocus) {
                if (!hasFocus) {
                  final password = _cubit.passwordController.text;
                  _cubit.setPasswordError(
                    AppValidator.validatePassword(password) ?? "",
                  );
                }
              },
            );
          },
        ),
        BlocBuilder<RegisterCubit, RegisterState>(
          buildWhen: (previous, current) =>
              previous.confirmPasswordError != current.confirmPasswordError ||
              previous.isConfirmPasswordVisible !=
                  current.isConfirmPasswordVisible,
          builder: (context, state) {
            return PasswordTextField(
              label: S.of(context).common_confirm_password,
              controller: _cubit.confirmPasswordController,
              focusNode: _cubit.confirmPasswordFocusNode,
              isObscure: !state.isConfirmPasswordVisible,
              errorText: state.confirmPasswordError,
              onToggleVisibility: () {
                _cubit.toggleConfirmPasswordVisibility();
              },
              onFocusChange: (hasFocus) {
                if (!hasFocus) {
                  final confirmPassword = _cubit.confirmPasswordController.text;
                  _cubit.setConfirmPasswordError(
                    AppValidator.validateConfirmPassword(
                          _cubit.passwordController.text,
                          confirmPassword,
                        ) ??
                        "",
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }
}
