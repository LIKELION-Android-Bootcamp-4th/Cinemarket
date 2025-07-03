import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';

class SynopsisText extends StatefulWidget {
  final String synopsis;
  final int maxLines;

  const SynopsisText({
    super.key,
    required this.synopsis,
    this.maxLines = 8,
  });

  @override
  State<SynopsisText> createState() => _SynopsisTextState();
}

class _SynopsisTextState extends State<SynopsisText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.synopsis,
          style: AppTextStyle.body,
          maxLines: isExpanded ? null : widget.maxLines,
          overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              isExpanded ? '접기' : '더보기',
              style: AppTextStyle.body.copyWith(
                color: AppColors.textPoint,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
