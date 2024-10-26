enum AssessmentStatus {
  toBeCompleted('to_be_completed', 'To Be Completed'),
  toBePublished('to_be_published', 'To Be Published'),
  published('published', 'Published'),
  toFinishEvaluation('to_finish_evaluation', 'To Finish Evaluation'),
  finishedEvaluation('finished_evaluation', 'Finished Evaluation');

  final String value;
  final String displayName;

  const AssessmentStatus(this.value, this.displayName);

  static AssessmentStatus fromString(String value) {
    return values.firstWhere(
      (v) => v.value == value,
      orElse: () =>
          throw ArgumentError('Invalid AssessmentStatus value: $value'),
    );
  }

  static AssessmentStatus fromDisplayName(String displayName) {
    return values.firstWhere(
      (v) => v.displayName.toLowerCase() == displayName.toLowerCase(),
      orElse: () => throw ArgumentError(
          'Invalid AssessmentStatus display name: $displayName'),
    );
  }
}
