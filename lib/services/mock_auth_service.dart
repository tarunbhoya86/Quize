// lib/services/mock_auth_service.dart

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/user_model.dart';

class MockAuthService with ChangeNotifier {
  MockUser? _currentUser;
  final Uuid _uuid = const Uuid();

  final Map<String, MockUser> _registeredUsers = {};

  MockUser? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  // NEW METHOD: To securely change the user's password
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
    if (_currentUser == null) {
      throw Exception('You must be logged in to change your password.');
    }
    // Find the user in our mock database
    final userInDb = _registeredUsers[_currentUser!.uid];
    if (userInDb == null) {
      throw Exception('User not found.');
    }
    // Verify the current password
    if (userInDb.password != currentPassword) {
      throw Exception('Incorrect current password.');
    }
    // Update the password
    final updatedUser = userInDb.copyWith(password: newPassword);
    _registeredUsers[_currentUser!.uid] = updatedUser;
    _currentUser = updatedUser;

    notifyListeners();
  }

  Future<void> updateUserProfile({String? newDisplayName, String? newPhotoUrl}) async {
    if (_currentUser == null) return;

    final updatedUser = _currentUser!.copyWith(
      displayName: newDisplayName,
      photoUrl: newPhotoUrl,
    );
    _currentUser = updatedUser;
    _registeredUsers[_currentUser!.uid] = updatedUser;
    await Future.delayed(const Duration(milliseconds: 500));
    notifyListeners();
  }

  Future<void> updateUserQuizStats({required int score, required String quizName}) async {
    if (_currentUser == null) return;
    final updatedUser = _currentUser!.copyWith(
      totalScore: (_currentUser!.totalScore ?? 0) + score,
      completedQuizzes: [...(_currentUser!.completedQuizzes ?? []), quizName],
    );
    _currentUser = updatedUser;
    _registeredUsers[_currentUser!.uid] = updatedUser;
    notifyListeners();
  }

  // ... [The rest of the file (register, login, etc.) remains the same]
  Future<MockUser?> register(String email, String password, String? displayName) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    if (_registeredUsers.values.any((u) => u.email == email)) {
      throw Exception('An account with this email already exists.');
    }
    final newUid = _uuid.v4();
    final newUser = MockUser(
      uid: newUid,
      email: email,
      password: password,
      displayName: displayName ?? email.split('@').first,
      createdAt: DateTime.now(),
      lastLoginAt: DateTime.now(),
      completedQuizzes: [],
      totalScore: 0,
    );
    _registeredUsers[newUid] = newUser;
    return newUser;
  }

  Future<MockUser?> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    try {
      final user = _registeredUsers.values.firstWhere(
            (u) => u.email == email,
      );
      if (user.password == password) {
        final MockUser loggedInUser = user.copyWith(lastLoginAt: DateTime.now());
        _currentUser = loggedInUser;
        _registeredUsers[loggedInUser.uid] = loggedInUser;
        notifyListeners();
        return _currentUser;
      } else {
        throw Exception('Incorrect password. Please try again.');
      }
    } on StateError {
      throw Exception('No user found for this email. Please register.');
    }
  }

  Future<MockUser?> signInWithGoogle() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    const String mockGoogleEmail = 'mock.google@example.com';
    final String mockGoogleUid = 'google-uid-${_uuid.v4()}';
    MockUser? googleUser;
    try {
      googleUser = _registeredUsers.values.firstWhere(
            (u) => u.email == mockGoogleEmail,
      );
      final updatedGoogleUser = googleUser.copyWith(lastLoginAt: DateTime.now());
      _registeredUsers[updatedGoogleUser.uid] = updatedGoogleUser;
      googleUser = updatedGoogleUser;
    } on StateError {
      final newGoogleUser = MockUser(
        uid: mockGoogleUid,
        email: mockGoogleEmail,
        displayName: 'Google User',
        photoUrl: 'https://placehold.co/100x100/A78BFA/ffffff?text=MG',
        createdAt: DateTime.now(),
        lastLoginAt: DateTime.now(),
        password: _uuid.v4(),
        completedQuizzes: [],
        totalScore: 0,
      );
      _registeredUsers[newGoogleUser.uid] = newGoogleUser;
      googleUser = newGoogleUser;
    }
    _currentUser = googleUser;
    notifyListeners();
    return _currentUser;
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
    notifyListeners();
  }
}