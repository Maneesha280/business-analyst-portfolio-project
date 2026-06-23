/* ---------------------------------------------------------
   Project: Customer Support Ticket Optimization System
   File: Ticket_Analysis_SQL_Scripts.sql
   Description: SQL queries for analyzing ticket performance,
                resolution times, agent efficiency, and
                escalation patterns.
---------------------------------------------------------- */


/* ---------------------------------------------------------
   1. Ticket Volume by Category
   Purpose: Identify which categories receive the most tickets
---------------------------------------------------------- */
SELECT 
    category, 
    COUNT(ticket_id) AS total_tickets
FROM tickets
GROUP BY category
ORDER BY total_tickets DESC;



/* ---------------------------------------------------------
   2. Average Resolution Time
   Purpose: Measure how long it takes to resolve tickets
---------------------------------------------------------- */
SELECT 
    category,
    ROUND(AVG(DATEDIFF(resolution_date, creation_date)), 2) 
        AS avg_resolution_days
FROM tickets
WHERE status = 'Resolved'
GROUP BY category
ORDER BY avg_resolution_days ASC;



/* ---------------------------------------------------------
   3. Agent Performance
   Purpose: Evaluate agent workload and efficiency
---------------------------------------------------------- */
SELECT 
    agent_name,
    COUNT(ticket_id) AS tickets_handled,
    ROUND(AVG(DATEDIFF(resolution_date, creation_date)), 2) 
        AS avg_resolution_days
FROM tickets
WHERE status = 'Resolved'
GROUP BY agent_name
ORDER BY tickets_handled DESC;



/* ---------------------------------------------------------
   4. Escalation Rate
   Purpose: Identify categories with high escalation frequency
---------------------------------------------------------- */
SELECT 
    category,
    COUNT(CASE WHEN escalated = 'Yes' THEN 1 END) 
        AS escalated_tickets,
    COUNT(ticket_id) AS total_tickets,
    ROUND(
        (COUNT(CASE WHEN escalated = 'Yes' THEN 1 END) 
         * 100.0 / COUNT(ticket_id)), 
        2
    ) AS escalation_rate
FROM tickets
GROUP BY category
ORDER BY escalation_rate DESC;



/* ---------------------------------------------------------
   End of File
---------------------------------------------------------- */
