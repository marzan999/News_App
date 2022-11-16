import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

String baseUrl = "https://newsapi.org/v2/everything?";
String token = "fca6f727c71d4201a11f21d74282430f";

myStyle(double fsize, Color color, [FontWeight? fw]) {
  return GoogleFonts.nunito(fontSize: fsize, color: color, fontWeight: fw);
}
