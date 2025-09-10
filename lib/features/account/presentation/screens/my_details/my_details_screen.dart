import 'package:ecommerce_app/core/constants/constants.dart';
import 'package:ecommerce_app/core/widgets/rounded_button.dart';
import 'package:ecommerce_app/core/widgets/text_field_widget.dart';
import 'package:ecommerce_app/features/account/presentation/blocs/user/bloc/user_bloc.dart';
import 'package:ecommerce_app/features/home/presentation/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDetailsScreen extends StatefulWidget {
  const MyDetailsScreen({super.key});

  @override
  State<MyDetailsScreen> createState() => _MyDetailsScreenState();
}

late TextEditingController nameController;
late TextEditingController emailController;
late String nameCard;

class _MyDetailsScreenState extends State<MyDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetUserEvent());
    nameController = TextEditingController();
    emailController = TextEditingController();
    nameCard = '';
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(10),
        child: CustomScrollView(
          slivers: [
            AppBarWidget(
              title: 'My Details',
              onPressed: () {},
              isBottom: false,
            ),
            BlocListener<UserBloc, UserState>(
              listener: (context, state) {
                if (state is UserLoaded) {
                  nameController.text = state.userEntity.fullName;
                  emailController.text = state.userEntity.email;
                  setState(() {
                    nameCard = state.userEntity.fullName;
                  });
                }
              },
              child: SliverToBoxAdapter(
                child: Column(
                  spacing: 10,
                  children: [
                    k15H,
                    CircleAvatar(
                      backgroundColor: Theme.of(context).cardColor,
                      foregroundColor: Theme.of(
                        context,
                      ).scaffoldBackgroundColor,
                      radius: 60,
                      child: Text(
                        nameCard.characters.take(2).string,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                        ),
                      ),
                    ),
                    textField('Full Name', 'Name', nameController),
                    textField(
                      'Email Address',
                      'example@gmail.com',
                      emailController,
                    ),
                    k10H,
                    RoundedButton(title: 'Submit', onPressed: () {}),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textField(String name, title, TextEditingController controller) {
    return Column(
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        TextFieldWidget(title: title, controller: controller),
      ],
    );
  }
}
