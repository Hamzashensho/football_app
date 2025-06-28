import 'package:flutter/material.dart';

class EntityDialog extends StatelessWidget {
  final String title;
  final Widget form;
  final VoidCallback onSave;
  final String saveButtonText;
  final double? maxWidth;

  const EntityDialog({
    super.key,
    required this.title,
    required this.form,
    required this.onSave,
    this.saveButtonText = 'Save',
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? MediaQuery.of(context).size.width * 0.4,
          minWidth: 300,
        ),
        child: SingleChildScrollView(
          child: form,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: onSave,
          child: Text(saveButtonText),
        ),
      ],
    );
  }
}

// Helper function to show the dialog
Future<void> showEntityDialog({
  required BuildContext context,
  required String title,
  required Widget form,
  required VoidCallback onSave,
  String? saveButtonText,
  double? maxWidth,
}) {
  return showDialog(
    context: context,
    builder: (context) => EntityDialog(
      title: title,
      form: form,
      onSave: onSave,
      saveButtonText: saveButtonText ?? 'Save',
      maxWidth: maxWidth,
    ),
  );
}