import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/utils/connectivity/connectivity_provider.dart';
import 'package:travel_app/utils/extensions/image_extensions.dart';
import 'package:travel_app/utils/extensions/media_query_extension.dart';
import 'package:travel_app/utils/helpers/snackbar_util.dart';
import 'package:travel_app/utils/route/app_routes.dart';
import 'package:travel_app/viewmodels/auth_viewmodel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final List<String> _backgroundImages = [
    JpgImageItems.loginBgOne.imagePath,
    JpgImageItems.loginBgTwo.imagePath,
    JpgImageItems.loginBgThree.imagePath,
  ];

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.read<AuthViewModel>();

    final slogans = authViewModel.getSlogans(context);
    return Scaffold(
      body: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: context.height,
              viewportFraction: 1.0,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: false,
              enableInfiniteScroll: true,
            ),
            items: _backgroundImages
                .map((item) => Image.asset(
                      item,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ))
                .toList(),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.8),
                ],
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(context.dynamicWidth(0.05)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.flight_takeoff,
                    size: context.dynamicWidth(0.3),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  SizedBox(height: context.dynamicHeight(0.03)),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: context.dynamicHeight(0.15),
                      viewportFraction: 1.0,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: false,
                      enableInfiniteScroll: true,
                      scrollDirection: Axis.vertical,
                    ),
                    items: slogans
                        .map((slogan) => Column(
                              // slogans listesini kullan
                              children: [
                                Text(
                                  slogan['title']!,
                                  style: TextStyle(
                                    fontSize: context.dynamicWidth(0.08),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: context.dynamicHeight(0.01)),
                                Text(
                                  slogan['subtitle']!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: context.dynamicWidth(0.04),
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ))
                        .toList(),
                  ),
                  SizedBox(height: context.dynamicHeight(0.05)),
                  Consumer2<AuthViewModel, ConnectivityProvider>(
                    builder:
                        (context, authViewModel, connectivityViewModel, child) {
                      return authViewModel.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : ElevatedButton.icon(
                              onPressed: () async {
                                if (!connectivityViewModel.hasInternet) {
                                  if (!context.mounted) return;
                                  SnackBarUtil.showSnackBar(
                                    context,
                                    AppLocalizations.of(context)
                                            ?.noInternetConnection ??
                                        'No internet connection. Please check your network.',
                                    isError: true,
                                  );
                                  return;
                                }

                                try {
                                  await authViewModel.signInWithGoogle();

                                  if (!context.mounted) return;

                                  if (authViewModel.currentUser != null) {
                                    Navigator.of(context)
                                        .pushReplacementNamed(AppRoutes.home);
                                  } else {
                                    SnackBarUtil.showSnackBar(
                                      context,
                                      AppLocalizations.of(context)
                                              ?.unexpectedError ??
                                          'Unexpected error occurred',
                                      isError: true,
                                    );
                                  }
                                } catch (e) {
                                  if (!context.mounted) return;
                                  SnackBarUtil.showSnackBar(
                                    context,
                                    e.toString(),
                                    isError: true,
                                  );
                                }
                              },
                              icon: Image.asset(
                                'assets/logo/google_logo.png',
                                height: 24.0,
                                width: 24.0,
                              ),
                              label: Text(
                                AppLocalizations.of(context)
                                        ?.signInWithGoogle ??
                                    'Sign in with Google',
                                style: TextStyle(
                                    fontSize: context.dynamicWidth(0.045)),
                              ),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(context.width * 0.8,
                                    context.dynamicHeight(0.06)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black87,
                                elevation: 5,
                              ),
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
