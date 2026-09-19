import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/dependency_injection/injection.dart';
import '../../../../core/services/device_info_service.dart';
import 'info_card_widget.dart';
import 'info_tile_widget.dart';

class ProfileInfoCardsWidget extends StatelessWidget {
  final String email;

  const ProfileInfoCardsWidget({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final deviceInfoService = getIt<DeviceInfoService>();

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          InfoCardWidget(
            title: 'Account',
            children: [
              InfoTileWidget(
                icon: Icons.email_outlined,
                label: 'Email',
                value: email,
              ),
              const InfoTileWidget(
                icon: Icons.shield_outlined,
                label: 'Account Status',
                value: 'Verified',
                valueColor: AppColors.success,
              ),
            ],
          ),
          const SizedBox(height: 12),
          InfoCardWidget(
            title: 'Device Information',
            children: [
              FutureBuilder(
                future: deviceInfoService.getDeviceInfo(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  final info = snapshot.data!;
                  return Column(
                    children: [
                      InfoTileWidget(
                        icon: Icons.phone_android_outlined,
                        label: 'Model',
                        value: info.model,
                      ),
                      InfoTileWidget(
                        icon: Icons.system_update_outlined,
                        label: 'OS Version',
                        value: info.osVersion,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
