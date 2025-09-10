import 'package:ecommerce_app/core/routes/router_constants.dart';
import 'package:ecommerce_app/features/checkout/domain/entities/order_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrderTile extends StatelessWidget {
  final OrderEntity order;
  const OrderTile({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final product = order.products.isNotEmpty ? order.products.first : null;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withAlpha(05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image (Larger Like Amazon)
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              product!.thumbnail,
              height: 100, // Increased height
              width: 100, // Increased width
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 100,
                width: 100,
                color: Colors.grey.shade200,
                child: const Icon(Icons.image_not_supported, size: 40),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '₹${order.totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  color: Theme.of(context).highlightColor.withAlpha(200),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 5,
                    ),
                    child: Text(order.status, style: TextStyle(fontSize: 12)),
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Theme.of(context).cardColor,
                      foregroundColor: Theme.of(
                        context,
                      ).scaffoldBackgroundColor,
                    ),
                    onPressed: () {
                      context.pushNamed(
                        RouterConstants.trackOrderScreen,
                        extra: order,
                      );
                    },
                    child: Text('Track Order'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
