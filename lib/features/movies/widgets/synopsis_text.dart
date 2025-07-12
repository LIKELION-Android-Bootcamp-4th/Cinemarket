import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class SynopsisText extends StatelessWidget {
  final String synopsis;

  const SynopsisText({
    super.key,
    required this.synopsis,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      synopsis,
      style: AppTextStyle.body,
    );
  }
}
