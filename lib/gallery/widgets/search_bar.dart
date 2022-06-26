import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  SearchBarWidget(
      {Key? key,
      required this.backgroudColor,
      required this.hintText,
      this.suffix,
      this.prefix,
      required this.onChange})
      : super(key: key);

  final Color backgroudColor;
  final String hintText;
  final Widget? suffix;
  final Widget? prefix;

  final Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.search,
      key: const Key('searchbar_textField'),
      onChanged: (string) => onChange(string),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: 20, horizontal: prefix == null ? 20 : 0),
        filled: true,
        fillColor: backgroudColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        prefixIcon: prefix,
        suffixIcon: suffix,
      ),
    );
  }
}
