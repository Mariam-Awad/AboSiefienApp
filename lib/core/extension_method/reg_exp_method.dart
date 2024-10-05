extension Validator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isValidPassword() {
    return RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
    ).hasMatch(this);
  }

  bool isFiledEmpty() {
    return RegExp(r'^\s*$').hasMatch(this);
  }

  bool isValidEgyptianNationalID() {
    RegExp regex = RegExp(
        r'(2|3)[0-9][1-9][0-1][1-9][0-3][1-9](01|02|03|04|11|12|13|14|15|16|17|18|19|21|22|23|24|25|26|27|28|29|31|32|33|34|35|88)\d{6}');
    return regex.hasMatch(this);
  }

  bool isValidLicense() {
    return RegExp(r'\d{14}').hasMatch(this);
  }

  bool isValidCarLicense() {
    return RegExp(r'\d{5,}').hasMatch(this);
  }
}
