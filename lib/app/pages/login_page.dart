import 'package:fe_bccintern24/app/pages/cubit/auth/auth_cubit.dart';
import 'package:fe_bccintern24/app/pages/home_page.dart';
import 'package:fe_bccintern24/app/pages/widgets/buttons.dart';
import 'package:fe_bccintern24/app/pages/widgets/text_fields.dart';
import 'package:fe_bccintern24/app/styles/color_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'signup_page.dart';
import 'widgets/loading.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isClickable = false;

  void checkClickable() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    setState(() {
      isClickable = email.isNotEmpty && password.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    const String assetName = 'assets/login-img.svg';
    final Widget svg = SvgPicture.asset(
      assetName,
    );

    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const HomePage()));
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                duration: const Duration(milliseconds: 2500),
                action: SnackBarAction(
                  label: "OK",
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Loading();
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 155,
                    ),
                    Center(child: svg),
                    const SizedBox(
                      height: 60,
                    ),
                    Text(
                      "Masuk",
                      style: GoogleFonts.poppins(
                          color: ColorStyles.primary,
                          fontSize: 24,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Selamat Datang Kembali!",
                      style: GoogleFonts.poppins(
                          color: ColorStyles.darkGrey,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFields(
                      controller: emailController,
                      text: "Email",
                      textInputType: TextInputType.emailAddress,
                      onChanged: (text) {
                        setState(() {
                          checkClickable();
                        });
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFields(
                      controller: passwordController,
                      text: "Password",
                      textInputType: TextInputType.name,
                      onChanged: (text) {
                        setState(() {
                          checkClickable();
                        });
                      },
                    ),
                    const SizedBox(
                      height: 64,
                    ),
                    Buttons(
                        text: "Masuk",
                        width: width,
                        isClickable: isClickable,
                        onClicked: () {
                          context.read<AuthCubit>().login(
                              emailController.text, passwordController.text);
                        }),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                            text: TextSpan(
                                text: "Belum ada akun?",
                                style: GoogleFonts.poppins(
                                    color: ColorStyles.darkGrey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                                children: [
                              TextSpan(
                                  text: " Daftar",
                                  style: GoogleFonts.poppins(
                                      color: ColorStyles.primary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignupPage()))),
                            ])),
                      ],
                    ),
                  ]),
            ),
          );
        },
      ),
    );
  }
}
