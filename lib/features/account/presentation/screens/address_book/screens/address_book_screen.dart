import 'package:ecommerce_app/core/routes/router_constants.dart';
import 'package:ecommerce_app/core/widgets/rounded_button.dart';
import 'package:ecommerce_app/features/account/presentation/blocs/address/bloc/address_bloc.dart';
import 'package:ecommerce_app/features/home/presentation/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AddressBookScreen extends StatefulWidget {
  const AddressBookScreen({super.key});

  @override
  State<AddressBookScreen> createState() => _AddressBookScreenState();
}

class _AddressBookScreenState extends State<AddressBookScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AddressBloc>().add(LoadAddressEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(10),
        child: CustomScrollView(
          slivers: [
            AppBarWidget(title: 'Address', onPressed: () {}, isBottom: false),
            SliverToBoxAdapter(
              child: Text(
                ' Saved Address',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            BlocBuilder<AddressBloc, AddressState>(
              builder: (context, state) {
                if (state is AddressError) {
                  return SliverFillRemaining(
                    child: Center(child: Text(state.message)),
                  );
                }
                if (state is AddressLoading) {
                  return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (state is AddressLoaded) {
                  if (state.addresses.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30.0),
                        child: Center(
                          child: Text(
                            'No address found',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return SliverList(
                    delegate: SliverChildBuilderDelegate((ctx, index) {
                      final address = state.addresses[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Theme.of(context).highlightColor,
                            ),
                          ),
                          leading: const Icon(LucideIcons.mapPin),
                          title: Row(
                            children: [
                              Text(address.fullName),
                              address.isDefault
                                  ? Card(
                                      color: Theme.of(context).highlightColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                        ),
                                        child: Text(
                                          'Default',
                                          style: TextStyle(
                                            color: Theme.of(context).cardColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(address.landMark),
                              Row(
                                spacing: 10,
                                children: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      minimumSize: Size(50, 35),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          100,
                                        ),
                                        side: BorderSide(
                                          color: Theme.of(context).focusColor,
                                        ),
                                      ),
                                      foregroundColor: Theme.of(
                                        context,
                                      ).cardColor,
                                    ),
                                    onPressed: () {
                                      context
                                          .pushNamed(
                                            RouterConstants.addNewAddressScreen,
                                            extra: {
                                              'id': address.id,
                                              'country': address.country,
                                              'buildingNo': address.buildingNo,
                                              'fullName': address.fullName,
                                              'landMark': address.landMark,
                                              'area': address.area,
                                              'town': address.town,
                                              'state': address.state,
                                              'mobileNo': address.mobileNo,
                                              'pincode': address.pincode,
                                              'isDefault': address.isDefault,
                                            },
                                          )
                                          .then((_) {
                                            if (context.mounted) {
                                              context.read<AddressBloc>().add(
                                                LoadAddressEvent(),
                                              );
                                            }
                                          });
                                    },
                                    child: Text('edit'),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      minimumSize: Size(50, 35),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          100,
                                        ),
                                        side: BorderSide(
                                          color: Theme.of(context).focusColor,
                                        ),
                                      ),
                                      foregroundColor: Theme.of(
                                        context,
                                      ).cardColor,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: Text('Are you sure?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                context.pop();
                                              },
                                              child: Text('No'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                context.read<AddressBloc>().add(
                                                  DeleteAddressEvent(
                                                    id: address.id,
                                                  ),
                                                );
                                                context.pop();
                                              },
                                              child: Text('Yes'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: Text('delete'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: Radio(
                            value: address.isDefault,
                            groupValue: true,
                            activeColor: Theme.of(context).cardColor,
                            toggleable: true,
                            visualDensity: VisualDensity.comfortable,
                            onChanged: (_) {
                              context.read<AddressBloc>().add(
                                SetDefaultAddressEvent(id: address.id),
                              );
                            },
                          ),
                        ),
                      );
                    }, childCount: state.addresses.length),
                  );
                }
                return const SliverToBoxAdapter(child: SizedBox());
              },
            ),

            SliverToBoxAdapter(
              child: RoundedButton(
                isLeft: true,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                foregroundColor: Theme.of(context).cardColor,
                icon: Icon(LucideIcons.plus),
                title: 'Add New Address',
                onPressed: () {
                  context.pushNamed(RouterConstants.addNewAddressScreen);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
