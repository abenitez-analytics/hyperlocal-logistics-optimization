-- CLEAN THE SLATE ---
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS couriers;
DROP TABLE IF EXISTS restaurants;

-- CREATE THE RESTAURANTS DIMENSION TABLE ---
CREATE TABLE restaurants (
    restaurant_id TEXT PRIMARY KEY,
    restaurant_name TEXT NOT NULL,
    neighborhood TEXT NOT NULL,
    cuisine_type TEXT NOT NULL,
    avg_prep_time_baseline INTEGER NOT NULL
);

-- CREATE THE COURIERS DIMENSION TABLE ---
CREATE TABLE couriers (
    courier_id TEXT PRIMARY KEY,
    vehicle_type TEXT NOT NULL,
    courier_rating REAL NOT NULL
);

-- CREATE THE ORDERS FACT TABLE ---
CREATE TABLE orders (
    order_id TEXT PRIMARY KEY,
    order_placed_at TEXT NOT NULL, 
    restaurant_id TEXT NOT NULL,
    courier_id TEXT NOT NULL,
    delivery_neighborhood TEXT NOT NULL,
    basket_value_euros REAL NOT NULL,
    delivery_fee_euros REAL NOT NULL,
    commission_euros REAL NOT NULL,
    prep_time_minutes INTEGER NOT NULL,
    courier_wait_minutes INTEGER NOT NULL,
    travel_time_minutes INTEGER NOT NULL,
    is_raining INTEGER NOT NULL CHECK (is_raining IN (0, 1)),
    order_status TEXT NOT NULL CHECK (order_status IN ('Delivered', 'Cancelled')),
    
    -- Defining Relationship Rules (Foreign Keys)
    FOREIGN KEY (restaurant_id) REFERENCES restaurants (restaurant_id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (courier_id) REFERENCES couriers (courier_id) 
        ON DELETE CASCADE ON UPDATE CASCADE
);





