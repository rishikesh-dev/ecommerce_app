import 'package:ecommerce_app/core/constants/constants.dart';
import 'package:ecommerce_app/core/widgets/rounded_button.dart';
import 'package:ecommerce_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce_app/features/details/presentation/bloc/details_bloc.dart';
import 'package:ecommerce_app/features/home/presentation/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsScreen extends StatefulWidget {
  final int id;
  const DetailsScreen({super.key, required this.id});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DetailsBloc>().add(LoadDetailsEvent(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(10),
        child: CustomScrollView(
          slivers: [
            /// Custom app bar
            AppBarWidget(title: 'Details', onPressed: () {}, isBottom: false),

            /// BlocBuilder to show details
            BlocBuilder<DetailsBloc, DetailsState>(
              builder: (context, state) {
                if (state is DetailsLoading) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                }

                if (state is DetailsError) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(state.message),
                      ),
                    ),
                  );
                }

                if (state is DetailsLoaded) {
                  final details = state.details;

                  return SliverList(
                    delegate: SliverChildListDelegate([
                      /// IMAGE (first image for now, can add carousel later)
                      Stack(
                        children: [
                          Center(
                            child: Image.network(
                              details.images[0],
                              height: MediaQuery.of(context).size.height / 2.5,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      /// TITLE
                      Text(
                        details.title,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        ' ${details.stock} in stock',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: details.stock < 10
                              ? Colors.red
                              : Colors.green.shade900,
                        ),
                      ),

                      /// RATING + REVIEWS COUNT
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 30),
                          const SizedBox(width: 5),
                          Text(
                            '${details.rating}/5',
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            ' (${details.reviews.length} reviews)',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).focusColor,
                            ),
                          ),
                        ],
                      ),

                      k15H,

                      /// DESCRIPTION
                      Text(
                        details.description,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).focusColor,
                        ),
                      ),

                      k10H,
                      Text.rich(
                        TextSpan(
                          text: details.discountPercentage > 0
                              ? '- ${details.discountPercentage.toInt()}%'
                              : '',
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).canvasColor,
                          ),
                          children: [
                            TextSpan(
                              text: ' \$${details.price}',
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).cardColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// REVIEWS HEADER
                      Text(
                        '${details.reviews.length} Reviews',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      k10H,
                    ]),
                  );
                }

                return const SliverToBoxAdapter(child: SizedBox());
              },
            ),

            /// Reviews list (separate sliver)
            BlocBuilder<DetailsBloc, DetailsState>(
              builder: (context, state) {
                if (state is DetailsLoaded &&
                    state.details.reviews.isNotEmpty) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate((ctx, index) {
                      final review = state.details.reviews[index];
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                        ),
                        title: StarRating(
                          rating: review.rating.toDouble(),
                          size: 25,
                        ),

                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              review.comment,
                              style: TextStyle(
                                fontSize: 17,
                                color: Theme.of(context).focusColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text.rich(
                              TextSpan(
                                text: review.reviewerName,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        '  ${review.date.day}-${review.date.month}-${review.date.year}',
                                    style: TextStyle(
                                      color: Theme.of(context).focusColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }, childCount: state.details.reviews.length),
                  );
                }
                return const SliverToBoxAdapter(child: SizedBox());
              },
            ),
          ],
        ),
      ),

      /// Bottom Bar
      bottomNavigationBar: BlocBuilder<DetailsBloc, DetailsState>(
        builder: (context, state) {
          if (state is DetailsLoaded) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
              child: Row(
                children: [
                  Text.rich(
                    TextSpan(
                      text: 'Price\n',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: '\$${state.details.price}',
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: BlocListener<CartBloc, CartState>(
                      listener: (context, state) {
                        if (state is CartLoaded) {
                          // Show a snackbar or a message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Item added to cart')),
                          );
                        }
                      },
                      child: RoundedButton(
                        isLeft: true,
                        title: 'Add to Cart',
                        onPressed: () {
                          context.read<CartBloc>().add(
                            AddToCartEvent(product: state.details),
                          );
                        },
                        icon: const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.local_mall_outlined, size: 25),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final double rating;
  final int starCount;
  final double size;

  const StarRating({
    super.key,
    required this.rating,
    this.starCount = 5,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(starCount, (index) {
        if (index < rating.floor()) {
          return Icon(Icons.star, color: Colors.amber, size: size);
        } else if (index < rating) {
          return Icon(Icons.star_half, color: Colors.amber, size: size);
        } else {
          return Icon(Icons.star_border, color: Colors.grey, size: size);
        }
      }),
    );
  }
}
