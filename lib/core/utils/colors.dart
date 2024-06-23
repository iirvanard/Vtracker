import 'dart:ui';

class HexColor {
  Color hexToRgba(String hexCode) {
    hexCode = hexCode.replaceAll("#", "");

    if (hexCode.length == 6) {
      hexCode = "FF$hexCode";
    }

    int hexValue = int.parse(hexCode, radix: 16);
    int r = (hexValue & 0xFF000000) >> 24;
    int g = (hexValue & 0x00FF0000) >> 16;
    int b = (hexValue & 0x0000FF00) >> 8;
    int a = hexValue & 0x000000FF;

    return Color.fromRGBO(r, g, b, a / 0.8);
  }
}
