part of 'widgets.dart';

class CustomButton extends GestureDetector {
  CustomButton({
    required String title,
    required GestureTapCallback onTap,
    GestureTapCallback? onLongPress,
    double fontSize = 18,
    double height = 40,
    double width = 150,
    double borderRadius = 8,
    Color color = const Color(0xFF5DB075),
    Color borderColor = const Color(0xFF54D3AD),
    Color textColor = const Color(0xFFfeffff),
    bool textBold = false,
    bool showIconShare = false,
    TextAlign textAlign = TextAlign.center,
    int forGender = 0,
  }) : super(
          onLongPress: onLongPress,
          onTap: onTap,
          child: Card(
            elevation: borderRadius,
            color: Colors.transparent,
            shadowColor: Colors.black26,
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: color,
                border: Border.all(color: borderColor),
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRadius),
                ),
              ),
              child: Center(
                child: Text(
                  title,
                  textAlign: textAlign,
                  style: whiteTextFontTitle.copyWith(
                    fontSize: fontSize,
                    color: textColor,
                    fontWeight: textBold ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        );
}
