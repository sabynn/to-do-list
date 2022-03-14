import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final Color primaryColor = Color(0xFFFFFFFF);
final Color secondaryColor = Color(0xFFA7C7E7);
final Color darkPrimaryColor = Color(0xFF000000);
final Color darkSecondaryColor = secondaryColor;
double defaultMargin = 24.0;
double defaultRadius = 17.0;

Color kLightBlueColor = const Color(0xFF83E9F2);
Color kBlueColor = const Color(0xff63A4FF);
Color kPrimaryColor = const Color(0xff3264E5);
Color kDarkColor = const Color(0xf0002884);
Color kWhiteColor = const Color(0xffFFFFFF);
Color kGreyColor = const Color(0xff9698A9);
Color kGreenColor = const Color(0xff0EC3AE);
Color kRedColor = const Color(0xffEB70A5);
Color kBackgroundColor = const Color(0xffFAFAFA);
Color kInactiveColor = const Color(0xffDBD7EC);
Color kTransparentColor = Colors.transparent;
Color kAvailableColor = const Color(0xffE0D9FF);
Color kUnavailableColor = const Color(0xffEBECF1);


final TextStyle kHeading5 =
GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.w400);
final TextStyle kHeading6 = GoogleFonts.poppins(
    fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15);
final TextStyle kSubtitle = GoogleFonts.poppins(
    fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15);
final TextStyle kBodyText = GoogleFonts.poppins(
    fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.25);
TextStyle darkTextStyle = GoogleFonts.poppins(
  color: kDarkColor,
);
TextStyle whiteTextStyle = GoogleFonts.poppins(
  color: kWhiteColor,
);
TextStyle greyTextStyle = GoogleFonts.poppins(
  color: kGreyColor,
);
TextStyle greenTextStyle = GoogleFonts.poppins(
  color: kGreenColor,
);
TextStyle redTextStyle = GoogleFonts.poppins(
  color: kRedColor,
);
TextStyle blueTextStyle = GoogleFonts.poppins(
  color: kPrimaryColor,
);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;
FontWeight black = FontWeight.w900;

final TextTheme myTextTheme = TextTheme(
  headline1: GoogleFonts.oswald(
      fontSize: 92, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: GoogleFonts.oswald(
      fontSize: 57, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3:
      GoogleFonts.oswald(fontSize: 46, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.oswald(
      fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5:
      GoogleFonts.oswald(fontSize: 23, fontWeight: FontWeight.w400),
  headline6: GoogleFonts.oswald(
      fontSize: 19,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15),
  subtitle1: GoogleFonts.oswald(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.oswald(
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.montserrat(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.montserrat(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.montserrat(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.montserrat(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.montserrat(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);

ThemeData lightTheme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: Colors.white,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: myTextTheme,

  appBarTheme: AppBarTheme(
    iconTheme: const IconThemeData(color: Colors.white),
    backgroundColor: secondaryColor,
    titleTextStyle: myTextTheme.headline6,
    elevation: 0,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: secondaryColor,
    ),
  ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: secondaryColor),
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: darkPrimaryColor,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: myTextTheme,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: darkSecondaryColor,
    unselectedItemColor: Colors.grey,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: secondaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
      ),
    ),
  ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: darkSecondaryColor),
);

