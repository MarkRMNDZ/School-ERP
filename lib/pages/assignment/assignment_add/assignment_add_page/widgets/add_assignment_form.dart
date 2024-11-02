import 'package:flutter/material.dart';
import 'package:school_erp/dtos/assessment/assessment_create_dto.dart';
import 'package:school_erp/dtos/assessment/assessment_taker_create_dto.dart';
import 'package:school_erp/enums/assessment_type.dart';
import 'package:school_erp/enums/assignment_type.dart';
import 'package:school_erp/features/auth/auth.dart';
import 'package:school_erp/features/auth/utils.dart';
import 'package:school_erp/features/transition/clean_slide_transition.dart';
import 'package:school_erp/models/section.dart';
import 'package:school_erp/models/subject_year.dart';
import 'package:school_erp/models/teacher.dart';
import 'package:school_erp/pages/assignment/assignment_add/assignment_setup_page/question_setup_page.dart';
import 'package:school_erp/theme/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAssignmentForm extends StatefulWidget {
  const AddAssignmentForm({super.key});

  @override
  State<AddAssignmentForm> createState() => _AddAssignmentFormState();
}

class _AddAssignmentFormState extends State<AddAssignmentForm> {
  List<Section?> sections = [];
  List<SubjectYear?> subjectYears = [];
  AssignmentType? selectedType = AssignmentType.inApp;
  Section? selectedSection;
  SubjectYear? selectedSubject;
  bool isLoading = true;

  final AssessmentCreateDTOBuilder assessmentCreateDTOBuilder =
      AssessmentCreateDTOBuilder();

  final AssessmentTakerCreateDTOBuilder assessmentTakerCreateDTOBuilder =
      AssessmentTakerCreateDTOBuilder();

  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  Future<void> _initializeForm() async {
    try {
      _createAssessmentDTO();
      await _loadData();
    } catch (e) {
      _handleError('Initialization error: ${e.toString()}');
    }
  }

  void _createAssessmentDTO() {
    try {
      final authState = context.read<AuthBloc>().state;
      final teacherId = getTeacherId(authState);

      assessmentCreateDTOBuilder.assessmentType = AssessmentType.assignment;
      assessmentCreateDTOBuilder.preparedById = teacherId;
    } catch (e) {
      throw Exception('Failed to create assessment: ${e.toString()}');
    }
  }

  Future<void> _loadData() async {
    try {
      final results = await Future.wait([
        Teacher.sections(),
        Teacher.activeSubjects(),
      ]);

      if (!mounted) return;

      setState(() {
        sections = results[0] as List<Section?>;
        subjectYears = results[1] as List<SubjectYear?>;
        selectedSection = sections.firstOrNull;
        selectedSubject = subjectYears.firstOrNull;
        isLoading = false;
      });
    } catch (e) {
      _handleError('Error loading data: ${e.toString()}');
    }
  }

  void _handleError(String message) {
    if (!mounted) return;

    setState(() => isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  final _formKey = GlobalKey<FormState>();

  void _validateAndSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.push(
        context,
        createSlideRoute(QuestionSetupPage(
            assessmentCreateDTOBuilder,
            assessmentTakerCreateDTOBuilder,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fix the errors in red')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                DropdownButtonFormField<Section?>(
                  value: selectedSection,
                  items: sections.map((Section? value) {
                    return DropdownMenuItem<Section?>(
                      value: value,
                      child: Text(value!.name),
                    );
                  }).toList(),
                  onChanged: (Section? newValue) {
                    setState(() {
                      selectedSection = newValue;
                    });
                  },
                  onSaved: (Section? newValue) {
                    assessmentTakerCreateDTOBuilder.sectionId = newValue!.id;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Select Class',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a Class';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                DropdownButtonFormField<SubjectYear?>(
                  value: subjectYears.isEmpty ? null : subjectYears[0],
                  items: subjectYears.map((SubjectYear? subjectYear) {
                    return DropdownMenuItem<SubjectYear?>(
                      value: subjectYear,
                      child: Text(subjectYear?.subjectName ?? ''),
                    );
                  }).toList(),
                  onChanged: (SubjectYear? newValue) {
                    setState(() {
                      selectedSubject = newValue;
                    });
                  },
                  onSaved: (SubjectYear? newValue) {
                    assessmentTakerCreateDTOBuilder.subjectYearId =
                        newValue!.id;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Select Subject',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a subject';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                TextFormField(
                    maxLength: 30,
                    decoration: const InputDecoration(
                      hintText: 'What should you call this assignment',
                      labelText: 'Title',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Title';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      assessmentCreateDTOBuilder.title = value!;
                    }),
                const SizedBox(height: 25),
                DropdownButtonFormField<AssignmentType>(
                  value: AssignmentType.inApp,
                  items: AssignmentType.values
                      .map((AssignmentType assignmentType) {
                    return DropdownMenuItem<AssignmentType>(
                      value: assignmentType,
                      child: Text(assignmentType.displayName),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedType = newValue;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Select Type',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a type';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                _buildAssignmentTypeForm(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                ElevatedButton(
                  onPressed: _validateAndSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    minimumSize: Size(double.infinity,
                        MediaQuery.of(context).size.height * 0.08),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    selectedType == AssignmentType.inApp
                        ? "Create Assignment"
                        : "SEND",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAssignmentTypeForm() {
    switch (selectedType) {
      case AssignmentType.online:
        return Column(
          children: [
            const SizedBox(height: 5),
            TextFormField(
              maxLength: 50,
              decoration: const InputDecoration(
                hintText: 'Enter valid URL',
                labelText: 'URL',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter a URL';
                }
                final RegExp urlPattern = RegExp(
                  r'^(https?:\/\/)?' // Optional http or https
                  r'((([a-z0-9\-]+\.)+[a-z]{2,})|localhost|' // Domain name or localhost
                  r'(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}))' // IP address
                  r'(:\d+)?(\/\S*)?$', // Optional port and path
                  caseSensitive: false,
                );
                if (!urlPattern.hasMatch(value)) {
                  return 'Enter a valid URL';
                }
                return null;
              },
            ),
          ],
        );

      case AssignmentType.inApp:
        return Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            DropdownButtonFormField<bool>(
              value: false,
              items: [true, false].map((bool option) {
                return DropdownMenuItem<bool>(
                  value: option,
                  child: Text(option ? 'Yes' : 'No'),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  // no corresponding mapping yet
                });
              },
              decoration: const InputDecoration(
                labelText: 'Is it AI generated',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null) {
                  return 'Please select an option';
                }
                return null;
              },
            ),
          ],
        );

      case AssignmentType.takeHome:
        return Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            TextFormField(
              maxLength: 30,
              decoration: const InputDecoration(
                hintText: 'How can this assignment be done',
                labelText: 'Instructions',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter Instructions';
                }
                return null;
              },
            ),
          ],
        );

      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid assignment type selected'),
          ),
        );
        return const SizedBox.shrink();
    }
  }
}
