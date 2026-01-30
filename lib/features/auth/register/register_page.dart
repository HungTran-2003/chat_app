import 'package:chat_app/core/constants/ui_constants.dart';
import 'package:chat_app/core/extensions/num_extension.dart';
import 'package:chat_app/core/theme/app_text_styles.dart';
import 'package:chat_app/core/utlis/validator.dart';
import 'package:chat_app/core/widgets/button/app_back_button.dart';
import 'package:chat_app/core/widgets/button/app_filled_button.dart';
import 'package:chat_app/core/widgets/text/app_text_rich.dart';
import 'package:chat_app/core/widgets/text_field/app_text_field.dart';
import 'package:chat_app/core/widgets/text_field/password_text_field.dart';
import 'package:chat_app/data/enum/status_type.dart';
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
      child: RegisterChildPage(),
    );
  }
}

class RegisterChildPage extends StatefulWidget {
  const RegisterChildPage({super.key});

  @override
  State<RegisterChildPage> createState() => _RegisterChildPageState();
}

class _RegisterChildPageState extends State<RegisterChildPage> {
  final _formKey = GlobalKey<FormState>();

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
        child: Padding(
          padding: UiConstants.horizontalPaddingLarge,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: _buildBodyPage(),
          ),
        ),
      ),
    );
  }

  Widget _buildBodyPage() {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUnfocus,
      onChanged: () {
        _cubit.setStatusButtonSignUp();
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [AppBackButton(

            )],
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
                previous.buttonSignUpStatus != current.buttonSignUpStatus,
            builder: (context, state) {
              return AppFilledButton(
                label: S.of(context).common_sign_up,
                onPress: () {
                  if (_formKey.currentState!.validate()) {
                    _cubit.registerAccount();
                  }
                },
                enable: state.buttonSignUpStatus?.isLoading,
              );
            },
          ),
          16.height,
          AppTextRich(
            rawText: S.of(context).common_have_account_login,
            styles: [AppTextStyle.primary.s14.w700],
            defaultStyle: AppTextStyle.grey.s14.w500,
            onPress: [_handlerLogin],
          ),
          10.height,
        ],
      ),
    );
  }

  Widget _buildAuthTextField() {
    return Column(
      spacing: 20,
      children: [
        AppTextField(
          label: S.of(context).common_label_name,
          controller: _cubit.nameController,
          focusNode: _cubit.nameFocusNode,
          textFieldNotifier: _cubit.nameNotifier,
          validator: (value) {
            if (value == null || value.isEmpty) {
              _cubit.nameNotifier.setTextError("Please enter your name");
              return "";
            }
            _cubit.nameNotifier.setTextError(null);
            return null;
          },
        ),

        AppTextField(
          label: S.of(context).common_your_email,
          controller: _cubit.emailController,
          focusNode: _cubit.emailFocusNode,
          textFieldNotifier: _cubit.emailNotifier,
          validator: (value) {
            final errorText = AppValidator.validateEmail(value!);
            _cubit.emailNotifier.setTextError(errorText);
            return errorText == null ? null : "";
          },
        ),

        PasswordTextField(
          label: S.of(context).common_password,
          passwordNotifier: _cubit.passwordNotifier,
          controller: _cubit.passwordController,
          focusNode: _cubit.passwordFocusNode,
          validator: (value) {
            final errorText = AppValidator.validatePassword(value!);
            _cubit.passwordNotifier.setTextError(errorText);
            return errorText == null ? null : "";
          },
        ),

        PasswordTextField(
          label: S.of(context).common_confirm_password,
          passwordNotifier: _cubit.confirmPasswordNotifier,
          controller: _cubit.confirmPasswordController,
          focusNode: _cubit.confirmPasswordFocusNode,
          validator: (value) {
            final errorText = AppValidator.validateConfirmPassword(
              _cubit.passwordController.text,
              value,
            );
            _cubit.confirmPasswordNotifier.setTextError(errorText);
            return errorText == null ? null : "";
          },
        ),
      ],
    );
  }

  void _handlerLogin() {
    _cubit.navigator.openLoginPage();
  }
}
