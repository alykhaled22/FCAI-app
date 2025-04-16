class Validators {
  static String? validateRequiredField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "This field is required";
    }
    return null;
  }

  static String? validateStudentId(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Student ID is required";
    }
    if (value.length != 8) {
      return "Student ID must be 8 digits";
    }
    return null;
  }

  static String? validateFcaiEmail(String? value, String? studentId) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }

    final emailRegex = RegExp(r'^(\d{8})@stud\.fci-cu\.edu\.eg$');
    final match = emailRegex.firstMatch(value);

    if (match == null) {
      return "Enter a valid FCAI email\nEx: 20200000@stud.fci-cu.edu.eg";
    }

    if (studentId != null && match.group(1) != studentId) {
      return "Email must match student ID";
    }

    return null;
  }

  static String? validateOldPassword(String? value,{required String oldPassword}) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }
    if (value != oldPassword) {
      return "Wrong password";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }
    if (value.length < 8) {
      return "Password must be at least 8 characters";
    }
    if (!RegExp(r'^(?=.*\d).{8,}$').hasMatch(value)) {
      return "Password must contain at least one number";
    }

    return null;
  }

  static String? validateConfirmPassword(
      String? value, String originalPassword) {
    if (value == null || value.trim().isEmpty) {
      return "Please confirm your password";
    }
    if (value != originalPassword) {
      return "Passwords do not match";
    }
    return null;
  }

  static String? validateStudentIdWithContext(
    String? value, {
    required String currentEmail,
    required String originalEmail,
  }) {
    if (value == null || value.trim().isEmpty) {
      if (currentEmail.isNotEmpty && currentEmail != originalEmail) {
        return "This field is required";
      }
    }

    if (value!.length != 8 && value.isNotEmpty) {
      return "Student ID must be 8 digits";
    }

    return null;
  }

  static String? validateFcaiEmailWithContext(
    String? value, {
    required String currentID,
    required String originalID,
  }) {
    if (value!.isEmpty && currentID.isNotEmpty && currentID != originalID) {
      return "This field is required";
    }
    if (value.isNotEmpty && currentID.isNotEmpty) {
      final emailRegex = RegExp(r'^(\d+)@stud\.fci-cu\.edu\.eg$');
      final match = emailRegex.firstMatch(value);

      if (match == null) {
        return "Enter a valid FCAI email. \nex:studentID@stud.fci-cu.edu.eg";
      }

      if (match.group(1) != currentID) {
        return "Email must match student ID";
      }
    }

    return null;
  }
}
