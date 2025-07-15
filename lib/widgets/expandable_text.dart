import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final Text textWidget;

  const ExpandableText({super.key, required this.textWidget});

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          crossFadeState:
              isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          firstChild: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.widgetBackground,
              borderRadius: BorderRadius.circular(4),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                widget.textWidget.data ?? '',
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
                style: widget.textWidget.style,
              ),
            ),
          ),

          secondChild: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.widgetBackground,
              borderRadius: BorderRadius.circular(4),
            ),
            child: SizedBox(width: double.infinity, child: widget.textWidget),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => setState(() => isExpanded = !isExpanded),
            style: ElevatedButton.styleFrom(
              foregroundColor: AppColors.textPrimary,
              backgroundColor: AppColors.widgetBackground,
              textStyle: AppTextStyle.body,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            child: Text(
              isExpanded ? '간략히' : '더보기',
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
