  import 'package:flutter/material.dart';

//---------------phone number validation-------------------
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();

  String? validatePhoneNumber(String? value) {
    final phoneRegExp = RegExp(r'^[0][0-9]{8,9}$');
    if (value == null || value.isEmpty) {
      return 'ត្រូវការលេខទូរស័ព្ទ';
    } else if (!phoneRegExp.hasMatch(value)) {
      return 'លេខទូរស័ព្ទមិនត្រឹមត្រូវ';
    }
    return null;
  }

  //---------------Username can't be empty-------------------
  final usernameController = TextEditingController();
  String? validateNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'មិនអាចទទេរ';
    }
    return null;
  }

  //-----------Password must be 4 characters and the same with confirm-----------
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'ត្រូវការលេខសម្ងាត់';
    } else if (value.length == 3) {
      return 'លេខសម្ងាត់ត្រូវតែ៤ខ្ទង់';
    }
    return null;
  }

  String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'ត្រូវការលេខសម្ងាត់ផ្ទៀងផ្ទាត់';
    } else if (value != password) {
      return 'លេខផ្ទៀងផ្ទាត់ខុសពីលេខសម្ងាត់';
    }
    return null;
  }