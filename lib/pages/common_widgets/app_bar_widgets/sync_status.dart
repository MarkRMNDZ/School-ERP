import 'dart:async';
import 'package:flutter/material.dart';
import 'package:powersync/powersync.dart';
import 'package:school_erp/features/powersync/db.dart';
import 'package:school_erp/theme/colors.dart';

class AppBarSyncStatus extends StatefulWidget {
  const AppBarSyncStatus({super.key});

  @override
  AppBarSyncStatusState createState() => AppBarSyncStatusState();
}

class AppBarSyncStatusState extends State<AppBarSyncStatus> {
  late SyncStatus _connectionState;
  StreamSubscription<SyncStatus>? _syncStatusSubscription;

  @override
  void initState() {
    super.initState();
    _connectionState = db.currentStatus;
    _syncStatusSubscription = db.statusStream.listen((event) {
      setState(() {
        _connectionState = db.currentStatus;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _syncStatusSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SyncStatusIcon(_connectionState);
  }
}

class SyncStatusIcon extends StatelessWidget {
  final SyncStatus status;
  const SyncStatusIcon(this.status, {super.key});

  @override
  Widget build(BuildContext context) {
    if (status.anyError != null) {
      //TODO: verbose errors should be replaced with something user-friendly
      if (!status.connected) {
        return IconToolTip(status.anyError!.toString(), Icons.cloud_off);
      } else {
        return IconToolTip(status.anyError!.toString(), Icons.sync_problem);
      }
    } else if (status.connecting) {
      return const IconToolTip('Connecting', Icons.cloud_sync_outlined);
    } else if (!status.connected) {
      return const IconToolTip('Not connected', Icons.cloud_off);
    } else if (status.uploading && status.downloading) {
      // The status changes often between downloading, uploading and both,
      // so we use the same icon for all three
      return const IconToolTip(
          'Uploading and downloading', Icons.cloud_sync_outlined);
    } else if (status.uploading) {
      return const IconToolTip('Uploading', Icons.cloud_sync_outlined);
    } else if (status.downloading) {
      return const IconToolTip('Downloading', Icons.cloud_sync_outlined);
    } else {
      return const IconToolTip('Connected', Icons.cloud_queue);
    }
  }
}

class IconToolTip extends StatelessWidget {
  final String text;
  final IconData icon;

  const IconToolTip(this.text, this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
      child: Tooltip(
        message: text,
        child: SizedBox(
          width: 40,
          height: null,
          child: Icon(icon, size: 35, color: AppColors.whiteColor),
        ),
      ),
    );
  }
}
