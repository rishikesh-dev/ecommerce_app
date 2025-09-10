import 'package:ecommerce_app/features/checkout/domain/entities/order_entity.dart';
import 'package:ecommerce_app/features/checkout/presentation/bloc/check_out_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderTrackingScreen extends StatefulWidget {
  final OrderEntity order;
  const OrderTrackingScreen({super.key, required this.order});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  final List<String> statuses = const [
    'Pending',
    'Packed',
    'Shipped',
    'Out for Delivery',
    'Delivered',
  ];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CheckOutBloc>().add(TrackOrdersEvent(id: widget.order.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Track Order')),
      body: BlocBuilder<CheckOutBloc, CheckOutState>(
        builder: (context, state) {
          if (state is CheckOutLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CheckOutError) {
            return Center(child: Text(state.message));
          } else if (state is CheckOutSuccess) {
            // Find the order we are tracking
            final order = state.orders.firstWhere(
              (o) => o.id == widget.order.id,
            );

            final currentIndex = statuses.indexOf(order.status);

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order ID: ${order.id}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Total: ₹${order.totalAmount}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Current Status: ${order.status}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Stepper(
                    currentStep: currentIndex < 0 ? 0 : currentIndex,
                    steps: List.generate(
                      statuses.length,
                      (index) => Step(
                        title: Text(statuses[index]),
                        content: const SizedBox.shrink(),
                        isActive: index <= currentIndex,
                        state: index < currentIndex
                            ? StepState.complete
                            : index == currentIndex
                            ? StepState.editing
                            : StepState.indexed,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
