import 'package:ecommerce_app/core/theme/theme_pallete.dart';
import 'package:ecommerce_app/features/account/presentation/screens/my_orders/widgets/order_tile.dart';
import 'package:ecommerce_app/features/checkout/presentation/bloc/check_out_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CheckOutBloc>().add(FetchOrdersEvent());
    });
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'My Orders',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).focusColor.withAlpha(100),
            ),
            child: TabBar(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              splashBorderRadius: BorderRadius.circular(10),
              dividerHeight: 0,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ThemePallete.whiteColor,
              ),
              controller: tabController,
              labelColor: ThemePallete.blackColor,
              unselectedLabelColor: Theme.of(context).cardColor.withAlpha(120),
              tabs: const [
                Tab(child: Text('Ongoing')),
                Tab(child: Text('Completed')),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: TabBarView(
          controller: tabController,
          children: const [OrderTab(), OrderTab(isCompleted: true)],
        ),
      ),
    );
  }
}

class OrderTab extends StatelessWidget {
  final bool isCompleted;
  const OrderTab({super.key, this.isCompleted = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckOutBloc, CheckOutState>(
      builder: (context, state) {
        if (state is CheckOutLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is CheckOutError) {
          return Center(child: Text(state.message));
        }
        if (state is CheckOutSuccess) {
          final filteredOrder = isCompleted
              ? state.orders.where((o) => o.status == 'Delivered').toList()
              : state.orders.where((o) => o.status != 'Delivered').toList();

          if (filteredOrder.isEmpty) {
            return const Center(child: Text("No orders found"));
          }

          return ListView.builder(
            itemCount: filteredOrder.length,
            itemBuilder: (ctx, index) {
              final orderDetails = filteredOrder[index];
              return OrderTile(order: orderDetails);
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
