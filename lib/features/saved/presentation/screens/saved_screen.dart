import 'package:ecommerce_app/features/home/presentation/widgets/app_bar_widget.dart';
import 'package:ecommerce_app/features/home/presentation/widgets/product_card.dart';
import 'package:ecommerce_app/features/saved/presentation/blocs/bloc/saved_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<SavedBloc>();
    if (bloc.state is SavedInitial) {
      debugPrint("Loading saved items...");
      bloc.add(GetSavedItemsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AppBarWidget(title: 'Saved items', onPressed: () {}, isBottom: false),
          BlocBuilder<SavedBloc, SavedState>(
            builder: (context, state) {
              if (state is SavedItemsLoading) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (state is SavedItemsLoaded) {
                if (state.products.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(child: Text('No saved items')),
                  );
                }

                return SliverGrid.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProductCard(product: state.products[index]),
                    );
                  },
                );
              }

              return const SliverFillRemaining(
                child: Center(child: Text('Nothing')),
              );
            },
          ),
        ],
      ),
    );
  }
}
