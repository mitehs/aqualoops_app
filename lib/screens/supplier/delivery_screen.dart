import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../widgets/custom_button.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  bool isStarted = false;

  final List<_DeliveryStop> stops = const [
    _DeliveryStop(
      number: 1,
      name: 'Priya Sharma',
      area: 'Indiranagar',
      distance: '0.8 km',
      isDone: true,
    ),
    _DeliveryStop(
      number: 2,
      name: 'Amit Verma',
      area: 'Domlur',
      distance: '2.4 km',
      isCurrent: true,
    ),
    _DeliveryStop(
      number: 3,
      name: 'Sneha Reddy',
      area: 'HAL 2nd Stage',
      distance: '3.2 km',
    ),
    _DeliveryStop(
      number: 4,
      name: 'Karan Mehta',
      area: 'Old Airport Road',
      distance: '4.1 km',
    ),
    _DeliveryStop(
      number: 5,
      name: 'Ananya Iyer',
      area: 'Koramangala',
      distance: '5.6 km',
    ),
    _DeliveryStop(
      number: 6,
      name: 'Rohit Nair',
      area: 'HSR Layout',
      distance: '7.2 km',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Deliveries'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroCard(),

            const SizedBox(height: 20),

            // Map placeholder
            Container(
              width: double.infinity,
              height: 210,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade100,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.supplierPrimary.withValues(alpha: 0.3),
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.navigation, size: 52, color: AppColors.supplierDark),
                  SizedBox(height: 10),
                  Text(
                    'Route to customer',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.supplierDark,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Turn left in 400 m onto CMH Road',
                    style: TextStyle(color: AppColors.grey, fontSize: 12.5),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Route Stops',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  '6 stops',
                  style: TextStyle(color: AppColors.grey, fontSize: 13),
                ),
              ],
            ),

            const SizedBox(height: 12),

            ...stops.map(_buildStopCard),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.supplierPrimary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.local_shipping,
                  color: Colors.white,
                  size: 26,
                ),
              ),

              const SizedBox(width: 12),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Active Delivery',
                      style: TextStyle(color: AppColors.grey, fontSize: 12.5),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Stop 2 of 8',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.supplierPrimary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isStarted ? 'In Progress' : 'Not Started',
                  style: const TextStyle(
                    color: AppColors.supplierDark,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          const Row(
            children: [
              Expanded(
                child: _InfoTile(label: 'Customer', value: 'Amit Verma'),
              ),
              Expanded(
                child: _InfoTile(label: 'ETA', value: '12 min'),
              ),
              Expanded(
                child: _InfoTile(label: 'Distance', value: '2.4 km'),
              ),
            ],
          ),

          const SizedBox(height: 16),

          CustomButton(
            label: isStarted ? 'COMPLETE STOP' : 'START DELIVERY',
            icon: isStarted ? Icons.check_circle_outline : Icons.play_arrow,
            onPressed: () {
              setState(() {
                isStarted = !isStarted;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isStarted
                        ? 'Delivery started for Stop 2'
                        : 'Stop 2 marked as completed',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStopCard(_DeliveryStop stop) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: stop.isCurrent
            ? Border.all(color: AppColors.supplierPrimary, width: 1.5)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          _stopBadge(stop),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stop.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${stop.area} • ${stop.distance}',
                  style: const TextStyle(color: AppColors.grey, fontSize: 12.5),
                ),
                if (stop.isCurrent) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _actionButton(Icons.call, () {}),
                      _actionButton(Icons.message_outlined, () {}),
                      _actionButton(Icons.navigation_outlined, () {}),
                    ],
                  ),
                ],
              ],
            ),
          ),

          if (!stop.isDone && !stop.isCurrent)
            const Icon(Icons.schedule, color: AppColors.grey, size: 22)
          else if (stop.isCurrent)
            const Icon(Icons.chevron_right, color: AppColors.supplierPrimary, size: 24),
        ],
      ),
    );
  }

  Widget _stopBadge(_DeliveryStop stop) {
    if (stop.isDone) {
      return const Icon(Icons.check_circle, color: AppColors.success, size: 34);
    }

    return Container(
      width: 34,
      height: 34,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: stop.isCurrent ? AppColors.supplierPrimary : AppColors.supplierLight,
      ),
      child: Text(
        '${stop.number}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: stop.isCurrent ? Colors.white : AppColors.supplierDark,
        ),
      ),
    );
  }

  Widget _actionButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: 20, color: AppColors.supplierDark),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      constraints: const BoxConstraints(minWidth: 38, minHeight: 38),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;

  const _InfoTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColors.grey, fontSize: 11),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _DeliveryStop {
  final int number;
  final String name;
  final String area;
  final String distance;
  final bool isDone;
  final bool isCurrent;

  const _DeliveryStop({
    required this.number,
    required this.name,
    required this.area,
    required this.distance,
    this.isDone = false,
    this.isCurrent = false,
  });
}
