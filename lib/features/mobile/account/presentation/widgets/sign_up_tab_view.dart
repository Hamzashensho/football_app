import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocListener, ReadContext;
import 'package:intl/intl.dart';
import 'package:sport_app_user/core/constants/assets.dart';
import 'package:sport_app_user/core/routing/route_paths.dart';
import 'package:sport_app_user/core/utils/logger.dart';
import 'package:sport_app_user/core/utils/size_config.dart';
import 'package:sport_app_user/core/widget/loader.dart';
import 'package:sport_app_user/core/widget/picker/drop_down_team_picker.dart';
import 'package:sport_app_user/features/mobile/account/domain/entities/user_entity.dart';
import 'package:sport_app_user/features/mobile/account/presentation/blocs/auth/auth_bloc.dart';
import 'package:sport_app_user/features/mobile/account/presentation/widgets/account_text_field.dart';
import 'package:sport_app_user/features/mobile/account/presentation/widgets/elevated_button.dart';

class SignUpTabView extends StatefulWidget {
  const SignUpTabView({
    super.key,
  });

  @override
  State<SignUpTabView> createState() => _SignUpTabViewState();
}

class _SignUpTabViewState extends State<SignUpTabView> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dobController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _confirmEmailController = TextEditingController();
  final _countryController = TextEditingController();
  final _stateController = TextEditingController();
  final _municipalityController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool showFirstPassword = false;
  bool showSecondPassword = false;
  bool isLoading = false;
  String? _selectedTeam;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _confirmEmailController.dispose();
    _countryController.dispose();
    _stateController.dispose();
    _municipalityController.dispose();
    _postalCodeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SignUpLoading) {
          LoadingOverlay.of(context).show();
        } else if (state is SignUpSuccess) {
          LoadingOverlay.of(context).hide();
          Navigator.pushReplacementNamed(context, RoutePaths.homeScreen);
        } else if (state is SignUpFailed) {
          LoadingOverlay.of(context).hide();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.heightMultiplier * 4,
          horizontal: SizeConfig.widthMultiplier * 6,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AccountTextField(
                  controller: _firstNameController,
                  hintText: 'First name',
                  prefixImagePath: Assets.userIcon,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 2),
                AccountTextField(
                  controller: _lastNameController,
                  hintText: 'Last name',
                  prefixImagePath: Assets.userIcon,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 2),
                AccountTextField(
                  controller: _dobController,
                  hintText: 'Date of birth',
                  prefixImagePath: Assets.dateIcon,
                  isDateTextField: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your date of birth';
                    }
                    return null;
                  },
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 2),
                AccountTextField(
                  controller: _phoneController,
                  hintText: 'Phone',
                  prefixImagePath: Assets.telephoneIcon,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 2),
                AccountTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  prefixImagePath: Assets.mailIcon,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 2),
                AccountTextField(
                  controller: _confirmEmailController,
                  hintText: 'Confirm email',
                  prefixImagePath: Assets.mailIcon,
                  validator: (value) {
                    if (value != _emailController.text) {
                      return 'Emails do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 2),
                AccountTextField(
                  controller: _countryController,
                  hintText: 'Country',
                  prefixImagePath: Assets.countryIcon,
                  isCountryPicker: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your country';
                    }
                    return null;
                  },
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 2),
                AccountTextField(
                  controller: _stateController,
                  hintText: 'State/Province',
                  prefixImagePath: Assets.maritalStatusIcon,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your state/province';
                    }
                    return null;
                  },
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 2),
                AccountTextField(
                  controller: _municipalityController,
                  hintText: 'Municipality',
                  prefixImagePath: Assets.homeIcon,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your municipality';
                    }
                    return null;
                  },
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 2),
                AccountTextField(
                  controller: _postalCodeController,
                  hintText: 'Postal Code/Zip Code',
                  prefixImagePath: Assets.mailBoxIcon,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your postal code';
                    }
                    return null;
                  },
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 2),
                AccountTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: !showFirstPassword,
                  prefixImagePath: Assets.passwordIcon,
                  suffixIcon: showFirstPassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  onTapSuffixIcon: () {
                    setState(() => showFirstPassword = !showFirstPassword);
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
                SizedBox(height: SizeConfig.heightMultiplier * 2),
                AccountTextField(
                  controller: _confirmPasswordController,
                  hintText: 'Confirm password',
                  obscureText: !showSecondPassword,
                  prefixImagePath: Assets.passwordIcon,
                  suffixIcon: showSecondPassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  onTapSuffixIcon: () {
                    setState(() => showSecondPassword = !showSecondPassword);
                  },
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 2),
                Text(
                  'Team (Optional)',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeConfig.textMultiplier * 1.8,
                  ),
                ),
                const SimpleTeamDropdown(

                  //onChanged: (team) => _selectedTeam = team,
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 2),
                AccountButton(
                  onPressed: isLoading
                      ? null
                      : () {
                    AppLogger.info(_dobController.text);
                    if (_formKey.currentState!.validate()) {
                      final user = UserEntity(
                        firstName: _firstNameController.text.trim(),
                        lastName: _lastNameController.text.trim(),
                        email: _emailController.text.trim(),
                        phoneNumber: _phoneController.text.trim(),
                        dob:  DateFormat('yyyy-MM-dd').parseStrict(_dobController.text),
                        country: _countryController.text.trim(),
                        stateProvince: _stateController.text.trim(),
                        municipality: _municipalityController.text.trim(),
                        zipCode: _postalCodeController.text.trim(),
                        favoriteTeamId: _selectedTeam,
                      );

                      context.read<AuthBloc>().add(
                        SignUpWithEmailRequested(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                          user: user,
                        ),
                      );
                    }else{
                      AppLogger.info('Form is non valid');
                    }
                  },
                  title: 'Sign up',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
