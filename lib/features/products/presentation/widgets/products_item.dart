import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_product_showcase_app/features/products/presentation/bloc/products_bloc.dart';
import 'package:mini_product_showcase_app/features/products/presentation/pages/description_screen.dart';

class ProductsItem extends StatelessWidget {
  final String searchTitle;
  final int idx;
  final List<String> items;
  final TextEditingController controller;
  const ProductsItem({
    super.key,
    required this.idx,
    required this.items,
    required this.searchTitle,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
  builder: (context, state) {
    if (state is ProductsLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is ProductsError) {
      return Center(child: Text(state.message));
    }

    if (state is ProductsLoaded) {
      final list = state.list;

      if (list.isEmpty) {
        return const Center(child: Text("Empty"));
      }

      final vmData = (idx == 0 && searchTitle.isEmpty)
          ? list
          : (idx == 2)
              ? list.where((id) {
                  return id.category == "women's clothing";
                }).toList()
              : (searchTitle.isNotEmpty)
                  ? list.where((id) {
                      return id.title
                              .split(' ')[0]
                              .toLowerCase() ==
                          searchTitle;
                    }).toList()
                  : list.where((id) {
                      return id.category.toLowerCase() ==
                          items[idx].toLowerCase();
                    }).toList();

      if (searchTitle.isNotEmpty) {
        controller.clear();
      }

      return ListView.builder(
        itemCount: vmData.length,
        itemBuilder: (context, index) {
          final item = vmData[index];

          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            DescriptionScreen(data: item),
                      ),
                    );
                  },
                  child: Card(
                    color:   const Color.fromARGB(255, 245, 217, 248),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment:
                            CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              item.title
                                      .split(' ')
                                      .reversed
                                      .take(3)
                                      .toList()
                                      .reversed
                                      .join(' ') ,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.all(4.0),
                              child: Text(
                                '\$${item.price}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight:
                                      FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          Image.network(
                            item.image ,
                            fit: BoxFit.contain,
                            height: 200,
                            width: 300,
                            errorBuilder:
                                (context, error, stackTrace) {
                              return const Center(
                                child: Icon(
                                  Icons.image,
                                  size: 120,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // ⭐ Rating
                Positioned(
                  right: 20,
                  top: 10,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color:
                            Color.fromRGBO(255, 198, 0, 1.0),
                        size: 40,
                      ),
                      Text(
                        item.rating?.rate.toString() ?? '',
                        style:
                            const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 50,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius:
                          BorderRadius.circular(90),
                      onTap: () {
                        context.read<ProductsBloc>().add(
                              ToggleFavoriteEvent(product: item),
                            );
                      },
                      child: Icon(
                        Icons.favorite_outlined,
                        color: item.isFavorite
                            ? Colors.red
                            : Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return const SizedBox(
      child: Center(child: Text("Unexpected state")),
    );
  },
);

  }
}
