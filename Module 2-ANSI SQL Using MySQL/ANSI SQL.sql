
-- Exercise 1: User Upcoming Events
SELECT 
    u.full_name,
    e.title AS event_title,
    e.city,
    e.start_date
FROM 
    Users u
JOIN 
    Registrations r ON u.user_id = r.user_id
JOIN 
    Events e ON r.event_id = e.event_id
WHERE 
    e.status = 'upcoming' AND u.city = e.city
ORDER BY 
    e.start_date;

-- Exercise 2: Top Rated Events
SELECT 
    e.title,
    AVG(f.rating) AS avg_rating,
    COUNT(f.feedback_id) AS feedback_count
FROM 
    Events e
JOIN 
    Feedback f ON e.event_id = f.event_id
GROUP BY 
    e.event_id
HAVING 
    COUNT(f.feedback_id) >= 10
ORDER BY 
    avg_rating DESC;

-- Exercise 3: Inactive Users
SELECT 
    u.full_name, u.email
FROM 
    Users u
LEFT JOIN 
    Registrations r ON u.user_id = r.user_id AND r.registration_date >= CURDATE() - INTERVAL 90 DAY
WHERE 
    r.registration_id IS NULL;

-- Exercise 4: Peak Session Hours
SELECT 
    e.title,
    COUNT(s.session_id) AS session_count
FROM 
    Events e
JOIN 
    Sessions s ON e.event_id = s.event_id
WHERE 
    TIME(s.start_time) >= '10:00:00' AND TIME(s.start_time) < '12:00:00'
GROUP BY 
    e.event_id;

-- Exercise 5: Most Active Cities
SELECT 
    u.city,
    COUNT(DISTINCT u.user_id) AS registered_users
FROM 
    Users u
JOIN 
    Registrations r ON u.user_id = r.user_id
GROUP BY 
    u.city
ORDER BY 
    registered_users DESC
LIMIT 5;

-- Exercise 6: Event Resource Summary
SELECT 
    e.title,
    SUM(CASE WHEN r.resource_type = 'pdf' THEN 1 ELSE 0 END) AS pdf_count,
    SUM(CASE WHEN r.resource_type = 'image' THEN 1 ELSE 0 END) AS image_count,
    SUM(CASE WHEN r.resource_type = 'link' THEN 1 ELSE 0 END) AS link_count
FROM 
    Events e
LEFT JOIN 
    Resources r ON e.event_id = r.event_id
GROUP BY 
    e.event_id;

-- Exercise 7: Low Feedback Alerts
SELECT 
    u.full_name,
    e.title AS event_title,
    f.rating,
    f.comments
FROM 
    Feedback f
JOIN 
    Users u ON f.user_id = u.user_id
JOIN 
    Events e ON f.event_id = e.event_id
WHERE 
    f.rating < 3;

-- Exercise 8: Sessions per Upcoming Event
SELECT 
    e.title,
    COUNT(s.session_id) AS session_count
FROM 
    Events e
LEFT JOIN 
    Sessions s ON e.event_id = s.event_id
WHERE 
    e.status = 'upcoming'
GROUP BY 
    e.event_id;

-- Exercise 9: Organizer Event Summary
SELECT 
    u.full_name AS organizer_name,
    e.status,
    COUNT(e.event_id) AS total_events
FROM 
    Users u
JOIN 
    Events e ON u.user_id = e.organizer_id
GROUP BY 
    u.user_id, e.status;

-- Exercise 10: Feedback Gap
SELECT 
    e.title
FROM 
    Events e
JOIN 
    Registrations r ON e.event_id = r.event_id
LEFT JOIN 
    Feedback f ON e.event_id = f.event_id
WHERE 
    f.feedback_id IS NULL
GROUP BY 
    e.event_id;

-- Exercise 11: Daily New User Count
SELECT 
    registration_date,
    COUNT(*) AS new_users
FROM 
    Users
WHERE 
    registration_date >= CURDATE() - INTERVAL 7 DAY
GROUP BY 
    registration_date
ORDER BY 
    registration_date DESC;

-- Exercise 12: Event with Maximum Sessions
SELECT 
    e.title,
    COUNT(s.session_id) AS session_count
FROM 
    Events e
JOIN 
    Sessions s ON e.event_id = s.event_id
GROUP BY 
    e.event_id
HAVING 
    session_count = (
        SELECT 
            MAX(session_count)
        FROM (
            SELECT 
                COUNT(session_id) AS session_count
            FROM 
                Sessions
            GROUP BY 
                event_id
        ) AS counts
    );

-- Exercise 13: Average Rating per City
SELECT 
    e.city,
    AVG(f.rating) AS avg_rating
FROM 
    Events e
JOIN 
    Feedback f ON e.event_id = f.event_id
GROUP BY 
    e.city;

-- Exercise 14: Most Registered Events
SELECT 
    e.title,
    COUNT(r.registration_id) AS total_registrations
FROM 
    Events e
JOIN 
    Registrations r ON e.event_id = r.event_id
GROUP BY 
    e.event_id
ORDER BY 
    total_registrations DESC
LIMIT 3;

-- Exercise 15: Event Session Time Conflict
SELECT 
    s1.event_id,
    s1.title AS session1,
    s2.title AS session2
FROM 
    Sessions s1
JOIN 
    Sessions s2 ON s1.event_id = s2.event_id AND s1.session_id < s2.session_id
WHERE 
    s1.end_time > s2.start_time AND s1.start_time < s2.end_time;

-- Exercise 16: Unregistered Active Users
SELECT 
    u.full_name,
    u.email,
    u.registration_date
FROM 
    Users u
LEFT JOIN 
    Registrations r ON u.user_id = r.user_id
WHERE 
    u.registration_date >= CURDATE() - INTERVAL 30 DAY
    AND r.registration_id IS NULL;

-- Exercise 17: Multi-Session Speakers
SELECT 
    speaker_name,
    COUNT(session_id) AS session_count
FROM 
    Sessions
GROUP BY 
    speaker_name
HAVING 
    COUNT(session_id) > 1;

-- Exercise 18: Resource Availability Check
SELECT 
    e.title
FROM 
    Events e
LEFT JOIN 
    Resources r ON e.event_id = r.event_id
WHERE 
    r.resource_id IS NULL;

-- Exercise 19: Completed Events with Feedback Summary
SELECT 
    e.title,
    COUNT(DISTINCT r.registration_id) AS total_registrations,
    AVG(f.rating) AS avg_rating
FROM 
    Events e
LEFT JOIN 
    Registrations r ON e.event_id = r.event_id
LEFT JOIN 
    Feedback f ON e.event_id = f.event_id
WHERE 
    e.status = 'completed'
GROUP BY 
    e.event_id;

-- Exercise 20: User Engagement Index
SELECT 
    u.full_name,
    COUNT(DISTINCT r.event_id) AS events_attended,
    COUNT(DISTINCT f.feedback_id) AS feedbacks_given
FROM 
    Users u
LEFT JOIN 
    Registrations r ON u.user_id = r.user_id
LEFT JOIN 
    Feedback f ON u.user_id = f.user_id
GROUP BY 
    u.user_id;

-- Exercise 21: Top Feedback Providers
SELECT 
    u.full_name,
    COUNT(f.feedback_id) AS feedback_count
FROM 
    Users u
JOIN 
    Feedback f ON u.user_id = f.user_id
GROUP BY 
    u.user_id
ORDER BY 
    feedback_count DESC
LIMIT 5;

-- Exercise 22: Duplicate Registrations Check
SELECT 
    user_id,
    event_id,
    COUNT(*) AS reg_count
FROM 
    Registrations
GROUP BY 
    user_id, event_id
HAVING 
    COUNT(*) > 1;

-- Exercise 23: Registration Trends
SELECT 
    DATE_FORMAT(registration_date, '%Y-%m') AS month,
    COUNT(*) AS registrations
FROM 
    Registrations
WHERE 
    registration_date >= CURDATE() - INTERVAL 12 MONTH
GROUP BY 
    month
ORDER BY 
    month;

-- Exercise 24: Average Session Duration per Event
SELECT 
    e.title,
    AVG(TIMESTAMPDIFF(MINUTE, s.start_time, s.end_time)) AS avg_duration_minutes
FROM 
    Events e
JOIN 
    Sessions s ON e.event_id = s.event_id
GROUP BY 
    e.event_id;

-- Exercise 25: Events Without Sessions
SELECT 
    e.title
FROM 
    Events e
LEFT JOIN 
    Sessions s ON e.event_id = s.event_id
WHERE 
    s.session_id IS NULL;
