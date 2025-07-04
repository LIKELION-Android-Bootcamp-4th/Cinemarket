import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:cinemarket/core/theme/app_colors.dart';

enum ToastPlacement { top, center, bottom }

class CommonToast {
  static void show({
    required BuildContext context,
    required String message,
    ToastificationType type = ToastificationType.info,
    ToastPlacement placement = ToastPlacement.bottom,
    Duration duration = const Duration(seconds: 2),
  }) {
    toastification.show(
      context: context,
      title: Text(message),
      autoCloseDuration: duration,
      alignment: _alignmentFromPlacement(placement),
      type: type,
      backgroundColor: AppColors.widgetBackground,
      foregroundColor: AppColors.textPrimary,
      icon: Icon(_iconFromType(type), color: _iconColorFromType(type)),
      margin: const EdgeInsets.only(bottom: 55),
      dragToClose: true,
      pauseOnHover: true,
      borderSide: BorderSide.none,
    );
  }

  static Alignment _alignmentFromPlacement(ToastPlacement placement) {
    switch (placement) {
      case ToastPlacement.bottom:
        return Alignment.bottomCenter;
      case ToastPlacement.center:
        return Alignment.center;
      case ToastPlacement.top:
      default:
        return Alignment.topCenter;
    }
  }

  static IconData _iconFromType(ToastificationType type) {
    switch (type) {
      case ToastificationType.success:
        return Icons.check_circle_outline;
      case ToastificationType.error:
        return Icons.error_outline;
      case ToastificationType.warning:
        return Icons.warning_outlined;
      case ToastificationType.info:
      default:
        return Icons.info_outline;
    }
  }

  static Color _iconColorFromType(ToastificationType type) {
    switch (type) {
      case ToastificationType.success:
        return const Color(0xFF4CAF50); // 초록
      case ToastificationType.error:
        return const Color(0xFFE57373); // 빨강
      case ToastificationType.warning:
        return const Color(0xFFFFB74D); // 주황
      case ToastificationType.info:
      default:
        return const Color(0xFF64B5F6); // 파랑
    }
  }

}
