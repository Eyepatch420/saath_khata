# SaathKhata Backend Infrastructure & API Specification

## 1. Project Overview
**SaathKhata** (Together Ledger) is a two-sided digital ledger application designed for the Indian informal economy. It facilitates a shared source of truth between vendors (service providers) and customers. 

### Core Tech Stack Requirements:
- **Database:** PostgreSQL (Relational integrity is crucial for financial ledgers).
- **Authentication:** JWT (JSON Web Token) with Mobile OTP-based login.
- **Language:** Node.js (Express/Fastify) or Python (Django/FastAPI) recommended.
- **Real-time:** WebSockets or Supabase Realtime for instant ledger updates.

---

## 2. Database Schema (PostgreSQL)

### Users Table
Stores basic user information for both Vendors and Customers.
```sql
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    mobile VARCHAR(15) UNIQUE NOT NULL,
    full_name VARCHAR(100),
    role VARCHAR(20) CHECK (role IN ('vendor', 'customer', 'both')),
    preferred_language VARCHAR(10) DEFAULT 'en',
    upi_id VARCHAR(100),
    profile_photo_url TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
```

### Businesses Table (Vendor Profiles)
Additional details required for users acting as Vendors.
```sql
CREATE TABLE businesses (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    owner_id UUID REFERENCES users(id),
    business_name VARCHAR(150) NOT NULL,
    category VARCHAR(50), -- e.g., 'Milk / Dairy', 'Kirana', etc.
    address TEXT,
    upi_id VARCHAR(100), -- Business specific UPI if different from user
    working_hours JSONB, -- { "start": "08:00", "end": "20:00" }
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
```

### Links Table (Relationships)
Manages the connection between a Vendor and a Customer.
```sql
CREATE TABLE ledger_links (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    vendor_id UUID REFERENCES businesses(id),
    customer_id UUID REFERENCES users(id),
    status VARCHAR(20) DEFAULT 'pending', -- 'pending', 'active', 'blocked'
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(vendor_id, customer_id)
);
```

### Ledger Entries Table
The core transactions.
```sql
CREATE TABLE ledger_entries (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    link_id UUID REFERENCES ledger_links(id),
    amount DECIMAL(12, 2) NOT NULL,
    type VARCHAR(20) CHECK (type IN ('credit', 'payment', 'advance', 'adjustment')),
    description TEXT,
    quantity DECIMAL(10, 2),
    unit VARCHAR(20), -- 'litre', 'kg', 'piece', etc.
    status VARCHAR(20) DEFAULT 'pending', -- 'pending', 'confirmed', 'disputed', 'auto_confirmed'
    created_by UUID REFERENCES users(id),
    bill_photo_url TEXT,
    confirmed_at TIMESTAMP WITH TIME ZONE,
    is_locked BOOLEAN DEFAULT FALSE, -- Set to TRUE once confirmed
    metadata JSONB, -- For OCR/Voice parsing data
    date DATE DEFAULT CURRENT_DATE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
```

### Staff Table
```sql
CREATE TABLE staff (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    business_id UUID REFERENCES businesses(id),
    name VARCHAR(100) NOT NULL,
    mobile VARCHAR(15),
    wage_type VARCHAR(20) CHECK (wage_type IN ('daily', 'monthly')),
    rate DECIMAL(10, 2), -- daily wage or monthly salary
    upi_id VARCHAR(100),
    joined_at DATE DEFAULT CURRENT_DATE
);
```

### Attendance Table
```sql
CREATE TABLE attendance (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    staff_id UUID REFERENCES staff(id),
    date DATE DEFAULT CURRENT_DATE,
    status VARCHAR(2) CHECK (status IN ('P', 'A', 'H', 'X')), -- Present, Absent, Half-day, Holiday
    marked_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(staff_id, date)
);
```

### Appointments Table
```sql
CREATE TABLE appointments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    vendor_id UUID REFERENCES businesses(id),
    customer_id UUID REFERENCES users(id),
    service_details JSONB, -- List of services selected
    scheduled_at TIMESTAMP WITH TIME ZONE NOT NULL,
    status VARCHAR(20) DEFAULT 'booked', -- 'booked', 'confirmed', 'completed', 'cancelled'
    entry_id UUID REFERENCES ledger_entries(id), -- Linked entry once completed
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
```

---

## 3. API Endpoints

### 3.1 Authentication
- `POST /auth/send-otp`: Request 6-digit OTP to mobile.
- `POST /auth/verify-otp`: Returns JWT + User details (or "new_user" flag).
- `POST /auth/refresh`: Refresh JWT token.

### 3.2 User & Profile
- `GET /user/profile`: Get current user info.
- `PUT /user/profile`: Update name, photo, language, UPI.
- `POST /vendor/register`: Convert user to vendor/setup business profile.

### 3.3 Vendor-Customer Linking
- `GET /links`: List all active relationships.
- `POST /links/request`: Send link request via mobile number or scanning QR.
- `POST /links/respond`: Accept/Reject a link request.

### 3.4 Ledger Management
- `GET /ledger/:link_id`: Fetch all entries for a specific ledger.
- `POST /ledger/entry`: Create a new entry (Credit/Payment).
- `PATCH /ledger/entry/:id/status`: Update status (Confirm/Dispute).
- `GET /ledger/summary/vendor`: Get total outstanding and today's collection for vendor dashboard.
- `GET /ledger/summary/customer`: Get total due across all vendors for customer dashboard.

### 3.5 Staff & Attendance
- `GET /staff`: List all staff for a business.
- `POST /staff`: Add new staff member.
- `POST /attendance`: Mark attendance for a specific date.
- `GET /staff/:id/salary-summary`: Calculate pending salary based on attendance.

### 3.6 Appointments
- `GET /appointments`: List appointments (filtered by date/role).
- `POST /appointments/book`: Customer books a slot.
- `PATCH /appointments/:id/status`: Update status (Confirm/Complete/Cancel).
- `GET /vendor/availability`: Check vendor's open slots for a date.

### 3.7 Voice & OCR (Processing)
- `POST /process/voice`: Send audio or transcribed text -> Returns parsed JSON (amount, item, quantity, type).
- `POST /process/ocr`: Send bill image -> Returns extracted data for confirmation.

---

## 4. Key Business Logic & Rules

### 4.1 Immutability
Once a `ledger_entry` status is changed to `confirmed`, the `is_locked` field must be set to `TRUE`. The backend **must enforce** that locked entries cannot be edited or deleted by anyone.

### 4.2 Auto-Confirmation
A background job (Cron) should run every hour to check for entries in `pending` status that are older than 24 hours. These should be automatically transitioned to `auto_confirmed` if the vendor has this setting enabled.

### 4.3 Two-Sided Visibility
Every entry created by a Vendor must trigger a real-time notification (FCM) to the Customer. Both parties read from the same `ledger_entries` table filtered by their `link_id`.

### 4.4 Multi-Language Support
The backend should support sending SMS/WhatsApp notifications in the user's `preferred_language`. API error messages should ideally be localized or provide error codes for frontend translation.

---

## 5. Security Requirements
1. **JWT Auth:** All endpoints (except OTP) must require a valid Bearer token.
2. **Ownership:** Ensure users can only access/modify ledgers where they are either the linked `vendor` or `customer`.
3. **Data Integrity:** Use DB transactions for ledger entries to ensure balance calculations remain consistent.
4. **Encryption:** Sensitive info like UPI IDs should be handled securely.

---

## 6. Data Points for Dashboards

### Vendor Dashboard
- `total_outstanding`: Sum of all `credit` entries minus `payment` entries across all linked customers.
- `today_collection`: Sum of all `payment` entries created today.
- `recent_customers`: List of linked customers with their individual running balances.

### Customer Dashboard
- `total_due`: Sum of all outstanding balances across all vendors.
- `vendor_list`: List of linked vendors with their business name, category, and current balance.
