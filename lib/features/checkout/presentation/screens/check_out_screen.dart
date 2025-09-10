import 'package:ecommerce_app/core/alerts/alert.dart';
import 'package:ecommerce_app/core/constants/constants.dart';
import 'package:ecommerce_app/core/entities/entities/product_entity.dart';
import 'package:ecommerce_app/core/widgets/rounded_button.dart';
import 'package:ecommerce_app/features/account/presentation/blocs/address/bloc/address_bloc.dart';
import 'package:ecommerce_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce_app/features/checkout/domain/entities/payment_method.dart';
import 'package:ecommerce_app/features/checkout/presentation/bloc/check_out_bloc.dart';
import 'package:ecommerce_app/features/checkout/presentation/bloc/payment/bloc/payment_bloc.dart';
import 'package:ecommerce_app/features/home/presentation/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:toastification/toastification.dart';

class CheckOutScreen extends StatelessWidget {
  final double subtotal, vat, shippingFee, total;
  final List<ProductEntity> productEntity;

  const CheckOutScreen({
    super.key,
    required this.subtotal,
    required this.vat,
    required this.shippingFee,
    required this.total,
    required this.productEntity,
  });

  @override
  Widget build(BuildContext context) {
    void placeOrder() {
      final addressState = context.read<AddressBloc>().state;
      if (addressState is! AddressLoaded) {
        alert(
          'Delivery Address',
          'Please add a delivery address',
          ToastificationType.warning,
        );
        return;
      }
      final address = (addressState).addresses;

      // COD
      if (paymentMethods[paymentNotifier.value].key == 'cash') {
        context.read<CheckOutBloc>().add(
          PlaceOrderEvent(
            products: productEntity,
            paymentMethod: 'Cash',
            address: address.first,
            total: total,
          ),
        );
        return;
      }

      // Online Payment
      context.read<PaymentBloc>().add(
        MakePaymentEvent(
          orderId: productEntity.map((e) => e.id).toList().toString(),
          description: productEntity
              .map((e) => e.description)
              .toList()
              .toString(),
          username: productEntity.map((e) => e.title).toList().toString(),
          currency: 'USD',
          amount: total,
          method: paymentMethods[paymentNotifier.value].key,
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(15),
        child: CustomScrollView(
          slivers: [
            AppBarWidget(title: 'Checkout', onPressed: () {}, isBottom: false),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(thickness: 0.5),
                  const SizedBox(height: 10),
                  const DeliveryAddress(),
                  const Divider(thickness: 0.5),
                  const Text(
                    'Payment Method',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const PaymentOptions(),
                  k15H,
                  const Divider(),
                  k15H,
                  const Text(
                    'Order Summary',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  PriceTile(title: 'Sub-total', price: subtotal.ceilToDouble()),
                  PriceTile(title: 'VAT(%)', price: vat.ceilToDouble()),
                  PriceTile(
                    title: 'Shipping fee',
                    price: shippingFee.ceilToDouble(),
                  ),
                  const Divider(),
                  PriceTile(
                    title: 'Total',
                    price: (subtotal + vat + shippingFee).ceilToDouble(),
                  ),
                  const SizedBox(height: 10),

                  /// Payment Listener + Checkout Listener
                  BlocConsumer<PaymentBloc, PaymentState>(
                    listener: (context, paymentState) {
                      if (paymentState is PaymentSuccess) {
                        final addressState = context.read<AddressBloc>().state;
                        if (addressState is AddressLoaded) {
                          final defaultAddress = addressState.addresses
                              .firstWhere((a) => a.isDefault);

                          // Trigger checkout after payment success
                          context.read<CheckOutBloc>().add(
                            PlaceOrderEvent(
                              products: productEntity,
                              paymentMethod:
                                  paymentMethods[paymentNotifier.value].key,
                              address: defaultAddress,
                              total: total,
                            ),
                          );
                        }
                      }

                      if (paymentState is PaymentFailed) {
                        alert(
                          paymentState.message,
                          '',
                          ToastificationType.error,
                        );
                      }
                    },
                    builder: (context, paymentState) {
                      if (paymentState is PaymentProcessing) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return BlocConsumer<CheckOutBloc, CheckOutState>(
                        listener: (context, state) {
                          if (state is CheckOutSuccess) {
                            alert(
                              'Order Placed',
                              'Your order has been placed successfully!',
                              ToastificationType.success,
                            );
                            for (final product in productEntity) {
                              context.read<CartBloc>().add(
                                RemoveFromCartEvent(product: product),
                              );
                            }
                          }

                          if (state is CheckOutError) {
                            alert(state.message, '', ToastificationType.error);
                          }
                        },
                        builder: (context, state) {
                          if (state is CheckOutLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return RoundedButton(
                            title: 'Place Order',
                            onPressed: placeOrder,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// =======================
/// Delivery Address Widget
/// =======================
class DeliveryAddress extends StatefulWidget {
  const DeliveryAddress({super.key});

  @override
  State<DeliveryAddress> createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> {
  @override
  void initState() {
    super.initState();
    context.read<AddressBloc>().add(LoadAddressEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressBloc, AddressState>(
      builder: (context, state) {
        if (state is AddressLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is AddressError) {
          return Text(state.message);
        }
        if (state is AddressLoaded) {
          if (state.addresses.isEmpty) {
            return const Center(child: Text('No Address found'));
          }

          final defaultAddress = state.addresses.firstWhere((a) => a.isDefault);

          return ListTile(
            leading: const Icon(LucideIcons.mapPin),
            title: Text(defaultAddress.area),
            subtitle: Text(defaultAddress.landMark),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

/// =======================
/// Price Tile Widget
/// =======================
class PriceTile extends StatelessWidget {
  final String title;
  final double price;

  const PriceTile({super.key, required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
      ),
      trailing: Text(
        '\$ $price',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }
}

/// =======================
/// Payment Options Widget
/// =======================
ValueNotifier<int> paymentNotifier = ValueNotifier<int>(0);

final List<PaymentMethod> paymentMethods = [
  PaymentMethod(id: 0, title: 'Card', key: 'card'),
  PaymentMethod(id: 1, title: 'Cash', key: 'cash'),
  PaymentMethod(id: 2, title: 'Net Banking', key: 'netbanking'),
];

class PaymentOptions extends StatefulWidget {
  const PaymentOptions({super.key});
  @override
  State<PaymentOptions> createState() => _PaymentOptionsState();
}

class _PaymentOptionsState extends State<PaymentOptions> {
  @override
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: paymentNotifier,
      builder: (context, selectedIndex, _) {
        return Column(
          children: [
            Row(
              children: [
                buildOption(
                  context,
                  index: 0,
                  icon: Icons.credit_card_outlined,
                  label: paymentMethods[0].title,
                  selected: selectedIndex == 0,
                ),
                buildOption(
                  context,
                  index: 1,
                  icon: Icons.money_sharp,
                  label: paymentMethods[1].title,
                  selected: selectedIndex == 1,
                ),
                buildOption(
                  context,
                  index: 2,
                  icon: Icons.mobile_friendly,
                  label: paymentMethods[2].title,
                  selected: selectedIndex == 2,
                ),
              ],
            ),
            const SizedBox(height: 15),
            (paymentNotifier.value == 1)
                ? ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Theme.of(context).cardColor.withAlpha(50),
                      ),
                    ),
                    leading: const Icon(Icons.money_outlined),
                    title: Text(
                      'Cash on delivery',
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Theme.of(context).cardColor.withAlpha(50),
                      ),
                    ),
                    leading: const Icon(Icons.mobile_friendly_outlined),
                    title: Text(
                      'Click on Place Order',
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ],
        );
      },
    );
  }
}

Widget buildOption(
  BuildContext context, {
  required int index,
  required IconData icon,
  required String label,
  required bool selected,
}) {
  return GestureDetector(
    onTap: () => paymentNotifier.value = index,
    child: Card(
      color: selected
          ? Theme.of(context).cardColor
          : Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: selected ? Theme.of(context).cardColor : Colors.grey.shade400,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
        child: Row(
          children: [
            Icon(
              icon,
              color: selected
                  ? Theme.of(context).scaffoldBackgroundColor
                  : Colors.grey.shade600,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: selected
                    ? Theme.of(context).scaffoldBackgroundColor
                    : Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
