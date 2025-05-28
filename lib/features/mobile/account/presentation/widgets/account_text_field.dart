import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sport_app_user/core/utils/size_config.dart';

class AccountTextField extends StatefulWidget {
  final String? hintText;
  final bool obscureText;
  final String? prefixImagePath;
  final IconData? suffixIcon;
  final Function()? onTapSuffixIcon;
  final bool isDateTextField;
  final bool isCountryPicker;
  final TextEditingController controller;
  final FormFieldValidator validator;

  const AccountTextField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.prefixImagePath,
    this.suffixIcon,
    this.onTapSuffixIcon,
    this.isDateTextField = false,
    this.isCountryPicker = false,
    required this.controller,
    required this.validator,
  });

  @override
  State<AccountTextField> createState() => _AccountTextFieldState();
}

class _AccountTextFieldState extends State<AccountTextField> {
  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        widget.controller.text = formattedDate;
      });
    }
  }

  Future<void> _selectCountry() async {
    showCountryPicker(
      context: context,
      onSelect: (Country country) {
        setState(() {
          widget.controller.text = country.name;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      keyboardType: _getKeyboardType(),
      controller: widget.controller,
      readOnly: widget.isDateTextField || widget.isCountryPicker,
      onTap: widget.isDateTextField
          ? _selectDate
          : widget.isCountryPicker
          ? _selectCountry
          : null,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        prefixIcon: widget.prefixImagePath != null
            ? Image.asset(widget.prefixImagePath!, color: Colors.black)
            : null,
        suffixIcon: widget.suffixIcon != null
            ? InkWell(
          onTap: widget.onTapSuffixIcon,
          child: Icon(widget.suffixIcon),
        )
            : null,
        hintText: widget.hintText,
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizeConfig.screenHeight * 0.01),
        ),
      ),
    );
  }

  TextInputType _getKeyboardType() {
    final hint = widget.hintText?.toLowerCase() ?? '';
    if (hint.contains('email')) return TextInputType.emailAddress;
    if (hint.contains('phone') || hint.contains('postal')) {
      return TextInputType.number;
    }
    return TextInputType.text;
  }
}
