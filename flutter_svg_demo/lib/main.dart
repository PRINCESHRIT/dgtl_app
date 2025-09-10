import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SVG Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SvgShowcasePage(),
    );
  }
}

class SvgShowcasePage extends StatefulWidget {
  const SvgShowcasePage({super.key});
  @override
  State<SvgShowcasePage> createState() => _SvgShowcasePageState();
}

class _SvgShowcasePageState extends State<SvgShowcasePage> {
  String? _inlineSvg; // example of loading an svg as string to modify at runtime

  @override
  void initState() {
    super.initState();
    _loadOneSvgAsString();
  }

  Future<void> _loadOneSvgAsString() async {
    // load one of the SVG files from assets as a string (useful for runtime edits)
    final svgString = await rootBundle.loadString('assets/svgs/heart-svgrepo-com.svg');
    setState(() => _inlineSvg = svgString);
  }

  @override
  Widget build(BuildContext context) {
    final assets = <String>[
      'assets/svgs/online-medical-consultation-male-svgrepo-com.svg',
      'assets/svgs/medical-examination-male-svgrepo-com.svg',
      'assets/svgs/male-doctor-to-guide-svgrepo-com.svg',
      'assets/svgs/heart-svgrepo-com.svg',
      'assets/svgs/kidney-svgrepo-com.svg',
      'assets/svgs/happy-2-svgrepo-com.svg',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('SVGs in Flutter')),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1,
              ),
              itemCount: assets.length,
              itemBuilder: (context, index) {
                final path = assets[index];
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Expanded(
                          child: SvgPicture.asset(
                            path,
                            fit: BoxFit.contain,
                            // You can override color here if the SVG paths are set up for currentColor / fill="currentColor"
                            // color: Colors.blue, // uncomment to force color
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          path.split('/').last,
                          style: const TextStyle(fontSize: 11),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Example of using loaded string SVG where we can modify it:
          Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const Text('Example: loaded SVG as string (you can edit it at runtime)'),
                const SizedBox(height: 8),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: _inlineSvg == null
                      ? const Center(child: CircularProgressIndicator())
                      : SvgPicture.string(
                          // if you want to force color across the svg, you could do simple replacements here
                          _inlineSvg!.replaceAll('fill="#F76D57"', 'fill="#1E88E5"'),
                          fit: BoxFit.contain,
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
