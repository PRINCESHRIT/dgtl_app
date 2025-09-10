# Frontend Dashboard Development Roadmap
**CKD Clinical Wellness & Support Dashboard**

## 📋 Project Vision

**Goal:** Create a calming, empathetic wellness dashboard that transforms clinical monitoring into a gentle, supportive journey of health discovery and empowerment.

**Design Philosophy:** 
- **Emotional First:** Soft pastels, rounded edges, and organic shapes create safety and calm
- **Human Connection:** Personal greetings, cultural sensitivity, and growth-oriented language
- **Gentle Intelligence:** AI insights delivered with warmth, not clinical coldness

**Target Users:** 
- **Primary:** CKD patients seeking gentle self-monitoring and empowerment
- **Secondary:** Healthcare providers wanting compassionate patient engagement tools

---

## 🌸 Dashboard Architecture: Gentle 3-Garden Layout

### **Visual Metaphor:** *Three Gardens of Wellness*
```
┌─────────────────────────────────────────────────────────────┐
│           🌺 WELLNESS INSIGHTS GARDEN 🌺                    │
│              (Your AI Health Companion)                    │
│                      (Top 60%)                             │
├─────────────────────────┬───────────────────────────────────┤
│  🌱 DAILY CHECK-IN      │    📊 VITALS SANCTUARY           │
│     SANCTUARY           │    (Your Body's Story)            │
│   (How You Feel)        │      (Bottom 40%)                │
│    (Bottom 40%)         │                                   │
└─────────────────────────┴───────────────────────────────────┘
```

### **Design Language:**
- **Soft Pastel Palette:** Mint green, lavender, peach, cream, sky blue
- **Organic Shapes:** Rounded cards, bubble visualizations, flowing layouts  
- **Growth Metaphors:** Plants, gardens, blooming progress indicators
- **Emotional Color Coding:** 
  - 💚 Wellness/Normal → Mint Green
  - 💛 Attention Needed → Soft Peach  
  - 💜 Priority Care → Gentle Lavender

## �� Dashboard Architecture: 3-Block Layout

### **Layout Structure:**
```
┌─────────────────────────────────────────────────────────────┐
│                    AI RECOMMENDATION BLOCK                  │
│                         (Top 60%)                          │
├─────────────────────────┬───────────────────────────────────┤
│   SYMPTOM LOGGER BLOCK  │        VITALS BLOCK              │
│      (Bottom 40%)       │     (Bottom 40%)                 │
└─────────────────────────┴───────────────────────────────────┘
```

---

## 🌺 GARDEN 1: WELLNESS INSIGHTS GARDEN

### **Purpose:**
Your gentle AI health companion that delivers insights with warmth, hope, and actionable care guidance.

### **Component Breakdown:**

#### **1.1 Personal Welcome Grove** 
```
┌─────────────────────────────────────────────────────────────┐
│ 🌸 Hello, Sarah ✨ | Today is a new day for wellness       │
│ 🌱 Your health journey • Day 47 • Last check-in: 2 hours   │
└─────────────────────────────────────────────────────────────┘
```

**Implementation Requirements:**
- **Emotional Tone:** Warm greeting with name and gentle encouragement
- **Visual Identity:** Soft rounded card with gradient (peach to cream)
- **Micro-Animation:** Subtle glow on patient name, gentle bounce on emoji
- **Growth Language:** "journey," "wellness," "care" vs clinical terms
- **Responsive:** Maintains warmth on mobile with stacked, intimate layout

#### **1.2 Gentle Care Reminders Bloom**
```
┌─────────────────────────────────────────────────────────────┐
│ � Your Care Team Wants You to Know...                     │
│ 🌿 "Let's review your current medications together"         │
│ 💝 Your wellbeing matters - we're here to help             │
│ [Schedule Care Chat] • [Learn More] • [I'm Ready ✨]       │
└─────────────────────────────────────────────────────────────┘
```

**Implementation Requirements:**
- **Emotional Reframing:** "Care reminders" not "alerts," supportive tone
- **Visual Softness:** 
  - Background: Soft lavender gradient `#F3F0FF` to `#F8FAFC`
  - Border: Gentle purple `#A78BFA` with rounded corners
  - Icons: Hearts, leaves, sparkles instead of warning triangles
- **Micro-Interactions:** 
  - Soft pulsing glow (breathing effect) for attention
  - Button hover: gentle color bloom outward
  - Dismiss with gratitude message: "Thank you for caring for yourself 💚"

#### **1.3 Wellness Bubbles Garden**
```
┌─────────────┬─────────────┬─────────────────────────────────┐
│ 🌱 KIDNEY    │ 💧 ENERGY   │   🌸 CARE PRIORITY             │
│   HEALTH     │   FLOW      │                                │
│   Stage G4   │ 27.3 units  │     Gentle Attention           │
│ ●●●●○○○○○    │ ●●○○○○○     │   🤝 Let's work together       │
└─────────────┴─────────────┴─────────────────────────────────┘
```

**Implementation Requirements:**
- **Bubble Progress Bars:** Circles fill like water drops, not harsh bars
- **Emotional Language:** "Kidney Health," "Energy Flow," "Care Priority"  
- **Soft Color Gradients:**
  - Wellness: Mint green `#DCFCE7` to `#BBF7D0`
  - Attention: Peach `#FED7AA` to `#FDBA74`  
  - Priority: Lavender `#E9D5FF` to `#C4B5FD`
- **Micro-Animations:** Bubbles gently "breathe" (expand/contract)
- **Responsive:** Bubbles stack gracefully, maintaining organic feel

#### **1.4 Clinical Flags Panel**
```
┌─────────────────────────────────────────────────────────────┐
│ Clinical Flags: [predialysis_pathway] [BP_uncontrolled]     │
│                [CKD-MBD_active] [medication_safety_alert]   │
└─────────────────────────────────────────────────────────────┘
```

**Implementation Requirements:**
- **UI Pattern:** Pill-shaped tags
- **Interaction:** Clickable with hover effects
- **Color Coding:** Category-based colors (red for safety, orange for monitoring)
- **Filtering:** Click to filter related recommendations

#### **1.5 Recommendations Checklist**
```
┌─────────────────────────────────────────────────────────────┐
│ Clinical Recommendations:                                   │
│ ☐ Review and address high-risk medications                 │
│ ☐ Initiate predialysis education and planning              │
│ ☐ Optimize antihypertensive regimen                        │
│ ☐ Schedule nephrology consultation                          │
└─────────────────────────────────────────────────────────────┘
```

**Implementation Requirements:**
- **UI Pattern:** Interactive checkboxes
- **Functionality:** 
  - Check/uncheck with persistence
  - Due date indicators
  - Priority sorting
- **Styling:** Clear typography, proper spacing

#### **1.6 Guideline Evidence Cards**
```
┌─────────────────────────────────────────────────────────────┐
│ Evidence-Based Guidelines:                                   │
│ ┌─────────────────┐ ┌─────────────────┐                    │
│ │ KDIGO BP Guide  │ │ SGLT2i in CKD   │                    │
│ │ Similarity:100% │ │ Similarity: 85% │                    │
│ └─────────────────┘ └─────────────────┘                    │
└─────────────────────────────────────────────────────────────┘
```

**Implementation Requirements:**
- **UI Pattern:** Card grid layout
- **Content:** Document title, similarity score, preview snippet
- **Interaction:** Click to expand, external link capability
- **Styling:** Card shadows, hover effects

#### **1.7 Clinical Rationale Expandable Section**
```
┌─────────────────────────────────────────────────────────────┐
│ Clinical Rationale: [+] Expand Details                     │
│ ├─ Medication Safety: High-risk drugs identified...        │
│ ├─ CKD Stage: eGFR of 27.3 places patient in G4...        │
│ └─ BP Control: Latest reading 143/94 above target...       │
└─────────────────────────────────────────────────────────────┘
```

**Implementation Requirements:**
- **UI Pattern:** Collapsible accordion
- **Content:** Key-value pairs with detailed explanations
- **Styling:** Tree-like structure, indented details

---

## 📝 BLOCK 2: SYMPTOM LOGGER BLOCK

### **Purpose:**
Patient-friendly interface for logging symptoms, BP readings, and daily health metrics.

### **Component Breakdown:**

#### **2.1 Blood Pressure Trackpad**
```
┌─────────────────────────────────────────────────────────────┐
│ Blood Pressure Tracker                          📈 Graph    │
│ ┌─────────────┬─────────────┐                              │
│ │ Systolic    │ Diastolic   │  [Log Reading]               │
│ │    ___      │    ___      │                              │
│ │   /143\     │   /94 \     │                              │
│ └─────────────┴─────────────┘                              │
│ Latest: 143/94 mmHg | Status: ⚠️  HIGH | Time: 2:30 PM     │
└─────────────────────────────────────────────────────────────┘
```

**Implementation Requirements:**
- **Input Method:** 
  - Numeric keypad overlay for mobile
  - Stepper controls for desktop
  - Voice input capability (future)
- **Visualization:**
  - Mini chart showing last 7 readings
  - Color-coded status indicators
  - Target range overlay
- **Validation:** 
  - Range checking (50-300 systolic, 30-200 diastolic)
  - Alert for extremely high/low values

#### **2.2 Symptom Logging Panel**
```
┌─────────────────────────────────────────────────────────────┐
│ Daily Symptoms                                              │
│ ┌─────────────┬─────────────┬─────────────┬─────────────┐   │
│ │   Fatigue   │  Swelling   │ Fluid Intake│  Shortness  │   │
│ │  ●●●●○○○    │  ●●○○○○○    │   2.1 L     │  ●●●○○○○    │   │
│ │ Moderate    │    Mild     │   Normal    │  Moderate   │   │
│ └─────────────┴─────────────┴─────────────┴─────────────┘   │
│ [+ Add Custom Symptom] | Last Updated: 1 hour ago          │
└─────────────────────────────────────────────────────────────┘
```

**Implementation Requirements:**
- **Fatigue Tracker:**
  - 7-point scale (1=no fatigue, 7=extreme)
  - Quick tap interface
  - Visual progress bars
- **Swelling Monitor:**
  - Body part selector (legs, feet, hands, face)
  - Severity scale with visual cues
  - Photo comparison capability (future)
- **Fluid Intake Logger:**
  - Quick increment buttons (250ml, 500ml, 1L)
  - Visual measurement guide
  - Daily goal tracking with progress bar
- **Breathing Assessment:**
  - Shortness of breath scale
  - Activity correlation (at rest, mild activity, etc.)
  - Quick emergency contact for severe symptoms

#### **2.3 Additional Symptoms Panel**
```
┌─────────────────────────────────────────────────────────────┐
│ Other Symptoms:                                             │
│ □ Nausea      □ Dizziness    □ Headache    □ Sleep Issues   │
│ □ Appetite    □ Chest Pain   □ Weakness    [+ Custom]       │
│                                                             │
│ Notes: [Free text area for additional details...]          │
│ 📅 Schedule: Daily reminder at 8:00 PM                      │
└─────────────────────────────────────────────────────────────┘
```

**Implementation Requirements:**
- **UI Pattern:** Checkbox grid with quick selection
- **Custom Symptoms:** Free-text input with autocomplete
- **Notes Section:** Rich text editor with character limit
- **Scheduling:** Reminder notifications with customizable times

---

## 📊 BLOCK 3: VITALS BLOCK

### **Purpose:**
Comprehensive vital signs monitoring with normal range indicators and trend analysis.

### **Component Breakdown:**

#### **3.1 Core Vitals Dashboard**
```
┌─────────────────────────────────────────────────────────────┐
│ Vital Signs Overview                      📈 Trends View    │
│ ┌─────────────────┬─────────────────┬─────────────────┐     │
│ │     Weight      │   Temperature   │   Heart Rate    │     │
│ │   68.2 kg      │    98.6°F      │    72 BPM      │     │
│ │ ✅ Normal       │  ✅ Normal      │  ✅ Normal      │     │
│ │ Range: 65-75kg  │ Range: 97-99°F  │ Range: 60-100   │     │
│ └─────────────────┴─────────────────┴─────────────────┘     │
│                                                             │
│ ┌─────────────────┬─────────────────┬─────────────────┐     │
│ │  Oxygen Sat.    │  Blood Sugar    │    Sleep        │     │
│ │     98%        │    105 mg/dL   │   7.2 hours     │     │
│ │ ✅ Normal       │  ⚠️  Borderline │  ✅ Good        │     │
│ │ Range: 95-100%  │ Range: <100     │ Goal: 7-9 hrs   │     │
│ └─────────────────┴─────────────────┴─────────────────┘     │
└─────────────────────────────────────────────────────────────┘
```

**Implementation Requirements:**
- **Status Indicators:**
  - ✅ Green: Normal range
  - ⚠️ Orange: Borderline/Watch
  - 🔴 Red: Abnormal/Critical
- **Range Display:** 
  - Personalized ranges based on patient profile
  - CKD-specific normal ranges
- **Quick Entry:** 
  - One-tap logging for each vital
  - Smart defaults based on previous readings
- **Trends:** 
  - Mini sparkline charts
  - 7-day, 30-day, 90-day views

#### **3.2 Advanced Metrics Panel**
```
┌─────────────────────────────────────────────────────────────┐
│ CKD-Specific Metrics                                        │
│ ┌─────────────────┬─────────────────┬─────────────────┐     │
│ │  Urine Output   │   Protein       │   Creatinine    │     │
│ │   1.8 L/day    │  ++ (Moderate)  │   3.2 mg/dL    │     │
│ │ ⚠️ Low          │  🔴 High        │  🔴 High        │     │
│ │ Goal: >2L       │  Goal: Trace    │  Baseline: 2.5  │     │
│ └─────────────────┴─────────────────┴─────────────────┘     │
│                                                             │
│ Last Lab Results: April 15, 2024 | Next Due: Sept 15, 2024 │
└─────────────────────────────────────────────────────────────┘
```

**Implementation Requirements:**
- **CKD Focus:** 
  - Kidney-specific vital ranges
  - Progression indicators
  - Target goals based on CKD stage
- **Lab Integration:** 
  - Manual entry for home tests
  - Import from lab reports (OCR future feature)
  - Due date reminders

---

## 🔄 SHARED FUNCTIONALITY: ACTION BUTTONS

### **Upload Lab Report Button**
```
┌─────────────────────────────────────────────────────────────┐
│                    [📤 Upload Lab Report]                    │
│        Drag & drop PDF or take photo of paper report       │
└─────────────────────────────────────────────────────────────┘
```

**Implementation Requirements:**
- **File Types:** PDF, JPG, PNG
- **Processing:** OCR text extraction (future), manual entry fallback
- **Validation:** Lab result format checking
- **Storage:** Secure, encrypted file storage

### **Download Combined Report Button**
```
┌─────────────────────────────────────────────────────────────┐
│                  [📥 Download Full Report]                   │
│      Generate PDF: Clinical Analysis + Patient Data        │
└─────────────────────────────────────────────────────────────┘
```

**Implementation Requirements:**
- **Format:** PDF with clinical formatting
- **Content:** All AI recommendations + logged symptoms + vitals
- **Branding:** Professional medical report layout
- **Sharing:** Email, print, secure portal integration

---

## 📱 Technical Implementation Roadmap

### **Phase 1: Foundation (Week 1-2)**
- [ ] Set up responsive grid layout (3-block structure)
- [ ] Implement Patient Header with real-time data
- [ ] Create basic stat cards for Key Indicators
- [ ] Build expandable/collapsible component system

### **Phase 2: AI Recommendation Block (Week 3-4)**
- [ ] Urgent Safety Alerts Banner with animation
- [ ] Clinical Flags as interactive tags
- [ ] Recommendations checklist with persistence
- [ ] Guideline Evidence cards with modal popups
- [ ] Clinical Rationale accordion

### **Phase 3: Symptom Logger Block (Week 5-6)**
- [ ] Blood Pressure numeric trackpad with validation
- [ ] Symptom severity sliders and quick-tap interface
- [ ] Fluid intake tracker with visual measurements
- [ ] Custom symptom entry with autocomplete
- [ ] Mini-chart visualizations for trends

### **Phase 4: Vitals Block (Week 7-8)**
- [ ] Core vitals dashboard with status indicators
- [ ] CKD-specific metrics panel
- [ ] Range customization based on patient profile
- [ ] Trend analysis with multiple time periods
- [ ] Integration with uploaded lab data

### **Phase 5: Integration & Polish (Week 9-10)**
- [ ] Upload Lab Report functionality with file processing
- [ ] Download Combined Report PDF generation
- [ ] Mobile responsiveness optimization
- [ ] Performance optimization and caching
- [ ] User testing and refinement

### **Phase 6: Advanced Features (Week 11-12)**
- [ ] Real-time notifications for critical values
- [ ] Voice input for symptom logging
- [ ] Medication reminder integration
- [ ] Export to healthcare provider portals
- [ ] Accessibility compliance (WCAG 2.1)

---

## 🎨 Design System Requirements

### **Color Palette:**
- **Primary:** `#2563EB` (Medical Blue)
- **Success:** `#16A34A` (Normal/Good)
- **Warning:** `#EA580C` (Borderline/Watch)
- **Danger:** `#DC2626` (Critical/High Risk)
- **Background:** `#F8FAFC` (Light Gray)
- **Text:** `#1E293B` (Dark Blue-Gray)

### **Typography:**
- **Headers:** Inter, 24px-32px, Semi-bold
- **Body:** Inter, 14px-16px, Regular
- **Data Values:** JetBrains Mono, 18px-24px, Medium
- **Small Text:** Inter, 12px, Regular

### **Component Library:**
- **Stat Cards:** Shadow, rounded corners, hover effects
- **Buttons:** Primary, secondary, danger variants
- **Inputs:** Form validation, error states
- **Charts:** Consistent color scheme, responsive
- **Modals:** Overlay with backdrop blur

---

## 📊 API Integration Requirements

### **Expected Data Endpoints:**

1. **Patient Analysis:** `GET /api/patient/{id}/analysis`
2. **Symptom Logging:** `POST /api/patient/{id}/symptoms`
3. **Vitals Recording:** `POST /api/patient/{id}/vitals`
4. **Lab Upload:** `POST /api/patient/{id}/lab-reports`
5. **Report Generation:** `GET /api/patient/{id}/report.pdf`

### **Real-time Updates:**
- **WebSocket connection** for live vital monitoring
- **Push notifications** for critical alerts
- **Auto-save** for all form inputs

---

## 🚀 Success Metrics

### **Performance Targets:**
- [ ] Page load time: <2 seconds
- [ ] Chart rendering: <500ms
- [ ] Form submission: <1 second
- [ ] Mobile responsiveness: 100% feature parity

### **User Experience Goals:**
- [ ] Symptom logging completion rate: >80%
- [ ] Critical alert response time: <30 seconds
- [ ] Healthcare provider satisfaction: >90%
- [ ] Patient engagement: Daily usage >70%

This roadmap provides a comprehensive foundation for building a world-class CKD clinical decision support dashboard that combines AI insights with practical patient monitoring tools.
