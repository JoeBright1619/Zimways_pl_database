# Zimways Food Delivery Management System

## 👥 Student Information
- **Name:** Kirenga Joe Bright  
- **Student ID:** 25823

## 📝 Problem Statement

The **Zimways Food Delivery Management System** aims to improve product delivery in Zimbabwe by providing a secure and reliable platform for transactions between customers and vendors.

### Key Requirements
- Prevent table manipulations (`INSERT`, `UPDATE`, `DELETE`) during weekdays (Monday to Friday) and public holidays
- Implement PL/SQL-based auditing mechanism to log operations
- Enforce business rules and maintain data integrity
- Track user activities with detailed audit logs

## 📊 Database Implementation

### Core Components

#### 1. Audit Logging System
The system implements a comprehensive audit logging mechanism through the `audit_pkg` package:

```sql
CREATE OR REPLACE PACKAGE audit_pkg AS
    PROCEDURE log_item_action(
        p_user    VARCHAR2,
        p_op      VARCHAR2,
        p_status  VARCHAR2,
        p_message VARCHAR2
    );
END audit_pkg;
```

**Key Features**:
- Real-time operation logging
- User action tracking with timestamps
- Status and message recording
- Secure audit trail maintenance

**Implementation Details**:
- Logs are stored in `Item_Audit_Log` table
- Each log entry captures:
  - User ID
  - Action timestamp
  - Operation type
  - Status
  - Detailed message

#### 2. Business Rules Enforcement
The system implements business rules through triggers to:
- Restrict operations during weekdays and holidays
- Validate data modifications
- Maintain data integrity
- Generate audit trails

**Security Features**:
- Operation restrictions during business hours
- Automatic audit trail generation
- User action tracking
- Data modification validation

## 📸 Implementation Screenshots

### User Interface Flow
1. **User Authentication**
   ![User Display](screenshots/user_display.PNG)
   *User interface showing a random customer that we'll use to carry out an order*

2. **Product Selection**
   ![Items Chosen](screenshots/items_chosen.PNG)
   *the vendor chooses the highlighted items*

3. **Cart Management**
   ![Add to Cart](screenshots/add_items_to_cart.PNG)
   ![Cart ID Display](screenshots/displays_cartId.PNG)
   ![Cart Items](screenshots/cart_items.PNG)
   *Cart management process showing item addition and cart items after addition*

4. **Order Processing**
   ![Place Order](screenshots/place_order_with_customer_id.PNG)
   ![Order Initiated](screenshots/order_initiated.PNG)
   ![Cart Cleared](screenshots/cart_items_cleared.PNG)
   *Complete order placement flow*

5. **Payment and Delivery**
   ![Payment Made](screenshots/payment_made.PNG)
   ![Order Status](screenshots/order_status_after_payment.PNG)
   ![Delivery Confirmation](screenshots/delivered_product.PNG)
   *Payment processing and delivery confirmation*

### Database Design
![Entity Relationship Diagram](screenshots/zimways_entity_relationship.drawio.png)
*Database entity relationship diagram*

![Business Model](screenshots/zimways_business_model.drawio.png)
*System business model diagram*

## 📁 Project Structure
```
sql_queries/
├── packages/      # Contains audit_pkg for logging
├── triggers/      # Business rules and restrictions
├── procedures/    # Business logic procedures
├── ddl/          # Table definitions
├── dml/          # Data operations
└── window_functions/  # Analytical queries
```

## 🔒 Security Features
- Restricted operations during weekdays and holidays
- Comprehensive audit logging
- Data integrity enforcement
- User activity tracking