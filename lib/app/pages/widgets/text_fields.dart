import 'package:fe_bccintern24/app/styles/color_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFields extends StatefulWidget {
  const TextFields({
    Key? key,
    required this.controller,
    required this.text,
    required this.textInputType,
  }) : super(key: key);

  final TextEditingController controller;
  final String text;
  final TextInputType textInputType;

  @override
  State<TextFields> createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFields> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.textInputType,
        style: GoogleFonts.poppins(
            color: ColorStyles.darkGrey,
            fontSize: 13,
            fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(16, 0, 12, 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(width: 1),
          ),
          hintText: widget.text,
          labelText: widget.text,
          labelStyle: GoogleFonts.poppins(
              color: ColorStyles.darkGrey,
              fontSize: 13,
              fontWeight: FontWeight.w400),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(
              width: 2,
              color: ColorStyles.primary,
            ),
          ),
        ),
      ),
    );
  }
}
