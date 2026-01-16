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
      create: (context){
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
    return Scaffold(
      body: SafeArea(
        child: _buildBodyPage(),
      ),
    );
  }

  Widget _buildBodyPage(){
    return Padding(
      padding: UiConstants.horizontalPaddingLarge,
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
          AuthDividerWithText(
            style: AppTextStyle.grey.s14.w500,
          ),
          30.height,
          _buildAuthTextField(),
          170.height,
          AppFilledButton(label: S.of(context).common_sign_in, onPress: (){}),
          16.height,
          _buildForgotPasswordText(),
        ],
      ),
    );
  }

  Widget _buildIconButtonAuth(){
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

  Widget _buildAuthTextField(){
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppTextField(
            label: S.of(context).common_your_email,
          ),
          30.height,
          AppTextField(
            label: S.of(context).common_password,
            obscureText: true,
            suffixIcon: AppIconButton(
              path: AssetConstants.backIcon,
              sizeIcon: Size(14, 14),
              onPress: (){

              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForgotPasswordText() {
    return GestureDetector(
      onTap: (){
        print("Forgot Password");
      },
      child: Text(
        S.of(context).common_forgot_password,
        style: AppTextStyle.primary.s14.w600,
      ),
    );
  }
}

