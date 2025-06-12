import 'package:flutter/material.dart';

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
      child: TextFormField(
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

  FormFieldConfig({
    required this.name,
    required this.label,
    this.validator,
    this.keyboardType = TextInputType.text,
    required this.controller,
  });
}
