import 'package:airvitals/core/presentation/extensions/theme_extension.dart';
import 'package:airvitals/core/routing/app_router.dart';
import 'package:airvitals/features/home/presentation/bloc/sensor_data_bloc.dart';
import 'package:airvitals/l10n/l10n.dart';
import 'package:airvitals/shared/domain/failures/sensor_failures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

final class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<SensorDataBloc>()
        ..add(
          SensorDataStarted(GetIt.I<FirebaseAuth>().currentUser!.uid),
        ),
      child: const HomeView(),
    );
  }
}

final class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.homeTitle),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (context.mounted) {
                const SignInRoute().go(context);
              }
            },
            tooltip: l10n.signOut,
          ),
        ],
      ),
      body: BlocBuilder<SensorDataBloc, SensorDataState>(
        builder: (context, state) {
          return switch (state) {
            SensorDataInitial() => const SizedBox.shrink(),
            SensorDataLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            SensorDataSuccess(data: final data) => Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      theme.colorScheme.primary.withAlpha(25),
                      theme.colorScheme.primary.withAlpha(13),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth:
                              context.width > 600.w ? 600.w : context.width,
                        ),
                        padding: EdgeInsets.all(16.w),
                        child: _RoomCard(
                          temperature: data.temperature,
                          humidity: data.humidity,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            SensorDataFailure(failure: final failure) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 48.w,
                      color: theme.colorScheme.error,
                    ),
                    16.h.verticalSpace,
                    Text(
                      switch (failure) {
                        ConnectionFailure() => l10n.connectionError,
                        ServerFailure() => l10n.serverError,
                        NoDataFailure() => l10n.noDataError,
                      },
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.error,
                      ),
                    ),
                  ],
                ),
              ),
          };
        },
      ),
    );
  }
}

final class _RoomCard extends StatelessWidget {
  const _RoomCard({
    required this.temperature,
    required this.humidity,
  });

  final double temperature;
  final double humidity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _AnimatedSensorValue(
              icon: Icons.thermostat,
              label: l10n.temperature,
              value: temperature,
              unit: '°C',
              color: theme.colorScheme.primary,
            ),
            32.h.verticalSpace,
            _AnimatedSensorValue(
              icon: Icons.water_drop,
              label: l10n.humidity,
              value: humidity,
              unit: '%',
              color: theme.colorScheme.secondary,
            ),
          ],
        ),
      ),
    );
  }
}

final class _AnimatedSensorValue extends StatelessWidget {
  const _AnimatedSensorValue({
    required this.icon,
    required this.label,
    required this.value,
    required this.unit,
    required this.color,
  });

  final IconData icon;
  final String label;
  final double value;
  final String unit;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: value),
      duration: const Duration(seconds: 1),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) => Column(
        children: [
          Icon(
            icon,
            size: 48.w,
            color: color,
          ),
          16.h.verticalSpace,
          Text(
            label,
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.onSurface.withAlpha(204),
            ),
          ),
          8.h.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value.toStringAsFixed(1),
                style: theme.textTheme.displayMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                unit,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
