import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ozare/styles/common/common.dart';


class InputField extends StatefulWidget {
  const InputField({
    required this.controller,
    required this.hintText,
    required this.labelText,
    super.key,
    this.isPassword = false,
    this.textInputType = TextInputType.text,
    this.inputFormatters = const [],
    this.validator,
    this.maxLines,
    this.suffix = const SizedBox(),
    this.readOnly = false,
  });

  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final bool isPassword;
  final TextInputType textInputType;
  final List<TextInputFormatter> inputFormatters;
  final String? Function(String?)? validator;
  final int? maxLines;
  final Widget suffix;
  final bool readOnly;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late bool isObscure;

  @override
  void initState() {
    isObscure = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.labelText),
        const SizedBox(height: 4),
        TextFormField(
          readOnly: widget.readOnly,
          obscureText: isObscure,
          controller: widget.controller,
          keyboardType: widget.textInputType,
          inputFormatters: widget.inputFormatters,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          maxLines: widget.maxLines,
          validator:
              widget.validator ?? (val) => Validators.defaultValidator(val!),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 12,
            ),
            filled: true,
            fillColor: Colors.grey[150],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey[100]!,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey[100]!,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                    icon: Icon(
                      isObscure
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: !isObscure ? primary2Color : Colors.grey[400],
                    ),
                  )
                : widget.suffix,
          ),
        ),
      ],
    );
  }
}
