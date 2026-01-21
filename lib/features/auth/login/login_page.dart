import 'package:chat_app/core/constants/asset_constants.dart';
import 'package:chat_app/core/constants/ui_constants.dart';
import 'package:chat_app/core/extensions/num_extension.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/core/theme/app_text_styles.dart';
import 'package:chat_app/core/widgets/button/app_back_button.dart';
import 'package:chat_app/core/widgets/button/app_filled_button.dart';
import 'package:chat_app/core/widgets/button/app_icon_button.dart';
import 'package:chat_app/core/widgets/text/app_text_rich.dart';
import 'package:chat_app/core/widgets/text_field/app_text_field.dart';
import 'package:chat_app/core/widgets/text_field/password_text_field.dart';
import 'package:chat_app/data/enum/status_type.dart';
import 'package:chat_app/features/auth/login/login_cubit.dart';
import 'package:chat_app/features/auth/login/login_navigator.dart';
import 'package:chat_app/features/auth/widgets/auth_text/auth_text_high_light.dart';
import 'package:chat_app/features/auth/widgets/divider/auth_divider_with_text.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) {
        return LoginCubit(navigator: LoginNavigator(context: context));
      },
      child: LoginChildPage(),
    );
  }
}

class LoginChildPage extends StatefulWidget {
  const LoginChildPage({super.key});

  @override
  State<LoginChildPage> createState() => _LoginChildPageState();
}

class _LoginChildPageState extends State<LoginChildPage> {
  final _formKey = GlobalKey<FormState>();

  late LoginCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: _buildBodyPage()));
  }

  Widget _buildBodyPage() {
    return Padding(
      padding: UiConstants.horizontalPaddingLarge,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUnfocus,
          onChanged: () {
            _cubit.setStatusButtonLogin();
          },
          child: Column(
            children: [
              60.height,
              AuthTextHighLight(rawText: S.of(context).auth_login_title),
              26.height,
              Text(
                S.of(context).auth_login_description,
                style: AppTextStyle.grey.s14.w500,
                textAlign: TextAlign.center,
              ),
              30.height,
              _buildIconButtonAuth(),
              30.height,
              AuthDividerWithText(style: AppTextStyle.grey.s14.w500),
              30.height,
              _buildAuthTextField(),
              60.height,
              BlocBuilder<LoginCubit, LoginState>(
                buildWhen: (previous, current) =>
                    previous.buttonLoginStatus != current.buttonLoginStatus,
                builder: (context, state) {
                  return AppFilledButton(
                    label: S.of(context).common_sign_in,
                    onPress: () {
                      if (_formKey.currentState!.validate()) {
                        _cubit.cleanController();
                        _cubit.cleanFocusNode();
                        print("Login Success");
                      }
                    },
                    enable: state.buttonLoginStatus?.isLoading,
                  );
                },
              ),
              16.height,
              _buildForgotPasswordText(),
              20.height,
              AppFilledButton(
                label: S.of(context).common_sign_up,
                onPress: () {
                  _formKey.currentState?.reset();
                  _cubit.cleanController();
                  _cubit.cleanFocusNode();
                  _cubit.cleanNotifier();
                  _cubit.navigator.openSignUpPage();
                },
              ),
              10.height,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButtonAuth() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 20,
      children: [
        AppIconButton(
          path: AssetConstants.iconFacebook,
          borderColor: AppColors.borderBlack,
        ),

        AppIconButton(
          path: AssetConstants.iconGoogle,
          borderColor: AppColors.borderBlack,
        ),

        AppIconButton(
          path: AssetConstants.iconApple,
          borderColor: AppColors.borderBlack,
          iconColor: AppColors.backgroundDark,
        ),
      ],
    );
  }

  Widget _buildAuthTextField() {
    return Column(
      children: [
        AppTextField(
          label: S.of(context).common_your_email,
          controller: _cubit.emailController,
          focusNode: _cubit.emailFocusNode,
          textFieldNotifier: _cubit.emailNotifier,
          validator: (value) {
            if (value == null || value.isEmpty) {
              _cubit.emailNotifier.setTextError("Please enter your email");
              return "";
            }
            _cubit.emailNotifier.setTextError(null);
            return null;
          },
        ),
        20.height,
        PasswordTextField(
          label: S.of(context).common_password,
          passwordNotifier: _cubit.passwordNotifier,
          controller: _cubit.passwordController,
          focusNode: _cubit.passwordFocusNode,
          validator: (value) {
            if (value == null || value.isEmpty) {
              _cubit.passwordNotifier.setTextError(
                "Please enter your password",
              );
              return "";
            }
            _cubit.passwordNotifier.setTextError(null);
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildForgotPasswordText() {
    return GestureDetector(
      onTap: () {
        print("Forgot Password");
      },
      child: Text(
        S.of(context).common_forgot_password,
        style: AppTextStyle.primary.s14.w600,
      ),
    );
  }
}
