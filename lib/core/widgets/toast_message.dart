import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class ToastMessage extends StatelessWidget {
  final String message;
  final ToastType type;
  final VoidCallback? onDismiss;

  const ToastMessage({
    super.key,
    required this.message,
    this.type = ToastType.info,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _getBorderColor()),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            _getIcon(),
            color: _getIconColor(),
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: AppTheme.bodyStyle.copyWith(
                color: _getTextColor(),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (onDismiss != null) ...[
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onDismiss,
              child: Icon(
                Icons.close,
                color: _getIconColor(),
                size: 18,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (type) {
      case ToastType.success:
        return AppTheme.successColor.withValues(alpha: 0.95);
      case ToastType.error:
        return AppTheme.errorColor.withValues(alpha: 0.95);
      case ToastType.warning:
        return AppTheme.warningColor.withValues(alpha: 0.95);
      case ToastType.info:
        return AppTheme.primaryColor.withValues(alpha: 0.95);
    }
  }

  Color _getBorderColor() {
    switch (type) {
      case ToastType.success:
        return AppTheme.successColor;
      case ToastType.error:
        return AppTheme.errorColor;
      case ToastType.warning:
        return AppTheme.warningColor;
      case ToastType.info:
        return AppTheme.primaryColor;
    }
  }

  Color _getIconColor() {
    switch (type) {
      case ToastType.success:
      case ToastType.error:
      case ToastType.warning:
      case ToastType.info:
        return Colors.white;
    }
  }

  Color _getTextColor() {
    switch (type) {
      case ToastType.success:
      case ToastType.error:
      case ToastType.warning:
      case ToastType.info:
        return Colors.white;
    }
  }

  IconData _getIcon() {
    switch (type) {
      case ToastType.success:
        return Icons.check_circle;
      case ToastType.error:
        return Icons.error;
      case ToastType.warning:
        return Icons.warning;
      case ToastType.info:
        return Icons.info;
    }
  }
}

enum ToastType { success, error, warning, info }

// Helper function to show toast
void showToast(
  BuildContext context, {
  required String message,
  ToastType type = ToastType.info,
  Duration duration = const Duration(seconds: 3),
}) {
  final overlay = Overlay.of(context);
  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).padding.top + 16,
      left: 0,
      right: 0,
      child: Material(
        color: Colors.transparent,
        child: ToastMessage(
          message: message,
          type: type,
          onDismiss: () {
            overlayEntry.remove();
          },
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(duration, () {
    if (overlayEntry.mounted) {
      overlayEntry.remove();
    }
  });
}
