import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/features/mobile/account/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sport_app_user/features/mobile/account/domain/entities/user_entity.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signInWithEmail(String email, String password);
  Future<UserModel> signUpWithEmail(String email, String password, UserEntity user);
  Future<UserModel> signInWithGoogle();
  Future<UserModel> signInWithFacebook();
  Future<UserModel?> getCurrentUser();
  Future<void> signOut();

  Future<void> resetEmailPassword(String email);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users');

  AuthRemoteDataSourceImpl(this._firebaseAuth);

  @override
  Future<UserModel> signInWithEmail(String email, String password) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      final user = result.user;
      if (user == null) throw Exception('User is null after sign in');
      return _createUserModel(user);
    } on FirebaseAuthException catch (e) {
      throw Exception('Sign in failed: ${e.message}');
    }
  }

  @override
  Future<UserModel> signUpWithEmail(String email, String password, UserEntity userEntity) async {
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      final user = result.user;
      if (user == null) throw Exception('User is null after sign up');
      user.sendEmailVerification();
      final userModel = _mapEntityToModel(user, userEntity);
      await _usersCollection.doc(user.uid).set(userModel.toJson());
      return userModel;
    } on FirebaseAuthException catch (e) {
      await signOut();
      throw Exception('Sign up failed: ${e.message}');
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) throw Exception('Cancelled by user');

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final result = await _firebaseAuth.signInWithCredential(credential);
      final user = result.user;
      if (user == null) throw Exception('User is null after Google sign in');

      final userModel = _createUserModel(user);
      final docExists = (await _usersCollection.doc(user.uid).get()).exists;

      if (!docExists) {
        await _usersCollection.doc(user.uid).set(userModel.toJson());
      }

      return userModel;
    } on FirebaseAuthException catch (e) {
      throw Exception('Google sign in failed: ${e.message}');
    }
  }

  @override
  Future<UserModel> signInWithFacebook() async {
    try {
      final result = await FacebookAuth.instance.login();

      if (result.status != LoginStatus.success || result.accessToken == null) {
        throw Exception('Facebook sign in failed: ${result.message}');
      }

      final credential = FacebookAuthProvider.credential(result.accessToken!.tokenString);
      final userCredential = await _firebaseAuth.signInWithCredential(credential);
      final user = userCredential.user;
      if (user == null) throw Exception('User is null after Facebook sign in');

      final userModel = _createUserModel(user);
      final docExists = (await _usersCollection.doc(user.uid).get()).exists;

      if (!docExists) {
        await _usersCollection.doc(user.uid).set(userModel.toJson());
      }

      return userModel;
    } on FirebaseAuthException catch (e) {
      throw Exception('Facebook sign in failed: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error during Facebook sign in: $e');
    }
  }


  @override
  Future<UserModel?> getCurrentUser() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;
    return _createUserModel(user);
  }


  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception('Sign out failed: $e');
    }
  }


  UserModel _createUserModel(User user) {
    return UserModel(
      userId: user.uid,
      firstName: user.displayName ?? '',
      lastName: '',
      dob: DateTime.now(),
      phoneNumber: user.phoneNumber ?? '',
      email: user.email ?? '',
      country: '',
      stateProvince: '',
      municipality: '',
      zipCode: '',
      favoriteTeamId: '',
      notifications: UserNotifications(app: true, favoriteTeam: true),
      pictureUrl: user.photoURL??''
    );
  }

  UserModel _mapEntityToModel(User firebaseUser, UserEntity entity) {
    return UserModel(
      userId: firebaseUser.uid,
      firstName: entity.firstName,
      lastName: entity.lastName,
      dob: entity.dob ?? DateTime.now(),
      phoneNumber: entity.phoneNumber ?? '',
      email: firebaseUser.email ?? '',
      country: entity.country ?? '',
      stateProvince: entity.stateProvince ?? '',
      municipality: entity.municipality ?? '',
      zipCode: entity.zipCode ?? '',
      favoriteTeamId: entity.favoriteTeamId ?? '',
      notifications: entity.notifications??UserNotifications(app: true,favoriteTeam: true),
      pictureUrl: entity.pictureUrl??''
    );
  }

  @override
  Future<void> resetEmailPassword(String email,) async {
    try {
      _firebaseAuth.sendPasswordResetEmail(email: email);
    } on Exception catch (e) {
      throw Exception('Send password reset email failed: ${e.toString()}');
    }
  }
}
