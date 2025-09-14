import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dgtl_app/app/design_system.dart';
import 'package:dgtl_app/features/health_tracking/health_integration_service.dart';

class BPSymptomLoggerCard extends ConsumerStatefulWidget {
  const BPSymptomLoggerCard({super.key});

  @override
  ConsumerState<BPSymptomLoggerCard> createState() => _BPSymptomLoggerCardState();
}

class _BPSymptomLoggerCardState extends ConsumerState<BPSymptomLoggerCard> {
  String systolic = "";
  String diastolic = "";
  double fatigueLevel = 3.0;
  bool isExpanded = false;
  bool isLoading = false;

  Future<void> _saveBPData() async {
    if (systolic.isEmpty || diastolic.isEmpty) return;
    
    setState(() {
      isLoading = true;
    });

    try {
      final service = ref.read(healthIntegrationServiceProvider.notifier);
      await service.logBPReading(
        systolic: int.tryParse(systolic) ?? 0,
        diastolic: int.tryParse(diastolic) ?? 0,
        heartRate: 75, // Default value
        notes: 'Fatigue Level: ${fatigueLevel.toInt()}/5',
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('BP डेटा सेव हो गया!'),
          ),
        );
        setState(() {
          systolic = "";
          diastolic = "";
          fatigueLevel = 3.0;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('कुछ गलत हुआ। फिर कोशिश करें।'),
          ),
        );
        setState(() {
          isLoading = false;
        });
      }
    }
  }

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
                      color: PastelColors.primaryAction.withOpacity(0.1),
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
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
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
                const SizedBox(height: 16),
                
                // BP Input Section
                Text(
                  "रक्तचाप की रीडिंग (mmHg)", // Blood pressure reading
                  style: PastelTextStyles.cardTitle.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 12),
                
                Row(
                  children: [
                    // Systolic input
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            systolic = value;
                          });
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "सिस्टोलिक", // Systolic
                          hintText: "120",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: PastelColors.primaryAction),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text("/", style: PastelTextStyles.cardTitle),
                    const SizedBox(width: 12),
                    // Diastolic input
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            diastolic = value;
                          });
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "डायस्टोलिक", // Diastolic
                          hintText: "80",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: PastelColors.primaryAction),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Fatigue Level Section
                Text(
                  "थकान का स्तर", // Fatigue level
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
                
                // Save Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _saveBPData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PastelColors.primaryAction,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text(
                            "सेव करें", // Save
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
