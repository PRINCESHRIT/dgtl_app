import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dgtl_app/app/design_system.dart';
import 'package:dgtl_app/features/health_tracking/health_integration_service.dart';

class BPSymptomLoggerCard extends ConsumerStatefulWidget {
  const BPSymptomLoggerCard({super.key});

  @override
  ConsumerState<BPSymptomLoggerCard> createState() => _BPSymptomLoggerCardState();
}

class _BPSymptomLoggerCardState extends State<BPSymptomLoggerCard> {
  String systolic = "";
  String diastolic = "";
  double fatigueLevel = 3.0;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: PastelColors.softWhite,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: PastelColors.primaryAction.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: PastelColors.primaryActionLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.monitor_heart,
                      color: PastelColors.primaryAction,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "रक्तचाप और लक्षण रिकॉर्ड करें", // Record BP and symptoms
                          style: PastelTextStyles.cardTitle,
                        ),
                        Text(
                          "दैनिक स्वास्थ्य ट्रैकिंग", // Daily health tracking
                          style: PastelTextStyles.body.copyWith(
                            fontSize: 12,
                            color: PastelColors.mutedBlack.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Quick action button
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PastelColors.primaryAction,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                    child: Text(
                      isExpanded ? "बंद करें" : "लॉग करें",
                      style: PastelTextStyles.actionButton.copyWith(fontSize: 14),
                    ),
                  ),
                ],
              ),
              
              if (!isExpanded) ...[
                const SizedBox(height: 16),
                // Quick status view
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: PastelColors.hopefulGreen.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: PastelColors.hopefulGreen,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "आज का BP: 120/80 • स्थिति: सामान्य",
                        style: PastelTextStyles.body.copyWith(
                          color: Colors.green[800],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              
              if (isExpanded) ...[
                const SizedBox(height: 20),
                // BP Input Section
                Text(
                  "रक्तचाप दर्ज करें:", // Enter Blood Pressure
                  style: PastelTextStyles.cardTitle.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildBPInput("सिस्टोलिक", systolic, (value) {
                        setState(() {
                          systolic = value;
                        });
                      }),
                    ),
                    const SizedBox(width: 12),
                    Text("/", style: PastelTextStyles.cardTitle),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildBPInput("डायस्टोलिक", diastolic, (value) {
                        setState(() {
                          diastolic = value;
                        });
                      }),
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Fatigue slider
                Text(
                  "आज कितनी थकान महसूस कर रहे हैं?", // How tired are you feeling today?
                  style: PastelTextStyles.cardTitle.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text("कम", style: PastelTextStyles.body), // Less
                    Expanded(
                      child: Slider(
                        value: fatigueLevel,
                        min: 1,
                        max: 5,
                        divisions: 4,
                        activeColor: PastelColors.primaryAction,
                        inactiveColor: PastelColors.primaryAction.withOpacity(0.2),
                        onChanged: (value) {
                          setState(() {
                            fatigueLevel = value;
                          });
                        },
                      ),
                    ),
                    Text("ज्यादा", style: PastelTextStyles.body), // More
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Save button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Save logic here
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("डेटा सफलतापूर्वक सेव हुआ!"), // Data saved successfully
                          backgroundColor: PastelColors.hopefulGreen,
                        ),
                      );
                      setState(() {
                        isExpanded = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PastelColors.primaryAction,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      "सेव करें", // Save
                      style: PastelTextStyles.actionButton,
                    ),
                  ),
                ),
              ],
          const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildBPInput(String label, String value, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: PastelTextStyles.body.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: PastelColors.primaryAction.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: TextField(
            textAlign: TextAlign.center,
            style: PastelTextStyles.healthScore.copyWith(
              color: PastelColors.mutedBlack,
            ),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "000",
              hintStyle: TextStyle(
                color: PastelColors.mutedBlack.withOpacity(0.3),
              ),
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
