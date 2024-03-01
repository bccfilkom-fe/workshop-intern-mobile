import 'package:fe_bccintern24/app/styles/color_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFields extends StatefulWidget {
  const TextFields({
    Key? key,
    required this.controller,
    required this.text,
    required this.textInputType,
    required this.onChanged,
  }) : super(key: key);

  final TextEditingController controller;
  final String text;
  final TextInputType textInputType;
  final Function(String) onChanged;

  @override
  _TextFieldsState createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFields> {
  bool isNotEmpty = false;

  @override
  void initState() {
    super.initState();
    if (widget.controller.text.isNotEmpty) {
      setState(() {
        isNotEmpty = true;
      });
    }
  }

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
          fontWeight: FontWeight.w400,
        ),
        onChanged: (value) {
          setState(() {
            isNotEmpty = value.isNotEmpty;
          });
          widget.onChanged(value);
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(16, 0, 12, 0),
          hintText: widget.text,
          labelText: widget.text,
          labelStyle: GoogleFonts.poppins(
            color: ColorStyles.darkGrey,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(
              width: 2,
              color: ColorStyles.primary,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(
              width: isNotEmpty ? 2 : 1,
              color: isNotEmpty ? ColorStyles.primary : ColorStyles.darkGrey,
            ),
          ),
        ),
      ),
    );
  }
}
