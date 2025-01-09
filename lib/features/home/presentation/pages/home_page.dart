import 'package:airvitals/core/routing/app_router.dart';
import 'package:airvitals/features/home/domain/entities/room.dart';
import 'package:airvitals/features/home/presentation/bloc/rooms_bloc.dart';
import 'package:airvitals/l10n/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<RoomsBloc>()
        ..add(
          RoomsStarted(GetIt.I<FirebaseAuth>().currentUser!.uid),
        ),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.roomsTitle),
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
      body: BlocBuilder<RoomsBloc, RoomsState>(
        builder: (context, state) {
          return switch (state) {
            RoomsInitial() => const SizedBox.shrink(),
            RoomsLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            RoomsSuccess(rooms: final rooms) => _RoomsGrid(rooms: rooms),
            RoomsFailure() => Center(
                child: Text(l10n.roomsError),
              ),
          };
        },
      ),
    );
  }
}

class _RoomsGrid extends StatelessWidget {
  const _RoomsGrid({required this.rooms});

  final List<Room> rooms;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = switch (constraints.maxWidth) {
          > 1200 => 4,
          > 800 => 3,
          > 600 => 2,
          _ => 1,
        };

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.5,
          ),
          itemCount: rooms.length,
          itemBuilder: (context, index) {
            final room = rooms[index];
            return _RoomCard(
              name: room.name,
              temperature: room.temperature,
              humidity: room.humidity,
            );
          },
        );
      },
    );
  }
}

class _RoomCard extends StatefulWidget {
  const _RoomCard({
    required this.name,
    required this.temperature,
    required this.humidity,
  });

  final String name;
  final double temperature;
  final double humidity;

  @override
  State<_RoomCard> createState() => _RoomCardState();
}

class _RoomCardState extends State<_RoomCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Card(
          elevation: 8,
          clipBehavior: Clip.antiAlias,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  theme.colorScheme.primary.withAlpha(204),
                  theme.colorScheme.secondary.withAlpha(153),
                ],
                stops: [
                  0,
                  _animation.value,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.home_rounded,
                        color: theme.colorScheme.onPrimary,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          widget.name,
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _AnimatedValueDisplay(
                        icon: Icons.thermostat_rounded,
                        value: widget.temperature,
                        unit: '°C',
                        label: l10n.temperature,
                        animation: _animation,
                      ),
                      _AnimatedValueDisplay(
                        icon: Icons.water_drop_rounded,
                        value: widget.humidity,
                        unit: '%',
                        label: l10n.humidity,
                        animation: _animation,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _AnimatedValueDisplay extends StatelessWidget {
  const _AnimatedValueDisplay({
    required this.icon,
    required this.value,
    required this.unit,
    required this.label,
    required this.animation,
  });

  final IconData icon;
  final double value;
  final String unit;
  final String label;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: theme.colorScheme.onPrimary.withAlpha(180),
          size: 24,
        ),
        const SizedBox(height: 8),
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: value),
          duration: const Duration(seconds: 1),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) => Text(
            '${value.toStringAsFixed(1)}$unit',
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onPrimary.withAlpha(180),
          ),
        ),
      ],
    );
  }
}
