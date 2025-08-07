import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/services/data/travel_data_service.dart';
import 'package:travel_app/utils/extensions/media_query_extension.dart';
import 'package:travel_app/utils/helpers/snackbar_util.dart';
import 'package:travel_app/utils/route/app_routes.dart';
import 'package:travel_app/viewmodels/auth_viewmodel.dart';
import 'package:travel_app/viewmodels/home_viewmodel.dart';
import 'package:travel_app/viewmodels/profile_viewmodel.dart';
import 'package:travel_app/utils/helpers/date_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travel_app/widgets/profile/profile_info_card.dart';
import 'package:travel_app/widgets/home/travel_card.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _fullNameController = TextEditingController();
  final TravelDataService _travelDataService = TravelDataService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profileViewModel =
          Provider.of<ProfileViewModel>(context, listen: false);
      if (profileViewModel.userProfile != null) {
        _fullNameController.text = profileViewModel.userProfile!.fullName ?? '';
      }
      // ReservationViewModel'ın constructor'ı zaten rezervasyonları yüklüyor.
      // Burada tekrar çağırmaya gerek yok, Provider hatasına neden olabilir.
      // Provider.of<ReservationViewModel>(context, listen: false).loadReservedTrips(); // Bu satır kaldırıldı
    });
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.profileTitle ?? 'Profile'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).colorScheme.secondary.withOpacity(0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Consumer<ProfileViewModel>(
        builder: (context, profileViewModel, child) {
          if (profileViewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final userProfile = profileViewModel.userProfile;
          final authUser =
              Provider.of<AuthViewModel>(context, listen: false).currentUser;

          return SingleChildScrollView(
            padding: EdgeInsets.all(context.dynamicWidth(0.05)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: context.dynamicWidth(0.15),
                    backgroundColor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    backgroundImage: authUser?.photoURL != null
                        ? NetworkImage(authUser!.photoURL!)
                        : null,
                    child: authUser?.photoURL == null
                        ? Icon(Icons.person_rounded,
                            size: context.dynamicWidth(0.15),
                            color: Theme.of(context).colorScheme.primary)
                        : null,
                  ),
                ),
                SizedBox(height: context.dynamicHeight(0.03)),
                ProfileInfoCard(
                  label: AppLocalizations.of(context)?.fullName ?? 'Full Name',
                  content: TextField(
                    controller: _fullNameController,
                    decoration: InputDecoration(
                      hintText:
                          AppLocalizations.of(context)?.fullName ?? 'Full Name',
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 8.0), // Padding eklendi
                    ),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                ProfileInfoCard(
                  label: AppLocalizations.of(context)?.email ?? 'Email',
                  content: TextFormField(
                    initialValue: authUser?.email ?? 'N/A',
                    readOnly: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 8.0), // Padding eklendi
                    ),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                ProfileInfoCard(
                  label:
                      AppLocalizations.of(context)?.createdAt ?? 'Created At',
                  content: TextFormField(
                    initialValue: userProfile?.createdAt != null
                        ? DateUtil.formatDateTime(userProfile!.createdAt)
                        : 'N/A',
                    readOnly: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 8.0), // Padding eklendi
                    ),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                ProfileInfoCard(
                  label:
                      AppLocalizations.of(context)?.lastLogin ?? 'Last Login',
                  content: TextFormField(
                    initialValue: userProfile?.lastLogin != null
                        ? DateUtil.formatDateTime(userProfile!.lastLogin!)
                        : 'N/A',
                    readOnly: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 8.0), // Padding eklendi
                    ),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                SizedBox(height: context.dynamicHeight(0.04)),
                Center(
                  child: ElevatedButton(
                    onPressed: profileViewModel.isLoading
                        ? null
                        : () async {
                            try {
                              await profileViewModel
                                  .updateFullName(_fullNameController.text);

                              if (!context.mounted) return;

                              SnackBarUtil.showSnackBar(
                                context,
                                AppLocalizations.of(context)?.profileUpdated ??
                                    'Profile updated successfully!',
                              );
                            } catch (e) {
                              if (!context.mounted) return;

                              SnackBarUtil.showSnackBar(
                                context,
                                e.toString(),
                                isError: true,
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(
                          context.width * 0.6, context.dynamicHeight(0.06)),
                    ),
                    child: Text(profileViewModel.isLoading
                        ? (AppLocalizations.of(context)?.saving ?? 'Saving...')
                        : (AppLocalizations.of(context)?.update ?? 'Update')),
                  ),
                ),
                SizedBox(height: context.dynamicHeight(0.02)),
                Center(
                  child: TextButton(
                    onPressed: profileViewModel.isLoading
                        ? null
                        : () async {
                            await Provider.of<AuthViewModel>(context,
                                    listen: false)
                                .signOut();

                            if (!context.mounted) return;

                            Navigator.of(context)
                                .pushReplacementNamed(AppRoutes.login);
                          },
                    child: Text(
                      AppLocalizations.of(context)?.logout ?? 'Logout',
                    ),
                  ),
                ),
                SizedBox(height: context.dynamicHeight(0.04)),
                Text(
                  AppLocalizations.of(context)?.favorites ?? 'Favorites',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: context.dynamicHeight(0.02)),
                Consumer<HomeViewModel>(
                  builder: (context, homeViewModel, child) {
                    final favoriteTrips = homeViewModel.favoriteTrips;
                    if (favoriteTrips.isEmpty) {
                      return Center(
                        child: Text(
                          AppLocalizations.of(context)?.noTripsFound ??
                              'No trips found.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: favoriteTrips.length,
                      itemBuilder: (context, index) {
                        final trip = favoriteTrips[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: context.dynamicHeight(0.005)),
                          child: TravelCard(
                            trip: trip,
                            onToggleFavorite: () {
                              homeViewModel.toggleFavorite(
                                  trip, context); // context eklendi
                              profileViewModel
                                  .loadUserProfile(); // Favori durumu değiştiğinde profil listesini güncelle
                            },
                            travelDataService: _travelDataService,
                          ),
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: context.dynamicHeight(0.04)),
              ],
            ),
          );
        },
      ),
    );
  }
}
