import 'package:flutter/material.dart';
import '../state/app_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const _ProfileHeader(),
              const SizedBox(height: 16),
              _StatsRow(saved: state.savedCount),
              const Divider(height: 32),
              SwitchListTile(
                secondary: const Icon(Icons.dark_mode_outlined),
                title: const Text('Dark mode'),
                value: state.isDark,
                onChanged: (_) => state.toggleTheme(),
              ),
              const _SettingTile(Icons.notifications_none, 'Notifications'),
              const _SettingTile(Icons.lock_outline, 'Privacy'),
              const _SettingTile(Icons.help_outline, 'Help center'),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 720;
    final t = Theme.of(context).textTheme;
    return Column(
      children: [
        CircleAvatar(
          radius: wide ? 56 : 44,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Icon(
            Icons.person,
            size: wide ? 56 : 44,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Text('Nadiya Rahman', style: t.headlineSmall),
        const Text('nadiya_rahman'),
      ],
    );
  }
}

class _StatsRow extends StatelessWidget {
  final int saved;
  const _StatsRow({required this.saved});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const _Stat('Followers', '1.2k'),
        const _Stat('Following', '348'),
        _Stat('Saved', '$saved'),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final String value;
  const _Stat(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: Theme.of(context).textTheme.titleLarge),
        Text(label),
      ],
    );
  }
}

class _SettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  const _SettingTile(this.icon, this.title);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$title (demo)')),
      ),
    );
  }
}
