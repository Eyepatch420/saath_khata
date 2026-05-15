# SaathKhata — Backend Integration Master Document
**Version:** 1.0  
**Date:** 2026-05-14  
**Purpose:** Source of truth for backend team. Defines all API contracts, DTOs, enums, and integration requirements.

---

## Base URL Convention
```
Production:  https://api.saathkhata.in/v1
Staging:     https://staging.api.saathkhata.in/v1
```

## Auth Header
All authenticated endpoints require:
```
Authorization: Bearer <jwt_access_token>
```

## Standard Response Envelope
```json
{
  "success": true,
  "data": { },
  "error": null,
  "meta": {
    "timestamp": "2026-05-14T10:00:00Z",
    "requestId": "uuid"
  }
}
```

## Standard Error Response
```json
{
  "success": false,
  "data": null,
  "error": {
    "code": "INVALID_OTP",
    "message": "The OTP entered is incorrect or has expired.",
    "field": "otp"
  }
}
```

## Pagination Wrapper
```json
{
  "success": true,
  "data": {
    "items": [],
    "pagination": {
      "page": 1,
      "pageSize": 20,
      "totalItems": 150,
      "totalPages": 8,
      "hasNext": true,
      "hasPrev": false
    }
  }
}
```

---

## SECTION 1: AUTH APIs

### 1.1 Send OTP
```
POST /auth/send-otp
Auth: None
```
**Request:**
```json
{
  "phone": "9876543210",
  "countryCode": "+91"
}
```
**Response:**
```json
{
  "success": true,
  "data": {
    "sessionToken": "otp-session-uuid",
    "expiresIn": 300,
    "phone": "9876543210"
  }
}
```
**Errors:** `RATE_LIMIT_EXCEEDED`, `INVALID_PHONE`

---

### 1.2 Verify OTP
```
POST /auth/verify-otp
Auth: None
```
**Request:**
```json
{
  "phone": "9876543210",
  "otp": "123456",
  "sessionToken": "otp-session-uuid"
}
```
**Response (New User):**
```json
{
  "success": true,
  "data": {
    "isNewUser": true,
    "accessToken": null,
    "refreshToken": null
  }
}
```
**Response (Existing User):**
```json
{
  "success": true,
  "data": {
    "isNewUser": false,
    "accessToken": "jwt-access-token",
    "refreshToken": "jwt-refresh-token",
    "user": {
      "id": "uuid",
      "name": "Sujeet Kumar",
      "phone": "9876543210",
      "role": "vendor",
      "businessName": "Krishna Dairy",
      "businessCategory": "Milk / Dairy",
      "businessAddress": "Sector 15, Noida",
      "upiId": "krishna@upi",
      "profilePhotoUrl": null,
      "createdAt": "2026-01-01T00:00:00Z"
    }
  }
}
```
**Errors:** `INVALID_OTP`, `OTP_EXPIRED`, `SESSION_EXPIRED`

---

### 1.3 Complete Profile (New User)
```
POST /auth/complete-profile
Auth: Temp session token from OTP verify
```
**Request:**
```json
{
  "name": "Sujeet Kumar",
  "role": "vendor",
  "businessName": "Krishna Dairy",
  "businessCategory": "Milk / Dairy",
  "businessAddress": "Sector 15, Noida",
  "upiId": "krishna@upi"
}
```
**Response:** Same as Verify OTP existing user response (full auth tokens + user)

---

### 1.4 Refresh Token
```
POST /auth/refresh
Auth: None
```
**Request:**
```json
{
  "refreshToken": "jwt-refresh-token"
}
```
**Response:**
```json
{
  "data": {
    "accessToken": "new-jwt-access-token",
    "refreshToken": "new-jwt-refresh-token"
  }
}
```

---

### 1.5 Logout
```
POST /auth/logout
Auth: Required
```
**Request:** Empty body  
**Response:** `{ "success": true }`

---

## SECTION 2: USER / PROFILE APIs

### 2.1 Get Profile
```
GET /users/me
Auth: Required
```
**Response:**
```json
{
  "data": {
    "id": "uuid",
    "name": "Sujeet Kumar",
    "phone": "9876543210",
    "role": "vendor",
    "businessName": "Krishna Dairy",
    "businessCategory": "Milk / Dairy",
    "businessAddress": "Sector 15, Noida",
    "upiId": "krishna@upi",
    "profilePhotoUrl": "https://cdn.saathkhata.in/photos/uuid.jpg",
    "createdAt": "2026-01-01T00:00:00Z",
    "updatedAt": "2026-05-14T10:00:00Z"
  }
}
```

---

### 2.2 Update Profile
```
PUT /users/me
Auth: Required
```
**Request:**
```json
{
  "name": "Sujeet Kumar Updated",
  "businessName": "Krishna Dairy & More",
  "businessAddress": "New Address",
  "upiId": "sujeet@upi"
}
```

---

## SECTION 3: VENDOR-CUSTOMER LINK APIs

### 3.1 Get My Customers (Vendor)
```
GET /vendor/customers?page=1&pageSize=20&search=
Auth: Required (Vendor role)
```
**Response:**
```json
{
  "data": {
    "items": [
      {
        "id": "uuid",
        "customerId": "uuid",
        "customerName": "Ramesh Singh",
        "customerPhone": "9988776655",
        "outstandingAmount": 1250.00,
        "lastTransactionDate": "2026-05-13T00:00:00Z",
        "status": "active"
      }
    ],
    "pagination": { }
  }
}
```

---

### 3.2 Get My Vendors (Customer)
```
GET /customer/vendors?page=1&pageSize=20
Auth: Required (Customer role)
```
**Response:**
```json
{
  "data": {
    "items": [
      {
        "id": "uuid",
        "vendorId": "uuid",
        "vendorName": "Krishna Dairy",
        "vendorPhone": "9876543210",
        "businessName": "Krishna Dairy",
        "businessCategory": "Milk / Dairy",
        "outstandingAmount": 850.00,
        "lastTransactionDate": "2026-05-14T07:30:00Z",
        "upiId": "krishna@upi"
      }
    ]
  }
}
```

---

### 3.3 Link Customer to Vendor
```
POST /vendor/customers/link
Auth: Required (Vendor role)
```
**Request:**
```json
{
  "customerPhone": "9988776655"
}
```
**Response:** Returns the customer link object (as in 3.1 item)  
**Errors:** `CUSTOMER_NOT_FOUND`, `ALREADY_LINKED`

---

## SECTION 4: SHARED LEDGER APIs

### 4.1 Get Ledger Entries
```
GET /ledger/{linkId}?page=1&pageSize=20&status=&type=&fromDate=&toDate=
Auth: Required (both vendor and customer can call this)
```
**Path Params:** `linkId` — the vendor-customer relationship UUID  
**Query Params:**
- `status`: `pending | confirmed | disputed | auto_confirmed`
- `type`: `credit | payment | advance | adjustment`
- `fromDate`, `toDate`: ISO date strings

**Response:**
```json
{
  "data": {
    "items": [
      {
        "id": "uuid",
        "linkId": "uuid",
        "vendorId": "uuid",
        "customerId": "uuid",
        "type": "credit",
        "amount": 60.00,
        "description": "2L Milk",
        "quantity": 2.0,
        "unit": "litre",
        "status": "confirmed",
        "isLocked": true,
        "attachmentUrl": null,
        "createdByRole": "vendor",
        "createdAt": "2026-05-13T07:30:00Z",
        "confirmedAt": "2026-05-13T10:00:00Z",
        "disputeReason": null,
        "autoConfirmedAt": null
      }
    ],
    "balance": {
      "totalCredit": 5000.00,
      "totalPayment": 2500.00,
      "netBalance": 2500.00,
      "currency": "INR"
    },
    "pagination": { }
  }
}
```

---

### 4.2 Add Ledger Entry
```
POST /ledger/{linkId}/entries
Auth: Required (Vendor role only for credit entries)
```
**Request:**
```json
{
  "type": "credit",
  "amount": 60.00,
  "description": "2L Milk",
  "quantity": 2.0,
  "unit": "litre",
  "date": "2026-05-14T07:30:00Z",
  "attachmentUrl": null
}
```
**Response:** Returns the created entry (as in 4.1 item)  
**Validation:**
- `amount` must be > 0
- `type` must be `credit | payment | advance | adjustment`
- `date` cannot be in the future by more than 24 hours

---

### 4.3 Confirm Entry (Customer confirms)
```
POST /ledger/entries/{entryId}/confirm
Auth: Required (Customer role)
```
**Request:** Empty body  
**Response:**
```json
{
  "data": {
    "entryId": "uuid",
    "status": "confirmed",
    "confirmedAt": "2026-05-14T10:00:00Z",
    "isLocked": true
  }
}
```
**Errors:** `ENTRY_ALREADY_CONFIRMED`, `ENTRY_ALREADY_DISPUTED`, `NOT_AUTHORIZED`

---

### 4.4 Dispute Entry (Customer disputes)
```
POST /ledger/entries/{entryId}/dispute
Auth: Required (Customer role)
```
**Request:**
```json
{
  "reason": "Amount is incorrect, should be ₹50 not ₹60"
}
```
**Response:**
```json
{
  "data": {
    "entryId": "uuid",
    "status": "disputed",
    "disputeReason": "Amount is incorrect, should be ₹50 not ₹60",
    "disputedAt": "2026-05-14T10:00:00Z"
  }
}
```

---

### 4.5 Resolve Dispute (Vendor resolves)
```
POST /ledger/entries/{entryId}/resolve-dispute
Auth: Required (Vendor role)
```
**Request:**
```json
{
  "resolution": "corrected",
  "correctedAmount": 50.00,
  "note": "Agreed, correcting the amount"
}
```
**Response:** Returns updated entry

---

### 4.6 Vendor Dashboard Stats
```
GET /vendor/dashboard
Auth: Required (Vendor role)
```
**Response:**
```json
{
  "data": {
    "totalOutstanding": 45200.00,
    "todayCollection": 1250.00,
    "monthlyRevenue": 112000.00,
    "activeCustomers": 12,
    "pendingConfirmations": 3,
    "recentCustomers": [
      {
        "customerId": "uuid",
        "customerName": "Sujeet Kumar",
        "outstandingAmount": 1250.00,
        "lastTransactionDate": "2026-05-14T07:30:00Z"
      }
    ]
  }
}
```

---

### 4.7 Customer Dashboard Stats
```
GET /customer/dashboard
Auth: Required (Customer role)
```
**Response:**
```json
{
  "data": {
    "totalDue": 2450.00,
    "vendorCount": 3,
    "pendingConfirmations": 2,
    "recentVendors": [ ]
  }
}
```

---

## SECTION 5: STAFF MANAGEMENT APIs

### 5.1 Get Staff List
```
GET /vendor/staff?page=1&pageSize=20
Auth: Required (Vendor role)
```
**Response:**
```json
{
  "data": {
    "items": [
      {
        "id": "uuid",
        "vendorId": "uuid",
        "name": "Mohan Lal",
        "phone": "9876543000",
        "role": "helper",
        "salaryType": "daily",
        "salaryAmount": 500.00,
        "upiId": "mohan@upi",
        "joinDate": "2025-01-01",
        "isActive": true,
        "presentToday": true,
        "unpaidSalary": 4500.00,
        "advanceTaken": 500.00
      }
    ]
  }
}
```

---

### 5.2 Add Staff
```
POST /vendor/staff
Auth: Required (Vendor role)
```
**Request:**
```json
{
  "name": "Mohan Lal",
  "phone": "9876543000",
  "role": "helper",
  "salaryType": "daily",
  "salaryAmount": 500.00,
  "upiId": "mohan@upi"
}
```

---

### 5.3 Mark Attendance
```
POST /vendor/staff/{staffId}/attendance
Auth: Required (Vendor role)
```
**Request:**
```json
{
  "date": "2026-05-14",
  "status": "present"
}
```
**Valid statuses:** `present | absent | half_day | holiday`

---

### 5.4 Get Attendance Calendar
```
GET /vendor/staff/{staffId}/attendance?month=2026-05
Auth: Required (Vendor role)
```
**Response:**
```json
{
  "data": {
    "staffId": "uuid",
    "month": "2026-05",
    "attendanceRecords": [
      {
        "date": "2026-05-01",
        "status": "present"
      },
      {
        "date": "2026-05-02",
        "status": "absent"
      }
    ],
    "summary": {
      "presentDays": 12,
      "absentDays": 2,
      "halfDays": 0,
      "totalPayableDays": 12.0
    }
  }
}
```

---

### 5.5 Pay Salary
```
POST /vendor/staff/{staffId}/pay-salary
Auth: Required (Vendor role)
```
**Request:**
```json
{
  "amount": 4500.00,
  "paymentMethod": "upi",
  "upiTransactionId": "UPI-TXN-123",
  "note": "May salary",
  "month": "2026-05"
}
```

---

### 5.6 Add Advance
```
POST /vendor/staff/{staffId}/advance
Auth: Required (Vendor role)
```
**Request:**
```json
{
  "amount": 500.00,
  "note": "Emergency advance"
}
```

---

## SECTION 6: BOOKING / APPOINTMENT APIs

### 6.1 Get Vendor Slots
```
GET /vendor/slots?date=2026-05-15
Auth: Required
```
**Response:**
```json
{
  "data": {
    "date": "2026-05-15",
    "slots": [
      {
        "id": "uuid",
        "startTime": "09:00",
        "endTime": "09:30",
        "duration": 30,
        "isAvailable": true,
        "bookingId": null
      }
    ]
  }
}
```

---

### 6.2 Create Booking
```
POST /bookings
Auth: Required (Customer role)
```
**Request:**
```json
{
  "vendorId": "uuid",
  "slotId": "uuid",
  "date": "2026-05-15",
  "serviceType": "haircut",
  "notes": "Regular trim please"
}
```
**Response:**
```json
{
  "data": {
    "id": "uuid",
    "vendorId": "uuid",
    "customerId": "uuid",
    "slotId": "uuid",
    "date": "2026-05-15",
    "startTime": "09:00",
    "serviceType": "haircut",
    "status": "confirmed",
    "notes": "Regular trim please",
    "createdAt": "2026-05-14T10:00:00Z"
  }
}
```

---

### 6.3 Get My Bookings (Customer)
```
GET /customer/bookings?status=&page=1
Auth: Required (Customer role)
```
**Status values:** `confirmed | pending | cancelled | completed`

---

### 6.4 Get Vendor Bookings (Vendor)
```
GET /vendor/bookings?date=2026-05-15&status=
Auth: Required (Vendor role)
```

---

### 6.5 Update Booking Status
```
PUT /bookings/{bookingId}/status
Auth: Required
```
**Request:**
```json
{
  "status": "cancelled",
  "reason": "Customer cancelled"
}
```

---

## SECTION 7: NOTIFICATIONS APIs

### 7.1 Get Notifications
```
GET /notifications?page=1&pageSize=20&isRead=
Auth: Required
```
**Response:**
```json
{
  "data": {
    "items": [
      {
        "id": "uuid",
        "userId": "uuid",
        "type": "entry_added",
        "title": "New Entry Added",
        "body": "Krishna Dairy added ₹60 entry for today's milk",
        "data": {
          "entryId": "uuid",
          "linkId": "uuid",
          "amount": 60.00
        },
        "isRead": false,
        "createdAt": "2026-05-14T07:30:00Z"
      }
    ],
    "unreadCount": 3
  }
}
```

**Notification Types:**
```
entry_added         — Vendor added an entry (notifies customer)
entry_confirmed     — Customer confirmed entry (notifies vendor)
entry_disputed      — Customer disputed entry (notifies vendor)
payment_received    — Payment recorded (notifies customer)
salary_paid         — Vendor paid salary (notifies staff)
booking_confirmed   — Booking confirmed
booking_cancelled   — Booking cancelled
reminder_due        — Automated reminder for outstanding dues
monthly_summary     — Monthly ledger summary
```

---

### 7.2 Mark Notification as Read
```
PUT /notifications/{notificationId}/read
Auth: Required
```

---

### 7.3 Mark All as Read
```
PUT /notifications/read-all
Auth: Required
```

---

### 7.4 FCM Token Registration
```
POST /users/fcm-token
Auth: Required
```
**Request:**
```json
{
  "fcmToken": "firebase-cloud-messaging-token",
  "platform": "android"
}
```

---

## SECTION 8: PAYMENTS / UPI APIs

### 8.1 Initiate Payment
```
POST /payments/initiate
Auth: Required (Customer role)
```
**Request:**
```json
{
  "vendorId": "uuid",
  "amount": 2500.00,
  "entryIds": ["uuid1", "uuid2"],
  "upiId": "krishna@upi",
  "note": "Monthly settlement"
}
```
**Response:**
```json
{
  "data": {
    "transactionId": "uuid",
    "upiDeepLink": "upi://pay?pa=krishna@upi&pn=Krishna+Dairy&am=2500&tn=SaathKhata+Payment",
    "amount": 2500.00,
    "status": "pending",
    "expiresAt": "2026-05-14T10:10:00Z"
  }
}
```

---

### 8.2 Verify Payment
```
POST /payments/{transactionId}/verify
Auth: Required
```
**Request:**
```json
{
  "upiTransactionId": "UPI202605140001",
  "status": "success"
}
```

---

### 8.3 Get Transaction History
```
GET /payments/history?page=1&pageSize=20&fromDate=&toDate=
Auth: Required
```
**Response:**
```json
{
  "data": {
    "items": [
      {
        "id": "uuid",
        "vendorId": "uuid",
        "customerId": "uuid",
        "amount": 2500.00,
        "upiTransactionId": "UPI202605140001",
        "status": "success",
        "note": "Monthly settlement",
        "createdAt": "2026-05-14T10:05:00Z"
      }
    ]
  }
}
```

---

## SECTION 9: REPORTS APIs

### 9.1 Vendor Revenue Report
```
GET /vendor/reports/revenue?period=monthly&year=2026&month=5
Auth: Required (Vendor role)
```
**Response:**
```json
{
  "data": {
    "period": "2026-05",
    "totalRevenue": 112000.00,
    "totalCollected": 85000.00,
    "totalOutstanding": 27000.00,
    "transactionCount": 145,
    "newCustomers": 2,
    "dailyBreakdown": [
      {
        "date": "2026-05-01",
        "credit": 5000.00,
        "payment": 3000.00
      }
    ]
  }
}
```

---

### 9.2 Customer Summary Report
```
GET /vendor/reports/customers/{customerId}?period=monthly&year=2026&month=5
Auth: Required (Vendor role)
```

---

## SECTION 10: ENUMS

```dart
// User role
enum UserRole { vendor, customer }

// Entry type
enum EntryType { credit, payment, advance, adjustment }

// Entry status
enum EntryStatus { pending, confirmed, disputed, autoConfirmed }

// Staff salary type
enum SalaryType { daily, weekly, monthly }

// Attendance status
enum AttendanceStatus { present, absent, halfDay, holiday }

// Notification type
enum NotificationType {
  entryAdded, entryConfirmed, entryDisputed,
  paymentReceived, salaryPaid,
  bookingConfirmed, bookingCancelled,
  reminderDue, monthlySummary
}

// Booking status
enum BookingStatus { pending, confirmed, cancelled, completed }

// Payment status
enum PaymentStatus { pending, success, failed, refunded }
```

---

## SECTION 11: AUTO-CONFIRM RULE

Entries automatically transition from `pending` to `auto_confirmed` after **72 hours** if the customer has not confirmed or disputed. This is a backend-side cron job.

**Backend logic:**
```
SELECT * FROM ledger_entries 
WHERE status = 'pending' 
AND created_at < NOW() - INTERVAL '72 hours'
→ UPDATE status = 'auto_confirmed', auto_confirmed_at = NOW()
→ Send notification to customer: "Entries auto-confirmed after 72 hours"
```

---

## SECTION 12: REALTIME REQUIREMENTS

The following events require real-time push to connected clients:

| Event | Push to |
|-------|---------|
| Entry added | Customer |
| Entry confirmed/disputed | Vendor |
| Payment recorded | Customer |
| Booking status changed | Both parties |
| Salary paid | Staff member |

**Recommended approach:** Firebase Cloud Messaging (FCM) for push, with optional WebSocket for in-app real-time sync.

---

## SECTION 13: DATABASE ENTITIES (Reference)

```sql
users (id, name, phone, role, business_name, business_category, business_address, upi_id, profile_photo_url, fcm_token, created_at)

vendor_customer_links (id, vendor_id, customer_id, status, created_at)

ledger_entries (id, link_id, vendor_id, customer_id, type, amount, description, quantity, unit, status, is_locked, attachment_url, created_by_role, created_at, confirmed_at, auto_confirmed_at, dispute_reason, disputed_at)

staff_members (id, vendor_id, name, phone, role, salary_type, salary_amount, upi_id, join_date, is_active)

attendance_records (id, staff_id, date, status)

salary_payments (id, staff_id, vendor_id, amount, payment_method, upi_transaction_id, month, note, paid_at)

bookings (id, vendor_id, customer_id, slot_id, date, service_type, status, notes, created_at)

appointment_slots (id, vendor_id, start_time, end_time, duration, is_recurring, day_of_week)

notifications (id, user_id, type, title, body, data, is_read, created_at)

payment_transactions (id, vendor_id, customer_id, amount, upi_transaction_id, status, note, entry_ids, created_at)
```

---

*This document must be updated whenever API contracts change. Last updated: 2026-05-14*
