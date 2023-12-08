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

  71	   3	     3	          1
  74	   3	     4	          1
  109	   5	     4	          1
  127	   5	     4	          1
  128	   3	     4	          1
  159	   1	     4	          1
  166	   5	     4	          1
  172	   3	     4	          1
  211	   5	     1	          1
  224	   5	     1	          1
