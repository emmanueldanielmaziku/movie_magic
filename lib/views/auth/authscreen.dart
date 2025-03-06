import 'package:flutter/material.dart';
import 'package:movie_magic/core/services/auth_service.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_svg/svg.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool authenticating = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(1.0),
                  ],
                ),
              ),
            ),
          ),
          Column(children: [
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 100.0, left: 20.0, right: 20.0),
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: "Welcome to ",
                        style: TextStyle(
                          height: 1.2,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[100],
                        ),
                      ),
                      const TextSpan(
                        text: "Movie Magic",
                        style: TextStyle(
                          height: 1.2,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ])),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: [
                        // Google Sign In Button
                        Padding(
                          padding: const EdgeInsets.only(bottom: 50.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                authenticating = true;
                              });
                              AuthService().signInWithGoogle();
                            },
                            child: Container(
                              height: 45.0,
                              width: 200.0,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 95, 22, 212),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: authenticating
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(right: 25.0),
                                          child: SizedBox(
                                            width: 15.0,
                                            height: 15.0,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2.0,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Shimmer.fromColors(
                                          baseColor: Colors.grey[200]!,
                                          highlightColor: Colors.grey[700]!,
                                          child: Text(
                                            "Please wait...",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey[800],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: SvgPicture.asset(
                                            'assets/icons/google.svg',
                                            height: 20.0,
                                            width: 20.0,
                                          ),
                                        ),
                                        Shimmer.fromColors(
                                          baseColor: Colors.grey[200]!,
                                          highlightColor: Colors.grey[700]!,
                                          child: Text(
                                            "Sign in with Google",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey[800],
                                            ),
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
                ],
              ),
            ),
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      Divider(
                        color: Colors.grey[600]!,
                        height: 30.0,
                        thickness: 1.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            'By using the app, you agree to our Terms of Service \n and acknowledge reading the Privacy Policy.',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[200],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Privacy Policy",
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 14.0),
                            ),
                            const SizedBox(width: 20.0),
                            Text(
                              ".",
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 14.0),
                            ),
                            const SizedBox(width: 20.0),
                            Text(
                              "Terms of Service",
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 14.0),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ]),
        ],
      ),
    );
  }
}
