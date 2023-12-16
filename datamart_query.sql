INSERT INTO analysis.dm_rfm_segments (user_id, recency, frequency, monetary_value)
SELECT
    r.user_id,
    r.recency,
    f.frequency,
    m.monetary_value
FROM analysis.tmp_rfm_recency r
JOIN analysis.tmp_rfm_frequency f ON r.user_id = f.user_id
JOIN analysis.tmp_rfm_monetary_value m ON r.user_id = m.user_id;


-- Первые десять строк из таблицы analysis.dm_rfm_segments отсортированные по user_id.

user_id | recency | frequency |monetary_value

   0	   5	     3	          4
   1	   2	     3	          3
   2	   4	     3	          5
   3	   4	     3	          3
   4	   2	     3	          3
   5	   1	     5	          5
   6	   5	     3	          5
   7	   2	     2	          2
   8	   5	     1	          3
   9	   5	     2	          2
