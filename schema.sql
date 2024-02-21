-- Represents the products in the e-commerence store
CREATE TABLE `Products`(
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(255) UNIQUE NOT NULL,
    `type` VARCHAR(255) NOT NULL,
    `categories` VARCHAR(255) NOT NULL,
    `description` TEXT NOT NULL,
    `pricing` DECIMAL(8,2) CHECK (`pricing` >= 0) NOT NULL,
    `quantity`  INT  CHECK (`quantity` > 0) NOT NULL
);

-- Represents personal information about our customers
CREATE TABLE `CustomerInfo`(
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `Username` VARCHAR(255) UNIQUE NOT NULL,
    `Password` VARCHAR(255) UNIQUE NOT NULL,
    `firstname` VARCHAR(255) NOT NULL,
    `lastname` VARCHAR(255) NOT NULL,
    `phonenumber` CHAR(15) NOT NULL
);

-- Represents order information of our customers
CREATE TABLE `Orders`(
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `timeSubmitted` DATETIME NOT NULL,
    `customerID` INT NOT NULL,
    `billingID`  INT NOT NULL,
    `shippingID`  INT NOT NULL
);

-- Represents an association between the order and its products
CREATE TABLE `OrdersandProducts`(
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `quantityPurchased` INT NOT NULL,
    `orderID`  INT NOT NULL,
    `productID`  INT NOT NULL
);

-- Represents payment information of our customers
CREATE TABLE `PaymentInfo`(
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `paymentType` ENUM('Credit', 'Debit') NOT NULL,
    `paymentStatus` ENUM('Approved', 'Declined', 'Pending') NOT NULL,
    `paymentSubmissionTime` DATETIME NOT NULL,
    `amountPaid` DECIMAL(10,2) NOT NULL,
    `orderID`  INT NOT NULL,
    `customerID`  INT NOT NULL
);

-- Reprents shipping information of our customers
CREATE TABLE `Shipping`(
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `shippingAddress` VARCHAR(255) NOT NULL,
    `shippingMethod` ENUM('standard','express') NOT NULL,
    `shippingCost` DECIMAL(4,2)  NOT NULL,
    `carrierName` ENUM('UPS', 'USPS', 'FEDEX') NOT NULL,
    `trackingID` CHAR(20) NOT NULL,
    `orderID`  INT NOT NULL,
    `customerID`  INT NOT NULL,
    `orderStatus` ENUM('Pending','Shipped','Delivered') NOT NULL
);

-- Represents information on current,past and future promotions
CREATE TABLE `Promotion`(
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `promoDescription` TEXT NOT NULL,
    `discountAmount` DECIMAL(5,2) CHECK(`discountAmount` >= 0) NOT NULL,
    `promoStartDate` DATETIME NOT NULL,
    `promoEndDate` DATETIME NOT NULL,
    `productID`  INT NOT NULL
);

-- Represents the reviews left by the customer for a given product
CREATE TABLE `Reviews`(
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `ratingDescription` TEXT NOT NULL,
    `rating` INT NOT NULL,
    `productID`  INT NOT NULL,
    `customerID`  INT NOT NULL
);

-- adding the foreign keys later on since it would cause issues when compiling
ALTER TABLE `Orders`
ADD FOREIGN KEY(`customerID`) REFERENCES `CustomerInfo`(`id`),
ADD FOREIGN KEY(`billingID`) REFERENCES `PaymentInfo`(`id`),
ADD FOREIGN KEY(`shippingID`) REFERENCES `Shipping`(`id`);

ALTER TABLE `OrdersandProducts`
ADD FOREIGN KEY(`orderID`) REFERENCES `Orders`(`id`),
ADD FOREIGN KEY(`productID`) REFERENCES `Products`(`id`);

ALTER TABLE `PaymentInfo`
ADD FOREIGN KEY(`orderID`) REFERENCES `Orders`(`id`),
ADD FOREIGN KEY(`customerID`) REFERENCES `CustomerInfo`(`id`);

ALTER TABLE `Shipping`
ADD FOREIGN KEY(`orderID`) REFERENCES `Orders`(`id`),
ADD FOREIGN KEY(`customerID`) REFERENCES `CustomerInfo`(`id`);

ALTER TABLE `Promotion`
ADD FOREIGN KEY(`productID`) REFERENCES `Products`(`id`);

ALTER TABLE `Reviews`
ADD FOREIGN KEY(`productID`) REFERENCES `Products`(`id`),
ADD FOREIGN KEY(`customerID`) REFERENCES `CustomerInfo`(`id`);

-- Create indexes to speed common searches
CREATE INDEX customer_order_search ON `Shipping`(`orderStatus`,`customerID`);
CREATE INDEX inventory_check ON `Products`(`quantity`);
CREATE INDEX well_recived_products ON `Reviews`(`rating`);

-- Create Views for freqeuent lookups
CREATE VIEW orderMangement AS
SELECT * FROM `CustomerInfo`
WHERE `id` IN (
    SELECT `customerID` FROM `Shipping`
        WHERE `orderStatus`='Pending'
);

CREATE VIEW CurrentTopProducts AS
SELECT `name`,`rating` FROM `Products`
JOIN `Reviews` ON `Products`.`id`=`Reviews`.`productID`
WHERE `rating`>=4
ORDER BY `rating` DESC LIMIT 3;


-- create a stored procedure to check stock levels of products that fall below a certain threshold
DELIMITER //

CREATE PROCEDURE inventory_check()
BEGIN
    SELECT `name`,`quantity`,
    CASE
        WHEN `quantity`<10 THEN 'Low Stock Alert'
        ELSE 'Sufficent Inventory'
    END AS `Inventory Level`
    FROM `Products`;
END//

DELIMITER ;
