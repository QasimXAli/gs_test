String? requiredValidator(String? value) {
  return (value == null || value.trim().isEmpty)
      ? 'This field is required'
      : null;
}

String? emailValidator(String? value) {
  if (value == null || value.trim().isEmpty) return 'Email is required';
  final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
  return emailRegex.hasMatch(value.trim()) ? null : 'Enter a valid email';
}
