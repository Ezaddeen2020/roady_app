// widgets/app_bar_widget.dart
import 'package:fdelux_source_neytrip/common/app_colors.dart' as common_colors;
import 'package:flutter/material.dart';
// import '../constants.dart';
import '../classes/constants.dart';

class AppBarWidget extends StatelessWidget {
  final String selectedLocation;

  const AppBarWidget({super.key, required this.selectedLocation});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nu',
                  style: TextStyle(
                    fontSize: 13,
                    color: common_colors.AppColors.textSecondary,
                  ),
                ),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        selectedLocation,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down, size: 24),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              CircleIconButton(
                icon: Icons.favorite_outline,
                iconColor: common_colors.AppColors.success,
                backgroundColor: Colors.grey[100]!,
              ),
              const SizedBox(width: 12),
              const CircleIconButton(
                icon: Icons.person_outline,
                iconColor: Colors.green,
                backgroundColor: common_colors.AppColors.background,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  const CircleIconButton({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: iconColor, size: 22),
    );
  }
}
