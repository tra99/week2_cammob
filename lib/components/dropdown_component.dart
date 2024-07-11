import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String labelText;
  final String? value;
  final List<String> items;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String>? validator;

  const CustomDropdown({
    super.key,
    required this.labelText,
    this.value,
    required this.items,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: validator ?? (value) {
        if (value == null || value.isEmpty) {
          return 'ត្រូវការជ្រើសរើស $labelText';
        }
        return null;
      },
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
            labelText: labelText,
            errorStyle: const TextStyle(color: Colors.black),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            border: const OutlineInputBorder(),
            errorText: state.errorText,
          ),
          isEmpty: value == null || value!.isEmpty,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isDense: true,
              onChanged: (newValue) {
                state.didChange(newValue);
                onChanged?.call(newValue);
              },
              items: items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
