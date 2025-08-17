import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:eventlyy/FireBase/firebase_services.dart';
import 'package:eventlyy/Providers/settings_provider.dart';
import 'package:eventlyy/Providers/user_provider.dart';
import 'package:eventlyy/Screens/Auth/forget_password_screen.dart';
import 'package:eventlyy/Screens/Auth/register_screen.dart';
import 'package:eventlyy/Screens/Home/home_screen.dart';
import 'package:eventlyy/Widgets/default_elevated_button.dart';
import 'package:eventlyy/Widgets/default_text_field.dart';
import 'package:eventlyy/apptheme.dart';
import 'package:eventlyy/l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isCentered = true;
  bool _showText = false;
  late String _text;
  String _displayedText = '';
  bool _eraseText = false;
  bool _showLoginForm = false;

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _text = AppLocalizations.of(context)!.hello_again_lets_begin;
      _displayedText = _text;
    });
    _startAnimationSequence();
  }

  Future<void> _eraseTextAnimated() async {
    for (int i = _text.length; i >= 0; i--) {
      await Future.delayed(Duration(milliseconds: 25));
      if (!mounted) return;
      setState(() {
        _displayedText = _text.substring(0, i);
      });
    }
    setState(() {
      _showText = false;
    });
  }

  Future<void> _startAnimationSequence() async {
    // 1s delay, then show the text
    await Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        _showText = true;
        setState(() {});
      }
    });

    // then wait 4.5 seconds for the text to erase then move the logo to the top
    await Future.delayed(Duration(milliseconds: 4600), () {
      if (mounted) {
        _isCentered = false;
        setState(() {});
      }
    });

    // then wait 500ms for the image to move, then fade in the Login form
    await Future.delayed(Duration(milliseconds: 500), () {
      if (mounted) {
        _showLoginForm = true;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    AppLocalizations localizations = AppLocalizations.of(context)!;
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  top: _isCentered ? size.height * 0.4 : size.height * 0.1,
                  left: 0,
                  right: 0,
                  child: Hero(
                    tag: 'evently-logo',
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: size.height * 0.2,
                    ),
                  ),
                ),

                if (_showText)
                  Positioned(
                    top: size.height * 0.6,
                    left: 0,
                    right: 0,
                    child: Center(
                      child:
                          !_eraseText
                              ? AnimatedTextKit(
                                animatedTexts: [
                                  TypewriterAnimatedText(
                                    _text,
                                    textStyle: textTheme.headlineSmall!
                                        .copyWith(color: Apptheme.primary),
                                    speed: Duration(milliseconds: 70),
                                    cursor: '|',
                                  ),
                                ],
                                onFinished: () {
                                  setState(() {
                                    _eraseText = true;
                                  });
                                  _eraseTextAnimated();
                                },
                                isRepeatingAnimation: false,
                              )
                              : Text(
                                '$_displayedText|',
                                style: textTheme.headlineSmall!.copyWith(
                                  color: Apptheme.primary,
                                ),
                              ),
                    ),
                  ),

                AnimatedOpacity(
                  opacity: _showLoginForm ? 1.0 : 0.0,
                  duration: Duration(seconds: 1),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: size.height * 0.35),
                        DefaultTextField(
                          text: localizations.email,
                          icon: CupertinoIcons.mail_solid,
                          controller: _emailcontroller,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return localizations.field_can_not_be_empty;
                            }
                            if (value.length < 5) {
                              return localizations
                                  .email_can_not_be_less_than_5_characters;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        DefaultTextField(
                          text: localizations.password,
                          icon: CupertinoIcons.padlock_solid,
                          controller: _passwordcontroller,
                          hasSuffix: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return localizations.field_can_not_be_empty;
                            }
                            if (value.length < 6) {
                              return localizations
                                  .password_can_not_be_less_than_6_characters;
                            }
                            return null;
                          },
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(
                                context,
                              ).pushNamed(ForgetPasswordScreen.routeName);
                            },
                            child: Text(
                              localizations.login_forget_password,
                              style: textTheme.titleMedium!.copyWith(
                                color: Apptheme.primary,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: DefaultElevatedButton(
                            text: localizations.login,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                FirebaseServices.login(
                                      email: _emailcontroller.text,
                                      password: _passwordcontroller.text,
                                    )
                                    .then((user) {
                                      Provider.of<UserProvider>(
                                        context,
                                        listen: false,
                                      ).updateCurrentUser(user);
                                      Navigator.of(
                                        context,
                                      ).pushReplacementNamed(
                                        HomeScreen.routeName,
                                      );
                                    })
                                    .catchError((error) {
                                      if (error is FirebaseAuthException) {
                                        DelightToastBar(
                                          position: DelightSnackbarPosition.top,
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
                                                  scale: 4,
                                                  child: Lottie.asset(
                                                    'assets/lottie/Failed.json',
                                                  ),
                                                ),
                                              ),
                                              title: Text(
                                                '${error.message}',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Apptheme.white,
                                                ),
                                              ),
                                            );
                                          },
                                        ).show(context);
                                      }
                                    });
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              localizations.login_dont_have_account,
                              style: textTheme.titleMedium!.copyWith(
                                color:
                                    settingsProvider.isDark
                                        ? Apptheme.white
                                        : Apptheme.black,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(
                                  context,
                                ).pushNamed(RegisterScreen.routeName);
                              },
                              child: Text(
                                localizations.login_create_account,
                                style: textTheme.titleMedium!.copyWith(
                                  color: Apptheme.primary,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Divider(
                                color: Apptheme.primary,
                                thickness: 1,
                                indent: size.width * 0.1,
                              ),
                            ),
                            Text(
                              '     Or     ',
                              style: textTheme.titleMedium!.copyWith(
                                color: Apptheme.primary,
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Apptheme.primary,
                                thickness: 1,
                                endIndent: size.width * 0.1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            // FirebaseServices.googleSignInFunc();
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            elevation: 0,
                            backgroundColor:
                                settingsProvider.isDark
                                    ? Apptheme.darkModeBackGround
                                    : Apptheme.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            side: BorderSide(width: 1, color: Apptheme.primary),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/google.png'),
                              SizedBox(width: 10),
                              Text(
                                localizations.login_login_with_google,
                                style: textTheme.titleLarge!.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
