// features/profile/presentation/pages/profile_page.dart
//
// استخدام DeviceInfoService (Singleton) — بيتنادى FutureBuilder واحد
// بس، والنتيجة متخزنة (cached) جوه الـ service نفسه.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:pay_flow_app/core/di/injection.dart' as di;
import 'package:pay_flow_app/core/services/device_info_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final email = FirebaseAuth.instance.currentUser?.email ?? 'غير مسجل';
    final deviceInfoService = di.sl<DeviceInfoService>();

    return Scaffold(
      appBar: AppBar(title: const Text('الملف الشخصي')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
            const SizedBox(height: 16),
            Text(email, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 24),
            const Text('معلومات الجهاز',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            FutureBuilder(
              future: deviceInfoService.getDeviceInfo(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                final info = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('الموديل: ${info.model}'),
                    Text('نظام التشغيل: ${info.osVersion}'),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
