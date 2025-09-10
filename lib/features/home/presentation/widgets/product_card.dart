import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/entities/entities/product_entity.dart';
import 'package:ecommerce_app/core/routes/router_constants.dart';
import 'package:ecommerce_app/core/widgets/fav_button.dart';
import 'package:ecommerce_app/features/saved/presentation/blocs/bloc/saved_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ProductCard extends StatefulWidget {
  final ProductEntity product;
  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  void initState() {
    super.initState();
    context.read<SavedBloc>().add(GetSavedItemsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SavedBloc>().state;
    final isLiked =
        state is SavedItemsLoaded && state.products.contains(widget.product);

    final imageUrl = (widget.product.thumbnail.isNotEmpty)
        ? widget.product.thumbnail
        : 'https://via.placeholder.com/300x400.png?text=No+Image';

    return InkWell(
      onTap: () {
        context.pushNamed(
          RouterConstants.detailsScreen,
          pathParameters: {'id': widget.product.id.toString()},
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.grey.shade200,
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.broken_image, size: 40),
                    ),
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: FavButton(
                    isLiked: isLiked,
                    onPressed: () {
                      if (isLiked) {
                        context.read<SavedBloc>().add(
                          RemoveSavedItemsEvent(item: widget.product),
                        );
                      } else {
                        context.read<SavedBloc>().add(
                          AddSavedItemEvent(item: widget.product),
                        );
                      }
                    },
                    icon: isLiked ? Icons.favorite : LucideIcons.heart,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              widget.product.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).cardColor,
              ),
            ),
            Text(
              '\$${widget.product.price}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).focusColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
