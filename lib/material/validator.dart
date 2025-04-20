class Validator {
  static String? username(String? value) {
    if (value == null || value.isEmpty) {
      return 'Cannot be empty';
    }

    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Cannot be empty';
    }

    return null;
  }
  
static String? studentID(String? value) {
  if (value == null || value.isEmpty) {
    return 'ID is required';
  }

  final idRegex = RegExp(r'^\d{10}$');
  if (!idRegex.hasMatch(value)) {
    return 'Student ID must be 10 digits';
  }

  return null;
}


}