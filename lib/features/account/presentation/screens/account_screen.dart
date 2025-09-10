import 'package:ecommerce_app/core/constants/constants.dart';
import 'package:ecommerce_app/core/routes/router_constants.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/features/home/presentation/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AppBarWidget(title: 'Account', onPressed: () {}, isBottom: false),
          SliverToBoxAdapter(
            child: Column(
              spacing: 5,
              children: [
                Divider(
                  color: Theme.of(context).focusColor.withAlpha(50),
                  height: 0.2,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
                AccountList(
                  title: 'My Orders',
                  icon: LucideIcons.package,
                  isDivider: false,
                  onTap: () {
                    context.pushNamed(RouterConstants.myOrdersScreen);
                  },
                ),
                Divider(
                  color: Theme.of(context).focusColor.withAlpha(50),
                  height: 10,
                  thickness: 10,
                  indent: 0,
                  endIndent: 0,
                ),
                SizedBox(height: 3),
                AccountList(
                  title: 'My Details',
                  icon: LucideIcons.userCog,
                  onTap: () {
                    context.pushNamed(RouterConstants.myDetailsScreen);
                  },
                ),
                AccountList(
                  title: 'Address Book',
                  icon: LucideIcons.mapPin,
                  isDivider: false,
                  onTap: () {
                    context.pushNamed(RouterConstants.myAddressesScreen);
                  },
                ),

                Divider(
                  color: Theme.of(context).focusColor.withAlpha(50),
                  height: 10,
                  thickness: 10,
                  indent: 0,
                  endIndent: 0,
                ),
                AccountList(
                  title: 'Help Center',
                  icon: LucideIcons.headset,
                  isDivider: false,
                  onTap: () {
                    context.pushNamed(RouterConstants.helpCenterScreen);
                  },
                ),
                Divider(
                  color: Theme.of(context).focusColor.withAlpha(50),
                  height: 10,
                  thickness: 10,
                  indent: 0,
                  endIndent: 0,
                ),
                k10H,
                AccountList(
                  title: 'Log Out',
                  icon: LucideIcons.logOut,
                  isDivider: false,
                  isLogin: true,
                  onTap: () {
                    context.read<AuthBloc>().add(AuthLogoutRequested());
                    if (context.read<AuthBloc>().state is AuthSignedOut) {
                      context.goNamed(RouterConstants.loginScreen);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AccountList extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isDivider, isIconNeeded, isLogin;
  const AccountList({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.isIconNeeded = true,
    this.isLogin = false,
    this.isDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          style: ListTileStyle.list,
          textColor: isLogin
              ? Theme.of(context).canvasColor
              : Theme.of(context).cardColor,
          iconColor: isLogin
              ? Theme.of(context).canvasColor
              : Theme.of(context).cardColor,
          enableFeedback: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          leading: Icon(icon),
          title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
          trailing: isIconNeeded
              ? Icon(
                  LucideIcons.chevronRight,
                  color: isLogin
                      ? Theme.of(context).canvasColor
                      : Theme.of(context).focusColor,
                )
              : null,
          onTap: onTap,
        ),
        isDivider
            ? Divider(
                color: Theme.of(context).focusColor.withAlpha(100),
                height: 0.5,
                thickness: 1,
                indent: 50,
                endIndent: 20,
              )
            : SizedBox(),
      ],
    );
  }
}
