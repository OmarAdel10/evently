import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:eventlyy/FireBase/firebase_services.dart';
import 'package:eventlyy/Providers/settings_provider.dart';
import 'package:eventlyy/Providers/user_provider.dart';
import 'package:eventlyy/Widgets/default_elevated_button.dart';
import 'package:eventlyy/Widgets/default_text_field.dart';
import 'package:eventlyy/apptheme.dart';
import 'package:eventlyy/l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({super.key});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    AppLocalizations localizations = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: Apptheme.primary,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(64)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                backgroundColor: Apptheme.white.withValues(alpha: 0.7),
                radius: 60,
                backgroundImage:
                    userProvider.currentUser!.imageUrl != null
                        ? NetworkImage(userProvider.currentUser!.imageUrl!)
                        : null,
                child:
                    userProvider.currentUser!.imageUrl == null
                        ? Icon(
                          CupertinoIcons.person_fill,
                          size: 60,
                          color: Apptheme.black,
                        )
                        : null,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userProvider.currentUser!.name,
                    style: textTheme.headlineSmall,
                  ),
                  Text(
                    userProvider.currentUser!.email,
                    style: textTheme.titleMedium!.copyWith(
                      color: Apptheme.white,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor:
                        settingsProvider.isDark
                            ? Apptheme.darkModeBackGround
                            : Apptheme.lightModeBackGround,
                    enableDrag: true,
                    elevation: 50,
                    isDismissible: true,
                    useSafeArea: true,
                    context: context,
                    builder:
                        (context) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: MediaQuery.sizeOf(context).height * 0.35,
                              decoration: BoxDecoration(
                                color: Apptheme.primary,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(28),
                                  topRight: Radius.circular(28),
                                ),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(
                                      CupertinoIcons.chevron_compact_down,
                                      color: Apptheme.grey,
                                      size: 50,
                                    ),
                                    Stack(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Apptheme.white
                                              .withValues(alpha: 0.7),
                                          backgroundImage:
                                              userProvider
                                                          .currentUser!
                                                          .imageUrl !=
                                                      null
                                                  ? NetworkImage(
                                                    userProvider
                                                        .currentUser!
                                                        .imageUrl!,
                                                  )
                                                  : null,
                                          radius: 100,
                                          child:
                                              userProvider
                                                          .currentUser!
                                                          .imageUrl ==
                                                      null
                                                  ? Icon(
                                                    CupertinoIcons.person_fill,
                                                    size: 100,
                                                    color: Apptheme.black,
                                                  )
                                                  : null,
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                            padding: EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                              color: Apptheme.white,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              border: Border.all(
                                                color: Apptheme.primary,
                                                width: 5,
                                              ),
                                            ),
                                            child: IconButton(
                                              onPressed: () /* async */ {
                                                DelightToastBar(
                                                  position:
                                                      DelightSnackbarPosition
                                                          .top,
                                                  autoDismiss: true,
                                                  snackbarDuration: Duration(
                                                    seconds: 2,
                                                  ),
                                                  builder: (context) {
                                                    return ToastCard(
                                                      color: Apptheme.red,
                                                      leading: SizedBox(
                                                        width: 30,
                                                        height: 30,
                                                        child: Transform.scale(
                                                          scale: 3,
                                                          child: Lottie.asset(
                                                            'assets/lottie/Failed.json',
                                                          ),
                                                        ),
                                                      ),
                                                      title: Text(
                                                        localizations.error,
                                                        style: textTheme
                                                            .titleMedium!
                                                            .copyWith(
                                                              color:
                                                                  Apptheme
                                                                      .white,
                                                            ),
                                                      ),
                                                    );
                                                  },
                                                ).show(context);
                                                // try {
                                                //   showDialog(
                                                //     context: context,
                                                //     builder:
                                                //         (context) => Center(
                                                //           child:
                                                //               CircularProgressIndicator(),
                                                //         ),
                                                //   );

                                                //   userProvider.updateProfileImage().then((
                                                //     _,
                                                //   ) {
                                                //     Navigator.of(context).pop();

                                                //     DelightToastBar(
                                                //       position:
                                                //           DelightSnackbarPosition
                                                //               .top,
                                                //       autoDismiss: true,
                                                //       snackbarDuration:
                                                //           Duration(seconds: 2),
                                                //       builder: (context) {
                                                //         return ToastCard(
                                                //           color: Colors.green,
                                                //           leading: SizedBox(
                                                //             width: 30,
                                                //             height: 30,
                                                //             child: Transform.scale(
                                                //               scale: 4,
                                                //               child: Lottie.asset(
                                                //                 'assets/lottie/successfully2.json',
                                                //               ),
                                                //             ),
                                                //           ),
                                                //           title: Text(
                                                //             'Profile Image Updated Successfuly !',
                                                //             style: TextStyle(
                                                //               fontSize: 16,
                                                //               fontWeight:
                                                //                   FontWeight
                                                //                       .w500,
                                                //               color:
                                                //                   Apptheme
                                                //                       .white,
                                                //             ),
                                                //           ),
                                                //         );
                                                //       },
                                                //     ).show(context);
                                                //   });
                                                // } catch (e) {
                                                //   if (Navigator.canPop(
                                                //     context,
                                                //   )) {
                                                //     Navigator.of(context).pop();
                                                //   }

                                                //   DelightToastBar(
                                                //     position:
                                                //         DelightSnackbarPosition
                                                //             .top,
                                                //     autoDismiss: true,
                                                //     snackbarDuration: Duration(
                                                //       seconds: 2,
                                                //     ),
                                                //     builder: (context) {
                                                //       return ToastCard(
                                                //         color: Apptheme.red,
                                                //         leading: SizedBox(
                                                //           width: 30,
                                                //           height: 30,
                                                //           child: Transform.scale(
                                                //             scale: 3,
                                                //             child: Lottie.asset(
                                                //               'assets/lottie/Failed.json',
                                                //             ),
                                                //           ),
                                                //         ),
                                                //         title: Text(
                                                //           'Error !',
                                                //           style: textTheme
                                                //               .titleMedium!
                                                //               .copyWith(
                                                //                 color:
                                                //                     Apptheme
                                                //                         .white,
                                                //               ),
                                                //         ),
                                                //       );
                                                //     },
                                                //   ).show(context);
                                                // }
                                              },
                                              icon: Icon(
                                                CupertinoIcons
                                                    .rectangle_stack_fill_badge_plus,
                                                size: 24,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                          0.03,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                    children: [
                                      // Name
                                          Text(
                                            localizations.register_name,
                                            style: textTheme.titleLarge!
                                                .copyWith(
                                                  color:
                                                      settingsProvider
                                                              .isDark
                                                          ? Apptheme.white
                                                          : Apptheme.black,
                                                ),
                                          ),
                                          const SizedBox(height: 16),
                                          DefaultTextField(
                                            text:
                                                userProvider
                                                    .currentUser!
                                                    .name,
                                            controller: _nameController,
                                            hasPrefix: true,
                                            icon:
                                                CupertinoIcons.person_fill,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return localizations
                                                    .field_can_not_be_empty;
                                              }
                                              if (value.length < 3) {
                                                return localizations
                                                    .name_can_not_be_less_than_3_characters;
                                              }
                                              return null;
                                            },
                                          ),
                                      const SizedBox(height: 16),
                                      // Email
                                      Text(
                                        localizations.email,
                                        style: textTheme.titleLarge!
                                            .copyWith(
                                              color:
                                                  settingsProvider.isDark
                                                      ? Apptheme.white
                                                      : Apptheme.black,
                                            ),
                                      ),
                                      const SizedBox(height: 16),
                                      DefaultTextField(
                                        text: userProvider.currentUser!.email,
                                        controller: _emailController,
                                        hasPrefix: true,
                                        icon: CupertinoIcons.mail_solid,
                                        readOnly: true,
                                      ),
                                      Spacer(),
                                      SizedBox(
                                        width: double.infinity,
                                        child: DefaultElevatedButton(
                                          text: localizations.update_settings,
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                    .validate() &&
                                                FirebaseAuth
                                                        .instance
                                                        .currentUser!
                                                        .displayName !=
                                                    _nameController.text) {
                                              FirebaseServices.updateUserName(
                                                _nameController.text,
                                              ).then((_) {
                                                userProvider.updateUserName(
                                                  _nameController.text,
                                                );
                                                Navigator.of(context).pop();
                                                DelightToastBar(
                                                  position:
                                                      DelightSnackbarPosition
                                                          .top,
                                                  autoDismiss: true,
                                                  snackbarDuration: Duration(
                                                    seconds: 2,
                                                  ),
                                                  builder: (context) {
                                                    return ToastCard(
                                                      color: Colors.green,
                                                      leading: SizedBox(
                                                        width: 30,
                                                        height: 30,
                                                        child: Transform.scale(
                                                          scale: 4,
                                                          child: Lottie.asset(
                                                            'assets/lottie/successfully2.json',
                                                          ),
                                                        ),
                                                      ),
                                                      title: Text(
                                                        localizations
                                                            .settings_updated_successfully,
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Apptheme.white,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ).show(context);
                                              });
                                            } else {
                                              DelightToastBar(
                                                position:
                                                    DelightSnackbarPosition.top,
                                                autoDismiss: true,
                                                snackbarDuration: Duration(
                                                  seconds: 2,
                                                ),
                                                builder: (context) {
                                                  return ToastCard(
                                                    color: Apptheme.red,
                                                    leading: SizedBox(
                                                      width: 30,
                                                      height: 30,
                                                      child: Transform.scale(
                                                        scale: 3,
                                                        child: Lottie.asset(
                                                          'assets/lottie/Failed.json',
                                                        ),
                                                      ),
                                                    ),
                                                    title: Text(
                                                      localizations.error,
                                                      style: textTheme
                                                          .titleMedium!
                                                          .copyWith(
                                                            color:
                                                                Apptheme.white,
                                                          ),
                                                    ),
                                                  );
                                                },
                                              ).show(context);
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                  );
                },
                icon: Icon(
                  CupertinoIcons.pencil,
                  color: Apptheme.white,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
