import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_user/core/constants/assets.dart';
import 'package:sport_app_user/core/routing/route_paths.dart';
import 'package:sport_app_user/core/utils/size_config.dart';
import 'package:sport_app_user/core/widget/divider/custom_divider.dart';
import 'package:sport_app_user/core/widget/loader.dart';
import 'package:sport_app_user/features/mobile/account/presentation/widgets/account_text_field.dart';
import 'package:sport_app_user/features/mobile/account/presentation/widgets/elevated_button.dart';
import 'package:sport_app_user/features/mobile/account/presentation/blocs/auth/auth_bloc.dart';

class LoginTabView extends StatefulWidget {
  const LoginTabView({super.key});

  @override
  State<LoginTabView> createState() => _LoginTabViewState();
}

class _LoginTabViewState extends State<LoginTabView> {
  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool showPassword = false;
  bool isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message) {
    LoadingOverlay.of(context).hide();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading ||
            state is LoginLoading ||
            state is LoginWithGoogleLoading ||
            state is SendResetPasswordEmailLoading) {
          LoadingOverlay.of(context).show();
        } else if (state is LoginSuccess || state is LoginWithGoogleSuccess) {
          LoadingOverlay.of(context).hide();
          Navigator.pushReplacementNamed(context, RoutePaths.homeScreen);
        } else if (state is LoginFailed) {
          _showSnackBar(state.message);
        } else if (state is LoginWithGoogleFailed) {
          _showSnackBar(state.message);
        } else if (state is SendResetPasswordEmailSuccess) {
          _showSnackBar('Send Reset Email password Success');
        } else if (state is SendResetPasswordEmailFailed) {
          _showSnackBar(state.message);
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.heightMultiplier * 4,
          horizontal: SizeConfig.widthMultiplier * 6,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _emailFormKey,
                child: AccountTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  prefixImagePath: Assets.mailIcon,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(
                      r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: SizeConfig.heightMultiplier * 2),
              Form(
                key: _passwordFormKey,
                child: AccountTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: !showPassword,
                  prefixImagePath: Assets.passwordIcon,
                  suffixIcon:
                      showPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                  onTapSuffixIcon: () {
                    setState(() => showPassword = !showPassword);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: SizeConfig.heightMultiplier * 0.2),
              TextButton(
                onPressed: () {
                  if (_emailFormKey.currentState?.validate() ?? false) {
                    context.read<AuthBloc>().add(
                      ResetPassword(email: _emailController.text.trim()),
                    );
                  }
                },
                child: Text(
                  'Forgot your password?',
                  style: TextStyle(
                    color: Colors.cyanAccent,
                    fontSize: SizeConfig.textMultiplier * 1.7,
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.heightMultiplier * 2),

              AccountButton(
                onPressed:
                    isLoading
                        ? null
                        : () {
                          if ((_emailFormKey.currentState?.validate() ??
                                  false) &&
                              (_passwordFormKey.currentState?.validate() ??
                                  false)) {
                            context.read<AuthBloc>().add(
                              SignInWithEmailRequested(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              ),
                            );
                          }
                        },
                title: 'Log in',
                //isLoading: isLoading,
              ),

              SizedBox(height: SizeConfig.heightMultiplier * 5),
              Row(
                children: [
                  const CustomDivider(),
                  Text(
                    'Sign in with your social account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.textMultiplier * 2,
                    ),
                  ),
                  const CustomDivider(),
                ],
              ),
              SizedBox(height: SizeConfig.heightMultiplier * 3),
              AccountButton(
                onPressed:
                    isLoading
                        ? null
                        : () {
                          context.read<AuthBloc>().add(
                            SignInWithGoogleRequested(),
                          );
                        },
                title: 'Log in with Google',
                foregroundColor: Colors.white,
                iconImagePath: Assets.googleIcon,
              ),
              //SizedBox(height: SizeConfig.heightMultiplier * 2),
              // AccountButton(
              //   onPressed: isLoading ? null : () {
              //     context.read<AuthBloc>().add(SignInWithFacebookRequested());
              //   },
              //   title: 'Log in with Facebook',
              //   foregroundColor: Colors.white,
              //   iconImagePath: Assets.facebookIcon,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
