# Frontend UI/UX Requirements Document
**CKD Clinical Decision Support Dashboard**

## 📋 Executive Summary

**Project Goal:** Develop a modern, intuitive clinical dashboard that seamlessly integrates with our Dart-based backend AI analysis engine to provide real-time clinical decision support for CKD patients and healthcare providers.

**Design Philosophy:** Medical-grade functionality with consumer-app usability, inspired by modern mental health apps' approachable design patterns.

---

## 🎯 Target Users & Use Cases

### **Primary Users: Healthcare Providers**
- **Nephrologists:** Need instant clinical insights, medication alerts, and evidence-based recommendations
- **Nurses:** Require quick vital entry, symptom tracking, and patient status monitoring
- **Medical Assistants:** Need efficient data entry and report generation capabilities

### **Secondary Users: CKD Patients**
- **Self-monitoring:** Daily symptom logging, vitals tracking, medication adherence
- **Health awareness:** Understanding lab results, tracking progress, engaging with care plans

---

## 🏗️ Architecture Integration Requirements

### **Backend API Integration Points**

#### **Real-Time Clinical Analysis API**
```typescript
// Primary Analysis Endpoint
GET /api/patient/{patientId}/clinical-analysis
Response: {
  ckdStage: string,
  egfr: number,
  actionPriority: 'Urgent' | 'NearTerm' | 'Routine',
  clinicalFlags: string[],
  recommendations: string[],
  medicationSafetyWarnings: MedicationAlert[],
  guidelineSearchResults: GuidelineDocument[],
  rationale: Record<string, string>,
  lastUpdated: timestamp
}
```

#### **Patient Data Management APIs**
```typescript
// Symptom Logging
POST /api/patient/{patientId}/symptoms
Body: {
  date: string,
  bloodPressure?: { systolic: number, diastolic: number },
  symptoms: { type: string, severity: 1-7, notes?: string }[],
  fluidIntake?: number,
  customSymptoms?: string[]
}

// Vitals Recording
POST /api/patient/{patientId}/vitals
Body: {
  weight?: number,
  temperature?: number,
  heartRate?: number,
  oxygenSaturation?: number,
  bloodSugar?: number,
  sleepHours?: number,
  urineOutput?: number
}

// Lab Report Upload
POST /api/patient/{patientId}/lab-reports
Body: FormData with file upload + metadata
```

#### **WebSocket Real-Time Updates**
```typescript
// WebSocket connection for live updates
ws://api-domain/ws/patient/{patientId}
Events: {
  'clinical-analysis-updated': ClinicalAnalysis,
  'medication-alert': MedicationAlert,
  'vital-threshold-exceeded': VitalAlert
}
```

---

## 🎨 Design System Specifications

### **Color Palette (Medical + Approachable)**
```css
/* Primary Medical Colors */
--medical-blue: #2563EB;
--medical-blue-light: #DBEAFE;

/* Status Colors */
--success-green: #16A34A;
--success-light: #DCFCE7;
--warning-orange: #EA580C;
--warning-light: #FED7AA;
--danger-red: #DC2626;
--danger-light: #FEF2F2;

/* Soft Backgrounds (Mental Health App Inspired) */
--bg-peach: #FEF7ED;
--bg-mint: #F0FDF4;
--bg-lavender: #F5F3FF;
--bg-cream: #FFFBEB;

/* Neutral Grays */
--gray-50: #F8FAFC;
--gray-100: #F1F5F9;
--gray-700: #374151;
--gray-900: #1E293B;
```

### **Typography Scale**
```css
/* Headers */
--font-header: 'Inter', sans-serif;
--size-xl: 32px; /* Main dashboard title */
--size-lg: 24px; /* Section headers */
--size-md: 18px; /* Card titles */

/* Body Text */
--font-body: 'Inter', sans-serif;
--size-base: 16px; /* Regular text */
--size-sm: 14px; /* Secondary text */
--size-xs: 12px; /* Timestamps, labels */

/* Data Values */
--font-mono: 'JetBrains Mono', monospace;
--size-data-lg: 24px; /* Key metrics */
--size-data-md: 18px; /* Regular values */
```

### **Component Specifications**

#### **Stat Cards (Key Indicators)**
```css
.stat-card {
  background: white;
  border-radius: 12px;
  box-shadow: 0 1px 3px rgba(0,0,0,0.1);
  padding: 24px;
  min-height: 120px;
}

.stat-value {
  font-size: var(--size-data-lg);
  font-weight: 600;
  font-family: var(--font-mono);
}

.stat-label {
  font-size: var(--size-sm);
  color: var(--gray-700);
  text-transform: uppercase;
  letter-spacing: 0.05em;
}
```

#### **Alert Banners (Medication Safety)**
```css
.alert-urgent {
  background: var(--danger-light);
  border: 2px solid var(--danger-red);
  border-radius: 8px;
  padding: 16px;
  margin-bottom: 24px;
  animation: subtle-pulse 2s infinite;
}

@keyframes subtle-pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.95; }
}
```

#### **Clinical Flags (Pill Tags)**
```css
.clinical-flag {
  display: inline-flex;
  align-items: center;
  padding: 6px 12px;
  border-radius: 20px;
  font-size: var(--size-xs);
  font-weight: 500;
  margin: 4px;
  transition: all 0.2s ease;
}

.flag-safety { background: var(--danger-light); color: var(--danger-red); }
.flag-monitoring { background: var(--warning-light); color: var(--warning-orange); }
.flag-normal { background: var(--success-light); color: var(--success-green); }
```

---

## 📱 Layout & Responsive Design

### **3-Block Dashboard Layout**
```css
.dashboard-container {
  display: grid;
  grid-template-areas: 
    "ai-block ai-block"
    "symptom-block vitals-block";
  grid-template-rows: 60vh 40vh;
  grid-template-columns: 1fr 1fr;
  gap: 24px;
  padding: 24px;
}

/* Mobile Responsive */
@media (max-width: 768px) {
  .dashboard-container {
    grid-template-areas: 
      "ai-block"
      "symptom-block"
      "vitals-block";
    grid-template-rows: auto auto auto;
    grid-template-columns: 1fr;
  }
}
```

### **Component Responsive Behavior**
- **Stat Cards:** 3-column desktop → 1-column mobile (stack vertically)
- **Alert Banners:** Full-width on all devices, increase padding on mobile
- **Input Controls:** Touch-friendly 44px minimum hit targets on mobile
- **Charts:** Maintain aspect ratio, reduce complexity on small screens

---

## 🔄 Real-Time Data Integration

### **State Management Requirements**
```typescript
// Global State Structure
interface DashboardState {
  patient: {
    id: string;
    profile: PatientProfile;
    lastUpdated: Date;
  };
  clinicalAnalysis: {
    data: ClinicalAnalysis | null;
    loading: boolean;
    error: string | null;
  };
  symptoms: {
    entries: SymptomEntry[];
    submitting: boolean;
  };
  vitals: {
    entries: VitalEntry[];
    submitting: boolean;
  };
  alerts: {
    active: Alert[];
    dismissed: string[];
  };
}
```

### **Real-Time Update Patterns**
1. **WebSocket Connection:** Establish on dashboard mount, reconnect on disconnect
2. **Optimistic Updates:** Show user input immediately, reconcile with server response
3. **Error Handling:** Graceful degradation with offline indicators
4. **Loading States:** Skeleton screens for initial load, spinner overlays for updates

---

## 🎯 Component-Specific Requirements

### **AI Recommendation Block (Top 60%)**

#### **Urgent Safety Alerts Banner**
```tsx
interface MedicationAlert {
  medicationName: string;
  severity: 'High' | 'Moderate' | 'Low';
  warning: string;
  actionRequired: string;
}

// Visual Requirements:
// - Prominent red border and background
// - Blinking animation for critical alerts
// - Dismiss button with confirmation modal
// - Auto-expand if multiple alerts (max 3 visible)
```

#### **Key Indicators Dashboard**
```tsx
interface KeyIndicators {
  ckdStage: string;
  egfr: number;
  actionPriority: 'Urgent' | 'NearTerm' | 'Routine';
}

// Visual Requirements:
// - Large, bold numbers (32px font)
// - Color-coded priority indicators
// - Hover effects showing additional context
// - Mobile: stack vertically with consistent spacing
```

#### **Clinical Flags Panel**
```tsx
// Interactive pill-shaped tags
// - Click to filter related recommendations
// - Hover shows detailed explanation tooltip
// - Category-based color coding
// - Max 2 rows, scroll horizontally if overflow
```

#### **Recommendations Checklist**
```tsx
interface Recommendation {
  id: string;
  text: string;
  priority: number;
  completed: boolean;
  dueDate?: Date;
}

// Requirements:
// - Persistent check state (save to backend)
// - Priority sorting (urgent first)
// - Due date indicators with color coding
// - Bulk actions (mark all complete)
```

### **Symptom Logger Block (Bottom Left 40%)**

#### **Blood Pressure Trackpad**
```tsx
// Input Requirements:
// - Numeric keypad overlay on mobile
// - Validation: systolic 50-300, diastolic 30-200
// - Visual feedback for out-of-range values
// - Mini trend chart (last 7 readings)
// - One-tap "Log Reading" button
```

#### **Symptom Severity Sliders**
```tsx
interface SymptomEntry {
  type: 'fatigue' | 'swelling' | 'shortness_of_breath';
  severity: 1 | 2 | 3 | 4 | 5 | 6 | 7;
  bodyPart?: string; // for swelling
  notes?: string;
}

// Visual Requirements:
// - 7-dot slider with labels (None → Extreme)
// - Quick-tap for common values
// - Visual progress indicators (filled circles)
// - Color gradient from green to red
```

#### **Fluid Intake Logger**
```tsx
// Requirements:
// - Quick increment buttons (250ml, 500ml, 1L)
// - Visual measurement guide (water bottle icons)
// - Daily goal progress bar
// - Running total display
// - Reset button for new day
```

### **Vitals Block (Bottom Right 40%)**

#### **Core Vitals Dashboard**
```tsx
interface VitalReading {
  type: 'weight' | 'temperature' | 'heartRate' | 'oxygenSat' | 'bloodSugar' | 'sleep';
  value: number;
  unit: string;
  timestamp: Date;
  status: 'normal' | 'borderline' | 'abnormal';
  normalRange: { min: number; max: number };
}

// Visual Requirements:
// - 2x3 grid layout
// - Status icons: ✅ (green), ⚠️ (orange), 🔴 (red)
// - Normal range display under each value
// - Mini sparkline trends (7-day history)
// - One-tap edit mode for quick updates
```

---

## 🔌 Backend Integration Specifications

### **API Error Handling**
```typescript
// Standard Error Response Format
interface APIError {
  code: string;
  message: string;
  details?: Record<string, any>;
}

// Frontend Error Handling:
// - Network errors: Show retry button with exponential backoff
// - Validation errors: Highlight specific form fields
// - Server errors: Show generic error message with support contact
// - Authentication errors: Redirect to login
```

### **Data Synchronization**
```typescript
// Offline-First Pattern
// - Cache all GET responses in localStorage
// - Queue POST/PUT requests when offline
// - Sync queued requests when connection restored
// - Show offline indicator in header
// - Optimistic updates with rollback on error
```

### **Performance Requirements**
- **Initial Load:** < 2 seconds for dashboard with cached data
- **Real-time Updates:** < 500ms from WebSocket event to UI update
- **Form Submissions:** < 1 second response time with loading indicators
- **Chart Rendering:** < 300ms for vitals charts and trend visualizations

---

## 📊 Data Visualization Requirements

### **Chart Library Integration**
```typescript
// Recommended: Chart.js or D3.js for custom visualizations
// Requirements:
// - Responsive design (maintain aspect ratio)
// - Accessibility (screen reader support)
// - Color-blind friendly palette
// - Touch-friendly interactions on mobile
// - Export functionality (PNG/PDF)
```

### **Trend Visualization Patterns**
- **Blood Pressure:** Line chart with target range shading
- **Symptom Severity:** Horizontal bar chart with color gradients
- **Vital Signs:** Sparkline micro-charts in stat cards
- **Medication Adherence:** Calendar heatmap (future feature)

---

## 🔒 Security & Privacy Requirements

### **Data Handling**
- **No PHI in localStorage:** Only store non-sensitive UI state
- **API Token Management:** Secure token storage with automatic refresh
- **Audit Logging:** Track all user interactions for compliance
- **Session Management:** Auto-logout after 30 minutes of inactivity

### **HIPAA Compliance**
- **Encrypted Communication:** All API calls over HTTPS
- **Access Controls:** Role-based component visibility
- **Data Minimization:** Only request necessary patient data
- **Breach Notification:** Clear error messages without exposing sensitive data

---

## 🚀 Development Priorities

### **Phase 1: Core Dashboard (Weeks 1-2)**
1. ✅ Three-block responsive layout
2. ✅ Patient header with real-time data
3. ✅ Basic stat cards for key indicators
4. ✅ WebSocket connection setup
5. ✅ Error boundary implementation

### **Phase 2: AI Integration (Weeks 3-4)**
1. 🔄 Medication safety alerts banner
2. 🔄 Clinical flags as interactive pills
3. 🔄 Recommendations checklist with persistence
4. 🔄 Guideline evidence cards
5. 🔄 Clinical rationale accordion

### **Phase 3: Data Entry (Weeks 5-6)**
1. 📝 Blood pressure numeric input
2. 📝 Symptom severity sliders
3. 📝 Fluid intake quick-entry
4. 📝 Vitals dashboard with status indicators
5. 📝 Form validation and error handling

### **Phase 4: Polish & Performance (Weeks 7-8)**
1. 🎨 Animation and micro-interactions
2. 🎨 Mobile optimization
3. 🎨 Accessibility compliance
4. 🎨 Performance optimization
5. 🎨 User testing integration

---

## 📋 Acceptance Criteria

### **Functional Requirements**
- [ ] All backend API endpoints integrate successfully
- [ ] Real-time updates work without page refresh
- [ ] Form submissions save correctly and show confirmation
- [ ] Medication alerts display prominently and persistently
- [ ] Charts render correctly on all screen sizes

### **Performance Requirements**
- [ ] Lighthouse score > 90 for Performance, Accessibility, Best Practices
- [ ] First Contentful Paint < 1.5 seconds
- [ ] Cumulative Layout Shift < 0.1
- [ ] All interactions respond within 100ms

### **Cross-Browser Compatibility**
- [ ] Chrome, Firefox, Safari, Edge (latest 2 versions)
- [ ] iOS Safari, Chrome Mobile (latest versions)
- [ ] Responsive design works 320px - 1920px viewport widths

---

## 💬 Communication & Handoff

### **Regular Sync Points**
- **Daily standups:** Progress updates and blocker identification
- **Weekly demos:** Show working features to clinical stakeholders
- **Bi-weekly retrospectives:** Process improvements and lessons learned

### **Documentation Requirements**
- **Component library:** Storybook with all reusable components
- **API integration guide:** Examples for each endpoint
- **Deployment guide:** Step-by-step production deployment
- **User guide:** Screenshots and workflows for end users

---

This requirements document provides the frontend team with everything needed to build a clinically-accurate, user-friendly dashboard that seamlessly integrates with your Dart backend infrastructure. The focus on real-time data integration, medical-grade reliability, and consumer-app usability will ensure successful adoption by both healthcare providers and patients.
