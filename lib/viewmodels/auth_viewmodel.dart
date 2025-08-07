import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/services/firebase/firebase_auth_service.dart';
import 'package:travel_app/services/firebase/firebase_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthViewModel extends ChangeNotifier {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final FirestoreService _firestoreService = FirestoreService();

  User? _currentUser;
  User? get currentUser => _currentUser;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  AuthViewModel() {
    _authService.authStateChanges.listen((user) {
      _currentUser = user;
      notifyListeners();
    });
  }

  Future<void> signInWithGoogle() async {
    _isLoading = true;
    notifyListeners();
    try {
      final userCredential = await _authService.signInWithGoogle();
      if (userCredential != null && userCredential.user != null) {
        _currentUser = userCredential.user;
        await _firestoreService.createUserProfile(
          _currentUser!.uid,
          _currentUser!.displayName,
          _currentUser!.email,
        );
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();
    try {
      await _authService.signOut();
      _currentUser = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //Slogans for login view
  List<Map<String, String>> getSlogans(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return [
      {
        'title': loc?.exploreTheWorldTitle ?? 'Explore the World',
        'subtitle':
            loc?.exploreTheWorldSubtitle ?? 'Your next adventure awaits.',
      },
      {
        'title': loc?.planYourJourneyTitle ?? 'Plan Your Journey',
        'subtitle':
            loc?.planYourJourneySubtitle ?? 'Effortless travel planning.',
      },
      {
        'title': loc?.discoverNewPlacesTitle ?? 'Discover New Places',
        'subtitle':
            loc?.discoverNewPlacesSubtitle ?? 'Unforgettable experiences.',
      },
    ];
  }
}
