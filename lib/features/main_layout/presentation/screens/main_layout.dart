import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_constants.dart';
import '../../../home/presentation/cubit/account_cubit/account_cubit.dart';
import '../../../home/presentation/cubit/account_cubit/account_state.dart';
import '../../../home/presentation/cubit/exchange_rate_cubit/exchange_rate_cubit.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../send/presentation/screens/send_screen.dart';
import '../../../receive/presentation/screens/receive_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  static const _titles = ['Home', 'Send', 'Receive', 'Profile'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExchangeRateCubit>().fetchRate(
            base: AppConstants.defaultBaseCurrency,
            target: AppConstants.defaultCurrency,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountCubit, AccountState>(
      listenWhen: (previous, current) {
        if (current is! AccountLoaded) return false;
        final prev = previous is AccountLoaded ? previous.errorMessage : null;
        return current.errorMessage != null && current.errorMessage != prev;
      },
      listener: (context, state) {
        final msg =
            state.maybeWhen(loaded: (_, __, ___, e) => e, orElse: () => null);
        if (msg != null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(msg)));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_titles[_currentIndex]),
          centerTitle: false,
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: const [
            HomeScreen(),
            SendScreen(),
            ReceiveScreen(),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) =>
              setState(() => _currentIndex = index),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.send_outlined),
              selectedIcon: Icon(Icons.send),
              label: 'Send',
            ),
            NavigationDestination(
              icon: Icon(Icons.account_balance_wallet_outlined),
              selectedIcon: Icon(Icons.account_balance_wallet),
              label: 'Receive',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
