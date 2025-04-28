import 'package:flutter/material.dart';
import 'package:sport_app_user/core/constants/assets.dart';
import 'package:sport_app_user/core/routing/route_paths.dart';
import 'package:sport_app_user/core/utils/size_config.dart';
import 'package:sport_app_user/core/widget/divider/custom_divider.dart';
import 'package:sport_app_user/features/account/presentation/widgets/account_text_field.dart';
import 'package:sport_app_user/features/account/presentation/widgets/elevated_button.dart';

class LoginTabView extends StatefulWidget {
  const LoginTabView({
    super.key,
  });

  @override
  State<LoginTabView> createState() => _LoginTabViewState();
}

class _LoginTabViewState extends State<LoginTabView> {
  bool showPassword=false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.heightMultiplier * 4,
        horizontal: SizeConfig.widthMultiplier * 6,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AccountTextField(
            hintText: "Email",
            prefixImagePath: Assets.mailIcon,
          ),
          SizedBox(height: SizeConfig.heightMultiplier*2),
          AccountTextField(
            hintText: "Password",
            obscureText: !showPassword,
            prefixImagePath: Assets.passwordIcon,
            suffixIcon:
                showPassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
            onTapSuffixIcon: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
          ),
          SizedBox(height: SizeConfig.heightMultiplier*0.2),
          TextButton(
            onPressed: () {},
            child: Text(
              "Forgot your password?",
              style: TextStyle(
                color: Colors.cyanAccent,
                fontSize: SizeConfig.textMultiplier * 1.7,
              ),
            ),
          ),
          SizedBox(height: SizeConfig.heightMultiplier*2),
          AccountButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, RoutePaths.homeScreen);
            },
            title: "Log in",
          ),
          SizedBox(height: SizeConfig.heightMultiplier*5),
          Row(
            children: [
              CustomDivider(),
              Text(
                "Sign in with your social account",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.textMultiplier * 2,
                ),
              ),
              CustomDivider(),
            ],
          ),
          SizedBox(height: SizeConfig.heightMultiplier*3),
          AccountButton(
            onPressed: () {  },
            title: "Log in with Google",
            //imageRightPadding: SizeConfig.widthMultiplier*5.8,
            foregroundColor: Colors.white,
            iconImagePath: Assets.googleIcon,

          ),
          SizedBox(height: SizeConfig.heightMultiplier*2),
          AccountButton(
            onPressed: () {  },
            //imageRightPadding: SizeConfig.widthMultiplier*0.1,
            labelLeftPadding: SizeConfig.widthMultiplier*7,
            title: "Log in with Facebook",
            foregroundColor: Colors.white,
            iconImagePath: Assets.facebookIcon,

          )

        ],
      ),
    );
  }
}
