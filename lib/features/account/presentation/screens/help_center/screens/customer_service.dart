import 'package:ecommerce_app/core/widgets/text_field_widget.dart';
import 'package:ecommerce_app/features/home/presentation/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

class CustomerService extends StatelessWidget {
  const CustomerService({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AppBarWidget(
            title: 'Customer Service',
            onPressed: () {},
            isBottom: false,
          ),
          SliverList.builder(
            itemCount: 10,
            itemBuilder: (ctx, index) {
              return Align(
                alignment: index.isEven
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: Column(
                  crossAxisAlignment: index.isEven
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: IntrinsicWidth().stepWidth,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: index.isEven
                              ? Radius.zero
                              : Radius.circular(10),
                          bottomRight: index.isOdd
                              ? Radius.zero
                              : Radius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Lorem ipsum (/ˌlɔː.rəm ˈ$index',
                        style: TextStyle(
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        '10:57 AM',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          spacing: 10,
          children: [
            Expanded(
              child: TextFieldWidget(
                title: 'Write your message',
                controller: TextEditingController(),
              ),
            ),
            IconButton.filled(
              style: IconButton.styleFrom(
                backgroundColor: Theme.of(context).cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {},
              icon: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(Icons.send, size: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
