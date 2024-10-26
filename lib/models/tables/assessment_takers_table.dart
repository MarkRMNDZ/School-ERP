import 'package:powersync/powersync.dart';

const assessmentTakersTable = Table('assessment_takers', [
  Column.integer('assessment_id'),
  Column.integer('subject_year_id'),
]);
