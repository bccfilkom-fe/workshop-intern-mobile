import 'package:fe_bccintern24/app/styles/color_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Buttons extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final double width;
  final bool isClickable;

  const Buttons({
    Key? key,
    required this.text,
    required this.onClicked,
    required this.width,
    required this.isClickable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
          child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              isClickable ? ColorStyles.primary : ColorStyles.lightGrey),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          elevation: MaterialStateProperty.all<double>(0),
          minimumSize: MaterialStateProperty.all<Size>(Size(width, 46)),
        ),
        onPressed: onClicked,
        child: Text(
          text,
          style: GoogleFonts.poppins(
              color: ColorStyles.white,
              fontSize: 13,
              fontWeight: FontWeight.w400),
        ),
      ));
}
