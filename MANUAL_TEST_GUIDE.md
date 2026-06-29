# SaathKhata — Manual Testing Guide

**For**: Non-technical manual testers  
**What is SaathKhata**: A mobile app that helps small business owners (vendors) and their customers keep track of credit and payments — a digital version of the traditional "khata" (account book). There are three types of users: Vendor, Customer, and Staff.

---

## Before You Begin

- You need the app installed and running on your phone or emulator.
- The backend must be running (ask a developer if you are unsure).
- **Test OTP**: When you are asked for a 6-digit OTP code, always enter **123456** (this is the dummy code used in development).
- Use a real 10-digit Indian mobile number starting with 6, 7, 8, or 9 when the app asks for one.

---

## Section 1: First Launch & Onboarding

### TC-1.1 — Language Selection Screen
**What to do**: Open the app fresh for the first time (or clear app data).

1. The app should open to a language selection screen.
2. You should see a list of languages: English, Hindi (हिन्दी), Bengali (বাংলা), Marathi (मराठी), Tamil (தமிழ்), Telugu (తెలుగు), Kannada (ಕನ್ನಡ), Gujarati (ગુજરાતી), Punjabi (ਪੰਜਾਬੀ), Malayalam (മലയാളം), Bhojpuri (भोजपुरी), Maithili (मैथिली).
3. Tap any language — it should highlight with a checkmark.
4. Tap the **Continue** button at the bottom.

**Expected**: The app moves to the onboarding screen, and all subsequent text appears in the language you selected.

---

### TC-1.2 — Onboarding Slides
**What to do**: After selecting language, you land on onboarding.

1. You should see 3 slides. Each slide has a large emoji icon, a title, and a subtitle.
2. Swipe left to go to the next slide, or use the dots at the bottom to navigate.
3. There is a **Skip** button in the top-right corner — tapping it should jump directly to the role selection screen.
4. On the last slide, tap **Get Started**.

**Expected**: You arrive at the Role Selection screen.

---

## Section 2: Registration & Login

### TC-2.1 — Role Selection Screen
**What to do**: On the Role Selection screen:

1. You should see two cards: **Vendor** (business owner) and **Customer**.
2. Tap **Vendor** — it should highlight in the vendor accent color (teal/green).
3. Tap **Customer** — it should highlight in the customer accent color.
4. Confirm you can switch between them by tapping each.

**Expected**: Selecting a role highlights it. A **Continue** or similar button becomes active and takes you to Phone Entry.

---

### TC-2.2 — Phone Number Entry
**What to do**: After selecting a role:

1. A phone number entry screen appears for the selected role (Vendor or Customer).
2. Try entering an invalid number like **12345** and tapping Send OTP — you should see a warning toast: "Invalid phone number" (or similar in your language).
3. Try entering a number starting with 5 (e.g. **5000000000**) — should also warn you.
4. Enter a valid number (starts with 6–9, 10 digits, e.g. **9876543210**).
5. Tap **Send OTP**.

**Expected**: A loading spinner appears briefly, then the app navigates to the OTP verification screen. A toast may confirm the OTP was sent.

---

### TC-2.3 — OTP Verification
**What to do**: On the OTP screen:

1. You see 6 individual digit boxes.
2. Tap the first box and type **1** — focus should automatically move to the next box.
3. Continue typing **2 3 4 5 6** — each digit should auto-advance.
4. Test the backspace key: pressing backspace should clear the current box and move focus back.
5. Try tapping **Verify** before filling all 6 boxes — you should see a warning: "Enter all 6 digits" (or similar).
6. Fill in **1 2 3 4 5 6** and tap **Verify**.

**Expected**: If this is a new phone number, the app goes to the Profile Setup screen. If the number already has an account, it logs you in directly and goes to the dashboard.

**Also test**: Tap **Resend OTP** — a toast should say "OTP resent" and the boxes should clear so you can enter again.

---

### TC-2.4 — Profile Setup (New User)
**What to do**: For a brand-new phone number after OTP:

1. The Profile Setup screen appears. At the top, there is a role selector — **Vendor** or **Customer**. Pick one.
2. You see a round avatar placeholder at the top — tap it to upload a profile photo (from your camera or gallery). This is optional.
3. Fill in:
   - **Your Name** (required)
   - **Email** (optional)
4. **If you selected Vendor**:
   - Fill in **Business Name** (required)
   - Fill in **Business Address** (required)
   - Choose a **Business Category** from the dropdown (Milk/Dairy, Press/Dhobi, Maid/Cook, Newspaper, Water Can, Tiffin/Food, Kirana/Grocery, Salon/Parlour, Construction Labour, Transport/Auto, Other)
   - Add a **UPI ID** (optional) — used so customers can pay you digitally
   - Optionally tap **Set Location** to pick your business location on a map
5. **If you selected Customer**: only Name and Email are required.
6. Tap **Complete Setup**.

**Expected**: You are taken to your dashboard (Vendor Dashboard or Customer Dashboard depending on your role).

---

### TC-2.5 — Email Login (Alternative)
**What to do**: On the Role Selection screen, look for an **Email Login** option (it may appear as a link or secondary button):

1. Tap it.
2. Enter a valid email and password for an existing account.
3. Tap Login.

**Expected**: You are logged in and taken to your dashboard.

---

## Section 3: Vendor Mode — All Features

After logging in as a Vendor, you see the **Vendor Dashboard** with a bottom navigation bar with 5 tabs: **Home, Staff, Booking, Reports, Settings**.

---

### TC-3.1 — Vendor Dashboard Overview
**What to do**: Open the app as a Vendor.

1. The top of the dashboard shows two stat cards:
   - **Outstanding** (total amount customers owe you, shown in red/orange)
   - **Collected Today** (payments received today, shown in green)
2. Tap the **Outstanding** card — it should open a list of customers with pending dues.
3. Tap the back button to return to the dashboard.
4. Tap the **Collected Today** card — it should open a list of today's payment records.
5. Return to dashboard.
6. Below the stat cards, you see **Quick Actions**:
   - **Remind All** — sends payment reminders to all customers with dues
   - **Add New** — links a new customer
   - **Daily Charge** — bulk charge all customers
7. The notification bell icon is in the top-right corner — check if it shows a badge number (indicates unread notifications).
8. You should also see a **search bar pill** near the top — this opens Vendor Search.
9. There is a **+ ADD CUSTOMER** floating button at the bottom — it appears when you scroll up and hides when you scroll down.
10. Pull down to refresh the dashboard — a loading indicator should appear briefly.

**Expected**: All elements are visible, tappable, and show data or a loading state.

---

### TC-3.2 — Add a New Customer (Vendor Side)
**What to do**: From the Vendor Dashboard:

1. Tap the **+ ADD CUSTOMER** floating button (or the "Add New" quick action).
2. A bottom sheet pops up with:
   - A text field: **Phone or email** (enter the customer's phone number or email)
   - A text field: **Nickname** (optional — how you know this customer)
3. Leave the phone/email blank and tap **Send Request** — nothing should happen (or a warning should show).
4. Enter a valid phone number or email of the customer account.
5. Optionally enter a nickname like "Ram Bhaiya".
6. Tap **Send Request**.

**Expected**: A success toast appears: "Request sent! They will be notified to confirm." The bottom sheet closes.

---

### TC-3.3 — Pending Link Requests (Vendor Side)
**What to do**: On the Vendor Dashboard, scroll down to find a **Pending Requests** section:

1. If there are any pending requests from customers who want to link with you, they appear here as cards.
2. Tap a pending request card — it opens the **Link Request Detail** screen.
3. You see the customer's name, phone number, and the request details.
4. Tap **Accept** to approve the link.
5. Or tap **Decline** to reject it.

**Expected**: After accepting, the customer disappears from pending and should now appear in your customer list on the dashboard.

---

### TC-3.4 — View Customer List and Customer Ledger
**What to do**: On the Vendor Dashboard, scroll down past the quick actions to see your linked customer list:

1. Each customer tile shows: their name/nickname, and their current balance (amount owed, in red for credit/outstanding, or in green if they've paid ahead).
2. Tap a customer tile to open the **Shared Ledger Screen** for that customer.
3. On the Shared Ledger Screen:
   - At the top, see the **Balance Header** showing the total outstanding/balance.
   - Below, see a scrollable list of all transactions (entries).
   - Each entry shows: date, amount, type (credit or payment), and a description.
4. Look for filter options (e.g., filter by date or by type) — a filter bar may appear near the top.
5. Tap an individual entry — it may expand to show more details or allow dispute/confirm actions.

**Expected**: The ledger loads and shows all past entries. Balance updates to reflect the total.

---

### TC-3.5 — Record Credit (Give Credit to Customer)
**What to do**: On the Shared Ledger Screen (inside a customer's ledger):

1. At the bottom of the screen, see two buttons: **Record Payment** (green) and **Give Credit** (red).
2. Tap **Give Credit** (red button).
3. A bottom sheet opens with:
   - **Amount** field (enter a number, e.g. 500)
   - **Description** field (e.g. "Milk delivery — 10 litres")
4. Leave amount blank and try to submit — should not proceed.
5. Enter 500 in amount, "Milk delivery" in description.
6. Tap **Save** or **Add Entry**.

**Expected**: A new entry appears in the ledger list marked as "Credit" in red with ₹500. The balance header updates to reflect the increased outstanding.

**Also test**: The entry should appear instantly without needing to refresh (live update via socket).

---

### TC-3.6 — Record Payment from Customer
**What to do**: On the Shared Ledger Screen:

1. Tap **Record Payment** (green button at the bottom).
2. A bottom sheet opens with Amount and Description fields.
3. Enter 200 as the amount.
4. Enter "Cash payment" as description.
5. Tap **Save**.

**Expected**: A new "Payment" entry appears in the ledger in green with ₹200. The balance decreases by 200.

---

### TC-3.7 — Voice Entry Feature
**What to do**: On the Shared Ledger Screen, look for a **microphone button** or **voice icon**:

1. Tap the microphone/voice button.
2. A dark overlay dialog appears with an animated circle.
3. It shows a listening state — speak something like "Milk 500 rupees credit" in your selected language.
4. The app should transcribe your speech and show a **Review** screen with the parsed amount, description, and type (credit or payment).
5. You can confirm or cancel the voice-parsed entry.
6. If the microphone isn't working in your test environment, the screen may show an error card — note the error message.

**Expected**: Voice entry dialog opens. If speech works, it parses and proposes an entry for review.

---

### TC-3.8 — Scan Bill (Bill OCR)
**What to do**: From the Vendor Dashboard or Ledger screen, find a **Scan Bill** option (may be in the FAB or a menu):

1. Navigate to Scan Bill screen (route: scan-bill).
2. You see a camera preview with a scanning frame overlay.
3. Buttons for Close (X) and Flash (lightning) are visible.
4. A simulated camera shows a grey placeholder (camera icon) — in a real device, this would be a live camera feed.
5. There is a **Scan Bill** title and a **Take Photo** or **Upload** button at the bottom.
6. Tap the Upload or select image option to pick a photo from the gallery.
7. After selecting, it navigates to **Bill Details Form** screen where you can review and confirm the parsed bill data.

**Expected**: Scan Bill screen opens. Camera placeholder is visible. You can navigate to Bill Details Form.

---

### TC-3.9 — Daily Charge / Bulk Charge Feature
**What to do**: From the Vendor Dashboard, tap **Daily Charge** quick action:

1. The **Bulk Charge** screen opens.
2. At the top, see a list of product templates (e.g. "Morning Milk - ₹50").
3. Tap **+** in the top-right corner to create a new product template:
   - Enter product name (e.g. "Evening Milk")
   - Enter amount (e.g. 30)
   - Tap Save
4. Back on Bulk Charge screen, select a template.
5. Below the templates, see your customer list — each customer has a checkbox or toggle.
6. Select some customers (check the checkboxes).
7. Tap **Charge Selected** or similar button.

**Expected**: The template is created and saved. Selecting customers and tapping charge creates ledger entries for all selected customers at once. A success toast should appear.

---

### TC-3.10 — Remind All Customers
**What to do**: From the Vendor Dashboard:

1. Tap the **Remind All** quick action card.
2. A loading spinner appears briefly.

**Expected**: A toast message appears like "Reminders sent to 3 customers" (where 3 is the count with outstanding dues). If no customers have dues, you should see "No customers with outstanding balance".

---

### TC-3.11 — All Customers Screen
**What to do**: Find the "All Customers" option (may be a "View All" link on the dashboard):

1. You see a complete list of all your linked customers.
2. Each customer shows their name and balance.
3. You may be able to search within this list.

**Expected**: Full customer list loads with correct balances.

---

### TC-3.12 — Outstanding List Screen
**What to do**: Tap the **Outstanding** stat card on the Vendor Dashboard:

1. You see only customers who have an outstanding balance (they owe you money).
2. Each entry shows the customer name and the amount owed.
3. Tap a customer to go to their ledger.

**Expected**: List shows only customers with positive outstanding balance (credit > payments).

---

### TC-3.13 — Collected Today Screen
**What to do**: Tap the **Collected Today** stat card:

1. You see all payment entries made today.
2. Each entry shows: customer name, amount, and time.

**Expected**: List shows all payments recorded today.

---

## Section 4: Vendor Mode — Staff Tab

The **Staff tab** (person icon, index 1 in bottom nav) manages your workers/employees.

### TC-4.1 — Staff Management Screen
**What to do**: Tap the **Staff** tab in the vendor bottom nav:

1. You see a list of your staff members. If empty, an empty state widget is shown.
2. Each staff tile shows: name, role (e.g. Helper, Delivery Boy), and salary type.
3. Tap the **+ Add Staff** floating button at the bottom.
4. A bottom sheet opens with fields:
   - **Name** (required)
   - **Phone Number** (required — for staff login)
   - **Monthly Salary** (required)
   - **Role** (e.g. Helper, Delivery, Manager)
   - **Salary Type** (Daily / Monthly)
5. Fill in the details and tap **Add Staff**.

**Expected**: The new staff member appears in the list. Leaving required fields blank should show validation.

---

### TC-4.2 — Staff Detail Screen
**What to do**: From the Staff Management screen, tap a staff member:

1. You see their full profile: name, phone, role, salary info.
2. **Attendance Calendar**: A calendar widget showing which days they were marked present/absent.
3. **Salary History**: A list of past salary payments.
4. **Action Buttons**: Options like:
   - **Mark Attendance** (mark today present or absent)
   - **Pay Salary** / **Accrue Salary** (advance or full payment)
   - **Give Advance**
5. Look for **App Access Card** — this shows whether the staff member has been given access to the staff portal of the app.
6. To enable app access: toggle or button to grant staff login — their phone number becomes their login.

**Expected**: All sections load. Attendance calendar shows correct days. Salary history lists past transactions.

---

### TC-4.3 — App Access for Staff
**What to do**: On the Staff Detail Screen:

1. Look for the **App Access** section/card.
2. If access is not enabled, there should be a button to **Grant App Access**.
3. Tap it — a confirmation may appear.
4. After enabling, the staff member can log into the app with their phone number and the OTP.

**Expected**: App access can be toggled on/off. The UI reflects the current state clearly.

---

## Section 5: Vendor Mode — Booking Tab

### TC-5.1 — Vendor Bookings Screen
**What to do**: Tap the **Booking** tab (clock icon) in the vendor bottom nav:

1. You see a list of all appointment/booking requests from customers.
2. Each booking shows: customer name, date, time slot, and status (pending/confirmed/cancelled).
3. Tabs or filters may let you view: **Upcoming**, **Past**, **All**.
4. Tap a booking — options may appear to Confirm or Cancel it.

**Expected**: Bookings list loads. You can view and take action on individual bookings.

---

## Section 6: Vendor Mode — Reports Tab

### TC-6.1 — Business Reports Screen
**What to do**: Tap the **Reports** tab (stars icon) in the vendor bottom nav:

1. You see a **Revenue Chart** — a visual graph showing revenue/collections over time.
2. **Summary Cards**: Total collected, total outstanding, top customer stats.
3. **Top Customers** list: customers sorted by the amount they've paid or owe.
4. Tap **All Customers Report** or a similar button — a detailed view of all customers with their balances.
5. Tap a specific customer in the report to open their **Customer Detail Report** — showing their full transaction history and totals.

**Expected**: Reports load and display charts and data. Tapping through shows more detail.

---

## Section 7: Vendor Mode — Settings Tab

### TC-7.1 — Settings Overview
**What to do**: Tap the **Settings** tab (gear icon) in the vendor bottom nav:

1. At the top, you should see your profile: name, profile photo (or initials), and your business name.
2. **Account Information** section contains:
   - **Edit Profile** — tap to edit your name, email, business name, address
   - **Change Password** — tap to change your login password
   - **Delete Account** — tap this (but **do not confirm** unless testing deletion) — a confirmation dialog should appear
3. **Account Settings** section contains:
   - **App Language** — shows current language (e.g. "English" or "हिंदी") — tap to change
   - **My UPI IDs** — manage your UPI payment IDs
   - **Membership Tiers** — set up loyalty tiers for your customers
   - **Privacy Policy** / **Terms of Service** links
   - **Logout** button (may be at the bottom)

**Expected**: All settings are visible and tappable. Each leads to the correct screen.

---

### TC-7.2 — Edit Profile
**What to do**: Tap **Edit Profile** in Settings:

1. A form opens pre-filled with your current details: name, email, business name, address, category.
2. Change your **Business Name** to something different.
3. Tap **Save**.

**Expected**: Changes are saved and reflected on the Settings screen and vendor dashboard.

---

### TC-7.3 — Change Language in Settings
**What to do**: Tap **App Language** in Settings:

1. A language picker appears (bottom sheet or dialog).
2. Select a different language (e.g. Hindi if you were on English).
3. Confirm the selection.

**Expected**: The app immediately switches all text to the selected language. Navigate around to verify — dashboard labels, button text, and section headers should all change.

---

### TC-7.4 — UPI ID Management
**What to do**: Tap **My UPI IDs** in Settings:

1. You see a list of your saved UPI IDs (e.g. "john@okicici").
2. If empty, an empty state is shown.
3. Tap **+** or **Add UPI ID** to add one.
4. Enter a UPI ID and save.
5. You should be able to delete an existing UPI ID by swiping or tapping a delete icon.

**Expected**: UPI IDs can be added and deleted. List updates after changes.

---

### TC-7.5 — Membership Tiers
**What to do**: Tap **Membership Tiers** in Settings (vendor only):

1. You see 3 tiers (typically Bronze, Silver, Gold — or your custom names).
2. Each tier shows its name and discount percentage.
3. Tap a tier card to edit it:
   - Change the tier name
   - Change the discount percentage (e.g. "10%")
4. Tap Save.

**Expected**: Tier names and discounts are editable and saved. Changes reflect on the tier cards.

---

### TC-7.6 — Logout
**What to do**: From Settings, find and tap **Logout**:

1. A confirmation dialog appears ("Are you sure you want to logout?").
2. Tap **Cancel** — you stay logged in.
3. Tap **Logout** again and confirm.

**Expected**: You are logged out and taken back to the Role Selection screen.

---

## Section 8: Customer Mode — All Features

Log in as a Customer (different phone number). You see the **Customer Dashboard** with a bottom nav: **Home, My Khatas, Bookings, Payments, Profile**.

---

### TC-8.1 — Customer Dashboard Overview
**What to do**: Open the app as a Customer:

1. At the top, see a **search bar pill** — this opens vendor search.
2. Below that, see a **Total Due Card** — shows the total amount you owe across all your vendors.
3. If the total due is greater than 0, there is a **Pay All Dues** button on this card.
4. Below, see an **Upcoming Appointments** card (if you have bookings).
5. Below that, see your list of linked vendors — each vendor tile shows their name and your balance with them (red = you owe them money).
6. Tap the notification bell icon to open notifications.
7. Tap **+ ADD VENDOR** floating button.

**Expected**: Dashboard loads with all sections. Balance amounts are visible.

---

### TC-8.2 — Add a Vendor (Customer Side)
**What to do**: Tap **+ ADD VENDOR** on the Customer Dashboard:

1. A bottom sheet appears with:
   - **Phone or email** field (enter your vendor's phone or email)
   - **Nickname** field (optional)
2. Enter the phone number or email of a vendor account.
3. Tap **Send Request**.

**Expected**: A success toast: "Request sent! They will be notified to confirm." The bottom sheet closes.

---

### TC-8.3 — Pending Link Requests (Customer Side)
**What to do**: On the Customer Dashboard, look for a banner or notification about pending requests:

1. If a vendor has sent you a link request, a banner appears: "You have X pending vendor request(s)".
2. Tap on it to open the **Customer Link Request Detail** screen.
3. You see the vendor's name and business details.
4. Tap **Accept** or **Decline**.

**Expected**: Accepting adds the vendor to your dashboard. Declining removes the request.

---

### TC-8.4 — View Your Ledger with a Vendor (Customer View)
**What to do**: On the Customer Dashboard, tap a vendor tile:

1. The **Shared Ledger Screen** opens — same as vendor sees, but from your side.
2. You can see all transactions between you and this vendor.
3. Balance header shows how much you owe (in red) or are owed (in green).
4. You can see individual entries: credits (when vendor charged you) and payments (when you paid).
5. As a customer, you only see the **Record Payment** button at the bottom (you cannot add credits — only the vendor can do that).

**Expected**: Ledger loads correctly from the customer's perspective. Only "Record Payment" is shown, not "Give Credit."

---

### TC-8.5 — My Khatas Screen
**What to do**: Tap the **My Khatas** tab (message icon) in customer bottom nav:

1. You see a list of all your linked vendors with their balances.
2. Tap a vendor to go to the shared ledger.
3. You may see search or filter options.

**Expected**: Full list of linked vendors shown with balances.

---

### TC-8.6 — Customer Bookings Screen
**What to do**: Tap the **Bookings** tab (clock icon) in customer bottom nav:

1. You see your upcoming and past appointments.
2. Each booking shows: vendor name, date, time, and status.
3. You may see a **Cancel** button on upcoming bookings.
4. Look for a **Book Appointment** button or navigate to a vendor's profile to book.

**Expected**: Your booking history and upcoming appointments are visible.

---

### TC-8.7 — Book an Appointment
**What to do**: Navigate to **Book Appointment** screen (via vendor profile or bookings tab):

1. The screen shows the vendor's name.
2. A horizontal date scroller shows the next 14 days — tap to select a date.
3. Below, available time slots appear for the selected date.
4. Tap an available slot to select it.
5. Tap **Book Now** or **Confirm Booking**.
6. A booking confirmation bottom sheet appears — review the details.
7. Confirm the booking.

**Expected**: After confirming, the booking appears in your Bookings list. A toast confirms success.

---

### TC-8.8 — Payments Screen
**What to do**: Tap the **Payments** tab (lightning icon) in customer bottom nav:

1. You see your payment history — all payments you've made across all vendors.
2. Each entry shows: vendor name, amount, date.
3. May also show total paid this month or similar summary.

**Expected**: Payment history loads correctly.

---

### TC-8.9 — Pay via UPI
**What to do**: From the Customer Dashboard (or ledger), if there is a Pay button:

1. Tap **Pay All Dues** or a UPI pay button.
2. The **UPI Payment Screen** opens showing:
   - The amount to pay (e.g. ₹500)
   - The recipient's name
   - A row of UPI app icons (PhonePe, GPay, Paytm, etc.)
   - A text field for the recipient's UPI ID (may be pre-filled if vendor has one saved)
   - A note field (optional)
3. Tap a UPI app icon to simulate payment.
4. The screen should show a success state after processing.

**Expected**: UPI Payment screen opens correctly. Success state shows after tapping an app. A "Retry" option appears if it fails.

---

### TC-8.10 — Customer Profile Screen
**What to do**: Tap the **Profile** tab (user icon) in customer bottom nav:

1. You see your profile details: name, phone number, email, profile photo.
2. Options to edit profile, change password, manage settings.

**Expected**: Profile screen shows your current details.

---

## Section 9: Staff Portal Mode

Log in using a phone number that has been granted staff access by a vendor (see TC-4.3 for how vendors grant access). Staff users see a **restricted portal** — 3 tabs: **Home, Customers, Pay (My Pay)**.

---

### TC-9.1 — Staff Home Screen
**What to do**: Log in as a Staff member:

1. The app title shows the business name (the vendor's business this staff belongs to).
2. A subtitle shows: "Staff: [your name]" or similar.
3. Two large action buttons:
   - **Record Delivery** (red) — for recording goods delivered to a customer (creates a credit entry)
   - **Collect Payment** (green) — for recording payment received from a customer
4. Below the buttons, see a short list of recent customers.
5. A "View All" link navigates to the full Customers tab.

**Expected**: Staff home loads with the two action buttons and a customer preview list.

---

### TC-9.2 — Record Delivery (Staff)
**What to do**: Tap **Record Delivery** on Staff Home:

1. A bottom sheet opens asking you to select a customer from your vendor's customer list.
2. Select a customer.
3. Enter an amount and description.
4. Tap Save.

**Expected**: A credit entry is created in the ledger. The staff member cannot access other vendor settings — only basic entry recording.

---

### TC-9.3 — Collect Payment (Staff)
**What to do**: Tap **Collect Payment** on Staff Home:

1. Same flow as Record Delivery but creates a payment entry (green).
2. Select customer, enter amount, tap Save.

**Expected**: A payment entry is created in the customer's ledger.

---

### TC-9.4 — Staff Customers Tab
**What to do**: Tap the **Customers** tab in staff bottom nav:

1. You see the full list of the vendor's customers.
2. You can tap a customer to record an entry for them.

**Expected**: Full customer list is shown. Staff can only record entries, not manage the vendor's business.

---

### TC-9.5 — My Pay Tab (Staff)
**What to do**: Tap the **Pay** tab in staff bottom nav:

1. You see your own salary and pay history:
   - Current month salary status
   - Advance received
   - Past salary payments
2. This is read-only — staff can see but not change their own salary.

**Expected**: Pay screen shows salary information. No edit options visible.

---

## Section 10: Notifications

### TC-10.1 — Notifications Screen
**What to do**: Tap the bell icon from any dashboard (vendor or customer):

1. The **Notifications Screen** opens.
2. Unread notifications are highlighted (different background or bold text).
3. Each notification shows: title, description, and time.
4. If there are unread notifications, a **Mark All Read** button appears in the top-right.
5. Tap **Mark All Read** — all notifications become marked as read, badge count on the bell icon resets to 0.
6. If there are no notifications, an empty state with an icon and message is shown.

**Expected**: Notifications load. Mark All Read clears the badge. Tapping a notification (link request or payment notification) navigates to the relevant screen.

---

## Section 11: Search Features

### TC-11.1 — Vendor Search (find other vendors)
**What to do**: Tap the **search bar pill** on either the Vendor or Customer Dashboard:

1. The **Vendor Search Screen** opens.
2. A search bar is at the top — type a business name or category keyword.
3. You can also filter by **Business Category** using the category chips below the search bar.
4. Tap a result to open the **Vendor Profile** screen — shows the vendor's business details, location, category.
5. From the vendor profile, a customer can initiate a link request.

**Expected**: Search returns results as you type. Category filter narrows results. Tapping a vendor shows their public profile.

---

## Section 12: Location Features

### TC-12.1 — Location Picker
**What to do**: On the Profile Setup screen or Edit Profile, tap **Set Location** or **Pick Location**:

1. The **Location Picker Screen** opens.
2. A map view and a search bar appear.
3. Search for a city or address.
4. Results appear below — tap one to confirm.
5. A pin or chip shows the selected coordinates.
6. Tap **Confirm** or **Done** to save the location.

**Expected**: Location picker opens, search works, and selecting a location returns it to the profile form.

---

## Section 13: Membership Feature

### TC-13.1 — Membership Banner in Ledger
**What to do**: Open a customer's ledger (as a vendor or as a customer viewing the ledger):

1. If the customer is enrolled in a membership tier, a **Membership Banner** appears at the top of the ledger.
2. The banner shows the tier name (e.g. Silver) and the discount percentage.

**Expected**: Banner is visible for enrolled customers. Non-enrolled customers have no banner.

---

### TC-13.2 — Request Membership (Customer Side)
**What to do**: Inside a shared ledger screen (customer view):

1. Look for a **Membership** or **Join Loyalty** option.
2. Tap it to request membership with this vendor.
3. The vendor gets notified and can approve/reject.

**Expected**: Membership request is sent. Banner updates after vendor approves.

---

## Section 14: Edge Cases and Negative Tests

### TC-14.1 — No Internet Connection
**What to do**: Turn off WiFi and mobile data on the test device, then:

1. Try refreshing the Vendor Dashboard.
2. Try adding a new entry in the ledger.
3. Try navigating to Reports.

**Expected**: The app should show an error state or toast — "No internet connection" or "Failed to load" — and offer a **Retry** button. It should not crash.

---

### TC-14.2 — Empty States
**What to do**: Test the following in a fresh account with no data:

1. **Vendor Dashboard** with no customers linked — should show an empty state or a prompt to add your first customer.
2. **Notifications** with no notifications — should show an empty state widget with an icon and message.
3. **Staff Management** with no staff added — empty state with a prompt.
4. **Reports** with no transactions — should show empty or zero values on charts.

**Expected**: Empty states are shown gracefully — no crashes, no blank white screens.

---

### TC-14.3 — Navigation — Back Button
**What to do**: Navigate deep into the app (e.g., Vendor Dashboard → Customer Ledger → Voice Entry):

1. Use the device's back button or swipe gesture to go back.
2. Verify you return to the correct previous screen each time.
3. On the main dashboard tabs, pressing back should prompt to exit the app (or go to the home tab, not navigate further back).

**Expected**: Back navigation works correctly at every level.

---

### TC-14.4 — Delete Account
**What to do**: Go to Settings → **Delete Account** (this is a destructive test — use a throwaway account):

1. Tap Delete Account.
2. A confirmation dialog appears with a warning message.
3. Tap **Cancel** — nothing should happen.
4. Tap **Delete Account** again and tap **Confirm**.

**Expected**: Account is deleted and you are logged out, returning to the Role Selection screen. Use this test only on throwaway accounts.

---

## Quick Test Checklist Summary

Use this to track which features you have verified:

| # | Feature | Vendor | Customer | Staff | Pass / Fail |
|---|---------|--------|----------|-------|-------------|
| 1 | Language Selection | — | — | — | |
| 2 | Onboarding slides | — | — | — | |
| 3 | Role selection | ✓ | ✓ | — | |
| 4 | Phone + OTP login | ✓ | ✓ | ✓ | |
| 5 | New user profile setup | ✓ | ✓ | — | |
| 6 | Dashboard loads correctly | ✓ | ✓ | ✓ | |
| 7 | Add/Link customer or vendor | ✓ | ✓ | — | |
| 8 | Accept/Decline link request | ✓ | ✓ | — | |
| 9 | View shared ledger | ✓ | ✓ | — | |
| 10 | Record credit entry | ✓ | — | ✓ | |
| 11 | Record payment entry | ✓ | ✓ | ✓ | |
| 12 | Voice entry | ✓ | — | — | |
| 13 | Scan Bill / OCR | ✓ | — | — | |
| 14 | Bulk / Daily charge | ✓ | — | — | |
| 15 | Remind All customers | ✓ | — | — | |
| 16 | Staff management | ✓ | — | — | |
| 17 | Staff app access | ✓ | — | — | |
| 18 | Attendance & salary | ✓ | — | ✓ | |
| 19 | Bookings (view) | ✓ | ✓ | — | |
| 20 | Book appointment | — | ✓ | — | |
| 21 | Business Reports | ✓ | — | — | |
| 22 | Notifications (read/unread) | ✓ | ✓ | — | |
| 23 | Vendor Search | ✓ | ✓ | — | |
| 24 | UPI Payment flow | — | ✓ | — | |
| 25 | Settings → Edit Profile | ✓ | ✓ | — | |
| 26 | Settings → Change Language | ✓ | ✓ | — | |
| 27 | Settings → UPI IDs | ✓ | — | — | |
| 28 | Membership Tiers (setup) | ✓ | — | — | |
| 29 | Membership Banner (ledger) | ✓ | ✓ | — | |
| 30 | Logout | ✓ | ✓ | ✓ | |
| 31 | No internet error handling | ✓ | ✓ | — | |
| 32 | Empty states | ✓ | ✓ | — | |
| 33 | Back navigation | ✓ | ✓ | ✓ | |

---

## Notes for Testers

- **OTP is always 123456** in development/testing.
- **Phone numbers** must be 10 digits starting with 6, 7, 8, or 9 (Indian format).
- **Vendor** = business owner. They see: Home, Staff, Booking, Reports, Settings.
- **Customer** = buyer/client. They see: Home, My Khatas, Bookings, Payments, Profile.
- **Staff** = the vendor's employee. They see: Home, Customers, My Pay — a restricted view.
- A single phone number can only be ONE role. Use different numbers to test Vendor vs Customer flows.
- If the app shows a loading spinner for more than 10 seconds, note it as a bug and try the Retry button.
- All amounts are in Indian Rupees (₹). Credit = money the customer owes the vendor. Payment = money the customer paid the vendor.
