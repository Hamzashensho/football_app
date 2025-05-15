import 'package:flutter/material.dart';
import 'package:sport_app_user/core/constants/assets.dart';
import 'package:sport_app_user/core/utils/size_config.dart';
import 'package:sport_app_user/core/widget/picker/drop_down_team_picker.dart';
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
  bool showFirstPassword=false;
  bool showSecondPassword=false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric( vertical: SizeConfig.heightMultiplier * 4,
        horizontal: SizeConfig.widthMultiplier * 6,),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AccountTextField(
             hintText: 'First name',
              prefixImagePath: Assets.userIcon,
            ),
            SizedBox(height: SizeConfig.heightMultiplier*2),
            const AccountTextField(
              hintText:'Last name',
              prefixImagePath: Assets.userIcon,
            ),
            SizedBox(height: SizeConfig.heightMultiplier*2),
            const AccountTextField(
              hintText: 'Date of birth',
              prefixImagePath: Assets.dateIcon,
              isDateTextField: true,
            ),
            SizedBox(height: SizeConfig.heightMultiplier*2),
            const AccountTextField(
              hintText: 'Phone',
              prefixImagePath: Assets.telephoneIcon,
            ),
            SizedBox(height: SizeConfig.heightMultiplier*2),
            const AccountTextField(
              hintText: 'Email',
              prefixImagePath: Assets.mailIcon,
            ),
            SizedBox(height: SizeConfig.heightMultiplier*2),
            const AccountTextField(
              hintText: 'Confirm email',
              prefixImagePath: Assets.mailIcon,
            ),
            SizedBox(height: SizeConfig.heightMultiplier*2),
            const AccountTextField(
              hintText: 'Country',
              prefixImagePath: Assets.countryIcon,
              isCountryPicker: true,
            ),
            SizedBox(height: SizeConfig.heightMultiplier*2),
            const AccountTextField(
              hintText: 'State province',
              prefixImagePath: Assets.maritalStatusIcon,
            ),
            SizedBox(height: SizeConfig.heightMultiplier*2),
            const AccountTextField(
              hintText: 'Municipality',
              prefixImagePath: Assets.homeIcon,
            ),
            SizedBox(height: SizeConfig.heightMultiplier*2),
            const AccountTextField(
              hintText: 'Postal Code/Zip Code',
              prefixImagePath: Assets.mailBoxIcon,
            ),
            SizedBox(height: SizeConfig.heightMultiplier*2),
            AccountTextField(
              hintText: 'Password',
              obscureText: !showFirstPassword,
              prefixImagePath: Assets.passwordIcon,
              suffixIcon:
              showFirstPassword
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              onTapSuffixIcon: () {
                setState(() {
                  showFirstPassword = !showFirstPassword;
                });
              },
            ),
            SizedBox(height: SizeConfig.heightMultiplier*2),
            AccountTextField(
              hintText: 'Confirm password',
              obscureText: !showSecondPassword,
              prefixImagePath: Assets.passwordIcon,
              suffixIcon:
              showSecondPassword
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              onTapSuffixIcon: () {
                setState(() {
                  showSecondPassword = !showSecondPassword;
                });
              },
            ),
            SizedBox(height: SizeConfig.heightMultiplier*2),
            Text('Team (Optional)',style: TextStyle(color:Colors.white,fontSize: SizeConfig.textMultiplier*1.8),),
            const SimpleTeamDropdown(),
            SizedBox(height: SizeConfig.heightMultiplier*2),

            AccountButton(
              onPressed: () {
                // Handle sign up
              },
              title: 'Sign up',
            ),
          ],
        ),
      ),
    );
  }
}

