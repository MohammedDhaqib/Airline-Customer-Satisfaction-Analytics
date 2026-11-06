-- Airline Customer Satisfaction & Service Analytics
-- Database: airline_analysis
-- Table: passengers
-- Check your actual table/column names before running these statements.

-- 1. Total records
SELECT COUNT(*) AS total_passengers
FROM passengers;

-- 2. Missing arrival-delay values
SELECT COUNT(*) AS missing_arrival_delay
FROM passengers
WHERE arrival_delay_minutes IS NULL;

-- 3. Satisfaction distribution
SELECT
    satisfaction,
    COUNT(*) AS passenger_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM passengers
GROUP BY satisfaction
ORDER BY passenger_count DESC;

-- 4. Satisfaction rate by class
SELECT
    class,
    COUNT(*) AS total_passengers,
    SUM(CASE WHEN satisfaction = 'satisfied' THEN 1 ELSE 0 END) AS satisfied_passengers,
    ROUND(
        100.0 * SUM(CASE WHEN satisfaction = 'satisfied' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0), 2
    ) AS satisfaction_rate_pct
FROM passengers
GROUP BY class
ORDER BY satisfaction_rate_pct DESC;

-- 5. Satisfaction rate by customer type
SELECT
    customer_type,
    COUNT(*) AS total_passengers,
    ROUND(
        100.0 * SUM(CASE WHEN satisfaction = 'satisfied' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0), 2
    ) AS satisfaction_rate_pct
FROM passengers
GROUP BY customer_type
ORDER BY satisfaction_rate_pct DESC;

-- 6. Satisfaction by departure-delay category
WITH delay_groups AS (
    SELECT
        CASE
            WHEN departure_delay_minutes = 0 THEN 'On Time'
            WHEN departure_delay_minutes BETWEEN 1 AND 15 THEN 'Short Delay'
            WHEN departure_delay_minutes BETWEEN 16 AND 60 THEN 'Moderate Delay'
            ELSE 'Long Delay'
        END AS delay_category,
        satisfaction
    FROM passengers
)
SELECT
    delay_category,
    COUNT(*) AS passenger_count,
    SUM(CASE WHEN satisfaction = 'satisfied' THEN 1 ELSE 0 END) AS satisfied_passengers,
    ROUND(
        100.0 * SUM(CASE WHEN satisfaction = 'satisfied' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0), 2
    ) AS satisfaction_rate_pct
FROM delay_groups
GROUP BY delay_category
ORDER BY CASE delay_category
    WHEN 'On Time' THEN 1
    WHEN 'Short Delay' THEN 2
    WHEN 'Moderate Delay' THEN 3
    ELSE 4
END;

-- 7. Average service ratings (selected fields)
SELECT
    ROUND(AVG(inflight_wifi_service), 2) AS avg_wifi,
    ROUND(AVG(ease_of_online_booking), 2) AS avg_online_booking,
    ROUND(AVG(food_and_drink), 2) AS avg_food_and_drink,
    ROUND(AVG(online_boarding), 2) AS avg_online_boarding,
    ROUND(AVG(seat_comfort), 2) AS avg_seat_comfort,
    ROUND(AVG(inflight_entertainment), 2) AS avg_entertainment,
    ROUND(AVG(on_board_service), 2) AS avg_onboard_service,
    ROUND(AVG(leg_room_service), 2) AS avg_leg_room,
    ROUND(AVG(baggage_handling), 2) AS avg_baggage_handling,
    ROUND(AVG(checkin_service), 2) AS avg_checkin,
    ROUND(AVG(cleanliness), 2) AS avg_cleanliness
FROM passengers;

-- 8. Average selected service ratings by satisfaction
SELECT
    satisfaction,
    ROUND(AVG(online_boarding), 2) AS avg_online_boarding,
    ROUND(AVG(inflight_entertainment), 2) AS avg_entertainment,
    ROUND(AVG(inflight_wifi_service), 2) AS avg_wifi
FROM passengers
GROUP BY satisfaction
ORDER BY satisfaction;

-- 9. Average delays by satisfaction
-- AVG ignores NULL arrival_delay_minutes values.
SELECT
    satisfaction,
    ROUND(AVG(departure_delay_minutes), 2) AS avg_departure_delay,
    ROUND(AVG(arrival_delay_minutes), 2) AS avg_arrival_delay
FROM passengers
GROUP BY satisfaction
ORDER BY satisfaction;
