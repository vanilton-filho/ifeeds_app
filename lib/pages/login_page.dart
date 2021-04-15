import 'dart:async';

import 'package:auth_buttons/res/buttons/google_auth_button.dart';
import 'package:auth_buttons/res/shared/auth_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ifeeds/firebase/firebase_service.dart';
import 'package:ifeeds/models/auth_response.dart';
import 'package:ifeeds/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  bool? isActive;

  LoginPage({this.isActive});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _currentPage = 0;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 0, keepPage: true);

    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage <= 3) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController!.hasClients) {
        _pageController!.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, userSnapshot) {
        if (userSnapshot.hasData) {
          return HomePage();
        } else {
          return Scaffold(
            backgroundColor: Color(0xff4E986E),
            body: Column(
              children: [
                Expanded(
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      PageView(
                        controller: _pageController,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 42),
                            child: Column(
                              children: [
                                Image(
                                  image: AssetImage(
                                    'assets/images/green_logo.png',
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Text(
                                    'O seu feedback sobre o IFS é muito importante para nós',
                                    style: GoogleFonts.roboto(
                                      fontSize: 23.0,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            color: Color(0xff38B6FF),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 42),
                              child: Column(
                                children: [
                                  Image(
                                    image: AssetImage(
                                      'assets/images/blue_logo.png',
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Text(
                                      'Ajude a sua comunidade crescer dando sua opnião',
                                      style: GoogleFonts.roboto(
                                        fontSize: 23.0,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            color: Color(0xffFF1616),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 42),
                              child: Column(
                                children: [
                                  Image(
                                    image: AssetImage(
                                      'assets/images/red_logo.png',
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Text(
                                      'É super fácil e rápido',
                                      style: GoogleFonts.roboto(
                                        fontSize: 23.0,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            color: Color(0xffFFDE59),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 42),
                              child: Column(
                                children: [
                                  Image(
                                    image: AssetImage(
                                      'assets/images/yellow_logo.png',
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Text(
                                      'Estamos prontos para te responder',
                                      style: GoogleFonts.roboto(
                                          fontSize: 23.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 68.0),
                        height: 250,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(42.0),
                            topRight: Radius.circular(42.0),
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                'Junte-se a nossa comunidade e ajude a melhorar o nosso IFS! \\0/',
                                style: GoogleFonts.roboto(fontSize: 18.0),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            GoogleAuthButton(
                              text: 'Entre com o Google',
                              darkMode: false,
                              style: AuthButtonStyle.secondary,
                              onPressed: _onClickGoogle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  _onClickGoogle() async {
    final service = FirebaseService();
    AuthResponse response = await service.loginGoogle();

    if (response.ok!) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return HomePage();
      }));
    } else {
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Não foi possível logar...')));
    }
  }
}
