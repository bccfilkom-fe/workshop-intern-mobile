import 'package:fe_bccintern24/app/pages/login_page.dart';
import 'package:fe_bccintern24/app/pages/widgets/buttons.dart';
import 'package:fe_bccintern24/app/pages/widgets/text_fields.dart';
import 'package:fe_bccintern24/app/styles/color_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    const String assetName = 'assets/signup-img.svg';
    final Widget svg = SvgPicture.asset(
      assetName,
    );

    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 155,
              ),
              Center(
                child: svg,
              ),
              const SizedBox(
                height: 60,
              ),
              Text(
                "Daftar",
                style: GoogleFonts.poppins(
                  color: ColorStyles.primary,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Buat Akun Anda!",
                style: GoogleFonts.poppins(
                  color: ColorStyles.darkGrey,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFields(
                controller: emailController,
                text: "Email",
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 12,
              ),
              TextFields(
                controller: passwordController,
                text: "Password",
                textInputType: TextInputType.name,
              ),
              const SizedBox(
                height: 64,
              ),
              Buttons(
                text: "Daftar",
                width: width,
                onClicked: () {
                  //TODO: injeksi fungsi cubit register
                },
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Sudah ada akun?",
                      style: GoogleFonts.poppins(
                        color: ColorStyles.darkGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: " Masuk",
                          style: GoogleFonts.poppins(
                            color: ColorStyles.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
