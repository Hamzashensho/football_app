// features/mobile/account/domain/entities/user_entity.dart
import 'package:sport_app_user/features/mobile/account/data/model/user_model.dart';

class UserEntity {
  final String? uid;
  final String email;
  final String firstName;
  final String lastName;
  final DateTime? dob;
  final String? phoneNumber;
  final String? country;
  final String? stateProvince;
  final String? municipality;
  final String? zipCode;
  final String? favoriteTeamId;
  final UserNotifications? notifications;
  final String? fcmToken;

  final String? pictureUrl;

  const UserEntity({
     this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.dob,
    this.phoneNumber,
    this.country,
    this.stateProvince,
    this.municipality,
    this.zipCode,
    this.favoriteTeamId,
    this.notifications,
    this.pictureUrl,
    this.fcmToken,
  });

}