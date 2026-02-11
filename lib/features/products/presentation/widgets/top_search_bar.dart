import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_product_showcase_app/core/common/cubit/currentTheme/theme_cubit.dart';

class TopSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSendClick;
  const TopSearchBar({
    super.key,
    required this.controller,
    required this.onSendClick,
  });
  @override
  Widget build(BuildContext context) {
    OutlineInputBorder myBorder() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      borderSide: const BorderSide(width: 1.3, color: Colors.grey),
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Product\nCollection",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: SizedBox(
            height: 48,
            child: TextField(
              controller: controller,
              onSubmitted: onSendClick,
              style: const TextStyle(fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                focusColor: Colors.black,
                hoverColor: Colors.black,
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                hintText: "Search",
                hintStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: Colors.grey,
                ),
                border: myBorder(),
                enabledBorder: myBorder(),
                focusedBorder: myBorder(),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8,),
        SizedBox(
          width: 70,
          child: SegmentedButton<bool>(
            showSelectedIcon: false,
            style: ButtonStyle(
              padding: const WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              ),
              visualDensity: VisualDensity.compact,
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
            segments: const [
              ButtonSegment(
                value: false,
                icon: Icon(Icons.wb_sunny_rounded, size: 18),
              ),
              ButtonSegment(
                value: true,
                icon: Icon(Icons.nightlight_round, size: 18),
              ),
            ],
            selected: {context.watch<ThemeCubit>().state.isDark},
            onSelectionChanged: (value) {
              context.read<ThemeCubit>().changeTheme();
            },
          ),
        ),
        const SizedBox(width: 8,),
      ],
    );
  }
}

