part of 'widgets.dart';

class CostumTextFormField extends StatelessWidget {
  final String title;
  final String hintText;
  final bool obscure;
  final TextEditingController controller;
  final Function() onTap;
  final TextInputType keyboardType;
  final double width;
  final double height;
  final int? maxLength;
  final FocusNode? focusNode;
  final Color borderColor;
  final double borderRadius;

  const CostumTextFormField({
    Key? key,
    required this.title,
    required this.hintText,
    this.obscure = false,
    required this.controller,
    required this.onTap,
    this.keyboardType = TextInputType.name,
    this.width = 300,
    this.height = 40,
    this.maxLength,
    this.focusNode,
    this.borderColor = const Color(0xFF1f1a17),
    this.borderRadius = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 0),
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: blackTextFont),
          const SizedBox(height: 6),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(width: 1, color: borderColor),
            ),
            height: height,
            child: TextField(
              focusNode: focusNode,
              keyboardType: keyboardType,
              maxLength: maxLength != null ? maxLength : null,
              obscureText: obscure,
              style: blackTextFont,
              //cursorColor: Colors.white,
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle:
                    blackTextFont.copyWith(color: blackColor.withOpacity(0.5)),
                border: InputBorder.none,
                // Here is key idea
                isDense: true,
                contentPadding: EdgeInsets.only(top: 6, left: 16),
                counterText: '',
                suffixIcon: IconButton(
                  icon: Icon(
                    obscure ? Icons.visibility : Icons.visibility_off,
                    color: hintText == "Kata sandi" || hintText == "Password"
                        ? blackColor
                        : Colors.transparent,
                  ),
                  onPressed: hintText == "Kata sandi" || hintText == "Password"
                      ? onTap
                      : () {},
                ),
              ).copyWith(),
            ),
          ),
        ],
      ),
    );
  }
}
