import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

String baseUrl = "https://newsapi.org/v2/everything?";
String token = "d4f25ffd61c54b98ba1b2420cf4e5065";

myStyle(double fsize, Color color, [FontWeight? fw]) {
  return GoogleFonts.nunito(fontSize: fsize, color: color, fontWeight: fw);
}
