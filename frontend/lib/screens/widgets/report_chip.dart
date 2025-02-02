import 'package:flutter/material.dart';

class ReportChip extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onSelect;

  const ReportChip({
    super.key,
    required this.icon,
    required this.text,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Colors.white;
    final theme = Theme.of(context);
    if (isSelected) primaryColor = theme.primaryColor;

    Color borderColor = theme.primaryColor.withValues(alpha: .75);
    if (isSelected) borderColor = Colors.transparent;

    Color textColor = theme.primaryColor.withValues(alpha: .75);
    if (isSelected) textColor = Colors.white;

    return ChoiceChip(
      side: BorderSide(color: borderColor, width: 1),
      padding: EdgeInsets.zero,
      iconTheme: IconThemeData(color: theme.primaryColor),
      showCheckmark: false,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: textColor,
          ),
          SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: textColor,
            ),
          ),
        ],
      ),
      selected: isSelected,
      onSelected: (_) => onSelect(),
      selectedColor: primaryColor,
    );
  }
}
