import re

# Read the file
with open('lib/app/theme.dart', 'r') as f:
    content = f.read()

# Fix duplicate surface parameter (keep first one, comment second)
content = re.sub(r'(surface: surfaceColor,\s+)(surface: backgroundColor,)', 
                 r'\1// \2 // Removed duplicate', content)

# Fix duplicate onSurface parameter (keep first one, comment second)  
lines = content.split('\n')
onSurface_count = 0
for i, line in enumerate(lines):
    if 'onSurface: textPrimary,' in line:
        onSurface_count += 1
        if onSurface_count > 1:
            lines[i] = lines[i].replace('onSurface: textPrimary,', '// onSurface: textPrimary, // Removed duplicate')

content = '\n'.join(lines)

# Write back
with open('lib/app/theme.dart', 'w') as f:
    f.write(content)

print("Fixed theme.dart duplicates")
