import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_text_widget.dart';

class InfoTileWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const InfoTileWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.primary,
        size: 22,
      ),
      title: AppTextWidget(
        text: label,
        textSize: 12,
        textColor: AppColors.textMuted,
      ),
      subtitle: AppTextWidget(
        text: value,
        fontWeightIndex: 4,
        textColor: valueColor,
      ),
      dense: true,
    );
  }
}
