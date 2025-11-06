import 'package:flutter/material.dart';

class CustomTextFeild extends StatelessWidget {
  const CustomTextFeild({super.key, this.onSubmitted});
  final Function(String)? onSubmitted;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: onSubmitted,

      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search, color: Colors.grey),
        hintText: 'Search',
        border: outlineInput(),
        enabledBorder: outlineInput(),
        focusedBorder: outlineInput(),
      ),
    );
  }

  OutlineInputBorder outlineInput() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: Colors.grey),
    );
  }
}
