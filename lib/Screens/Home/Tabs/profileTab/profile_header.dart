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
                radius: 40,
                // backgroundImage:
                //     userProvider.currentUser!.imageUrl != null
                //         ? NetworkImage(userProvider.currentUser!.imageUrl!)
                //         : null,
                child:
                    // userProvider.currentUser!.imageUrl == null
                        /* ? */ Icon(
                          CupertinoIcons.person_fill,
                          size: 40,
                          color: Apptheme.black,
                        )
                        // : null,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userProvider.currentUser?.name ?? 'User',
                    style: textTheme.headlineSmall,
                  ),
                  Text(
                    userProvider.currentUser?.email ?? 'User@Email.com',
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
                        (context) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: IntrinsicHeight(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          CupertinoIcons.chevron_compact_down,
                                          color: Apptheme.grey,
                                          size: 50,
                                        ),
                                        // Profile Avatar
                                        Stack(
                                          children: [
                                            Container(
                                              width: 250,
                                              height: 250,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                gradient: LinearGradient(
                                                  colors:
                                                      settingsProvider.isDark
                                                          ? [
                                                            Apptheme.primary,
                                                            Apptheme.red,
                                                          ]
                                                          : [
                                                            Apptheme.primary,
                                                            Apptheme.grey,
                                                          ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Apptheme.primary.withValues(
                                                      alpha: 0.3,
                                                    ),
                                                    spreadRadius: 0,
                                                    blurRadius: 25,
                                                    offset: const Offset(0, 8),
                                                  ),
                                                ],
                                              ),
                                              child: const Icon(
                                                Icons.person,
                                                size: 105,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              right: 10,
                                              child: Container(
                                                padding: EdgeInsets.all(3),
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Apptheme.darkModeBackGround, width: 1),
                                                  shape: BoxShape.circle,
                                                  gradient: LinearGradient(
                                                    colors:
                                                        settingsProvider.isDark
                                                            ? [
                                                              Apptheme.primary,
                                                              Apptheme.red,
                                                            ]
                                                            : [
                                                              Apptheme.primary,
                                                              Apptheme.grey,
                                                            ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Apptheme.primary
                                                          .withValues(alpha: 0.3),
                                                      spreadRadius: 0,
                                                      blurRadius: 25,
                                                      offset: const Offset(0, 8),
                                                    ),
                                                  ],
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
                                                        .rectangle_stack_fill_badge_plus,color: Apptheme.white,
                                                    size: 24,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                    
                                        const SizedBox(height: 32),
                                    
                                        // Name
                                        Text(
                                          localizations.register_name,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color:
                                                settingsProvider.isDark
                                                    ? Apptheme.white
                                                    : Apptheme.black,
                                          ),
                                        ),
                                    
                                        const SizedBox(height: 8),
                                        // Name Text Field
                                        DefaultTextField(
                                          text: userProvider.currentUser!.name,
                                          controller: _nameController,
                                          hasPrefix: true,
                                          icon: CupertinoIcons.person_fill,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
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
                                        const SizedBox(height: 16,),
                                    
                                        // Email
                                        Text(
                                          localizations.email,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color:
                                                settingsProvider.isDark
                                                    ? Apptheme.white
                                                    : Apptheme.black,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        DefaultTextField(
                                          text: userProvider.currentUser!.email,
                                          controller: _emailController,
                                          hasPrefix: true,
                                          icon: CupertinoIcons.mail_solid,
                                          readOnly: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 32,),
                            
                                // Update Settings button
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
                            
                                const SizedBox(height: 40),
                              ],
                            ),
                          ),
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
