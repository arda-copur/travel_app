import 'package:flutter/material.dart';
import 'package:travel_app/models/travel.dart';
import 'package:travel_app/models/user_profile.dart';
import 'package:travel_app/services/firebase/firebase_auth_service.dart';
import 'package:travel_app/services/firebase/firebase_service.dart';
import 'package:travel_app/services/data/travel_data_service.dart';

class ProfileViewModel extends ChangeNotifier {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final FirestoreService _firestoreService = FirestoreService();
  final TravelDataService _travelDataService = TravelDataService();

  UserProfile? _userProfile;
  UserProfile? get userProfile => _userProfile;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Travel> _favoriteTrips = [];
  List<Travel> get favoriteTrips => _favoriteTrips;

  ProfileViewModel() {
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    _isLoading = true;
    notifyListeners();
    final user = _authService.getCurrentUser();
    if (user != null) {
      _userProfile = await _firestoreService.getUserProfile(user.uid);
      await _loadFavoriteTrips();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> _loadFavoriteTrips() async {
    final allTrips = await _travelDataService.loadTravelData();
    final favoriteIds =
        await _travelDataService.localStorageService.getFavoriteTripIds();
    _favoriteTrips =
        allTrips.where((trip) => favoriteIds.contains(trip.id)).toList();
    notifyListeners();
  }

  Future<void> updateFullName(String newFullName) async {
    _isLoading = true;
    notifyListeners();
    final user = _authService.getCurrentUser();
    if (user != null) {
      try {
        await _firestoreService.updateUserProfile(user.uid, newFullName);
        _userProfile = _userProfile?.copyWith(fullName: newFullName) ??
            UserProfile(
              uid: user.uid,
              fullName: newFullName,
              email: user.email,
              createdAt: DateTime.now(),
            );
      } catch (e) {
        print('Error updating profile: $e');
        rethrow;
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    } else {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();
    try {
      await _authService.signOut();
      _userProfile = null;
      _favoriteTrips = [];
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

extension on UserProfile {
  UserProfile copyWith({
    String? fullName,
    String? email,
    DateTime? createdAt,
    DateTime? lastLogin,
  }) {
    return UserProfile(
      uid: uid,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
    );
  }
}
