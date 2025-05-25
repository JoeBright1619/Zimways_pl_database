CREATE TABLE Vendor (
    vendor_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    location VARCHAR2(100),
    status VARCHAR2(20) CHECK (status IN ('active', 'inactive')),
    rating NUMBER(2,1) CHECK (rating BETWEEN 0 AND 5),
    email VARCHAR2(100),
    phone VARCHAR2(20)
);


CREATE TABLE Customer (
    customer_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    phone VARCHAR2(20),
    address VARCHAR2(200)
);


CREATE TABLE Category (
    category_id NUMBER PRIMARY KEY,
    name VARCHAR2(50) UNIQUE NOT NULL
    description VARCHAR2(255)
);


CREATE TABLE Item (
    item_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    price NUMBER(7,2) NOT NULL,
    category_id NUMBER REFERENCES Category(category_id),
    vendor_id NUMBER REFERENCES Vendor(vendor_id)
);


CREATE TABLE Delivery_Driver (
    driver_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    phone VARCHAR2(20),
    status VARCHAR2(20) CHECK (status IN ('available', 'busy', 'inactive'))
);


CREATE TABLE Cart (
    cart_id NUMBER PRIMARY KEY,
    customer_id NUMBER UNIQUE REFERENCES Customer(customer_id),
    created_on DATE DEFAULT SYSDATE
);

CREATE TABLE Cart_Item (
    cart_id NUMBER REFERENCES Cart(cart_id),
    item_id NUMBER REFERENCES Item(item_id),
    quantity NUMBER DEFAULT 1 CHECK (quantity > 0),
    PRIMARY KEY (cart_id, item_id)
);




CREATE TABLE Orders (
    order_id NUMBER PRIMARY KEY,
    customer_id NUMBER REFERENCES Customer(customer_id),
    vendor_id NUMBER REFERENCES Vendor(vendor_id),
    total_amount NUMBER(10, 2) NOT NULL,
    status VARCHAR2(20) CHECK (status IN ('pending','paid','assigned', 'delivered')), 
    order_date DATE DEFAULT SYSDATE,
    driver_id NUMBER REFERENCES Delivery_Driver(driver_id)
);

CREATE TABLE Payment (
    payment_id NUMBER PRIMARY KEY,
    order_id NUMBER REFERENCES Orders(order_id),
    payment_date DATE DEFAULT SYSDATE,
    amount NUMBER(10,2),
    method VARCHAR2(50) CHECK (method IN ('cash', 'mobile money', 'card'))
);