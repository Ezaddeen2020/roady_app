import 'package:flutter/material.dart';
import '../model/models.dart';
import '../classes/constants.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            _buildLogo(),
            const SizedBox(width: 12),
            Expanded(child: _buildInfo()),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          restaurant.logoPath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: Colors.grey[300],
            child: const Icon(Icons.restaurant, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (restaurant.sponsored) _buildSponsoredTag(),
        Text(
          restaurant.name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 6),
        _buildRatingAndTime(),
        if (restaurant.freeDelivery || restaurant.discount != null) const SizedBox(height: 6),
        if (restaurant.freeDelivery) _buildFreeDelivery(),
        if (restaurant.discount != null) _buildDiscount(),
      ],
    );
  }

  Widget _buildSponsoredTag() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Text(
        'Gesponsord',
        style: TextStyle(fontSize: 10, color: Colors.black54),
      ),
    );
  }

  Widget _buildRatingAndTime() {
    return Row(
      children: [
        const Icon(Icons.star, color: AppColors.primary, size: 16),
        const SizedBox(width: 4),
        Text(
          restaurant.rating.toString(),
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            '• ${restaurant.deliveryTime}',
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildFreeDelivery() {
    return Row(
      children: [
        const Icon(Icons.delivery_dining, color: AppColors.deliveryPurple, size: 16),
        const SizedBox(width: 4),
        Text(
          'Gratis bezorging',
          style: TextStyle(color: Colors.grey[700], fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildDiscount() {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        restaurant.discount!,
        style: const TextStyle(
          color: AppColors.discountRed,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
