import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:dgtl_app/app/design_system.dart';
import 'pastel_card.dart';

class VitalTrackerCard extends StatelessWidget {
  const VitalTrackerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return PastelCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Vitals Tracker", style: PastelTextStyles.cardTitle),
          const SizedBox(height: 16),
          _buildVitalRow("Creatinine (क्रिएटिनिन)", "1.8 mg/dL", true),
          _buildVitalRow("eGFR", "45 mL/min", false),
          _buildVitalRow("Potassium (पोटेशियम)", "4.2 mEq/L", true),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: LineChart(
              LineChartData(
                // Dummy data for bubble-like chart
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 3), FlSpot(2.6, 2), FlSpot(4.9, 5), FlSpot(6.8, 3.1), FlSpot(8, 4), FlSpot(9.5, 3), FlSpot(11, 4),
                    ],
                    isCurved: true,
                    color: PastelColors.anxiousRose,
                    barWidth: 5,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.upload_file),
                label: const Text("Upload Report"),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.download),
                label: const Text("Download"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVitalRow(String name, String value, bool isImproving) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: PastelTextStyles.body),
          Row(
            children: [
              Text(value, style: PastelTextStyles.body.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              Icon(
                isImproving ? Icons.arrow_upward : Icons.arrow_downward,
                color: isImproving ? PastelColors.hopefulGreen : PastelColors.anxiousRose,
                size: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
