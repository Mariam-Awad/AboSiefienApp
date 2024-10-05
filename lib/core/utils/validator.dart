import 'package:flutter/material.dart';

extension Validator on TextEditingController {
  String getText() => this.text.trim();

  bool isValidEmail() {
    if (this.isEmpty()) return false;
    return RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(this.text);
  }

  bool isValidPassword() {
    if (this.isEmpty()) return false;
    return this.text.length < 6 ? false : true;
  }

  bool isValidPhone() {
    if (this.isEmpty()) return false;
    return this.text.length == 11 &&
        this.text.startsWith(RegExp('^(010|012|015|011)'));
  }

  bool isValidLandLine() {
    if (this.isEmpty()) return false;
    return this.text.length == 8;
  }

  bool isValidCardPassword() {
    if (this.isEmpty()) return false;
    return this.text.length == 4;
  }

  bool isValidInsuranceNumber() {
    if (this.isEmpty()) return false;
    return this.text.length == 8;
  }

  bool isValidFarmerCard() {
    if (this.isEmpty()) return false;
    return this.text.length == 16;
  }

  bool isEmpty() {
    if (this == null || this.text.isEmpty || this.text == null) return false;
    return true;
  }

  bool trimmedAndStillEmpty() {
    return this == null || this.text == null || this.text.trim().isEmpty;
  }

  bool isValidName() {
    if (this.isEmpty()) return false;
    return RegExp(r"^(?=.*?[a-z A-Z]).{2,}$").hasMatch(this.text);
  }

  bool isValidNationalID() {
    if (this.isEmpty()) return false;
    return (this.text.length < 14 || this.text.length > 14)
        ? false
        : RegExp(
                "^(2|3)[0-9][0-9][0-1][0-9][0-3][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]")
            .hasMatch(this.text);
  }
}

extension EqualityStrings on String {
  bool isEqual(String text) {
    return this == text;
  }
}
