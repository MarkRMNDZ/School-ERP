import 'package:school_erp/features/auth/auth.dart';
import 'package:school_erp/pages/common_widgets/common_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutModal extends StatelessModal {
  LogoutModal(BuildContext context)
      : super(
            context: context,
            title: 'Logout',
            content: const Text('Are you sure you want to logout'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.read<AuthBloc>().add(LogoutRequested());
                },
                child: const Text('Logout'),
              )
            ]);
}
