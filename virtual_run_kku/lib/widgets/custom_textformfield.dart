import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:virtual_run_kku/utils/constants/colors.dart';

// typedef OnChanged = Function();
// typedef OnSaved = Function();

class CustomTextFormField<T> extends StatelessWidget {
  final String? textLabel;
  final bool isRequired;
  final String? placeholder;
  final String? suffixText;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final ValueChanged? onChanged;
  final FormFieldSetter? onSaved;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final int? numMaxLine;

  const CustomTextFormField({
    Key? key,
    this.textLabel,
    required this.isRequired,
    this.placeholder,
    this.suffixText,
    this.textInputType,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.textInputAction,
    this.controller,
    this.inputFormatters,
    this.numMaxLine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textLabel == null
              ? const SizedBox()
              : Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          '$textLabel',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        isRequired
                            ? Text(
                                ' *',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: Colors.red),
                              )
                            : Container(),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
          TextFormField(
            maxLines: numMaxLine,
            validator: validator,
            keyboardType: textInputType ?? TextInputType.text,
            style: Theme.of(context).textTheme.headlineSmall,
            cursorColor: Colors.black12,
            onChanged: onChanged,
            onSaved: onSaved,
            textInputAction: textInputAction,
            controller: controller,
            inputFormatters: inputFormatters, // Only numbers can be entered,
            decoration: InputDecoration(
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: suffixText != null
                    ? Text('$suffixText',
                        style: Theme.of(context).textTheme.headlineSmall)
                    : null,
              ),
              suffixIconConstraints:
                  const BoxConstraints(minWidth: 10, minHeight: 10),
              filled: true,
              fillColor: Colors.white,
              hintText: placeholder,
              hintStyle: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.grey),
              contentPadding: const EdgeInsets.only(left: 14.0, right: 14),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorPrimary),
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorGrey),
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorRed),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorPrimary),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
