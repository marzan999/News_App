import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

String baseUrl = "https://newsapi.org/v2/everything?";
String token = "f1f697fbcb884fea97366c2bf58fc673";

myStyle(double fsize, Color color, [FontWeight? fw]) {
  return GoogleFonts.nunito(fontSize: fsize, color: color, fontWeight: fw);
}
