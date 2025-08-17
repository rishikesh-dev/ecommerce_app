import 'package:ecommerce_app/core/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AppBarWidget extends StatelessWidget {
  final String title;
  final bool isFilter, isBottom;
  final VoidCallback onPressed;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  const AppBarWidget({
    this.isBottom = true,
    this.controller,
    super.key,
    required this.title,
    this.isFilter = false,
    required this.onPressed,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 100,
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
      ),
      centerTitle: false,
      actions: [IconButton(onPressed: () {}, icon: Icon(LucideIcons.bell))],
      bottom: isBottom
          ? PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                        preffixIcon: LucideIcons.search,
                        suffixIcon: suffixIcon,
                        title: 'Search for clothes....',
                        controller: controller ?? TextEditingController(),
                      ),
                    ),
                    SizedBox(width: 10),
                    isFilter
                        ? IconButton.filled(
                            onPressed: () => onPressed(),
                            style: IconButton.styleFrom(
                              backgroundColor: Theme.of(context).cardColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            icon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(LucideIcons.slidersVertical),
                            ),
                          )
                        : IconButton.filled(
                            onPressed: () => onPressed(),
                            style: IconButton.styleFrom(
                              backgroundColor: Theme.of(context).cardColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            icon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(LucideIcons.search),
                            ),
                          ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}
