import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permissions'),
      ),
      body: const _PermissionsView(),
    );
  }
}

class _PermissionsView extends ConsumerWidget {
  const _PermissionsView();

  @override
  Widget build(BuildContext context, ref) {
    final appState = ref.watch(appStateProvider);

    return ListView(
      children: [
        CheckboxListTile(
          value: true,
          title: const Text('Cámara'),
          subtitle: const Text('Estado actual'),
          onChanged: (value) {},
        ),
        ListTile(title: Text('$appState'))
      ],
    );
  }
}
