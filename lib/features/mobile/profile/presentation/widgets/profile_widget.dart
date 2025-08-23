import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_user/core/constants/assets.dart';
import 'package:sport_app_user/core/constants/dummy_data.dart';
import 'package:sport_app_user/core/utils/size_config.dart';
import 'package:sport_app_user/core/widget/dialogs/entity_dialog.dart';
import 'package:sport_app_user/core/widget/form/entity_form.dart';
import 'package:sport_app_user/core/widget/loader.dart';
import 'package:sport_app_user/features/mobile/account/domain/entities/user_entity.dart';
import 'package:sport_app_user/features/mobile/account/presentation/blocs/auth/auth_bloc.dart';
import 'package:sport_app_user/features/mobile/profile/presentation/blocs/profile_bloc.dart';

class SectionTitle extends StatefulWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  State<SectionTitle> createState() => _SectionTitleState();
}

class _SectionTitleState extends State<SectionTitle> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.title,
      style: TextStyle(
        fontSize: 2 * SizeConfig.textMultiplier,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class UserInfoCard extends StatefulWidget {
  final UserEntity user;

  const UserInfoCard({super.key, required this.user});

  @override
  State<UserInfoCard> createState() => _UserInfoCardState();
}

class _UserInfoCardState extends State<UserInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3 * SizeConfig.widthMultiplier),
      ),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(2 * SizeConfig.widthMultiplier),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 5 * SizeConfig.imageSizeMultiplier,
                  backgroundImage:
                      widget.user.pictureUrl != null &&
                              widget.user.pictureUrl!.isNotEmpty
                          ? NetworkImage(widget.user.pictureUrl!)
                          : const AssetImage(Assets.profilePictureIcon)
                              as ImageProvider,
                ),
                SizedBox(width: 3 * SizeConfig.widthMultiplier),
                Expanded(
                  child: Text(
                    '${widget.user.firstName} ${widget.user.lastName}',
                    style: TextStyle(fontSize: 2 * SizeConfig.textMultiplier),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showEditUserDialog(
                      context: context,
                      bloc: context.read<ProfileBloc>(),
                      user: widget.user,
                    );
                  },
                  child: const Text('Edit'),
                ),
              ],
            ),
            const Divider(),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: SizeConfig.heightMultiplier * 1.8,
              ),
              child: Row(
                children: [
                  const Icon(Icons.email_outlined),
                  SizedBox(width: 2 * SizeConfig.widthMultiplier),
                  Expanded(child: Text(widget.user.email)),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(SignOutRequested());
                    },
                    child: const Text('Logout'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditUserDialog({
    required BuildContext context,
    required ProfileBloc bloc,
    UserEntity? user,
  }) {
    final firstNameController = TextEditingController(
      text: widget.user.firstName,
    );
    final lastNameController = TextEditingController(
      text: widget.user.lastName,
    );

    final formKey = GlobalKey<FormState>();

    showEntityDialog(
      context: context,
      title: 'Edit',
      form: BlocProvider.value(
        value: bloc,
        child: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is EditProfileLoading) {
              LoadingOverlay.of(context).show();
            } else if (state is EditProfileSuccess) {
              LoadingOverlay.of(context).hide();
              Navigator.of(context).pop();
              bloc.add(GetUser());
            } else if (state is EditProfileError) {
              LoadingOverlay.of(context).hide();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Edit User Data Failed, Please try again'),
                ),
              );
            }
          },
          child: EntityForm(
            formKey: formKey,
            fields: [
              FormFieldConfig(
                name: 'First Name',
                label: 'First Name',
                controller: firstNameController,
                validator: (val) => val?.isEmpty ?? true ? 'Required' : null,
              ),
              FormFieldConfig(
                name: 'Last Name',
                label: 'Last Name',
                controller: lastNameController,
                validator: (val) => val?.isEmpty ?? true ? 'Required' : null,
              ),
            ],
          ),
        ),
      ),
      onSave: () {
        if (formKey.currentState?.validate() ?? false) {
          final newData = UserEntity(
            email: widget.user.email,
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            fcmToken: widget.user.fcmToken,
            country: widget.user.country,
            dob: widget.user.dob,
            favoriteTeamId: widget.user.favoriteTeamId,
            municipality: widget.user.municipality,
            notifications: widget.user.notifications,
            phoneNumber: widget.user.phoneNumber,
            pictureUrl: widget.user.pictureUrl,
            stateProvince: widget.user.stateProvince,
            uid: widget.user.uid,
            zipCode: widget.user.zipCode,
          );

          bloc.add(EditUser(userEntity: newData));

          setState(() {});
        }
      },
    );
  }
}

class FavoriteTeamsList extends StatelessWidget {
  const FavoriteTeamsList({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteTeam = dummyTeams[0];

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3 * SizeConfig.widthMultiplier),
      ),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(2 * SizeConfig.widthMultiplier),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  favoriteTeam.logo,
                  width: 8 * SizeConfig.imageSizeMultiplier,
                ),
                SizedBox(width: 3 * SizeConfig.widthMultiplier),
                Expanded(child: Text(favoriteTeam.name)),
                InkWell(
                  onTap: () {
                    // Logic to change favorite team
                  },
                  child: const Icon(Icons.star, color: Colors.red),
                ),
              ],
            ),
            SizedBox(height: 2 * SizeConfig.heightMultiplier),
            ElevatedButton(
              onPressed: () {
                // Open "Add favorite team" dialog
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
