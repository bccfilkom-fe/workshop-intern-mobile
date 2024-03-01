import 'package:flutter/material.dart';

import '../../styles/color_styles.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: ColorStyles.primary,
      ),
    );
  }
}
