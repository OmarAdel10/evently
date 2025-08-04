import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:eventlyy/FireBase/firebase_services.dart';
import 'package:eventlyy/Screens/Auth/forget_password_screen.dart';
import 'package:eventlyy/Screens/Auth/register_screen.dart';
import 'package:eventlyy/Screens/Home/home_screen.dart';
import 'package:eventlyy/Widgets/default_elevated_button.dart';
import 'package:eventlyy/Widgets/default_text_field.dart';
import 'package:eventlyy/apptheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  final String _text = 'Hello Again, Let\'s Begin';
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
    _displayedText = _text;
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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                  textStyle: textTheme.headlineSmall!.copyWith(
                                    color: Apptheme.primary,
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
                              ),
                            ),
                  ),
                ),

              AnimatedOpacity(
                opacity: _showLoginForm ? 1.0 : 0.0,
                duration: Duration(seconds: 1),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: size.height * 0.35),
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
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(
                                context,
                              ).pushNamed(ForgetPasswordScreen.routeName);
                            },
                            child: Text(
                              'Forget Password?',
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
                            text: 'Login',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                FirebaseServices.login(
                                  email: _emailcontroller.text,
                                  password: _passwordcontroller.text,
                                ).then(
                                  (user) => Navigator.of(
                                    context,
                                  ).pushReplacementNamed(HomeScreen.routeName),
                                );
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t Have Account ?',
                              style: textTheme.titleMedium,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(
                                  context,
                                ).pushNamed(RegisterScreen.routeName);
                              },
                              child: Text(
                                'Create Account',
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
                            backgroundColor: Apptheme.white,
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
                                'Login With Google',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
