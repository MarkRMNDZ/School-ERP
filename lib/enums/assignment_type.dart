enum AssignmentType {
  inApp('in_app', 'In App'),
  online('online', 'Online'),
  takeHome('take_home', 'Take Home');

  final String value;
  final String displayName;

  const AssignmentType(this.value, this.displayName);

  static AssignmentType fromString(String value) {
    return values.firstWhere(
      (v) => v.value == value,
      orElse: () => throw ArgumentError('Invalid AssignmentType value: $value'),
    );
  }

  static AssignmentType fromDisplayName(String displayName) {
    return values.firstWhere(
      (v) => v.displayName.toLowerCase() == displayName.toLowerCase(),
      orElse: () => throw ArgumentError(
          'Invalid AssignmentType display name: $displayName'),
    );
  }
}
