import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_user/core/constants/assets.dart';
import 'package:sport_app_user/core/utils/size_config.dart';
import 'package:sport_app_user/features/mobile/account/presentation/blocs/auth/auth_bloc.dart';
import 'package:sport_app_user/features/mobile/account/presentation/widgets/background_image.dart';
import 'package:sport_app_user/features/mobile/account/presentation/widgets/login_tab_view.dart';
import 'package:sport_app_user/features/mobile/account/presentation/widgets/sign_up_tab_view.dart';
import 'package:sport_app_user/injection_container.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthBloc>(),
      child: Scaffold(
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
      ),
    );
  }
}