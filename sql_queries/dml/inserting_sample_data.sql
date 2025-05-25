
INSERT INTO Vendor (vendor_id, name, location, status, rating) VALUES (1, 'FreshFarm Groceries', 'Kigali - Remera', 'active', 4.8);
INSERT INTO Vendor (vendor_id, name, location, status, rating) VALUES (2, 'Bite Bakery', 'Kigali - Kacyiru', 'inactive', 3.5);
INSERT INTO Vendor (vendor_id, name, location, status, rating) VALUES (3, 'Zim Kitchen', 'Huye', 'active', 4.2);




INSERT INTO Customer (customer_id, name, email, phone, address)
VALUES (1, 'Eric Nshimiyimana', 'ericnshi@gmail.com', '+250780111222', 'Kigali - Gisozi');

INSERT INTO Customer (customer_id, name, email, phone, address)
VALUES (2, 'Alice Uwase', 'alice.uwase@example.com', '+250788333444', 'Kigali - Kicukiro');

INSERT INTO Customer (customer_id, name, email, phone, address)
VALUES (3, 'John Mugisha', 'jmugisha@example.com', '+250781555666', 'Huye - Tumba');






INSERT INTO CATEGORY (category_id, name)
VALUES (1, 'Beverages');

INSERT INTO CATEGORY (category_id, name)
VALUES (2, 'Fast Food');






INSERT INTO Item (item_id, name, price, category_id, vendor_id)
VALUES (1, 'Fresh Mango Juice', 2500.00, 1, 1);

INSERT INTO Item (item_id, name, price, category_id, vendor_id)
VALUES (2, 'Veg Burger', 3500.00, 2, 2);

INSERT INTO Item (item_id, name, price, category_id, vendor_id)
VALUES (3, 'Chicken Pizza Slice', 4500.00, 2, 2);

INSERT INTO Item (item_id, name, price, category_id, vendor_id)
VALUES (4, 'Avocado Smoothie', 3000.00, 1, 1);



INSERT INTO Cart (cart_id, customer_id)
VALUES (1, 1);


INSERT INTO Cart_Item (cart_id, item_id, quantity)
VALUES (1, 1, 2);





INSERT INTO Orders (order_id, customer_id, vendor_id, total_amount, status, order_date)
VALUES (1, 1, 1, 5500.00, 'pending', TO_DATE('2025-05-22', 'YYYY-MM-DD'));

-- Order by Alice Uwase from vendor 2
INSERT INTO Orders (order_id, customer_id, vendor_id, total_amount, status, order_date)
VALUES (2, 2, 2, 8000.00, 'delivered', TO_DATE('2025-05-20', 'YYYY-MM-DD'));

-- Order by John Mugisha from vendor 2
INSERT INTO Orders (order_id, customer_id, vendor_id, total_amount, status, order_date)
VALUES (3, 3, 2, 4500.00, 'pending', TO_DATE('2025-05-21', 'YYYY-MM-DD'));







-- Payment for order 1 using mobile money

INSERT INTO Payment (payment_id, order_id, payment_date, amount, method)
VALUES (1, 1, TO_DATE('2025-05-22', 'YYYY-MM-DD'), 5500.00, 'mobile money');

-- Payment for order 2 using card

INSERT INTO Payment (payment_id, order_id, payment_date, amount, method)
VALUES (2, 2, TO_DATE('2025-05-20', 'YYYY-MM-DD'), 8000.00, 'card');

-- Payment for order 3 using cash
INSERT INTO Payment (payment_id, order_id, payment_date, amount, method)
VALUES (3, 3, TO_DATE('2025-05-21', 'YYYY-MM-DD'), 4500.00, 'cash');