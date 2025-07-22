import 'package:sport_app_user/features/mobile/account/domain/entities/user_entity.dart';

class UserModel {
  final String userId;
  final String firstName;
  final String lastName;
  final DateTime dob;
  final String phoneNumber;
  final String email;
  final String country;
  final String stateProvince;
  final String municipality;
  final String zipCode;
  final String favoriteTeamId;
  final UserNotifications notifications;
  final String pictureUrl;
  final String fcmToken;

  UserModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.phoneNumber,
    required this.email,
    required this.country,
    required this.stateProvince,
    required this.municipality,
    required this.zipCode,
    required this.favoriteTeamId,
    required this.notifications,
    required this.pictureUrl,
    required this.fcmToken,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      userId: id,
      firstName: map['firstName']??'',
      lastName: map['lastName']??'',
      dob: DateTime.parse(map['dob']),
      phoneNumber: map['phoneNumber']??'',
      email: map['email']??'',
      country: map['country']??'',
      stateProvince: map['stateProvince']??'',
      municipality: map['municipality']??'',
      zipCode: map['zipCode']??'',
      favoriteTeamId: map['favoriteTeamId']??'',
      notifications: UserNotifications.fromMap(map['notifications']),
      pictureUrl: map['pictureUrl']??'',
        fcmToken:map['fcmToken']??''
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'dob': dob.toIso8601String(),
      'phoneNumber': phoneNumber,
      'email': email,
      'country': country,
      'stateProvince': stateProvince,
      'municipality': municipality,
      'zipCode': zipCode,
      'favoriteTeamId': favoriteTeamId,
      'notifications': notifications.toMap(),
      'pictureUrl':pictureUrl,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      dob: DateTime.parse(json['dob']),
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      country: json['country'],
      stateProvince: json['stateProvince'],
      municipality: json['municipality'],
      zipCode: json['zipCode'],
      favoriteTeamId: json['favoriteTeamId'],
      notifications: UserNotifications.fromJson(json['notifications']),
        pictureUrl: json['pictureUrl'],
      fcmToken: json['fcmToken']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'dob': dob.toIso8601String(),
      'phoneNumber': phoneNumber,
      'email': email,
      'country': country,
      'stateProvince': stateProvince,
      'municipality': municipality,
      'zipCode': zipCode,
      'favoriteTeamId': favoriteTeamId,
      'notifications': notifications.toJson(),
      'pictureUrl':pictureUrl,
      'fcmToken':fcmToken,
    };
  }

  UserEntity toEntity() => UserEntity(
    uid: userId,
    email: email,
    firstName: firstName,
    lastName: lastName,
    dob: dob,
    phoneNumber: phoneNumber,
    country: country,
    stateProvince: stateProvince,
    municipality: municipality,
    zipCode: zipCode,
    favoriteTeamId: favoriteTeamId,
    notifications: notifications,
    pictureUrl: pictureUrl,
    fcmToken: fcmToken,
  );

}

class UserNotifications {
  final bool app;
  final bool favoriteTeam;

  UserNotifications({required this.app, required this.favoriteTeam});

  factory UserNotifications.fromMap(Map<String, dynamic> map) {
    return UserNotifications(
      app: map['app'],
      favoriteTeam: map['favoriteTeam'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'app': app,
      'favoriteTeam': favoriteTeam,
    };
  }

  factory UserNotifications.fromJson(Map<String, dynamic> json) {
    return UserNotifications(
      app: json['app'],
      favoriteTeam: json['favoriteTeam'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'app': app,
      'favoriteTeam': favoriteTeam,
    };
  }
}
