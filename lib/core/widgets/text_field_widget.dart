import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    super.key,
    required this.title,
    this.obscureText = false,
    this.helper,
    this.preffixIcon,
    required this.controller,
    this.validator,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.inputFormater,
    this.onChange,
  });

  final TextEditingController controller;
  final String title;
  final Widget? helper;
  final IconData? preffixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormater;
  final Function(String)? onChange;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late ValueNotifier<bool> obscureTextNotifier;

  @override
  void initState() {
    super.initState();
    obscureTextNotifier = ValueNotifier<bool>(widget.obscureText);
  }

  @override
  void dispose() {
    obscureTextNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureTextNotifier,
      builder: (context, isObscured, child) {
        return TextFormField(
          onChanged: widget.onChange,
          keyboardType: widget.keyboardType,
          maxLength: widget.maxLength,
          controller: widget.controller,
          obscureText: isObscured,
          validator: widget.validator,
          inputFormatters: widget.inputFormater,
          decoration: InputDecoration(
            prefixIcon: widget.preffixIcon != null
                ? Icon(widget.preffixIcon, color: Theme.of(context).focusColor)
                : null,
            helper: widget.helper,
            hintText: widget.title,
            suffixIcon:
                widget.suffixIcon ??
                (widget.obscureText
                    ? IconButton(
                        onPressed: () {
                          obscureTextNotifier.value = !isObscured;
                        },
                        icon: Icon(
                          isObscured
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Theme.of(context).focusColor,
                        ),
                      )
                    : null),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Theme.of(
                  context,
                ).inputDecorationTheme.border!.borderSide.color,
                width: 2,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Theme.of(
                  context,
                ).inputDecorationTheme.border!.borderSide.color.withAlpha(100),
              ),
            ),
          ),
        );
      },
    );
  }
}
