import 'package:flutter/material.dart';

import '../utils/constants/colors.dart';

// typedef OnChanged = Function();
// typedef OnSaved = Function();

class DatePickerCustomTextFormField extends StatelessWidget {
  final String? textLabel;
  final bool isRequired;
  final String? placeholder;
  final String? suffixText;
  final IconData? suffixIcon;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final ValueChanged? onChanged;
  final FormFieldSetter? onSaved;
  final Function()? onTap;
  final TextEditingController? controller;
  const DatePickerCustomTextFormField({
    Key? key,
    required this.textLabel,
    required this.isRequired,
    this.placeholder,
    this.suffixText,
    this.suffixIcon,
    this.textInputType,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.controller,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ThemeData().colorScheme.copyWith(
                    primary: colorPrimary,
                    error: colorRed,
                  ),
            ),
            child: TextFormField(
              validator: validator,
              controller: controller,
              readOnly: true,
              onTap: onTap,
              keyboardType: textInputType ?? TextInputType.text,
              style: Theme.of(context).textTheme.headlineSmall,
              cursorColor: Colors.black12,
              onChanged: onChanged,
              onSaved: onSaved,
              decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    suffixIcon,
                    // color: colorPrimary,
                  ),
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
                focusColor: colorPrimary,
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
          ),
        ],
      ),
    );
  }
}
