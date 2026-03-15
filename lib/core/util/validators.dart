class Validators {
  static String? validateEmail(String email) {
    if (email.trim().isEmpty) {
      return "Email is required";
    }

    final emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (!emailRegex.hasMatch(email.trim())) {
      return "Enter a valid email";
    }

    return null;
  }

  static String? validatePassword(String password) {
    if (password.trim().isEmpty) {
      return 'Password is required';
    }

    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }
}