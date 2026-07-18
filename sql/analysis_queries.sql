SELECT -- Compares avg times.
    'V1 (Baseline Noise)' AS dataset_version,
    ROUND(AVG(courier_wait_minutes), 1) AS avg_wait_time,
    ROUND(AVG(travel_time_minutes), 1) AS avg_transit_time
FROM orders
UNION ALL
SELECT 
    'V2 (Traffic & Scarcity Integrated)' AS dataset_version,
    ROUND(AVG(courier_wait_minutes), 1) AS avg_wait_time,
    ROUND(AVG(travel_time_minutes), 1) AS avg_transit_time
FROM orders_v2;
    



SELECT 
    delivery_neighborhood,
    COUNT(order_id) AS total_orders,
    ROUND(AVG(prep_time_minutes), 1) AS avg_cooking_time,
    ROUND(AVG(courier_wait_minutes), 1) AS avg_courier_wait,
    ROUND(AVG(travel_time_minutes), 1) AS avg_transit_time,
    -- Total delivery duration from placement to doorstep
    ROUND(AVG(prep_time_minutes + travel_time_minutes), 1) AS avg_total_cycle_time
FROM orders_v2 
WHERE order_status = 'Delivered'
GROUP BY delivery_neighborhood 
ORDER BY avg_total_cycle_time DESC; 



WITH PeakHourOrders AS (
    SELECT *,
        -- Extract the hour from our standardized timestamp text
        CAST(SUBSTR(order_placed_at, 12, 2) AS INTEGER) AS placement_hour
    FROM orders_v2
)
SELECT 
    is_raining,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(basket_value_euros), 2) AS gross_merchandise_value,
    ROUND(SUM(commission_euros), 2) AS platform_commission,
    ROUND(AVG(travel_time_minutes), 1) AS avg_travel_time
FROM PeakHourOrders
WHERE placement_hour IN (13, 14, 19, 20) -- Focus exclusively on lunch & dinner rushes
GROUP BY is_raining;


WITH RankedCouriers AS (
    SELECT
        courier_id,
        vehicle_type,
        courier_rating,
        -- Rank couriers within their vehicle asset type
        PERCENT_RANK() OVER (
            PARTITION BY vehicle_type
            ORDER BY courier_rating ASC     
        ) AS rating_percentile
    FROM couriers 
)
SELECT 
    courier_id,2
    vehicle_type,
    courier_rating,
    ROUND(rating_percentile * 100, 1) AS percentile_score
FROM RankedCouriers 
WHERE rating_percentile <= 0.10 -- Filters for the bottom 10%
ORDER BY vehicle_type, courier_rating ASC;