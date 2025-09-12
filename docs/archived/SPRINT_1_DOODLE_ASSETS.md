# Sprint 1 Doodle Assets Guide
## 14 Critical Medical & Mood Illustrations

### 🎨 **Asset Structure**
```
assets/
  doodles/
    sprint1/
      medical/           # 5 medical data doodles
        blood_pressure.svg
        kidney_function.svg  
        glucose.svg
        weight.svg
        medication.svg
      mood/              # 5 health mood doodles
        happy.svg
        okay.svg
        worried.svg
        energetic.svg
        discomfort.svg
      progress/          # 4 progress & celebration doodles
        weekly_progress.svg
        daily_goals.svg
        celebration.svg
        greeting.svg
```

### 📊 **Doodle Specifications**

#### **Medical Data Doodles (5 Essential)**

**1. Blood Pressure** (`blood_pressure.svg`)
- **Design**: Gentle heart shape with soft pulse waves
- **Style**: Rounded, warm heart with 2-3 curved pulse lines
- **Colors**: Primary: #FF6B6B (warm red), Secondary: #FFE5E5 (soft pink)
- **Usage**: Blood pressure tracking cards, charts, buttons

**2. Kidney Function** (`kidney_function.svg`) 
- **Design**: Stylized kidney bean with filtering water drops
- **Style**: Kidney shape with 3-4 small droplets flowing through
- **Colors**: Primary: #4ECDC4 (teal), Secondary: #E8F8F7 (light teal)
- **Usage**: Kidney function charts, GFR tracking

**3. Glucose/Sugar** (`glucose.svg`)
- **Design**: Water drop with gentle sparkles/stars around it
- **Style**: Teardrop shape with 4-5 small star/sparkle elements
- **Colors**: Primary: #45B7D1 (blue), Secondary: #E3F2FD (light blue)
- **Usage**: Glucose tracking, sugar level monitoring

**4. Weight** (`weight.svg`)
- **Design**: Soft, friendly scale or body silhouette
- **Style**: Either bathroom scale with smile or human figure outline
- **Colors**: Primary: #96CEB4 (green), Secondary: #FFEAA7 (light yellow)
- **Usage**: Weight tracking, BMI monitoring

**5. Medication** (`medication.svg`)
- **Design**: Pill bottle with caring hands embracing it
- **Style**: Bottle with 2 gentle hand shapes around it, heart on label
- **Colors**: Primary: #DDA0DD (purple), Secondary: #F8E8FF (light lavender)
- **Usage**: Medication reminders, adherence tracking

#### **Health Mood Doodles (5 Essential)**

**6. Health Mood Happy** (`happy.svg`)
- **Design**: Smiling sun with gentle rays
- **Style**: Circle with curved smile, 8 soft rays around
- **Colors**: Primary: #FFD93D (golden yellow), Secondary: #FFF8DC (cream)
- **Usage**: Mood check-in, positive health status

**7. Health Mood Okay** (`okay.svg`)
- **Design**: Gentle neutral face in soft circle
- **Style**: Simple circle with straight line mouth, calm eyes
- **Colors**: Primary: #A8E6CF (mint green), Secondary: #F0FFF0 (honeydew)
- **Usage**: Neutral health status, stable condition

**8. Health Mood Worried** (`worried.svg`)
- **Design**: Cloud with caring embrace/protection
- **Style**: Fluffy cloud with gentle arms/wings wrapping around
- **Colors**: Primary: #FFB347 (peach), Secondary: #FFF0E6 (papaya)
- **Usage**: Concerned health status, needs attention

**9. Energy High** (`energetic.svg`)
- **Design**: Lightning bolt with soft glow
- **Style**: Curved lightning with radiating energy lines
- **Colors**: Primary: #FF8C94 (coral), Secondary: #FFE5E7 (rose)
- **Usage**: High energy levels, active periods

**10. Pain/Discomfort** (`discomfort.svg`)
- **Design**: Healing bandage with love heart
- **Style**: Cross-shaped bandage with small heart in center
- **Colors**: Primary: #C7CEEA (lavender), Secondary: #F0F4FF (alice blue)
- **Usage**: Pain tracking, discomfort logging

#### **Progress & Celebration Doodles (4 Essential)**

**11. Weekly Progress** (`weekly_progress.svg`)
- **Design**: Mountain with flag at peak
- **Style**: Simple mountain silhouette with triangular flag
- **Colors**: Primary: #98D8C8 (mint), Secondary: #F7FFFD (mint cream)
- **Usage**: Weekly achievements, progress milestones

**12. Daily Goals** (`daily_goals.svg`)
- **Design**: Checklist with stars
- **Style**: Paper/clipboard with 3 checkmarks and star decorations
- **Colors**: Primary: #F7DC6F (banana), Secondary: #FFFBF0 (ivory)
- **Usage**: Daily task completion, goal tracking

**13. Milestone Celebration** (`celebration.svg`)
- **Design**: Trophy with gentle confetti
- **Style**: Cup trophy with 5-6 small confetti pieces around
- **Colors**: Primary: #BB8FCE (orchid), Secondary: #FAF0FF (lavender)
- **Usage**: Achievement celebrations, milestones reached

**14. Welcome/Greeting** (`greeting.svg`)
- **Design**: Waving hand with heart
- **Style**: Open palm hand with small heart floating above
- **Colors**: Primary: #F8C471 (sandy brown), Secondary: #FDF2E9 (seashell)
- **Usage**: Welcome screens, greeting messages

### 🎨 **Design Guidelines**

#### **Universal Style Rules**
- **Line Weight**: 2-3px stroke width
- **Corner Radius**: All corners rounded (4-8px radius)
- **Shadow**: Subtle drop shadow (2px offset, 4px blur, 10% opacity)
- **Size**: Designed for 48x48px base, scalable to 24px and 72px
- **Cultural Sensitivity**: Warm, non-threatening, family-friendly

#### **Color Palette (Calm Medical)**
```css
/* Primary Colors (Main doodle elements) */
--heart-red: #FF6B6B      /* Blood pressure */
--kidney-teal: #4ECDC4     /* Kidney function */
--glucose-blue: #45B7D1    /* Glucose */
--weight-green: #96CEB4    /* Weight */
--medication-purple: #DDA0DD /* Pills */

/* Mood Colors */
--happy-yellow: #FFD93D    /* Happy */
--calm-mint: #A8E6CF      /* Okay */
--worried-peach: #FFB347   /* Worried */
--energy-coral: #FF8C94    /* Energetic */
--comfort-lavender: #C7CEEA /* Discomfort */

/* Progress Colors */
--progress-mint: #98D8C8   /* Progress */
--goals-banana: #F7DC6F    /* Goals */
--celebration-orchid: #BB8FCE /* Celebration */
--greeting-sandy: #F8C471   /* Greeting */
```

### 📱 **Flutter Integration**

#### **pubspec.yaml**
```yaml
dependencies:
  flutter_svg: ^2.0.7

flutter:
  assets:
    - assets/doodles/sprint1/
```

#### **Usage Example**
```dart
import 'package:flutter_svg/flutter_svg.dart';

// Medical doodle
SvgPicture.asset(
  'assets/doodles/sprint1/medical/blood_pressure.svg',
  width: 32,
  height: 32,
  colorFilter: ColorFilter.mode(
    AppColors.heartRed,
    BlendMode.srcIn,
  ),
)

// Mood doodle with interaction
GestureDetector(
  onTap: () => _selectMood(HealthMood.happy),
  child: SvgPicture.asset(
    'assets/doodles/sprint1/mood/happy.svg',
    width: 40,
    height: 40,
  ),
)
```

### 🚀 **Implementation Priority**

#### **Week 1 (Sept 15-21): Medical + Mood (10 doodles)**
1. Blood Pressure
2. Kidney Function  
3. Glucose
4. Medication
5. Weight
6. Happy
7. Okay
8. Worried
9. Energetic
10. Discomfort

#### **Week 2 (Sept 22-28): Progress + Polish (4 doodles)**
11. Weekly Progress
12. Daily Goals
13. Celebration
14. Greeting

### ✅ **Delivery Checklist**

- [ ] All 14 SVG files created
- [ ] Files optimized for web (< 5KB each)
- [ ] Colors match design system
- [ ] SVGs tested at 24px, 48px, 72px sizes
- [ ] Cultural appropriateness validated
- [ ] Medical accuracy confirmed
- [ ] Assets integrated in Flutter project
- [ ] Doodle component library created

This gives you the complete specification for creating the 14 essential doodles needed for Sprint 1!
