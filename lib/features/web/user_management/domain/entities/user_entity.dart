class UserEntity {
  final String userId;
  final String firstName;
  final String lastName;
  final DateTime dob;
  final String phoneNumber;
  final String email;
  final String country;
  final String? stateProvince;
  final String? municipality;
  final String? zipCode;
  final String? favoriteTeamId;
  // final NotificationObject? notifications; // Assuming NotificationObject is a custom class or map

  UserEntity({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.phoneNumber,
    required this.email,
    required this.country,
    this.stateProvince,
    this.municipality,
    this.zipCode,
    this.favoriteTeamId,
    // this.notifications,
  });

  // Consider adding factory constructors for fromJson/toJson if needed later in data layer
  // Consider adding Equatable for value comparison
}

