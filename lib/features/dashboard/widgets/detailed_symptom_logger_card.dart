import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:dgtl_app/app/design_system.dart';
import 'polished_pastel_card.dart';
import 'polished_button.dart';
import 'package:dgtl_app/app/di.dart';
import 'package:dgtl_app/core/database/database.dart';
import 'package:drift/drift.dart' as drift;

class DetailedSymptomLoggerCard extends StatefulWidget {
  const DetailedSymptomLoggerCard({super.key});

  @override
  State<DetailedSymptomLoggerCard> createState() => _DetailedSymptomLoggerCardState();
}

class _DetailedSymptomLoggerCardState extends State<DetailedSymptomLoggerCard> {
  // Blood Pressure
  String systolic = "";
  String diastolic = "";
  bool showWeeklyChart = false; // Toggle between daily/weekly view
  
  // Sample BP data for visualization (in real app, this would come from database)
  List<FlSpot> dailySystolicData = [
    FlSpot(0, 120), FlSpot(1, 125), FlSpot(2, 118), FlSpot(3, 122), 
    FlSpot(4, 128), FlSpot(5, 115), FlSpot(6, 120),
  ];
  List<FlSpot> dailyDiastolicData = [
    FlSpot(0, 80), FlSpot(1, 82), FlSpot(2, 78), FlSpot(3, 85), 
    FlSpot(4, 88), FlSpot(5, 75), FlSpot(6, 80),
  ];
  
  List<FlSpot> weeklySystolicData = [
    FlSpot(0, 122), FlSpot(1, 120), FlSpot(2, 125), FlSpot(3, 118),
  ];
  List<FlSpot> weeklyDiastolicData = [
    FlSpot(0, 82), FlSpot(1, 80), FlSpot(2, 84), FlSpot(3, 78),
  ];
  
  // Mood/Energy (1-3 scale)
  int energyMood = 2;
  
  // Fatigue/Pain (1-3 scale) 
  double fatigue = 2.0;
  double pain = 2.0;
  
  // Sleep Quality (1-3 scale)
  int sleepQuality = 2;
  
  // Fluid intake/output
  String fluidIntake = "";
  String fluidOutput = "";
  
  @override
  Widget build(BuildContext context) {
    return PolishedPastelCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with warm greeting
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      PastelColors.hopefulGreen.withOpacity(0.8),
                      PastelColors.hopefulGreen.withOpacity(0.4),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.favorite_rounded,
                  color: PastelColors.mutedBlack,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "दैनिक स्वास्थ्य ट्रैकर",
                      style: PastelTextStyles.cardTitle,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "आज आप कैसा महसूस कर रहे हैं?",
                      style: PastelTextStyles.cardSubtitle.copyWith(
                        color: PastelColors.mutedBlack.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: PastelColors.hopefulGreen.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  DateTime.now().day.toString() + " " + _getHindiMonth(),
                  style: PastelTextStyles.caption.copyWith(
                    fontWeight: FontWeight.w600,
                    color: PastelColors.mutedBlack.withOpacity(0.8),
                  ),
                ),
              ),
            ],
          ).animate().fadeIn(delay: 100.ms).slideX(begin: -0.2),
          
          const SizedBox(height: 24),
          
          // Blood Pressure Section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: PastelColors.calmBlue.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: PastelColors.calmBlue.withOpacity(0.5),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // SVG illustration
                    SvgPicture.asset(
                      'assets/illustrations/doctor_guide.svg',
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        PastelColors.mutedBlack,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "रक्तचाप (Blood Pressure)",
                      style: PastelTextStyles.cardTitle.copyWith(fontSize: 16),
                    ),
                    const Spacer(),
                    // Daily/Weekly toggle
                    Container(
                      decoration: BoxDecoration(
                        color: PastelColors.softWhite,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildToggleButton("दैनिक", !showWeeklyChart, () => setState(() => showWeeklyChart = false)),
                          _buildToggleButton("साप्ताहिक", showWeeklyChart, () => setState(() => showWeeklyChart = true)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: _buildBPInput("Systolic", "सिस्टोलिक", systolic, (value) => setState(() => systolic = value))),
                    const SizedBox(width: 16),
                    Text("/", style: PastelTextStyles.cardTitle),
                    const SizedBox(width: 16),
                    Expanded(child: _buildBPInput("Diastolic", "डायास्टोलिक", diastolic, (value) => setState(() => diastolic = value))),
                  ],
                ),
                
                // Real-time BP Visualizer
                _buildBPVisualizer(),
                
                const SizedBox(height: 20),
                
                // Real-time BP Line Chart with SVG Integration
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        PastelColors.calmBlue.withOpacity(0.05),
                        PastelColors.empathyAccent.withOpacity(0.03),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: PastelColors.calmBlue.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header with medical consultation icon
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: PastelColors.primaryAction.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: SvgPicture.asset(
                              'assets/illustrations/doctor_guide.svg',
                              height: 24,
                              width: 24,
                              colorFilter: ColorFilter.mode(
                                PastelColors.primaryAction,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'रक्तचाप विश्लेषण',
                                  style: PastelTextStyles.cardTitle.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  showWeeklyChart ? 'साप्ताहिक ट्रेंड' : 'दैनिक ट्रेंड',
                                  style: PastelTextStyles.caption.copyWith(
                                    color: PastelColors.mutedBlack.withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Chart Container
                      Container(
                        height: 200,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: PastelColors.softWhite.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: PastelColors.mutedBlack.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            // Chart Legend
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildLegendItem('सिस्टोलिक', PastelColors.primaryAction),
                                const SizedBox(width: 16),
                                _buildLegendItem('डायस्टोलिक', PastelColors.empathyAccent),
                              ],
                            ),
                            const SizedBox(height: 16),
                            // Line Chart
                            Expanded(
                              child: LineChart(_buildBPLineChartData()),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Enhanced BP Status
                      if (systolic.isNotEmpty && diastolic.isNotEmpty)
                        _buildEnhancedBPStatus(),
                    ],
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
          
          const SizedBox(height: 20),
          
          // Energy/Mood Section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: PastelColors.warmSaffron.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: PastelColors.warmSaffron.withOpacity(0.4),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.wb_sunny_rounded,
                      color: PastelColors.mutedBlack,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "मूड और एनर्जी",
                      style: PastelTextStyles.cardTitle.copyWith(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildEmojiSelector(1, "😔", "कम", energyMood == 1, () => setState(() => energyMood = 1)),
                    _buildEmojiSelector(2, "😊", "ठीक", energyMood == 2, () => setState(() => energyMood = 2)),
                    _buildEmojiSelector(3, "😄", "अच्छा", energyMood == 3, () => setState(() => energyMood = 3)),
                  ],
                ),
              ],
            ),
          ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),
          
          const SizedBox(height: 20),
          
          // Fatigue & Pain Sliders
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: PastelColors.pastelMint.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: PastelColors.pastelMint.withOpacity(0.5),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                _buildSliderSection("थकान स्तर", Icons.battery_1_bar, fatigue, (value) => setState(() => fatigue = value)),
                const SizedBox(height: 20),
                _buildSliderSection("दर्द स्तर", Icons.healing_rounded, pain, (value) => setState(() => pain = value)),
              ],
            ),
          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),
          
          const SizedBox(height: 20),
          
          // Sleep Quality
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: PastelColors.anxiousRose.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: PastelColors.anxiousRose.withOpacity(0.4),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.bedtime_rounded,
                      color: PastelColors.mutedBlack,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "नींद की गुणवत्ता",
                      style: PastelTextStyles.cardTitle.copyWith(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSleepSelector(1, "खराब", sleepQuality == 1, () => setState(() => sleepQuality = 1)),
                    _buildSleepSelector(2, "ठीक", sleepQuality == 2, () => setState(() => sleepQuality = 2)),
                    _buildSleepSelector(3, "अच्छी", sleepQuality == 3, () => setState(() => sleepQuality = 3)),
                  ],
                ),
              ],
            ),
          ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1),
          
          const SizedBox(height: 20),
          
          // Fluid Intake/Output
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: PastelColors.calmBlue.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: PastelColors.calmBlue.withOpacity(0.4),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.water_drop_rounded,
                      color: PastelColors.mutedBlack,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "तरल पदार्थ (मिली में)",
                      style: PastelTextStyles.cardTitle.copyWith(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: _buildFluidInput("पिया गया", "intake", fluidIntake, (value) => setState(() => fluidIntake = value))),
                    const SizedBox(width: 16),
                    Expanded(child: _buildFluidInput("निकला गया", "output", fluidOutput, (value) => setState(() => fluidOutput = value))),
                  ],
                ),
              ],
            ),
          ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1),
          
          const SizedBox(height: 32),
          
          // Log Symptoms Button
          PolishedButton(
            text: "लक्षण लॉग करें",
            isPrimary: true,
            icon: Icons.save_rounded,
            width: double.infinity,
            onPressed: _saveSymptoms,
          ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.1),
        ],
      ),
    );
  }
  
  Widget _buildBPInput(String label, String hindiLabel, String value, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hindiLabel,
          style: PastelTextStyles.caption.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _showNumericKeypad(context, hindiLabel, value, onChanged),
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              color: PastelColors.softWhite,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: PastelColors.mutedBlack.withOpacity(0.2)),
              boxShadow: [
                BoxShadow(
                  color: PastelColors.mutedBlack.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                value.isEmpty ? (label == "Systolic" ? "120" : "80") : value,
                style: PastelTextStyles.cardTitle.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: value.isEmpty 
                    ? PastelColors.mutedBlack.withOpacity(0.4)
                    : PastelColors.mutedBlack,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showNumericKeypad(BuildContext context, String title, String currentValue, Function(String) onChanged) {
    String tempValue = currentValue;
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            color: PastelColors.softWhite,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: PastelColors.mutedBlack.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              
              // Header
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      title,
                      style: PastelTextStyles.cardTitle.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: PastelColors.calmBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: PastelColors.calmBlue.withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        tempValue.isEmpty ? '0' : tempValue,
                        textAlign: TextAlign.center,
                        style: PastelTextStyles.cardTitle.copyWith(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: PastelColors.primaryAction,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Numeric Keypad
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Row 1: 1, 2, 3
                      Expanded(
                        child: Row(
                          children: [
                            _buildKeypadButton('1', () => setModalState(() => tempValue += '1')),
                            const SizedBox(width: 12),
                            _buildKeypadButton('2', () => setModalState(() => tempValue += '2')),
                            const SizedBox(width: 12),
                            _buildKeypadButton('3', () => setModalState(() => tempValue += '3')),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Row 2: 4, 5, 6
                      Expanded(
                        child: Row(
                          children: [
                            _buildKeypadButton('4', () => setModalState(() => tempValue += '4')),
                            const SizedBox(width: 12),
                            _buildKeypadButton('5', () => setModalState(() => tempValue += '5')),
                            const SizedBox(width: 12),
                            _buildKeypadButton('6', () => setModalState(() => tempValue += '6')),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Row 3: 7, 8, 9
                      Expanded(
                        child: Row(
                          children: [
                            _buildKeypadButton('7', () => setModalState(() => tempValue += '7')),
                            const SizedBox(width: 12),
                            _buildKeypadButton('8', () => setModalState(() => tempValue += '8')),
                            const SizedBox(width: 12),
                            _buildKeypadButton('9', () => setModalState(() => tempValue += '9')),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Row 4: Clear, 0, Backspace
                      Expanded(
                        child: Row(
                          children: [
                            _buildKeypadButton('साफ़', () => setModalState(() => tempValue = ''), isSpecial: true),
                            const SizedBox(width: 12),
                            _buildKeypadButton('0', () => setModalState(() => tempValue += '0')),
                            const SizedBox(width: 12),
                            _buildKeypadButton('⌫', () => setModalState(() {
                              if (tempValue.isNotEmpty) {
                                tempValue = tempValue.substring(0, tempValue.length - 1);
                              }
                            }), isSpecial: true),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // Done Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            onChanged(tempValue);
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: PastelColors.primaryAction,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                          ),
                          child: Text(
                            'पूर्ण',
                            style: PastelTextStyles.cardTitle.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).then((_) {
      // Update the parent widget when the modal closes
      setState(() {});
    });
  }

  Widget _buildKeypadButton(String label, VoidCallback onTap, {bool isSpecial = false}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: isSpecial 
              ? PastelColors.empathyAccent.withOpacity(0.1)
              : PastelColors.softWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSpecial 
                ? PastelColors.empathyAccent.withOpacity(0.3)
                : PastelColors.mutedBlack.withOpacity(0.2),
            ),
            boxShadow: [
              BoxShadow(
                color: PastelColors.mutedBlack.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              label,
              style: PastelTextStyles.cardTitle.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isSpecial 
                  ? PastelColors.empathyAccent
                  : PastelColors.mutedBlack,
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildBPVisualizer() {
    final sys = int.tryParse(systolic) ?? 0;
    final dia = int.tryParse(diastolic) ?? 0;
    final status = _getBPStatus(sys, dia);
    
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            status['color'].withOpacity(0.1),
            status['color'].withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: status['color'].withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Current Reading Display
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: status['color'],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  status['icon'], 
                  color: Colors.white, 
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${sys}/${dia} mmHg',
                      style: PastelTextStyles.cardTitle.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: PastelColors.mutedBlack,
                      ),
                    ),
                    Text(
                      status['text'],
                      style: PastelTextStyles.cardSubtitle.copyWith(
                        fontWeight: FontWeight.w600,
                        color: status['color'],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Visual Progress Bar (Single Line)
          _buildBPProgressBar(sys, dia, status),
          
          const SizedBox(height: 16),
          
          // Health Advice
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: PastelColors.softWhite.withOpacity(0.7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lightbulb,
                  color: PastelColors.empathyAccent,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    status['advice'],
                    style: PastelTextStyles.caption.copyWith(
                      fontWeight: FontWeight.w600,
                      color: PastelColors.mutedBlack.withOpacity(0.8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1);
  }
  
  Widget _buildBPProgressBar(int sys, int dia, Map<String, dynamic> status) {
    // Calculate position on scale (0-200 mmHg range)
    double sysPosition = (sys / 200).clamp(0.0, 1.0);
    double diaPosition = (dia / 120).clamp(0.0, 1.0);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Systolic Bar
        Text(
          'सिस्टोलिक (${sys} mmHg)',
          style: PastelTextStyles.caption.copyWith(
            fontWeight: FontWeight.w600,
            color: PastelColors.mutedBlack.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 8,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            gradient: LinearGradient(
              colors: [
                Colors.green,
                Colors.yellow,
                Colors.orange,
                Colors.red,
              ],
              stops: const [0.0, 0.4, 0.7, 1.0],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: MediaQuery.of(context).size.width * 0.7 * sysPosition - 6,
                top: -2,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: PastelColors.primaryAction,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Diastolic Bar
        Text(
          'डायास्टोलिक (${dia} mmHg)',
          style: PastelTextStyles.caption.copyWith(
            fontWeight: FontWeight.w600,
            color: PastelColors.mutedBlack.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 8,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            gradient: LinearGradient(
              colors: [
                Colors.green,
                Colors.yellow,
                Colors.orange,
                Colors.red,
              ],
              stops: const [0.0, 0.4, 0.7, 1.0],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: MediaQuery.of(context).size.width * 0.7 * diaPosition - 6,
                top: -2,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: PastelColors.empathyAccent,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 12),
        
        // Scale Labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('कम', style: PastelTextStyles.caption.copyWith(fontSize: 10, color: Colors.green)),
            Text('सामान्य', style: PastelTextStyles.caption.copyWith(fontSize: 10, color: Colors.yellow[700])),
            Text('बढ़ा हुआ', style: PastelTextStyles.caption.copyWith(fontSize: 10, color: Colors.orange)),
            Text('उच्च', style: PastelTextStyles.caption.copyWith(fontSize: 10, color: Colors.red)),
          ],
        ),
      ],
    );
  }
  
  Map<String, dynamic> _getBPStatus(int sys, int dia) {
    if (sys < 90 || dia < 60) {
      return {'text': 'कम रक्तचाप', 'color': Colors.blue, 'icon': Icons.arrow_downward, 'advice': 'नमक और पानी बढ़ाएं'};
    } else if (sys < 120 && dia < 80) {
      return {'text': 'सामान्य रक्तचाप', 'color': Colors.green, 'icon': Icons.check_circle, 'advice': 'बहुत अच्छा! इसे बनाए रखें'};
    } else if (sys <= 139 || dia <= 89) {
      return {'text': 'थोड़ा बढ़ा हुआ', 'color': Colors.orange, 'icon': Icons.warning, 'advice': 'नमक कम करें, व्यायाम करें'};
    } else {
      return {'text': 'उच्च रक्तचाप', 'color': Colors.red, 'icon': Icons.priority_high, 'advice': 'तुरंत डॉक्टर से मिलें'};
    }
  }

  Widget _buildToggleButton(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? PastelColors.calmBlue.withOpacity(0.3) : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          text,
          style: PastelTextStyles.caption.copyWith(
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: isSelected ? PastelColors.mutedBlack : PastelColors.mutedBlack.withOpacity(0.6),
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 2,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(1),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: PastelTextStyles.caption.copyWith(fontSize: 10),
        ),
      ],
    );
  }

  LineChartData _buildBPLineChartData() {
    final systolicData = showWeeklyChart ? weeklySystolicData : dailySystolicData;
    final diastolicData = showWeeklyChart ? weeklyDiastolicData : dailyDiastolicData;
    
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 20,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: PastelColors.mutedBlack.withOpacity(0.1),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: (double value, TitleMeta meta) {
              if (showWeeklyChart) {
                const weeks = ['सप्ताह 1', 'सप्ताह 2', 'सप्ताह 3', 'सप्ताह 4'];
                return value.toInt() < weeks.length 
                  ? Text(weeks[value.toInt()], style: PastelTextStyles.caption.copyWith(fontSize: 10))
                  : const SizedBox();
              } else {
                const days = ['सोम', 'मंगल', 'बुध', 'गुरु', 'शुक्र', 'शनि', 'रवि'];
                return value.toInt() < days.length
                  ? Text(days[value.toInt()], style: PastelTextStyles.caption.copyWith(fontSize: 10))
                  : const SizedBox();
              }
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 20,
            reservedSize: 40,
            getTitlesWidget: (double value, TitleMeta meta) {
              return Text(
                value.toInt().toString(),
                style: PastelTextStyles.caption.copyWith(fontSize: 10),
              );
            },
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: (showWeeklyChart ? weeklySystolicData.length : dailySystolicData.length).toDouble() - 1,
      minY: 60,
      maxY: 160,
      lineBarsData: [
        // Systolic line
        LineChartBarData(
          spots: systolicData,
          isCurved: true,
          color: PastelColors.primaryAction,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
              radius: 4,
              color: PastelColors.primaryAction,
              strokeWidth: 2,
              strokeColor: PastelColors.softWhite,
            ),
          ),
          belowBarData: BarAreaData(
            show: true,
            color: PastelColors.primaryAction.withOpacity(0.1),
          ),
        ),
        // Diastolic line
        LineChartBarData(
          spots: diastolicData,
          isCurved: true,
          color: PastelColors.empathyAccent,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
              radius: 4,
              color: PastelColors.empathyAccent,
              strokeWidth: 2,
              strokeColor: PastelColors.softWhite,
            ),
          ),
          belowBarData: BarAreaData(
            show: true,
            color: PastelColors.empathyAccent.withOpacity(0.1),
          ),
        ),
      ],
    );
  }

  Widget _buildEnhancedBPStatus() {
    final sys = int.tryParse(systolic) ?? 0;
    final dia = int.tryParse(diastolic) ?? 0;
    final status = _getBPStatus(sys, dia);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            (status['color'] as Color).withOpacity(0.1),
            (status['color'] as Color).withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (status['color'] as Color).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: status['color'],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  status['icon'],
                  color: Colors.white,
                  size: 16,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      status['text'],
                      style: PastelTextStyles.cardSubtitle.copyWith(
                        fontWeight: FontWeight.w600,
                        color: status['color'],
                      ),
                    ),
                    Text(
                      "$sys/$dia mmHg",
                      style: PastelTextStyles.caption.copyWith(
                        color: PastelColors.mutedBlack.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: PastelColors.softWhite.withOpacity(0.8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  size: 16,
                  color: PastelColors.mutedBlack.withOpacity(0.7),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    status['advice'],
                    style: PastelTextStyles.caption.copyWith(
                      fontStyle: FontStyle.italic,
                      color: PastelColors.mutedBlack.withOpacity(0.8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildEmojiSelector(int value, String emoji, String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? PastelColors.warmSaffron.withOpacity(0.3) : PastelColors.softWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? PastelColors.warmSaffron : PastelColors.mutedBlack.withOpacity(0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 4),
            Text(label, style: PastelTextStyles.caption),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSliderSection(String title, IconData icon, double value, Function(double) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: PastelColors.mutedBlack, size: 18),
            const SizedBox(width: 8),
            Text(title, style: PastelTextStyles.cardSubtitle),
          ],
        ),
        const SizedBox(height: 12),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: PastelColors.empathyAccent,
            inactiveTrackColor: PastelColors.empathyBorder,
            thumbColor: PastelColors.empathyAccent,
            overlayColor: PastelColors.empathyAccent.withOpacity(0.2),
          ),
          child: Slider(
            value: value,
            min: 1,
            max: 3,
            divisions: 2,
            label: ['कम', 'मध्यम', 'ज्यादा'][value.round() - 1],
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
  
  Widget _buildSleepSelector(int value, String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? PastelColors.anxiousRose.withOpacity(0.3) : PastelColors.softWhite,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? PastelColors.anxiousRose : PastelColors.mutedBlack.withOpacity(0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          label,
          style: PastelTextStyles.caption.copyWith(
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
  
  Widget _buildFluidInput(String label, String type, String value, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: PastelTextStyles.caption.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: PastelColors.softWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: PastelColors.mutedBlack.withOpacity(0.2)),
          ),
          child: TextField(
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: PastelTextStyles.cardSubtitle,
            decoration: InputDecoration(
              hintText: type == "intake" ? "1500" : "1200",
              hintStyle: PastelTextStyles.caption,
              suffix: Text("ml", style: PastelTextStyles.caption),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
  
  String _getHindiMonth() {
    final months = ['जन', 'फरव', 'मार्च', 'अप्रैल', 'मई', 'जून', 'जुलाई', 'अग', 'सितं', 'अक्टू', 'नवं', 'दिसं'];
    return months[DateTime.now().month - 1];
  }
  
  void _saveSymptoms() {
    final db = getIt<AppDatabase>();
    final now = DateTime.now();

    // Parse fields safely
    int? sys = int.tryParse(systolic.trim());
    int? dia = int.tryParse(diastolic.trim());
    int? intake = int.tryParse(fluidIntake.trim());
    int? output = int.tryParse(fluidOutput.trim());

    () async {
      try {
        // Ensure a default patient exists (id = first patient or create one)
        int patientId;
        final patients = await db.getAllPatients();
        if (patients.isEmpty) {
          patientId = await db.insertPatient(PatientsCompanion(
            firstName: drift.Value('माँ'),
            lastName: drift.Value(''),
            gender: const drift.Value('F'),
          ));
        } else {
          patientId = patients.first.id;
        }

        // Insert structured daily health log
        await db.insertDailyHealthLog(DailyHealthLogsCompanion(
          patientId: drift.Value(patientId),
          loggedAt: drift.Value(now),
          systolic: drift.Value(sys),
          diastolic: drift.Value(dia),
          energyMood: drift.Value(energyMood),
          fatigue: drift.Value(fatigue.round()),
          pain: drift.Value(pain.round()),
          sleepQuality: drift.Value(sleepQuality),
          fluidIntake: drift.Value(intake),
          fluidOutput: drift.Value(output),
        ));

        // Also capture a concise symptom row for pain/fatigue if present (optional)
        if ((fatigue.round()) > 1) {
          await db.insertSymptomLog(SymptomLogsCompanion(
            patientId: drift.Value(patientId),
            symptom: const drift.Value('Fatigue'),
            severity: drift.Value(fatigue.round()),
            description: drift.Value('Daily log via UI'),
            logDate: drift.Value(now),
          ));
        }
        if ((pain.round()) > 1) {
          await db.insertSymptomLog(SymptomLogsCompanion(
            patientId: drift.Value(patientId),
            symptom: const drift.Value('Pain'),
            severity: drift.Value(pain.round()),
            description: drift.Value('Daily log via UI'),
            logDate: drift.Value(now),
          ));
        }

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('लक्षण सफलतापूर्वक सेव हो गए! 🎉'),
            backgroundColor: PastelColors.hopefulGreen,
          ),
        );
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('सेव करने में समस्या: $e'),
            backgroundColor: PastelColors.anxiousRose,
          ),
        );
      }
    }();
  }
}
