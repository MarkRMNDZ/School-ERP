import 'package:flutter/material.dart';
import 'package:school_erp/dtos/assessment/assessment_create_dto.dart';
import 'package:school_erp/dtos/assessment/assessment_taker_create_dto.dart';
import 'package:school_erp/features/assessment/assessment_service.dart';
import 'package:school_erp/features/powersync/db.dart';
import 'package:school_erp/features/transition/clean_slide_transition.dart';
import 'package:school_erp/pages/assignment/assignment_add/question_builder_page/question_builder_page.dart';
import 'package:school_erp/pages/common_widgets/default_layout.dart';
import 'package:school_erp/pages/common_widgets/form_fields/number_input.dart';
import 'package:school_erp/pages/common_widgets/form_fields/datetime_picker.dart';
import 'package:school_erp/pages/common_widgets/default_button.dart';
import 'package:school_erp/pages/common_widgets/form_fields/labeled_dropdown.dart';

class QuestionSetupPage extends StatelessWidget {
  final AssessmentCreateDTOBuilder assessmentCreateDTOBuilder;
  final AssessmentTakerCreateDTOBuilder assessmentTakerCreateDTOBuilder;

  const QuestionSetupPage(
      this.assessmentCreateDTOBuilder, this.assessmentTakerCreateDTOBuilder,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(title: 'Assignment Setup', content: [
      FormContent(assessmentCreateDTOBuilder, assessmentTakerCreateDTOBuilder)
    ]);
  }
}

class FormContent extends StatefulWidget {
  final AssessmentCreateDTOBuilder assessmentCreateDTOBuilder;
  final AssessmentTakerCreateDTOBuilder assessmentTakerCreateDTOBuilder;

  const FormContent(
      this.assessmentCreateDTOBuilder, this.assessmentTakerCreateDTOBuilder,
      {super.key});

  @override
  _FormContentState createState() => _FormContentState();
}

class _FormContentState extends State<FormContent> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DateTimePickerFormField(
              label: 'Select quiz time',
              initialValue: DateTime.now(),
              onSaved: (newValue) {
                widget.assessmentCreateDTOBuilder.startTime = newValue!;
              },
            ),
            const SizedBox(height: 16),
            DateTimePickerFormField(
              label: 'Select question close time:',
              initialValue: DateTime.now(),
              onSaved: (newValue) {
                widget.assessmentCreateDTOBuilder.deadLine = newValue!;
              },
            ),
            const SizedBox(height: 16),
            NumberInputFormField(
              label: 'No. of   Questions',
              initialValue: 20,
              onSaved: (value) {
                widget.assessmentCreateDTOBuilder.totalQuestions = value!;
              },
            ),
            const SizedBox(height: 16),
            LabeledDropdownFormField<bool>(
              label: "Select Randomness",
              dropdownItems: const {"True": true, "False": false},
              initialValue: false,
              onSaved: (value) {
                widget.assessmentCreateDTOBuilder.randomizeSequence = value!;
              },
            ),
            const SizedBox(height: 32),
            DefaultButton(
              onPressed: () =>
                  _onNextPressed(context, widget.assessmentCreateDTOBuilder),
              text: "Next",
            ),
          ],
        ),
      ),
    );
  }

  void _onNextPressed(
      BuildContext context, AssessmentCreateDTOBuilder formData) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final assessmentService =
          AssessmentService(database: db); // di ini dapat didi temp didi muna
      await assessmentService.create(
        assessmentDTOBuilder: widget.assessmentCreateDTOBuilder,
        assessmentTakerDTOBuilder: widget.assessmentTakerCreateDTOBuilder,
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        createSlideRoute(const QuestionBuilderPage(),
        ),
      );
    }
  }
}
