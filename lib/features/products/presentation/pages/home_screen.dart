import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_product_showcase_app/features/products/presentation/bloc/products_bloc.dart';
import 'package:mini_product_showcase_app/features/products/presentation/widgets/icon_box_button.dart';
import 'package:mini_product_showcase_app/features/products/presentation/widgets/products_item.dart';
import 'package:mini_product_showcase_app/features/products/presentation/widgets/top_search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> items = const [
    'All',
    'Electronics',
    'Clothing',
    'Jewelery',
  ];
  int idx = 0;

  @override
  void initState() {
    context.read<ProductsBloc>().add(LoadProducts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
        child: Column(
          children: [
            TopSearchBar(controller: _controller, onSendClick: (title) {}),
            const SizedBox(height: 8),
            SizedBox(
              height: 60,
              child: IconBoxButton(
                items: items,
                idx: idx,
                onBoxValueChange: (id) {
                  setState(() {
                    idx = id;
                  });
                },
              ),
            ),
            Expanded(
              child: ProductsItem(
                idx: idx,
                items: items,
                searchTitle: _controller.text.trim().toLowerCase(),
                controller: _controller,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
