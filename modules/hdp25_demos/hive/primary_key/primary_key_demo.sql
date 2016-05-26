CREATE TABLE product 
( 
   product_id        INT,
   product_vendor_id INT,
   PRIMARY KEY (product_id) DISABLE NOVALIDATE,
   CONSTRAINT product_fk_1 FOREIGN KEY (product_vendor_id) REFERENCES vendor(vendor_id)  DISABLE NOVALIDATE
); 

CREATE TABLE vendor 
( 
   vendor_id INT,
   PRIMARY KEY (vendor_id) DISABLE NOVALIDATE RELY
); 
