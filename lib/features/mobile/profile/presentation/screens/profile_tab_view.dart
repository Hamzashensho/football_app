import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_user/core/routing/route_paths.dart';
import 'package:sport_app_user/core/utils/size_config.dart';
import 'package:sport_app_user/core/widget/loader.dart';
import 'package:sport_app_user/features/mobile/account/data/model/user_model.dart';
import 'package:sport_app_user/features/mobile/account/domain/entities/user_entity.dart';
import 'package:sport_app_user/features/mobile/account/presentation/blocs/auth/auth_bloc.dart';
import 'package:sport_app_user/features/mobile/profile/presentation/blocs/profile_bloc.dart';
import 'package:sport_app_user/features/mobile/profile/presentation/widgets/profile_widget.dart';

class ProfileTabView extends StatelessWidget {
  const ProfileTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProfileBloc()..add(GetUser())),
        BlocProvider(create: (context) => AuthBloc()),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SignOutLoading) {
            LoadingOverlay.of(context).show();
          } else if (state is SignOutSuccess) {
            LoadingOverlay.of(context).hide();
            Navigator.of(
              context,
            ).pushReplacementNamed(RoutePaths.cookiesScreen);
          } else if (state is SignOutFailed) {
            LoadingOverlay.of(context).hide();

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Logout Failed, Please try again')),
            );
          }
        },
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileError) {
              return Center(child: Text(state.message));
            } else if (state is ProfileSuccess) {
              final UserEntity userEntity = state.userEntity;
              return Flexible(
                child: Padding(
                  padding: EdgeInsets.all(2 * SizeConfig.widthMultiplier),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 2 * SizeConfig.heightMultiplier),

                        const SectionTitle(title: 'General Information'),
                        UserInfoCard(user: userEntity),

                        SizedBox(height: 3 * SizeConfig.heightMultiplier),

                        // Favorite Team Section
                        // const SectionTitle(title: 'Favorite Team'),
                        // const FavoriteTeamsList(),
                      ],
                    ),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
