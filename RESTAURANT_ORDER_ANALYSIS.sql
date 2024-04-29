use restaurant_db;



-- OBJECTIVE 1 -->



-- 1. View the menu_items table.
SELECT * FROM menu_items;

-- 2. Find the no. of items on the menu.
SELECT COUNT(*) FROM menu_items;

-- 3. What are the least and most expensive items on the menu?
SELECT * FROM menu_items order by PRICE;  -- LEAST EXPENSIVE

SELECT * FROM menu_items order by PRICE desc;  -- MOST EXPENSIVE

-- 4. How many Italian dishes on the menu?
SELECT count(*) FROM menu_items WHERE CATEGORY = "Italian";

-- 5. What are the least and most expensive Italian dishes on the menu?
SELECT * FROM menu_items WHERE CATEGORY = "Italian" order by price; -- LEAST EXPENSIVE

SELECT * FROM menu_items WHERE CATEGORY = "Italian" order by price desc;  -- MOST EXPENSIVE

-- 6. How many dishes are in each category?
SELECT Category, count(*) AS Dishes_Count FROM menu_items group by CATEGORY ;

-- 7. What is the average dishes price within the each category?
SELECT Category, avg(price) AS Average_Price FROM menu_items group by CATEGORY ;



-- OBJECTIVE 2 -->



-- 1. View the order_details table.
SELECT * FROM ORDER_DETAILS;

-- 2. What is the date range of the table?
SELECT * FROM ORDER_DETAILS order by ORDER_DATE;

SELECT MIN(ORDER_DATE), MAX(ORDER_DATE) FROM ORDER_DETAILS;

-- 3. How many orderss were made within the date range?
SELECT COUNT( distinct ORDER_ID) FROM ORDER_DETAILS;

-- 4. How many items were ordered within the date range?
SELECT COUNT(*) FROM ORDER_DETAILS;

-- 5. Which orders had the most numbers of items?
SELECT ORDER_ID, COUNT( distinct ITEM_ID) AS ITEMS_NUMBER FROM ORDER_DETAILS 
GROUP BY ORDER_ID ORDER BY ITEMS_NUMBER DESC;

-- 6. How many orders had more than 12 items?
SELECT COUNT(*) FROM(SELECT ORDER_ID, COUNT( ITEM_ID) AS ITEMS_NUMBER FROM ORDER_DETAILS 
GROUP BY ORDER_ID HAVING ITEMS_NUMBER > 12) AS ORDER_NUMBERS;



-- OBJECTIVE 3-->



-- 1.Combine the menu_items and order_details tables into a single table.
SELECT * FROM MENU_ITEMS;
SELECT * FROM ORDER_DETAILS;

SELECT * FROM ORDER_DETAILS OD LEFT JOIN MENU_ITEMS MI
		ON OD.ITEM_ID = MI.MENU_ITEM_ID;

-- 2. What were the least and most ordered items? What categories were they in?
SELECT ITEM_NAME, CATEGORY, COUNT(ORDER_DETAILS_ID) AS PURCHASE_NUMBERS
FROM ORDER_DETAILS OD LEFT JOIN MENU_ITEMS MI
	ON OD.ITEM_ID = MI.MENU_ITEM_ID
GROUP BY ITEM_NAME, CATEGORY ORDER BY PURCHASE_NUMBERS DESC;

-- 3. What were the top 5 orders that spent the most money?
SELECT ORDER_ID, SUM(PRICE) AS TOTAL_SPEND
FROM ORDER_DETAILS OD LEFT JOIN MENU_ITEMS MI
		ON OD.ITEM_ID = MI.MENU_ITEM_ID
GROUP BY ORDER_ID 
ORDER BY TOTAL_SPEND DESC LIMIT 5;

-- 4. View the details of the highest spend order. What insights can you gather from the results?
SELECT CATEGORY, COUNT(ITEM_ID)
FROM ORDER_DETAILS OD LEFT JOIN MENU_ITEMS MI
		ON OD.ITEM_ID = MI.MENU_ITEM_ID
WHERE ORDER_ID=440 GROUP BY CATEGORY;

-- 5. View the details of the top 5 highest spend orders. What insights can you gather from the results?
SELECT ORDER_ID, CATEGORY, COUNT(ITEM_ID)
FROM ORDER_DETAILS OD LEFT JOIN MENU_ITEMS MI
		ON OD.ITEM_ID = MI.MENU_ITEM_ID
WHERE ORDER_ID IN (440, 2075, 1957, 330, 2675) GROUP BY ORDER_ID,CATEGORY;

