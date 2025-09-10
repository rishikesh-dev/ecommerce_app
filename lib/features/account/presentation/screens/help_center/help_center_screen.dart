import 'package:ecommerce_app/core/routes/router_constants.dart';
import 'package:ecommerce_app/features/home/presentation/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> helpsTile = [
      {
        'icon': Icon(Icons.headset_mic_outlined),
        'title': 'Customer Service',
        'onTap': () {
          context.pushNamed(RouterConstants.customerServiceScreen);
        },
      },
    ];
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AppBarWidget(title: 'Help Center', onPressed: () {}, isBottom: false),
          SliverList(
            delegate: SliverChildListDelegate(
              helpsTile.map((e) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: ListTile(
                    onTap: e['onTap'],
                    enableFeedback: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.grey.shade400, width: .6),
                    ),
                    title: Text(e['title']),
                    leading: e['icon'],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
