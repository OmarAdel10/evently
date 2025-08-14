import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:eventlyy/FireBase/firebase_services.dart';
import 'package:eventlyy/Providers/user_provider.dart';
import 'package:eventlyy/Screens/Auth/login_screen.dart';
import 'package:eventlyy/Screens/Home/home_screen.dart';
import 'package:eventlyy/Widgets/default_elevated_button.dart';
import 'package:eventlyy/Widgets/default_text_field.dart';
import 'package:eventlyy/apptheme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _namecontroller = TextEditingController();

  final TextEditingController _emailcontroller = TextEditingController();

  final TextEditingController _passwordcontroller = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isCentered = true;
  bool _showText = false;
  final String _text = 'Hi There, Welcome to Evently \u{1F603}';
  String _displayedText = '';
  bool _eraseText = false;
  bool _showLoginForm = false;

  @override
  void dispose() {
    _namecontroller.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _displayedText = _text;
    _startAnimationSequence();
  }

  Future<void> _eraseTextAnimated() async {
    for (var i = _text.length; i >= 0; i--) {
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
    await Future.delayed(Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          _showText = true;
        });
      }
    });

    // then wait 4.5s for the erase text to be completed then move the logo to the top
    await Future.delayed(Duration(milliseconds: 5500), () {
      if (mounted) {
        setState(() {
          _isCentered = false;
        });
      }
    });
    // then wait 500ms for the image to move, then fade in the Login form
    await Future.delayed(Duration(milliseconds: 700), () {
      if (mounted) {
        setState(() {
          _showLoginForm = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  right: 0,
                  left: 0,
                  top: _isCentered ? size.height * 0.4 : size.height * 0.1,
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
                    left: 0,
                    right: 0,
                    top: size.height * 0.6,
                    child: Center(
                      child:
                          !_eraseText
                              ? AnimatedTextKit(
                                animatedTexts: [
                                  TypewriterAnimatedText(
                                    _text,
                                    textStyle: textTheme.headlineSmall!
                                        .copyWith(
                                          color: Apptheme.primary,
                                          fontSize: 22,
                                        ),
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
                                _displayedText + '|',
                                style: textTheme.headlineSmall!.copyWith(
                                  color: Apptheme.primary,
                                  fontSize: 22,
                                ),
                              ),
                    ),
                  ),

                AnimatedOpacity(
                  duration: Duration(seconds: 1),
                  opacity: _showLoginForm ? 1.0 : 0.0,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: size.height * 0.35),
                        DefaultTextField(
                          text: 'Name',
                          icon: CupertinoIcons.mail_solid,
                          controller: _namecontroller,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field Can Not Be Empty';
                            }
                            if (value.length < 3) {
                              return 'Name Can Not be Less Than 3 Characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        DefaultTextField(
                          text: 'Email',
                          icon: CupertinoIcons.mail_solid,
                          controller: _emailcontroller,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field Can Not Be Empty';
                            }
                            if (value.length < 5) {
                              return 'Email Can Not be Less Than 5 Characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        DefaultTextField(
                          text: 'Password',
                          icon: CupertinoIcons.padlock_solid,
                          controller: _passwordcontroller,
                          hasSuffix: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field Can Not Be Empty';
                            }
                            if (value.length < 8) {
                              return 'Password Can Not be Less Than 8 Characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: DefaultElevatedButton(
                            text: 'Create Account',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                FirebaseServices.register(
                                      name: _namecontroller.text,
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
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already Have Account ?',
                              style: textTheme.titleMedium,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(
                                  context,
                                ).pushReplacementNamed(LoginScreen.routeName);
                              },
                              child: Text(
                                'Login',
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
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.arrow_back_ios, color: Apptheme.primary),
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
