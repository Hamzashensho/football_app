import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EntityForm extends StatefulWidget {
  final List<FormFieldConfig> fields;
  final Map<String, dynamic>? initialValues;
  final GlobalKey<FormState>? formKey;

  const EntityForm({
    super.key,
    required this.fields,
    this.initialValues,
    this.formKey,
  });

  @override
  State<EntityForm> createState() => _EntityFormState();
}

class _EntityFormState extends State<EntityForm> {
  final Map<String, dynamic> _formData = {};

  @override
  void initState() {
    super.initState();
    if (widget.initialValues != null) {
      for (var field in widget.fields) {
        final value = widget.initialValues![field.name];
        if (value != null) {
          field.controller.text = value.toString();
          _formData[field.name] = value;
        }
      }
    }
  }

  Future<void> _selectDate(FormFieldConfig field) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      final String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        field.controller.text = formattedDate;
      });
    }
  }

  Future<void> _selectTime(FormFieldConfig field) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 12, minute: 10)
    );
    if (pickedTime != null) {
      setState(() {
        field.controller.text = '${pickedTime.hour}:${pickedTime.minute} ${pickedTime.period.name}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: widget.fields.map(_buildFormField).toList(),
      ),
    );
  }

  Widget _buildFormField(FormFieldConfig field) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: (field.dropdownItems?.isNotEmpty??false)
          ? DropdownButtonFormField<String>(
        value: field.controller.text.isNotEmpty ? field.controller.text : null,
        items: field.dropdownItems
            ?.map((item) => DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        ))
            .toList(),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (value) {
          setState(() {
            field.controller.text = value!;
            _formData[field.name] = value;
          });
        },
        validator: field.validator,
        decoration: InputDecoration(
          labelText: field.label,
          border: const OutlineInputBorder(),
        ),
      )
          : TextFormField(
        onTap: () {
          if (field.isDatePicker) {
            _selectDate(field);
          }else if(field.isTimePicker){
            _selectTime(field);
          }
        },
        readOnly: field.isDatePicker||field.isTimePicker,
        controller: field.controller,
        decoration: InputDecoration(
          labelText: field.label,
          border: const OutlineInputBorder(),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
        validator: field.validator,
        onSaved: (value) => _formData[field.name] = value,
        keyboardType: field.keyboardType,
      ),
    );
  }

}

class FormFieldConfig {
  final String name;
  final String label;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool isDatePicker;
  final bool isTimePicker;
  final List<String>? dropdownItems;
  final String? initialText;

  FormFieldConfig({
    required this.name,
    required this.label,
    this.validator,
    this.keyboardType = TextInputType.text,
    required this.controller,
    this.isDatePicker = false,
    this.isTimePicker=false,
    this.dropdownItems,
    this.initialText,
  });
}

