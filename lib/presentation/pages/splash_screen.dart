import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../common/styles.dart';


class SplashPage extends StatefulWidget {
  static const routeName = '/splash_screen';
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      Navigator.pushNamedAndRemoveUntil(
          context, '/home', (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF83E9F2), Color(0xff63A4FF)],
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // margin: const EdgeInsets.all(100.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: kDarkColor.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Container(
                    width: 130,
                    height: 130,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/icon-to-do-list.png',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                'LIST YOUR TO DO ✔',
                style: whiteTextStyle.copyWith(
                  fontSize: 25,
                  fontWeight: black,
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
