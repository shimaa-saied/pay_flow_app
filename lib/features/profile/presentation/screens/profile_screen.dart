import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../widgets/profile_body_widget.dart';
import '../widgets/profile_header_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final email = context.watch<AuthCubit>().state.maybeWhen(
          authenticated: (_, email) => email,
          orElse: () => 'Not signed in',
        );

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProfileHeaderWidget(email: email),
            ProfileBodyWidget(email: email),
          ],
        ),
      ),
    );
  }
}
