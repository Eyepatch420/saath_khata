SaathKhata — Product Requirements Document  **CONFIDENTIAL**

📒

**SaathKhata**

The Two-Sided Shared Ledger App for India

Product Requirements Document  |  Version 1.0  |  May 2026

|**Document Type**|Product Requirements Document (PRD)|
| :- | :- |
|**Product Name**|SaathKhata|
|**Version**|1\.0 — Initial Release|
|**Prepared For**|Development Team / Tech Partner|
|**Target Platforms**|Android (primary) · iOS · Progressive Web App|
|**Target Markets**|India — Tier 1, 2, and 3 cities|
|**Status**|Ready for Development|


# **1. Executive Summary**

SaathKhata is a two-sided digital ledger mobile application designed for the Indian informal economy. Unlike existing apps (OkCredit, KhataBook) where only the vendor records transactions and customers are passive recipients of SMS alerts, SaathKhata creates a shared, mutually visible ledger — the vendor records a delivery, the customer sees it in real time, confirms or disputes it, and both parties always see the same truth.

The app also serves as a full business management suite — handling staff payroll, labour attendance, appointment booking, bill OCR scanning, voice entries in 12 Indian languages, UPI-integrated payments, and detailed analytics — all in one platform.

## **1.1  The Problem**
India's informal economy runs on trust-based credit. A milkman, presswala, maid, kirana, or tiffin vendor keeps a physical khata (ledger). Disputes are extremely common — customers claim fewer deliveries than the vendor recorded. There is no shared source of truth. Existing digital ledger apps only digitize the vendor's side, ignoring the customer entirely.

## **1.2  The Solution**
SaathKhata introduces the concept of a Linked Shared Ledger — when a vendor and customer connect on the platform, every entry made by the vendor is instantly visible to the customer. The customer can confirm or dispute entries. Confirmed entries are immutably locked. Both parties always see the same running balance. Month-end payment is a single UPI tap.

## **1.3  Key Differentiators**
- First two-sided ledger in India — vendor + customer both see the same records
- Voice entry in 12 Indian languages (Hindi, Bangla, Marathi, Tamil, Telugu, Kannada, Gujarati, Punjabi, Odia, Malayalam, Bhojpuri, Maithili)
- Bill OCR — photograph any receipt to auto-create an entry
- Integrated staff/labour management with daily wage and monthly salary tracking
- Appointment booking system for service-based vendors (salons, tiffin, etc.)
- UPI-native payment collection with one-tap month-end settlement
- Immutable audit trail — confirmed entries cannot be edited by either party
- Credit scoring from ledger history (future fintech integration)


# **2. Product Overview**

## **2.1  App Name & Branding**

|**App Name**|SaathKhata (साथ खाता)|
| :- | :- |
|**Tagline**|"Ek Khata, Dono Ka" (One Ledger, For Both)|
|**Primary Color**|#00C896 (Teal Green)|
|**Secondary Color**|#0F2027 (Deep Navy)|
|**App Icon**|📒 Ledger book with two-person silhouette|
|**Tone**|Trustworthy, Simple, Indian, Warm|

## **2.2  Target Users**
SaathKhata serves two distinct user types who are linked to each other:

|**🏪  VENDOR / SUPPLIER**|**👤  CUSTOMER / BUYER**|
| :- | :- |
|<p>- Milkman / Dairy</p><p>- Presswala / Dhobi</p><p>- Maid / Cook / Helper</p><p>- Newspaper Vendor</p><p>- Water Can Supplier</p><p>- Tiffin Service</p><p>- Kirana / Grocery</p><p>- Salon / Parlour</p><p>- Construction Contractor</p><p>- Any small business owner</p>|<p>- Households using any of the above services</p><p>- Anyone who buys on credit from local vendors</p><p>- People who want transparency in their running tabs</p><p>- Customers who want one-tap UPI payment settlement</p><p>- Users who want to track all their vendor balances in one place</p>|

## **2.3  Supported Vendor Categories**

|**Milk / Dairy**|Daily delivery tracking with quantity, fat %, and amount per delivery|
| :- | :- |
|**Press / Dhobi**|Per-item ironing log — shirt, pant, saree, etc.|
|**Maid / Cook**|Daily attendance with part-day support and monthly salary|
|**Newspaper**|Daily / alternate-day / Sunday delivery tracking|
|**Water Can**|Per-can count and monthly total|
|**Tiffin / Food**|Daily meal delivery with menu variants (veg/non-veg, thali size)|
|**Kirana / Grocery**|Running tab / udhar with itemized bills via OCR|
|**Salon / Parlour**|Appointment booking + service-wise billing|
|**Construction Labour**|Daily wage tracking, advance payment, deductions|
|**Transport / Auto**|Monthly or per-trip billing for regular commute|


# **3. UI Screen Designs**

Below are the complete UI mockups for all key screens of the SaathKhata app. All screens are designed for mobile-first (390 × 844 px — iPhone 14 Pro standard).

## **3.1  Splash Screen & Onboarding**

|<p>![](Aspose.Words.e230e6d3-096c-46b7-8cc7-192ec2db67b7.001.png)</p><p>*Fig 1: Splash Screen*</p>|<p>![](Aspose.Words.e230e6d3-096c-46b7-8cc7-192ec2db67b7.002.png)</p><p>*Fig 2: Role Selection & Language*</p>|
| :-: | :-: |

The splash screen establishes brand identity. Users immediately choose their role (Vendor or Customer) and their preferred language. The app supports 12 Indian languages from the very first screen — language selection persists throughout the session and is saved to profile.

## **3.2  Vendor Dashboard**
![](Aspose.Words.e230e6d3-096c-46b7-8cc7-192ec2db67b7.003.png)

*Fig 3: Vendor Dashboard — Overview of collections, deliveries & quick actions*

The vendor dashboard shows today's delivery status per customer, total outstanding balance, amount collected today, and quick-action buttons for adding entries, voice entry, scanning bills, and sending bulk reminders. The floating action button provides instant access to add a new transaction.

## **3.3  Customer Dashboard**
![](Aspose.Words.e230e6d3-096c-46b7-8cc7-192ec2db67b7.004.png)

*Fig 4: Customer Dashboard — All vendor balances in one place*

The customer dashboard is the mirror view — showing all vendor relationships, outstanding balances, today's delivery status (confirmed/pending/disputed), and a single 'Pay All' UPI button to settle all outstanding dues at once. Each vendor card shows real-time delivery confirmation status.

## **3.4  Shared Ledger (The Core Feature)**
![](Aspose.Words.e230e6d3-096c-46b7-8cc7-192ec2db67b7.005.png)

*Fig 5: Shared Two-Sided Ledger — Both vendor and customer see identical records*

This is SaathKhata's defining innovation. When a vendor and customer are linked, both see the exact same ledger. Each entry shows the item, quantity, amount, and current confirmation status. The customer can confirm (locking the entry permanently) or raise a dispute. Confirmed entries show a 🔒 Immutable badge — neither party can edit them. Disputed entries are flagged for review.

- Confirmed entries: Locked forever, contribute to balance
- Pending entries: Awaiting customer confirmation (24-hour auto-confirm option for vendors)
- Disputed entries: Frozen, flagged, require manual resolution via in-app chat

## **3.5  Voice Entry (Multilingual)**
![](Aspose.Words.e230e6d3-096c-46b7-8cc7-192ec2db67b7.006.png)

*Fig 6: Voice Entry — Speak in Hindi/regional language to create entries instantly*

The voice entry screen allows vendors (especially low-tech users) to create ledger entries by speaking naturally in their language. The AI parses the spoken entry and extracts: customer name, item, quantity, amount, and entry type (credit/payment). The parsed result is shown for review before saving. Supported languages: Hindi, Bangla, Marathi, Tamil, Telugu, Kannada, Gujarati, Punjabi, Odia, Malayalam, Bhojpuri, Maithili.

Example Hindi voice command: "Sujeet ka aaj 2 litre doodh diya, ₹60 udhar" → automatically creates an entry for Sujeet Kumar, 2L Milk, ₹60 Credit.

## **3.6  Bill OCR Scanner**
![](Aspose.Words.e230e6d3-096c-46b7-8cc7-192ec2db67b7.007.png)

*Fig 7: Bill OCR — Photograph any receipt to auto-populate entry details*

The bill OCR screen opens the device camera with a scanning frame overlay. Users photograph any receipt or handwritten chit. The OCR engine extracts vendor name, amount, date, and item details. Extracted fields are shown in an editable preview before saving to the khata. This eliminates manual data entry for kirana and grocery vendors who deal with itemized bills.

## **3.7  Staff & Labour Management**
![](Aspose.Words.e230e6d3-096c-46b7-8cc7-192ec2db67b7.008.png)

*Fig 8: Staff & Labour — Attendance, wage tracking, and UPI salary payment*

The Staff module enables vendors (especially construction contractors, shop owners) to manage their workforce. Each staff member has a profile with wage type (daily/monthly), attendance calendar, and salary computation. Attendance is marked daily with Present / Absent / Half-day / Holiday states. Salary is auto-calculated based on attendance and displayed alongside a direct UPI payment button.

- Daily wage workers: Rate × days present = salary
- Monthly salaried: Fixed amount with deductions for absences
- Advance payment tracking with running balance
- Bonus and overtime support
- Salary slip generation as PDF / WhatsApp share

## **3.8  Appointment Booking**
![](Aspose.Words.e230e6d3-096c-46b7-8cc7-192ec2db67b7.009.png)

*Fig 9: Appointment Booking — Calendar-based slot selection with service picker*

Service-based vendors (salons, tiffin, etc.) can activate appointment booking. Customers see the vendor's available slots on a calendar, pick a time, and select services. Booked appointments are auto-added to the shared khata — payment happens after the service is delivered. Vendors get appointment notifications and can accept, reschedule, or cancel.

## **3.9  Reports & Analytics**
![](Aspose.Words.e230e6d3-096c-46b7-8cc7-192ec2db67b7.010.png)

*Fig 10: Reports — Revenue trends, outstanding amounts, and top customer rankings*

The reports screen gives vendors business intelligence: total revenue, outstanding dues, recovery rate, daily/weekly/monthly collection charts, and a ranked list of top customers by value. Reports are filterable by time period (week / month / quarter / year) and can be exported as PDF or shared via WhatsApp.

## **3.10  Notifications**
![](Aspose.Words.e230e6d3-096c-46b7-8cc7-192ec2db67b7.011.png)

*Fig 11: Notifications — Delivery confirmations, payment alerts & dispute flags*

The notification center aggregates all important events: new delivery recorded (customer gets confirm/dispute buttons directly in notification), payment received, payment reminders, salary due alerts, appointment confirmations, and dispute flags. Notifications are grouped by day and color-coded by type.

## **3.11  Settings & Language**
![](Aspose.Words.e230e6d3-096c-46b7-8cc7-192ec2db67b7.012.png)

*Fig 12: Settings — Language selector, UPI linking, notifications, and app lock*

Settings allow users to change app language (all 12 languages available), manage notification preferences, link/unlink UPI IDs, enable app PIN lock, and configure voice entry preferences. Language changes apply to all UI elements, voice recognition language, and SMS/WhatsApp reminder templates instantly.


# **4. Feature Requirements**

Features are prioritized using a standard framework: P0 = Must-have for MVP launch, P1 = Launch + 30 days, P2 = Launch + 90 days.

## **4.1  Feature Priority Matrix**

|**Feature**|**Description**|**Priority**|**Module**|
| :- | :- | :- | :- |
|**User Registration & OTP**|Mobile OTP login, role selection (vendor/customer), profile setup|**P0**|Auth|
|**Multilingual UI**|12 Indian languages, instant switch, persists to profile|**P0**|i18n|
|**Add Transaction (Manual)**|Credit / payment entry with amount, date, note|**P0**|Ledger|
|**Vendor-Customer Linking**|QR code scan or mobile number search to link accounts|**P0**|Network|
|**Shared Ledger View**|Both parties see identical records in real time|**P0**|Ledger|
|**Confirm / Dispute Entry**|Customer confirms or disputes vendor entries|**P0**|Ledger|
|**Immutable Lock**|Confirmed entries are permanently locked for both parties|**P0**|Ledger|
|**Push Notifications**|Delivery recorded, payment received, dispute raised|**P0**|Notifications|
|**UPI Payment Integration**|Customer pays vendor via UPI from within the app|**P0**|Payments|
|**Voice Entry (Hindi)**|Speak in Hindi to create entries via speech recognition|**P0**|Voice|
|**Voice Entry (All 12 Languages)**|Full multilingual voice entry support|**P1**|Voice|
|**Bill OCR Scanner**|Photo a receipt → auto-fill entry details|**P1**|OCR|
|**Staff Attendance Tracking**|Daily P/A/H marking for each staff member|**P1**|Staff|
|**Salary Computation**|Auto-calc daily wage & monthly salary from attendance|**P1**|Staff|
|**Salary Payment via UPI**|Pay staff salary directly from app|**P1**|Staff|
|**Appointment Booking**|Calendar slots, service selection, auto-khata entry|**P1**|Booking|
|**SMS / WhatsApp Reminders**|Auto reminders to customers with outstanding balance|**P1**|Notifications|
|**Reports & Analytics**|Revenue charts, outstanding, recovery rate|**P1**|Analytics|
|**PDF Export**|Export ledger, salary slips, and reports as PDF|**P1**|Export|
|**Bulk Delivery Entry**|Mark all customers as delivered in one tap (e.g., milkman)|**P1**|Ledger|
|**Dispute Resolution Chat**|In-app message thread on disputed entries|**P2**|Ledger|
|**Credit Score Dashboard**|Vendor's trustworthiness score based on delivery history|**P2**|Analytics|
|**Customer Credit Profile**|Customer's payment history score for vendor's reference|**P2**|Analytics|
|**GST Invoice Generation**|GST-compliant invoice for registered vendors|**P2**|Tax|
|**Multi-staff Management**|Vendor manages team of delivery boys with sub-accounts|**P2**|Staff|
|**Inventory Tracking**|Basic stock in/out for kirana vendors|**P2**|Inventory|
|**Fintech Partner Integration**|NBFC micro-loan offers based on khata history|**P2**|Finance|
|**WhatsApp Mini Khata**|Lightweight bot for customers who won't download the app|**P2**|Platform|


# **5. Functional Requirements (Detailed)**

## **5.1  Authentication & Onboarding**
**5.1.1  OTP Login**

- User enters 10-digit mobile number → OTP sent via SMS
- OTP is 6-digit, valid for 5 minutes, max 3 attempts
- On success, check if user exists (returning user) or new user
- New users complete profile setup: name, role, language, business type (if vendor)
- Google Sign-In as alternate option (OAuth 2.0)

**5.1.2  Role Selection**

- User selects Vendor or Customer at registration
- Role is stored in profile and drives all subsequent UX
- Users can have both roles (e.g., a shop owner is also a customer of a wholesaler)
- Role switching available from Settings → My Account

**5.1.3  Language Selection**

- Language picker shown on first launch (12 options)
- Selected language applied to all UI strings, voice recognition locale, and outgoing SMS
- Language can be changed anytime from Settings

## **5.2  Vendor-Customer Linking**
- Vendor shares their SaathKhata QR code or unique ID
- Customer scans QR or enters vendor ID to send a link request
- Vendor approves or rejects the link request
- Once linked, shared ledger is created — both can see all entries
- Vendor can also initiate link by entering customer's mobile number
- Customer does not need the app installed — they receive a WhatsApp/SMS invite link
- If customer hasn't installed the app, they see a web-view of the shared ledger
- One vendor can link to unlimited customers; one customer can link to unlimited vendors

## **5.3  Ledger — Entry Management**
**5.3.1  Entry Types**

- Credit (Udhar): Vendor delivered goods/services — customer owes money
- Payment: Customer has paid — reduces outstanding balance
- Advance: Customer paid in advance — creates credit balance
- Adjustment: Correction entry (requires reason note)

**5.3.2  Entry Fields**

- Date (default: today, editable)
- Type (Credit / Payment / Advance / Adjustment)
- Amount (₹)
- Item description (optional — e.g., '2L Full Cream Milk')
- Quantity (optional — with unit: litre, kg, piece, hour)
- Note (optional free text, max 200 chars)
- Attachment (optional — photo of bill)

**5.3.3  Entry Confirmation Flow**

- Vendor creates entry → Customer gets push notification immediately
- Customer has 3 options: Confirm ✓ | Dispute ⚠ | Ignore (24hr timeout)
- Confirmed entries: locked, contribute to balance, show 🔒 badge
- Disputed entries: frozen (not added to balance), show ⚠ badge, resolution chat opens
- Auto-confirm: Vendor can enable auto-confirmation after 24 hours if customer doesn't respond

**5.3.4  Immutability Rules**

- Confirmed entries CANNOT be edited or deleted by either party
- All edits to unconfirmed entries are logged with timestamp
- Admins can resolve disputes — their decision is final and immutably logged

## **5.4  Voice Entry**
- Activated by tapping 🎙 microphone button anywhere in the app
- Supports continuous speech input for 30 seconds
- NLP parser extracts: customer name, amount, item, quantity, entry type, date
- Parsed results shown in a confirmation card before saving
- All fields are editable before final save
- Language auto-detected from profile setting — can be overridden per session
- Voice command examples:
  - Hindi: "Ramesh ka 500 rupaya aaya" → Payment of ₹500 from Ramesh
  - Bangla: "Priya ke 2 litre dudh diyechi" → Credit 2L Milk to Priya
  - Tamil: "Anbu ku iniku paal kuduthen" → Credit milk delivery to Anbu today

## **5.5  Bill OCR**
- Camera opens with frame overlay — aligns receipt for scanning
- Also supports selecting from gallery for existing photos
- OCR pipeline extracts: vendor/shop name, date, line items, total amount
- Supports Hindi, English, and regional language bills
- Extracted fields pre-fill the entry form — all fields editable
- Original bill photo is attached to the entry for reference
- Works offline — OCR runs locally on-device for speed and privacy

## **5.6  Staff & Labour Management**
**5.6.1  Staff Profiles**

- Name, mobile number, role/designation, photo
- Wage type: Daily (₹/day) or Monthly (₹/month)
- Join date, bank account / UPI ID for salary payment
- Emergency contact

**5.6.2  Attendance**

- Daily attendance marking: Present (P) / Absent (A) / Half Day (H) / Holiday (X)
- Attendance can be marked via voice: "Mohan aaj present"
- Calendar view shows entire month attendance with color coding
- Bulk mark: one tap to mark all staff present/absent for a day
- Attendance records are immutable once the month is closed (salary locked)

**5.6.3  Salary Computation**

- Daily wage: salary = (days present + 0.5 × half-days) × daily rate
- Monthly: salary = fixed amount − (absences × daily deduction rate)
- Deductions: advance repayment, losses/fines (with reason)
- Additions: overtime, bonus, festival bonus
- Salary slip generated as PDF with all calculations

**5.6.4  Salary Payment**

- One-tap UPI transfer to staff's linked UPI ID
- Payment recorded in staff ledger automatically
- SMS notification sent to staff with payment details
- WhatsApp salary slip share option

## **5.7  Appointment Booking**
- Vendor sets up: services offered, duration, price, available time slots
- Working days and hours configurable per vendor
- Customer views vendor's calendar — available slots shown in green
- Customer selects date, time slot, and services
- Booking confirmation sent to both parties via push notification + WhatsApp
- Booked appointment auto-generates a pending entry in shared khata
- On service completion, vendor marks appointment as completed — entry becomes active
- Cancellation policy: vendor configures minimum advance notice required

## **5.8  Payments (UPI Integration)**
- Customers pay vendors via UPI Collect request
- Vendor's UPI ID is linked at registration
- Payment amount pre-filled with outstanding balance (editable for partial payment)
- Payment status tracked in real time — success/failure notification to both parties
- Successful payment auto-creates a Payment entry in the shared ledger
- Payment history screen with filters and export
- Supported UPI apps: GPay, PhonePe, Paytm, BHIM, and all UPI-enabled bank apps

## **5.9  Notifications**

|**Delivery Confirmed**|Vendor — customer confirmed the delivery entry|
| :- | :- |
|**Delivery Disputed**|Vendor — customer raised a dispute on an entry|
|**New Entry Added**|Customer — vendor has added a new entry to the shared khata|
|**Payment Received**|Vendor — customer has made a UPI payment|
|**Payment Reminder**|Customer — auto-reminder for outstanding balance (configurable frequency)|
|**Appointment Booked**|Vendor — a new appointment has been scheduled|
|**Appointment Reminder**|Customer — reminder 1 day and 1 hour before appointment|
|**Salary Due**|Vendor — staff salary is due for the closed month|
|**Salary Paid**|Staff — their salary has been transferred via UPI|
|**Link Request**|Vendor — a customer has requested to link accounts|


# **6. Multilingual Requirements**

## **6.1  Supported Languages**

|**#**|**Language**|**Script**|**Voice Input**|**SMS/WhatsApp**|
| :- | :- | :- | :- | :- |
|1|Hindi|Devanagari|✅ MVP|✅|
|2|Bengali|Bengali script|✅ MVP|✅|
|3|Marathi|Devanagari|✅ Phase 2|✅|
|4|Tamil|Tamil script|✅ Phase 2|✅|
|5|Telugu|Telugu script|✅ Phase 2|✅|
|6|Kannada|Kannada script|✅ Phase 2|✅|
|7|Gujarati|Gujarati script|✅ Phase 2|✅|
|8|Punjabi|Gurmukhi|✅ Phase 2|✅|
|9|Odia|Odia script|Phase 3|✅|
|10|Malayalam|Malayalam script|Phase 3|✅|
|11|Bhojpuri|Devanagari|Phase 3|Phase 3|
|12|Maithili|Devanagari|Phase 3|Phase 3|

## **6.2  Implementation Approach**
- All UI strings managed via i18n JSON files — one file per language
- String keys are English — each language file maps key → translated string
- Right-to-left (RTL) layout not required for any listed language (all are LTR)
- Font fallback: each language uses OS-native font stack for correct rendering
- Voice recognition: Google Speech-to-Text API with language locale codes
- Outgoing SMS/WhatsApp templates translated per language and stored server-side


# **7. Technical Architecture**

## **7.1  Tech Stack Recommendations**

|**Frontend (Android)**|React Native (Expo) — single codebase for Android & iOS|
| :- | :- |
|**Frontend (iOS)**|React Native (Expo) — same codebase|
|**Backend API**|Node.js + Express OR Django REST Framework (Python)|
|**Database**|PostgreSQL (relational) + Redis (caching/sessions)|
|**Real-time Sync**|Firebase Firestore OR Supabase Realtime for live ledger sync|
|**Voice Recognition**|Google Cloud Speech-to-Text API (with Indian language models)|
|**OCR Engine**|Google Cloud Vision API OR Tesseract (on-device for offline)|
|**UPI Integration**|Razorpay UPI Payment Links OR PayU OR direct UPI Deep Link|
|**Push Notifications**|Firebase Cloud Messaging (FCM)|
|**SMS / WhatsApp**|Twilio SMS + WhatsApp Business API (Meta)|
|**File Storage**|AWS S3 OR Google Cloud Storage (bill photos, salary slips)|
|**Authentication**|Firebase Auth (OTP) + Google OAuth|
|**Analytics**|Mixpanel OR Amplitude for user behaviour analytics|
|**Crash Reporting**|Sentry|
|**CI/CD**|GitHub Actions → Google Play Store & App Store|

## **7.2  Data Models (Core Entities)**
**User**

- user\_id, mobile, name, role[], language, created\_at, upi\_id, profile\_photo\_url

**Business (Vendor Profile)**

- business\_id, owner\_user\_id, business\_name, category, address, upi\_id, working\_hours

**Link (Vendor ↔ Customer Relationship)**

- link\_id, vendor\_id, customer\_user\_id, status (pending/active/blocked), created\_at

**Entry (Ledger Transaction)**

- entry\_id, link\_id, amount, type (credit/payment/advance/adjustment), date
- description, quantity, unit, note, bill\_photo\_url, created\_by
- status (pending/confirmed/disputed/auto\_confirmed), confirmed\_at, locked

**Staff**

- staff\_id, vendor\_id, name, mobile, wage\_type, daily\_rate, monthly\_salary, upi\_id

**Attendance**

- attendance\_id, staff\_id, date, status (P/A/H/X), marked\_by, marked\_at

**Appointment**

- appointment\_id, vendor\_id, customer\_user\_id, service\_ids[], slot\_datetime
- status (booked/confirmed/completed/cancelled), entry\_id (linked khata entry)

## **7.3  Security Requirements**
- All API endpoints require JWT authentication
- HTTPS enforced for all communications — no HTTP fallback
- Shared ledger data is end-to-end encrypted at rest
- Immutability enforced at database level — confirmed entries have write-lock triggers
- UPI transactions processed via PCI-DSS compliant payment gateway — no card data stored
- App PIN lock with biometric option (fingerprint / face unlock)
- OTP rate limiting — max 5 OTPs per mobile per hour
- Audit log for all admin actions


# **8. Non-Functional Requirements**

|**Performance**|App launch < 2 seconds · Ledger sync < 500ms · OCR result < 3 seconds|
| :- | :- |
|**Offline Support**|App works offline — entries queued locally, synced when connected|
|**Availability**|99\.9% uptime SLA for API · Planned maintenance in 2–4 AM window only|
|**Scalability**|Architecture must support 1M+ vendors and 10M+ customers within 2 years|
|**Device Support**|Android 8.0+ · iOS 14+ · Minimum 2GB RAM · 100MB storage|
|**Network**|Functional on 2G (basic entry adding) · Full features on 3G+|
|**Accessibility**|WCAG 2.1 AA compliance · Screen reader support · Large text option|
|**Data Retention**|Ledger data retained for 7 years (Indian accounting standards)|
|**Backup**|Automated daily backups · Point-in-time recovery up to 30 days|
|**Localization**|All dates in DD/MM/YYYY format · Currency in ₹ INR only|


# **9. Monetization Strategy**

## **9.1  Revenue Model**

|**Revenue Stream**|**Description**|**Projected Launch**|
| :- | :- | :- |
|Free Tier|Core ledger, 1 vendor link (customer), basic notifications — always free|Day 1|
|UPI Transaction Fee|0\.5–1% on each UPI payment processed in-app (shared with payment gateway)|Day 1|
|Vendor Premium|₹199/month — unlimited customers, OCR, staff management, analytics, PDF export|Month 3|
|Appointment SaaS|₹499/month for full appointment booking + CRM for salons/service vendors|Month 6|
|WhatsApp Reminders|₹99/month add-on for unlimited WhatsApp reminders (beyond 50/month free)|Month 3|
|Fintech Referrals|Revenue share with NBFC partners for micro-loan referrals based on khata credit score|Year 2|


# **10. Development Milestones & Timeline**

|**Phase**|**Timeline**|**Deliverables**|**Status**|
| :- | :- | :- | :- |
|Phase 1|Weeks 1–2|Project setup, UI design system, DB schema, API boilerplate|**Planning**|
|Phase 2|Weeks 3–5|Auth, user profiles, vendor-customer linking, basic ledger CRUD|**Development**|
|Phase 3|Weeks 6–8|Shared ledger, confirm/dispute flow, real-time sync, push notifications|**Development**|
|Phase 4|Weeks 9–10|Hindi voice entry, bill OCR, UPI payment integration|**Development**|
|Phase 5|Weeks 11–12|Staff management, attendance, salary computation, UPI salary payment|**Development**|
|Phase 6|Weeks 13–14|Analytics/reports, PDF export, multilingual UI (12 languages)|**Development**|
|Phase 7|Weeks 15–16|Appointment booking module, WhatsApp integration, SMS reminders|**Development**|
|Phase 8|Weeks 17–18|QA testing, performance optimization, security audit, bug fixes|**QA**|
|Beta Launch|Week 19|Closed beta with 500 vendors in 3 cities (Delhi, Mumbai, Kolkata)|**Beta**|
|Public Launch|Week 22|Google Play Store + App Store launch · Marketing campaign|**Launch**|


# **11. Open Questions & Risks**

## **11.1  Open Questions for Stakeholder Sign-Off**
1. Which payment gateway to use? (Razorpay vs PayU vs direct UPI) — affects MDR and settlement speed
1. Should auto-confirm (24hr timeout) be ON by default or opt-in for vendors?
1. What is the dispute resolution SLA? Who resolves unresolved disputes after 7 days?
1. Should the app support a WhatsApp web-view for customers who won't install the app?
1. Is GST invoice generation required at MVP, or can it be deferred to Phase 2?
1. Should we build OCR on-device (Tesseract) for offline support, or cloud-only (Google Vision)?

## **11.2  Key Risks & Mitigations**

|**Chicken-and-Egg**|Neither vendors nor customers join without the other. Mitigation: Launch vendor-only mode first (like OkCredit) — vendors get value without customer linkage. Introduce linking as an upgrade.|
| :- | :- |
|**Low-Tech Vendors**|Many milkmen/presswalas are not smartphone-savvy. Mitigation: Voice-first UI, large buttons, minimal screens, local language, WhatsApp-based customer onboarding.|
|**Dispute Abuse**|Customers may dispute valid entries to avoid payment. Mitigation: Dispute requires reason + photo evidence. Repeat disputers get flagged. Auto-confirm after 24hr prevents abuse.|
|**Competition**|OkCredit/KhataBook may copy the two-sided feature. Mitigation: Build network density fast — once vendor-customer pairs are linked, switching cost is very high.|
|**UPI Failure**|UPI payment failures frustrate both parties. Mitigation: Real-time payment status polling, clear error messages, manual payment mark option as fallback.|


# **12. Appendix**

## **12.1  Glossary**

|**Khata**|Ledger / account book (Hindi/Urdu). A record of credit and payments.|
| :- | :- |
|**Udhar**|Credit extended on trust — goods given now, payment later.|
|**Vendor**|The service/goods provider: milkman, presswala, kirana, etc.|
|**Customer**|The buyer who receives goods/services on credit.|
|**Shared Ledger**|SaathKhata's core innovation — a single ledger visible to both vendor and customer.|
|**Immutable Entry**|A confirmed ledger entry that is permanently locked and cannot be edited.|
|**UPI**|Unified Payments Interface — India's real-time payment system.|
|**OCR**|Optical Character Recognition — extracting text from photographs of bills.|
|**MDR**|Merchant Discount Rate — fee charged on UPI/card transactions.|
|**NBFC**|Non-Banking Financial Company — fintech partner for micro-loans.|

## **12.2  Competitive Comparison**

|**Feature**|**SaathKhata**|**OkCredit**|**KhataBook**|**Vyapar**|
| :- | :- | :- | :- | :- |
|**Two-sided shared ledger**|✅ YES|❌ No|❌ No|❌ No|
|**Customer confirms entries**|✅ YES|❌ No|❌ No|❌ No|
|**Voice entry (Indian lang)**|✅ 12 lang|❌ No|❌ No|❌ No|
|**Bill OCR scanning**|✅ YES|❌ No|Limited|✅ Yes|
|**Staff / labour management**|✅ YES|❌ No|❌ No|✅ Yes|
|**Appointment booking**|✅ YES|❌ No|❌ No|❌ No|
|**UPI payment in-app**|✅ YES|✅ Yes|✅ Yes|✅ Yes|
|**Dispute resolution**|✅ YES|❌ No|❌ No|❌ No|
|**Credit scoring**|Planned|❌ No|❌ No|❌ No|


*End of Document*

SaathKhata PRD v1.0  ·  May 2026  ·  Confidential
SaathKhata v1.0 PRD  |  May 2026  |  Page 
