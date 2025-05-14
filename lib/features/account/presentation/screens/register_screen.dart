import 'package:flutter/material.dart';
import 'package:sport_app_user/core/constants/assets.dart';
import 'package:sport_app_user/core/utils/size_config.dart';

import 'package:sport_app_user/features/account/presentation/widgets/background_image.dart';
import 'package:sport_app_user/features/account/presentation/widgets/login_tab_view.dart';
import 'package:sport_app_user/features/account/presentation/widgets/sign_up_tab_view.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(imagePath: Assets.accountBackgroundImage),

          Padding(
            padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 20),
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 7,
                    ),
                    labelColor: Colors.white,
                    labelStyle: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 2,
                    ),
                    unselectedLabelColor: Colors.white70,
                    indicatorColor: Colors.cyanAccent,
                    dividerColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: const [Tab(text: 'Log in'), Tab(text: 'Sign up')],
                  ),
                  const Expanded(
                    child: TabBarView(
                      children: [
                        LoginTabView(),

                        SignUpTabView(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}





