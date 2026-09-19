import 'package:flutter/material.dart';

import '../../../../core/widgets/app_text_widget.dart';

class InfoCardWidget extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const InfoCardWidget({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: AppTextWidget(
              text: title.toUpperCase(),
              textSize: 11,
              fontWeightIndex: 6,
              letterSpacing: 0.8,
              textColor: Theme.of(context).colorScheme.primary,
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}
