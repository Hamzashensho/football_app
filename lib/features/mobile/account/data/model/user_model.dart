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
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      userId: id,
      firstName: map['firstName'],
      lastName: map['lastName'],
      dob: DateTime.parse(map['dob']),
      phoneNumber: map['phoneNumber'],
      email: map['email'],
      country: map['country'],
      stateProvince: map['stateProvince'],
      municipality: map['municipality'],
      zipCode: map['zipCode'],
      favoriteTeamId: map['favoriteTeamId'],
      notifications: UserNotifications.fromMap(map['notifications']),
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
    };
  }
}

class UserNotifications {
  final bool app;
  final bool favoriteTeam;

  UserNotifications({
    required this.app,
    required this.favoriteTeam,
  });

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
}
