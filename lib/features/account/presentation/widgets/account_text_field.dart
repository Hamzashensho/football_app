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

  const AccountTextField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.prefixImagePath,
    this.suffixIcon,
    this.onTapSuffixIcon,
    this.isDateTextField = false,
    this.isCountryPicker = false,
  });

  @override
  State<AccountTextField> createState() => _AccountTextFieldState();
}

class _AccountTextFieldState extends State<AccountTextField> {
  final TextEditingController _controller = TextEditingController();

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
        _controller.text = formattedDate;
      });
    }
  }

  Future<void> _selectCountry() async {
    showCountryPicker(
      context: context,
      onSelect: (Country country) {
        setState(() {
          _controller.text = country.name;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType:
          widget.hintText?.toLowerCase().contains('email') ?? false
              ? TextInputType.emailAddress
              : ((widget.hintText?.toLowerCase().contains('phone') ?? false) ||
                  (widget.hintText?.toLowerCase().contains('postal') ?? false))
              ? TextInputType.number
              : TextInputType.text,
      controller: _controller,
      readOnly: widget.isDateTextField || widget.isCountryPicker,
      onTap:
          widget.isDateTextField
              ? _selectDate
              : widget.isCountryPicker
              ? _selectCountry
              : () {},
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        prefixIcon:
            widget.prefixImagePath != null
                ? Image.asset(widget.prefixImagePath!, color: Colors.black)
                : null,
        suffixIcon:
            widget.suffixIcon != null
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
}
