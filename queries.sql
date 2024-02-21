-- Find all the product names that a given customer have ordered

SELECT `name` FROM `Products`
WHERE `id` IN (
    SELECT `productID` FROM `OrdersandProducts`
    WHERE `orderID` IN (
        SELECT `id` FROM `Orders`
        WHERE `customerID`=(
            SELECT `id` FROM `CustomerInfo`
            WHERE `firstname`='Mark' AND `lastname`='Schmidt'
)
)
);

-- Checking shipping status given customer first and last name

SELECT `orderStatus` FROM `Shipping`
WHERE `customerID`=(
        SELECT `id` FROM `CustomerInfo`
        WHERE `firstname`='Mark' AND `lastname`='Schmidt'
);


-- Seeing which products were purchased the most

SELECT `name` FROM `Products`
WHERE `id` IN (
    SELECT `productID` FROM (
        SELECT SUM(`quantityPurchased`) AS `TotalPurchased`, `productID` FROM `OrdersandProducts`
        GROUP BY `productID`
        HAVING `TotalPurchased`=(
            SELECT MAX(`TotalPurchased`)  FROM (
                SELECT SUM(`quantityPurchased`) AS `TotalPurchased`, `productID` FROM `OrdersandProducts`
                GROUP BY `productID`
) AS `alias`
)
) AS `alias2`
);

-- For a seamless insertion lets remove the check for now
SET FOREIGN_KEY_CHECKS = 0;

-- adding new Products
INSERT INTO `Products` (`name`,`type`,`categories`,`description`,`pricing`,`quantity`)
VALUES
('Reining Cookies','Dessert','Food','Get your cookies from reins signature kitchen. It is a treat that have you coming back for more!',1.99,10),
('Apple Vision Pro','Wearable Technology','Electronics', 'Step into the future with the Apple Vision Pro, Apples groundbreaking mixed reality headset.',3499.99,100),
('Herrera-Rodriguez Yoga Mat','Sports','Fitness Equipment','Introducing the Herrera-Rodriguez Yoga Mat, a perfect addition to your fitness equipment collection. Elevate your experience with our top-rated sports!',40.06,14),
('King Ltd Action Figure','Toys','Collectibles','Introducing the King Ltd Action Figure, a perfect addition to your collectibles collection. Elevate your experience with our top-rated toys!',40.07,19),
('Palmer, Murphy and Hickman Cashmere Sweater','Fashion','Clothing','Introducing the Palmer, Murphy and Hickman Cashmere Sweater, a perfect addition to your clothing collection. Elevate your experience with our top-rated fashion!',28.08,16),
('Hernandez-Vazquez Action Figure','Toys','Collectibles','Introducing the Hernandez-Vazquez Action Figure, a perfect addition to your collectibles collection. Elevate your experience with our top-rated toys!',91.04,6),
('Garcia-Jackson Espresso Machine','Home','Kitchen Appliances','Introducing the Garcia-Jackson Espresso Machine, a perfect addition to your kitchen appliances collection. Elevate your experience with our top-rated home!',88.07,6),
('Oconnell LLC Espresso Machine','Home','Kitchen Appliances','Introducing the Oconnell LLC Espresso Machine, a perfect addition to your kitchen appliances collection. Elevate your experience with our top-rated home!',47.03,17),
('Stafford, Gross and Matthews Espresso Machine','Home','Kitchen Appliances','Introducing the Stafford, Gross and Matthews Espresso Machine, a perfect addition to your kitchen appliances collection. Elevate your experience with our top-rated home!',99.03,6),
('Farley, Bruce and Dominguez Action Figure','Toys','Collectibles','Introducing the Farley, Bruce and Dominguez Action Figure, a perfect addition to your collectibles collection. Elevate your experience with our top-rated toys!',9.07,12),
('Rollins Group LED Smart TV','Electronics','Home Entertainment','Introducing the Rollins Group LED Smart TV, a perfect addition to your home entertainment collection. Elevate your experience with our top-rated electronics!',16.03,10),
('Mcdaniel PLC Organic Tea Set','Food','Beverages','Introducing the Mcdaniel PLC Organic Tea Set, a perfect addition to your beverages collection. Elevate your experience with our top-rated food!',64.08,9),
('Thomas, Jones and Hernandez Espresso Machine','Home','Kitchen Appliances','Introducing the Thomas, Jones and Hernandez Espresso Machine, a perfect addition to your kitchen appliances collection. Elevate your experience with our top-rated home!',74.01,8),
('Garcia-Dominguez Eau de Parfum','Beauty','Fragrance','Introducing the Garcia-Dominguez Eau de Parfum, a perfect addition to your fragrance collection. Elevate your experience with our top-rated beauty!',96.03,17),
('York, Stewart and Doyle LED Smart TV','Electronics','Home Entertainment','Introducing the York, Stewart and Doyle LED Smart TV, a perfect addition to your home entertainment collection. Elevate your experience with our top-rated electronics!',8.09,13),
('Ford Ltd Eau de Parfum','Beauty','Fragrance','Introducing the Ford Ltd Eau de Parfum, a perfect addition to your fragrance collection. Elevate your experience with our top-rated beauty!',19.03,15),
('Casey, Thomas and Reid Organic Tea Set','Food','Beverages','Introducing the Casey, Thomas and Reid Organic Tea Set, a perfect addition to your beverages collection. Elevate your experience with our top-rated food!',65.03,7);


-- adding customers information
INSERT INTO `CustomerInfo` (`Username`,`Password`,`firstname`,`lastname`,`phonenumber`)
VALUES
('englishjulie','p5FXuOWd%^','Mark','Schmidt','060-695-9295'),
('zachary46','N2VWIKpn@p','Jesus','Smith','646-373-7931'),
('danielcampos','1nIt4)z)(2','Catherine','Williams','210-238-1008'),
('browncarrie','*#KEGvwr1d','Chad','Smith','763-987-6881'),
('alyssareyes','ug&1t#GgYP','Felicia','Novak','965-341-1994'),
('nancycummings','^ZxCdNmg)5','Jessica','Manning','214-078-9872'),
('katelynmills','#a*O50Ye(3','Sabrina','Jones','973-815-2371'),
('michelle61','(6MzJlNPs0','Shawn','Gross','222-717-3381'),
('fmccoy','sh7G+ngnr*','Steven','Turner','438-245-9090'),
('xmartinez','2$o(8IlH8^','Cassie','Ramirez','133-951-6205'),
('eatkins','FRLNuEFj+0','Dean','Santos','791-590-6121'),
('reynoldscharles','DU4PAoQmU&','Steven','Vaughan','520-861-5061'),
('hhodges','o*Z5Kw9vla','Nicholas','Castaneda','826-737-9181'),
('jimenezjessica','$L%3UZjftS','Travis','Parsons','261-053-8077'),
('wyattanthony','r8#M2Bv(ZQ','Michael','Velez','873-162-4030');

-- adding order information
INSERT INTO `Orders`(`timeSubmitted`,`customerID`,`billingID`,`shippingID`)
VALUES
('2023-12-31 07:47:12',10,1,1),
('2023-10-25 13:56:06',6,2,2),
('2023-08-07 08:59:44',11,3,3),
('2023-04-25 22:38:16',7,4,4),
('2023-05-21 21:09:07',14,5,5),
('2023-08-17 23:39:32',15,6,6),
('2024-02-02 11:06:35',1,7,7),
('2023-07-01 04:12:26',2,8,8),
('2023-12-28 11:22:41',5,9,9),
('2023-08-26 08:58:18',12,10,10),
('2023-08-03 10:47:55',8,11,11),
('2023-06-20 03:53:11',3,12,12),
('2023-11-07 02:11:30',10,13,13),
('2023-03-29 21:26:54',11,14,14),
('2023-09-15 05:56:25',1,15,15);

-- adding the orders id with its associated products and amount purchased
INSERT INTO `OrdersandProducts`(`quantityPurchased`,`orderID`,`productID`)
VALUES
(2,1,1),
(3,1,2),
(1,2,3),
(4,2,4),
(5,3,5),
(2,3,6),
(3,4,7),
(1,4,8),
(4,5,9),
(5,5,10),
(6,6,11),
(2,6,12),
(1,7,13),
(3,7,14),
(4,8,15),
(5,8,1),
(6,9,2),
(2,9,3),
(1,10,4),
(3,10,5),
(4,11,6),
(5,11,7),
(6,12,8),
(2,12,9),
(1,13,10),
(3,13,11),
(4,14,12),
(5,14,13),
(6,15,14),
(2,15,15);


-- adding customer payment info, includes shipping costs and discounts applied
INSERT INTO `PaymentInfo`(`paymentType`,`paymentStatus`,`paymentSubmissionTime`,`amountPaid`,`orderID`,`customerID`)
VALUES
('credit', 'approved', '2023-06-20 03:53:11',10509.14, 1, 10),
('debit', 'pending', '2023-10-25 13:56:06', 186.28, 2, 6),
('credit', 'declined', '2023-08-07 08:59:44',278.47,3, 11),
('debit', 'approved', '2023-04-25 22:38:16', 311.24, 4, 7),
('credit', 'pending', '2023-05-21 21:09:07', 447.46, 5, 14),
('debit', 'approved', '2023-08-17 23:39:32',234.33, 6, 15),
('credit', 'declined', '2024-02-02 11:06:35',368.09, 7, 1),
('debit', 'pending', '2023-07-01 04:12:26',50.31 , 8, 2),
('credit', 'approved', '2023-12-28 11:22:41',21086.05, 9, 5),
('debit', 'declined', '2023-08-26 08:58:18',98.28, 10, 12),
('credit', 'pending', '2023-08-03 10:47:55', 804.51, 11, 8),
('debit', 'approved', '2023-06-20 03:53:11', 490.23, 12, 3),
('credit', 'declined', '2023-11-07 02:11:30',63.15, 13, 10),
('debit', 'pending', '2023-03-29 21:26:54',636.36 , 14, 11),
('credit', 'approved', '2023-09-15 05:56:25', 598.35, 15, 1);

-- adding shipping information, even if transaction was declined it would at least have stored the attempted shipping
INSERT INTO `Shipping`(`shippingAddress`,`shippingMethod`,`shippingCost`,`carrierName`,`trackingID`,`orderID`,`customerID`,`orderStatus`)
VALUES
('1234 Elm St, Springfield', 'standard', 5.99, 'USPS', 'US123456789', 1, 10,'Delivered'),
('5678 Maple Ave, Anytown', 'express', 9.99, 'UPS', 'UP123456789', 2, 6,'Pending'),
('91011 Oak Rd, Smallville', 'standard', 5.99, 'FEDEX', 'FE123456789', 3, 11,'Pending'),
('1213 Pine St, Metropolis', 'express', 0.00, 'USPS', 'US987654321', 4, 7,'Shipped'),
('1415 Birch Ln, Gotham', 'standard', 5.99, 'UPS', 'UP987654321', 5, 14,'Pending'),
('1617 Cedar Pl, Star City', 'express', 9.99, 'FEDEX', 'FE987654321', 6, 15,'Shipped'),
('1819 Spruce Blvd, Central City', 'standard', 5.99, 'USPS', 'US192837465', 7, 1,'Pending'),
('2021 Willow Way, Keystone', 'express', 9.99, 'UPS', 'UP192837465', 8, 2,'Pending'),
('2223 Elm St, Coast City', 'standard', 5.99, 'FEDEX', 'FE192837465', 9, 5,'Delivered'),
('2425 Maple Ave, Midway', 'express', 9.99, 'USPS', 'US564738291', 10, 12,'Pending'),
('2627 Oak Rd, National City', 'standard', 0.00, 'UPS', 'UP564738291', 11, 8,'Pending'),
('2829 Pine St, Jump City', 'express', 9.99, 'FEDEX', 'FE564738291', 12, 3,'Shipped'),
('3031 Birch Ln, Bludhaven', 'standard', 5.99, 'USPS', 'US647382910', 13, 10,'Pending'),
('3233 Cedar Pl, Hub City', 'express', 9.99, 'UPS', 'UP647382910', 14, 11,'Pending'),
('1819 Spruce Blvd, Central City', 'standard', 5.99, 'FEDEX', 'FE647382910', 15, 1,'Delivered');

-- adding promotions
INSERT INTO `Promotion`(`promoDescription`,`discountAmount`,`promoStartDate`,`promoEndDate`,`productID`)
VALUES
('Enjoy 20% off Reins Cookies this Spring', 0.20, '2023-03-29 00:00:00', '2023-06-20 23:59:59', 1),
('Limited Time: $500 off Apple Vision Pro', 500.00, '2023-10-25 00:00:00', '2023-11-07 23:59:59', 2),
('Summer Yoga Special: Buy One Get One Free on Yoga Mats', 40.06, '2023-06-21 00:00:00', '2023-11-17 23:59:59', 3),
('15% Off King Ltd Action Figures for Early Birds', 0.15, '2023-08-25 00:00:00', '2023-11-21 23:59:59', 4),
('Exclusive Early Spring $10 off Cashmere Sweaters', 10.00, '2023-08-02 00:00:00', '2023-09-28 23:59:59', 5),
('Winter Warm-Up: Free Shipping on All Espresso Machines', 0.00, '2023-03-28 00:00:00', '2023-12-02 23:59:59', 7);

-- adding reviews
INSERT INTO `Reviews`(`ratingDescription`,`rating`,`productID`,`customerID`)
VALUES
('Excellent product, highly recommend!', 5, 1, 10),
('Good quality, but took a while to arrive.', 4, 3, 6),
('Decent for the price.', 3, 5, 11),
('Not what I expected, slightly disappointed.', 2, 7, 7),
('Product was defective, had to return.', 1, 9, 14),
('Love it! Works better than expected.', 5,11, 15),
('Satisfactory, but I have seen better.', 3, 13, 1),
('Great value for the money.', 4, 15, 2),
('Product did not meet my expectations.', 2, 3, 5),
('Absolutely fantastic! Buying another one soon.', 5, 4, 12),
('Average product, nothing special.', 3, 6, 8),
('Disappointed with the quality.', 1, 8, 3),
('Very happy with this purchase. Highly recommend!', 5, 10, 10),
('Product is okay, but shipping was slow.', 3, 5, 11),
('Incredible performance, well worth the price.', 5, 14, 1);

-- set it back :)
SET FOREIGN_KEY_CHECKS = 1;
