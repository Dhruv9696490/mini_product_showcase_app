import 'package:flutter/material.dart';

class AuthField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;

  const AuthField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
  });

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword ? obscure : false,
        obscuringCharacter: '*',
        decoration: InputDecoration(
          hintText: widget.hintText,
          suffixIcon: widget.isPassword
              ? IconButton(
                  iconSize: 18,
                  splashRadius: 18,
                  onPressed: () {
                    setState(() {
                      obscure = !obscure;
                    });
                  },
                  icon: const Icon(Icons.visibility_outlined),
                )
              : null,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "${widget.hintText} is missing";
          }
          return null;
        },
      ),
    );
  }
}
