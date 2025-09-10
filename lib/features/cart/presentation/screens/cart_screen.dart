import 'package:ecommerce_app/core/routes/router_constants.dart';
import 'package:ecommerce_app/core/widgets/rounded_button.dart';
import 'package:ecommerce_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce_app/features/home/presentation/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(GetAllCartsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AppBarWidget(title: 'Cart', onPressed: () {}, isBottom: false),
          SliverToBoxAdapter(child: CheckOut()),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoading) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (state is CartError) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text(
                      state.message,
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
                );
              }
              if (state is CartLoaded) {
                final productList = state.products;
                if (state.products.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(child: Text('No Carted item found')),
                  );
                }
                return SliverList.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                  itemCount: productList.length,
                  itemBuilder: (ctx, index) {
                    final product = productList[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Theme.of(ctx).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Theme.of(ctx).dividerColor.withAlpha(100),
                          width: 0.6,
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            // Product Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                product.thumbnail,
                                width: 120,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),

                            const SizedBox(width: 12),

                            // Product Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.title,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Category: ${product.category}',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '\$${product.price.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Theme.of(context).cardColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Actions
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    LucideIcons.trash2,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    context.read<CartBloc>().add(
                                      RemoveFromCartEvent(product: product),
                                    );
                                  },
                                ),
                                const SizedBox(height: 30),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _QuantityButton(
                                      icon: Icons.remove,
                                      onPressed: () {
                                        if (product.quantity <= 1) {
                                          context.read<CartBloc>().add(
                                            RemoveFromCartEvent(
                                              product: product,
                                            ),
                                          );
                                        }
                                        context.read<CartBloc>().add(
                                          DecreaseQuantityEvent(product.id),
                                        );
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      child: Text(
                                        product.quantity.toString(),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    _QuantityButton(
                                      icon: Icons.add,
                                      onPressed: () {
                                        context.read<CartBloc>().add(
                                          IncreaseQuantityEvent(product.id),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return SliverFillRemaining(
                child: Center(child: Text('No Item found')),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CheckOut extends StatelessWidget {
  const CheckOut({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded && state.products.isNotEmpty) {
          // ✅ Calculate subtotal properly
          double subtotal = state.products.fold(
            0,
            (sum, product) => sum + (product.price * product.quantity),
          );

          // ✅ Safer shipping fee condition
          double shippingFee = 0;
          if (subtotal <= 100) {
            shippingFee = 10; // example condition
          }
          if (subtotal == 0) {
            shippingFee = 0;
          }

          // ✅ Total calculation
          double total = subtotal + shippingFee;
          double vat = total * 0.15;
          return IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                spacing: 10,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sub-total',
                        style: TextStyle(
                          fontSize: 17,
                          color: Theme.of(context).focusColor,
                        ),
                      ),
                      Text(
                        '\$ ${subtotal.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).cardColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'VAT(%)',
                        style: TextStyle(
                          fontSize: 17,
                          color: Theme.of(context).focusColor,
                        ),
                      ),
                      Text(
                        '\$ ${vat.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).cardColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Shipping fee',
                        style: TextStyle(
                          fontSize: 17,
                          color: Theme.of(context).focusColor,
                        ),
                      ),
                      Text(
                        '\$ $shippingFee',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).cardColor,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 17,
                          color: Theme.of(context).focusColor,
                        ),
                      ),
                      Text(
                        '\$ ${(total).toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).cardColor,
                        ),
                      ),
                    ],
                  ),
                  RoundedButton(
                    title: 'Go to Checkout',
                    icon: Icon(LucideIcons.arrowRight400, size: 30),
                    onPressed: () {
                      context.pushNamed(
                        RouterConstants.checkOutScreen,
                        extra: {
                          'subtotal': subtotal,
                          'vat': vat,
                          'shippingFee': shippingFee,
                          'total': total,
                          'products': state.products,
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  const _QuantityButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(icon, size: 18),
      ),
    );
  }
}
