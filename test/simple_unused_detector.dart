// Simple Unused Files Detector for Database + AI/ML/RAG + Backend
// Finds files that exist but are never imported or used

import 'dart:io';

void main() async {
  print('🔍 DGTL Healthcare Unused Files Analysis');
  print('=========================================');
  
  // Step 1: Get all relevant files in our integration areas
  print('\n1️⃣  Scanning Database + AI/ML/RAG + Backend files...');
  
  final coreFiles = <String>[];
  final fileContents = <String, String>{};
  
  // Define the core integration directories
  final targetDirs = [
    'lib/core/database',
    'lib/core/ai', 
    'lib/core/services',
    'lib/core/api',
    'lib/services',
    'lib/features/ai_chat',
  ];
  
  // Collect all Dart files in these directories
  for (final dirPath in targetDirs) {
    final dir = Directory(dirPath);
    if (await dir.exists()) {
      await for (final entity in dir.list(recursive: true)) {
        if (entity is File && entity.path.endsWith('.dart')) {
          final filePath = entity.path;
          coreFiles.add(filePath);
          
          try {
            fileContents[filePath] = await entity.readAsString();
            print('   📄 Found: ${filePath.replaceAll('/Users/shrit/dgtl_app/lib/', '')}');
          } catch (e) {
            print('   ⚠️  Could not read: $filePath');
          }
        }
      }
    } else {
      print('   📁 Directory not found: $dirPath');
    }
  }
  
  print('\n   📊 Total files found: ${coreFiles.length}');
  
  // Step 2: Check which files are imported by other files
  print('\n2️⃣  Checking import usage...');
  
  final usedFiles = <String>{};
  final allDartFiles = <String>[];
  
  // Get all Dart files in the project for import checking
  final libDir = Directory('lib');
  if (await libDir.exists()) {
    await for (final entity in libDir.list(recursive: true)) {
      if (entity is File && entity.path.endsWith('.dart')) {
        allDartFiles.add(entity.path);
      }
    }
  }
  
  // Check each file for imports
  for (final dartFile in allDartFiles) {
    try {
      final content = await File(dartFile).readAsString();
      
      // Look for import statements (simple string matching)
      final lines = content.split('\n');
      for (final line in lines) {
        if (line.trim().startsWith('import ') && !line.contains('dart:') && !line.contains('package:')) {
          // Extract the import path
          final importMatch = line.indexOf("'");
          final importMatch2 = line.indexOf('"');
          
          var startIndex = -1;
          var endIndex = -1;
          var quote = '';
          
          if (importMatch != -1 && (importMatch2 == -1 || importMatch < importMatch2)) {
            startIndex = importMatch + 1;
            endIndex = line.indexOf("'", startIndex);
            quote = "'";
          } else if (importMatch2 != -1) {
            startIndex = importMatch2 + 1;
            endIndex = line.indexOf('"', startIndex);
            quote = '"';
          }
          
          if (startIndex != -1 && endIndex != -1) {
            var importPath = line.substring(startIndex, endIndex);
            
            // Convert relative import to absolute path
            if (importPath.startsWith('../')) {
              final currentDirParts = dartFile.split('/');
              currentDirParts.removeLast(); // Remove filename
              
              final importParts = importPath.split('/');
              for (final part in importParts) {
                if (part == '..') {
                  if (currentDirParts.isNotEmpty) currentDirParts.removeLast();
                } else if (part != '.' && part.isNotEmpty) {
                  currentDirParts.add(part);
                }
              }
              
              importPath = currentDirParts.join('/');
              if (!importPath.endsWith('.dart')) {
                importPath += '.dart';
              }
              
              // Check if this matches any of our core files
              for (final coreFile in coreFiles) {
                if (coreFile.endsWith(importPath)) {
                  usedFiles.add(coreFile);
                  print('   ✅ Used: ${coreFile.replaceAll('/Users/shrit/dgtl_app/lib/', '')} (imported by ${dartFile.replaceAll('/Users/shrit/dgtl_app/lib/', '')})');
                }
              }
            }
          }
        }
      }
    } catch (e) {
      // Skip files that can't be read
    }
  }
  
  // Step 3: Find unused files
  print('\n3️⃣  Identifying unused files...');
  
  final unusedFiles = <String>[];
  
  for (final coreFile in coreFiles) {
    if (!usedFiles.contains(coreFile)) {
      // Check if it's a special file (main, export, etc.)
      final fileName = coreFile.split('/').last;
      final content = fileContents[coreFile] ?? '';
      
      var isSpecial = false;
      
      if (fileName.contains('main.dart') || fileName.contains('_main.dart')) {
        print('   📄 Special (Main): ${coreFile.replaceAll('/Users/shrit/dgtl_app/lib/', '')}');
        isSpecial = true;
      } else if (content.contains('export ')) {
        print('   📄 Special (Export): ${coreFile.replaceAll('/Users/shrit/dgtl_app/lib/', '')}');
        isSpecial = true;
      } else if (coreFile.contains('test/') || fileName.endsWith('_test.dart')) {
        print('   📄 Special (Test): ${coreFile.replaceAll('/Users/shrit/dgtl_app/lib/', '')}');
        isSpecial = true;
      }
      
      if (!isSpecial) {
        unusedFiles.add(coreFile);
      }
    }
  }
  
  // Step 4: Analyze unused files
  print('\n4️⃣  Analyzing unused files...');
  
  if (unusedFiles.isEmpty) {
    print('   🎉 No unused files found! All integration files are being used.');
  } else {
    for (final file in unusedFiles) {
      final content = fileContents[file] ?? '';
      final lines = content.split('\n').length;
      final hasClass = content.contains('class ');
      final fileName = file.split('/').last;
      
      print('   ❌ UNUSED: ${file.replaceAll('/Users/shrit/dgtl_app/lib/', '')}');
      print('      📊 $lines lines, ${content.length} chars');
      print('      🔧 Has class: $hasClass');
      print('      💡 Safe to delete: ${!hasClass || lines < 50 ? 'YES' : 'REVIEW FIRST'}');
      print('');
    }
  }
  
  // Final summary
  print('\n📊 FINAL RESULTS:');
  print('==================');
  print('📁 Total core files: ${coreFiles.length}');
  print('✅ Files being used: ${usedFiles.length}');
  print('❌ Unused files: ${unusedFiles.length}');
  
  if (unusedFiles.isNotEmpty) {
    final totalUnusedLines = unusedFiles
        .map((f) => fileContents[f]!.split('\n').length)
        .reduce((a, b) => a + b);
    
    print('\n💡 Cleanup opportunity:');
    print('   🗑️  $totalUnusedLines lines of unused code');
    print('   📝 Files to review for deletion: ${unusedFiles.length}');
  } else {
    print('\n🎉 Perfect! No unused files in your Database + AI/ML/RAG + Backend integration!');
  }
}
