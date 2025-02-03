import 'package:flutter/material.dart';

class EmptyReportMessage extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;

  const EmptyReportMessage({
    super.key,
    this.icon = Icons.warning_rounded,
    this.title = 'Nenhum dado foi encontrado',
    this.subtitle = 'Aparentemente ainda não existem dados para exibir esse '
        'relatório, considere adicionar novos '
        'candidados <bold>através de arquivo JSON<bold>',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Column(
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 56,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                          children: [
                            TextSpan(text: subtitle!.split('<bold>')[0]),
                            TextSpan(
                              text: subtitle!.split('<bold>')[1],
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}