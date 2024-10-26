enum AssessmentType {
  assignment('assignment'),
  quiz('quiz'),
  exam('exam');

  final String value;

  const AssessmentType(this.value);

  static AssessmentType fromString(String value) {
    return values.firstWhere(
      (v) => v.value == value,
    );
  }
}
