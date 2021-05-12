WITH tab       AS (
                  SELECT t.cohort_definition_id,
                         t.subject_id,
                         t.cohort_start_date,
                         coalesce(min(o.cohort_start_date), max(t.cohort_end_date)) AS event_date,
                         CASE WHEN min(o.cohort_start_date) IS NULL THEN 0 ELSE 1 END AS event
                  FROM @cohort_database_schema.@cohort_table t
                  LEFT JOIN @cohort_database_schema.@cohort_table o
                      ON t.subject_id = o.subject_id
                          AND o.cohort_start_date >= t.cohort_start_date
                          AND o.cohort_start_date <= t.cohort_end_date
                          AND o.cohort_definition_id = @outcome_id
                  WHERE t.cohort_definition_id  IN (101, 103, 111, 117, 105, 107, 109, 113, 115, 102, 104, 112, 118, 106, 108, 110, 114, 116, 119, 120, 337, 101000011, 102000011, 103000011, 104000011, 105000011, 106000011, 107000011, 108000011, 109000011, 110000011, 111000011, 112000011, 113000011, 114000011, 115000011, 116000011, 117000011, 118000011, 119000011, 120000011, 101000021, 102000021, 103000021, 104000021, 105000021, 106000021, 107000021, 108000021, 109000021, 110000021, 111000021, 112000021, 113000021, 114000021, 115000021, 116000021, 117000021, 118000021, 119000021, 120000021, 101000061, 102000061, 103000061, 104000061, 105000061, 106000061, 107000061, 108000061, 109000061, 110000061, 111000061, 112000061, 113000061, 114000061, 115000061, 116000061, 117000061, 118000061, 119000061, 120000061, 101000071, 102000071, 103000071, 104000071, 105000071, 106000071, 107000071, 108000071, 109000071, 110000071, 111000071, 112000071, 113000071, 114000071, 115000071, 116000071, 117000071, 118000071, 119000071, 120000071, 101003011, 102003011, 103003011, 104003011, 105003011, 106003011, 107003011, 108003011, 109003011, 110003011, 111003011, 112003011, 113003011, 114003011, 115003011, 116003011, 117003011, 118003011, 119003011, 120003011, 101003021, 102003021, 103003021, 104003021, 105003021, 106003021, 107003021, 108003021, 109003021, 110003021, 111003021, 112003021, 113003021, 114003021, 115003021, 116003021, 117003021, 118003021, 119003021, 120003021, 101003031, 102003031, 103003031, 104003031, 105003031, 106003031, 107003031, 108003031, 109003031, 110003031, 111003031, 112003031, 113003031, 114003031, 115003031, 116003031, 117003031, 118003031, 119003031, 120003031, 101003041, 102003041, 103003041, 104003041, 105003041, 106003041, 107003041, 108003041, 109003041, 110003041, 111003041, 112003041, 113003041, 114003041, 115003041, 116003041, 117003041, 118003041, 119003041, 120003041, 101003051, 102003051, 103003051, 104003051, 105003051, 106003051, 107003051, 108003051, 109003051, 110003051, 111003051, 112003051, 113003051, 114003051, 115003051, 116003051, 117003051, 118003051, 119003051, 120003051, 101003061, 102003061, 103003061, 104003061, 105003061, 106003061, 107003061, 108003061, 109003061, 110003061, 111003061, 112003061, 113003061, 114003061, 115003061, 116003061, 117003061, 118003061, 119003061, 120003061, 101003071, 102003071, 103003071, 104003071, 105003071, 106003071, 107003071, 108003071, 109003071, 110003071, 111003071, 112003071, 113003071, 114003071, 115003071, 116003071, 117003071, 118003071, 119003071, 120003071, 101003081, 102003081, 103003081, 104003081, 105003081, 106003081, 107003081, 108003081, 109003081, 110003081, 111003081, 112003081, 113003081, 114003081, 115003081, 116003081, 117003081, 118003081, 119003081, 120003081, 101003091, 102003091, 103003091, 104003091, 105003091, 106003091, 107003091, 108003091, 109003091, 110003091, 111003091, 112003091, 113003091, 114003091, 115003091, 116003091, 117003091, 118003091, 119003091, 120003091, 101003101, 102003101, 103003101, 104003101, 105003101, 106003101, 107003101, 108003101, 109003101, 110003101, 111003101, 112003101, 113003101, 114003101, 115003101, 116003101, 117003101, 118003101, 119003101, 120003101, 101003111, 102003111, 103003111, 104003111, 105003111, 106003111, 107003111, 108003111, 109003111, 110003111, 111003111, 112003111, 113003111, 114003111, 115003111, 116003111, 117003111, 118003111, 119003111, 120003111, 101003121, 102003121, 103003121, 104003121, 105003121, 106003121, 107003121, 108003121, 109003121, 110003121, 111003121, 112003121, 113003121, 114003121, 115003121, 116003121, 117003121, 118003121, 119003121, 120003121, 101003131, 102003131, 103003131, 104003131, 105003131, 106003131, 107003131, 108003131, 109003131, 110003131, 111003131, 112003131, 113003131, 114003131, 115003131, 116003131, 117003131, 118003131, 119003131, 120003131, 101003141, 102003141, 103003141, 104003141, 105003141, 106003141, 107003141, 108003141, 109003141, 110003141, 111003141, 112003141, 113003141, 114003141, 115003141, 116003141, 117003141, 118003141, 119003141, 120003141, 101003151, 102003151, 103003151, 104003151, 105003151, 106003151, 107003151, 108003151, 109003151, 110003151, 111003151, 112003151, 113003151, 114003151, 115003151, 116003151, 117003151, 118003151, 119003151, 120003151, 101003161, 102003161, 103003161, 104003161, 105003161, 106003161, 107003161, 108003161, 109003161, 110003161, 111003161, 112003161, 113003161, 114003161, 115003161, 116003161, 117003161, 118003161, 119003161, 120003161, 101003171, 102003171, 103003171, 104003171, 105003171, 106003171, 107003171, 108003171, 109003171, 110003171, 111003171, 112003171, 113003171, 114003171, 115003171, 116003171, 117003171, 118003171, 119003171, 120003171, 101003181, 102003181, 103003181, 104003181, 105003181, 106003181, 107003181, 108003181, 109003181, 110003181, 111003181, 112003181, 113003181, 114003181, 115003181, 116003181, 117003181, 118003181, 119003181, 120003181, 101003191, 102003191, 103003191, 104003191, 105003191, 106003191, 107003191, 108003191, 109003191, 110003191, 111003191, 112003191, 113003191, 114003191, 115003191, 116003191, 117003191, 118003191, 119003191, 120003191, 101003201, 102003201, 103003201, 104003201, 105003201, 106003201, 107003201, 108003201, 109003201, 110003201, 111003201, 112003201, 113003201, 114003201, 115003201, 116003201, 117003201, 118003201, 119003201, 120003201, 101003211, 102003211, 103003211, 104003211, 105003211, 106003211, 107003211, 108003211, 109003211, 110003211, 111003211, 112003211, 113003211, 114003211, 115003211, 116003211, 117003211, 118003211, 119003211, 120003211, 101003221, 102003221, 103003221, 104003221, 105003221, 106003221, 107003221, 108003221, 109003221, 110003221, 111003221, 112003221, 113003221, 114003221, 115003221, 116003221, 117003221, 118003221, 119003221, 120003221, 101003231, 102003231, 103003231, 104003231, 105003231, 106003231, 107003231, 108003231, 109003231, 110003231, 111003231, 112003231, 113003231, 114003231, 115003231, 116003231, 117003231, 118003231, 119003231, 120003231, 101003241, 102003241, 103003241, 104003241, 105003241, 106003241, 107003241, 108003241, 109003241, 110003241, 111003241, 112003241, 113003241, 114003241, 115003241, 116003241, 117003241, 118003241, 119003241, 120003241, 101003251, 102003251, 103003251, 104003251, 105003251, 106003251, 107003251, 108003251, 109003251, 110003251, 111003251, 112003251, 113003251, 114003251, 115003251, 116003251, 117003251, 118003251, 119003251, 120003251, 101003261, 102003261, 103003261, 104003261, 105003261, 106003261, 107003261, 108003261, 109003261, 110003261, 111003261, 112003261, 113003261, 114003261, 115003261, 116003261, 117003261, 118003261, 119003261, 120003261, 101003271, 102003271, 103003271, 104003271, 105003271, 106003271, 107003271, 108003271, 109003271, 110003271, 111003271, 112003271, 113003271, 114003271, 115003271, 116003271, 117003271, 118003271, 119003271, 120003271, 101003281, 102003281, 103003281, 104003281, 105003281, 106003281, 107003281, 108003281, 109003281, 110003281, 111003281, 112003281, 113003281, 114003281, 115003281, 116003281, 117003281, 118003281, 119003281, 120003281, 101003291, 102003291, 103003291, 104003291, 105003291, 106003291, 107003291, 108003291, 109003291, 110003291, 111003291, 112003291, 113003291, 114003291, 115003291, 116003291, 117003291, 118003291, 119003291, 120003291, 101003301, 102003301, 103003301, 104003301, 105003301, 106003301, 107003301, 108003301, 109003301, 110003301, 111003301, 112003301, 113003301, 114003301, 115003301, 116003301, 117003301, 118003301, 119003301, 120003301, 101003311, 102003311, 103003311, 104003311, 105003311, 106003311, 107003311, 108003311, 109003311, 110003311, 111003311, 112003311, 113003311, 114003311, 115003311, 116003311, 117003311, 118003311, 119003311, 120003311, 101003321, 102003321, 103003321, 104003321, 105003321, 106003321, 107003321, 108003321, 109003321, 110003321, 111003321, 112003321, 113003321, 114003321, 115003321, 116003321, 117003321, 118003321, 119003321, 120003321, 101003331, 102003331, 103003331, 104003331, 105003331, 106003331, 107003331, 108003331, 109003331, 110003331, 111003331, 112003331, 113003331, 114003331, 115003331, 116003331, 117003331, 118003331, 119003331, 120003331, 101003341, 102003341, 103003341, 104003341, 105003341, 106003341, 107003341, 108003341, 109003341, 110003341, 111003341, 112003341, 113003341, 114003341, 115003341, 116003341, 117003341, 118003341, 119003341, 120003341, 101003351, 102003351, 103003351, 104003351, 105003351, 106003351, 107003351, 108003351, 109003351, 110003351, 111003351, 112003351, 113003351, 114003351, 115003351, 116003351, 117003351, 118003351, 119003351, 120003351, 101003361, 102003361, 103003361, 104003361, 105003361, 106003361, 107003361, 108003361, 109003361, 110003361, 111003361, 112003361, 113003361, 114003361, 115003361, 116003361, 117003361, 118003361, 119003361, 120003361, 101003371, 102003371, 103003371, 104003371, 105003371, 106003371, 107003371, 108003371, 109003371, 110003371, 111003371, 112003371, 113003371, 114003371, 115003371, 116003371, 117003371, 118003371, 119003371, 120003371, 101003381, 102003381, 103003381, 104003381, 105003381, 106003381, 107003381, 108003381, 109003381, 110003381, 111003381, 112003381, 113003381, 114003381, 115003381, 116003381, 117003381, 118003381, 119003381, 120003381, 101003012, 102003012, 103003012, 104003012, 105003012, 106003012, 107003012, 108003012, 109003012, 110003012, 111003012, 112003012, 113003012, 114003012, 115003012, 116003012, 117003012, 118003012, 119003012, 120003012, 101003022, 102003022, 103003022, 104003022, 105003022, 106003022, 107003022, 108003022, 109003022, 110003022, 111003022, 112003022, 113003022, 114003022, 115003022, 116003022, 117003022, 118003022, 119003022, 120003022, 101003032, 102003032, 103003032, 104003032, 105003032, 106003032, 107003032, 108003032, 109003032, 110003032, 111003032, 112003032, 113003032, 114003032, 115003032, 116003032, 117003032, 118003032, 119003032, 120003032, 101003042, 102003042, 103003042, 104003042, 105003042, 106003042, 107003042, 108003042, 109003042, 110003042, 111003042, 112003042, 113003042, 114003042, 115003042, 116003042, 117003042, 118003042, 119003042, 120003042, 101003052, 102003052, 103003052, 104003052, 105003052, 106003052, 107003052, 108003052, 109003052, 110003052, 111003052, 112003052, 113003052, 114003052, 115003052, 116003052, 117003052, 118003052, 119003052, 120003052, 101003062, 102003062, 103003062, 104003062, 105003062, 106003062, 107003062, 108003062, 109003062, 110003062, 111003062, 112003062, 113003062, 114003062, 115003062, 116003062, 117003062, 118003062, 119003062, 120003062, 101003072, 102003072, 103003072, 104003072, 105003072, 106003072, 107003072, 108003072, 109003072, 110003072, 111003072, 112003072, 113003072, 114003072, 115003072, 116003072, 117003072, 118003072, 119003072)  GROUP BY t.cohort_definition_id, t.subject_id, t.cohort_start_date 
 UNION ALL 
                   SELECT t.cohort_definition_id,
                         t.subject_id,
                         t.cohort_start_date,
                         coalesce(min(o.cohort_start_date), max(t.cohort_end_date)) AS event_date,
                         CASE WHEN min(o.cohort_start_date) IS NULL THEN 0 ELSE 1 END AS event
                  FROM @cohort_database_schema.@cohort_table t
                  LEFT JOIN @cohort_database_schema.@cohort_table o
                      ON t.subject_id = o.subject_id
                          AND o.cohort_start_date >= t.cohort_start_date
                          AND o.cohort_start_date <= t.cohort_end_date
                          AND o.cohort_definition_id = @outcome_id
                  WHERE t.cohort_definition_id  IN (120003072, 101003082, 102003082, 103003082, 104003082, 105003082, 106003082, 107003082, 108003082, 109003082, 110003082, 111003082, 112003082, 113003082, 114003082, 115003082, 116003082, 117003082, 118003082, 119003082, 120003082, 101003092, 102003092, 103003092, 104003092, 105003092, 106003092, 107003092, 108003092, 109003092, 110003092, 111003092, 112003092, 113003092, 114003092, 115003092, 116003092, 117003092, 118003092, 119003092, 120003092, 101003102, 102003102, 103003102, 104003102, 105003102, 106003102, 107003102, 108003102, 109003102, 110003102, 111003102, 112003102, 113003102, 114003102, 115003102, 116003102, 117003102, 118003102, 119003102, 120003102, 101003112, 102003112, 103003112, 104003112, 105003112, 106003112, 107003112, 108003112, 109003112, 110003112, 111003112, 112003112, 113003112, 114003112, 115003112, 116003112, 117003112, 118003112, 119003112, 120003112, 101003122, 102003122, 103003122, 104003122, 105003122, 106003122, 107003122, 108003122, 109003122, 110003122, 111003122, 112003122, 113003122, 114003122, 115003122, 116003122, 117003122, 118003122, 119003122, 120003122, 101003132, 102003132, 103003132, 104003132, 105003132, 106003132, 107003132, 108003132, 109003132, 110003132, 111003132, 112003132, 113003132, 114003132, 115003132, 116003132, 117003132, 118003132, 119003132, 120003132, 101003142, 102003142, 103003142, 104003142, 105003142, 106003142, 107003142, 108003142, 109003142, 110003142, 111003142, 112003142, 113003142, 114003142, 115003142, 116003142, 117003142, 118003142, 119003142, 120003142, 101003152, 102003152, 103003152, 104003152, 105003152, 106003152, 107003152, 108003152, 109003152, 110003152, 111003152, 112003152, 113003152, 114003152, 115003152, 116003152, 117003152, 118003152, 119003152, 120003152, 101003162, 102003162, 103003162, 104003162, 105003162, 106003162, 107003162, 108003162, 109003162, 110003162, 111003162, 112003162, 113003162, 114003162, 115003162, 116003162, 117003162, 118003162, 119003162, 120003162, 101003172, 102003172, 103003172, 104003172, 105003172, 106003172, 107003172, 108003172, 109003172, 110003172, 111003172, 112003172, 113003172, 114003172, 115003172, 116003172, 117003172, 118003172, 119003172, 120003172, 101003182, 102003182, 103003182, 104003182, 105003182, 106003182, 107003182, 108003182, 109003182, 110003182, 111003182, 112003182, 113003182, 114003182, 115003182, 116003182, 117003182, 118003182, 119003182, 120003182, 101003192, 102003192, 103003192, 104003192, 105003192, 106003192, 107003192, 108003192, 109003192, 110003192, 111003192, 112003192, 113003192, 114003192, 115003192, 116003192, 117003192, 118003192, 119003192, 120003192, 101003202, 102003202, 103003202, 104003202, 105003202, 106003202, 107003202, 108003202, 109003202, 110003202, 111003202, 112003202, 113003202, 114003202, 115003202, 116003202, 117003202, 118003202, 119003202, 120003202, 101003212, 102003212, 103003212, 104003212, 105003212, 106003212, 107003212, 108003212, 109003212, 110003212, 111003212, 112003212, 113003212, 114003212, 115003212, 116003212, 117003212, 118003212, 119003212, 120003212, 101003222, 102003222, 103003222, 104003222, 105003222, 106003222, 107003222, 108003222, 109003222, 110003222, 111003222, 112003222, 113003222, 114003222, 115003222, 116003222, 117003222, 118003222, 119003222, 120003222, 101003232, 102003232, 103003232, 104003232, 105003232, 106003232, 107003232, 108003232, 109003232, 110003232, 111003232, 112003232, 113003232, 114003232, 115003232, 116003232, 117003232, 118003232, 119003232, 120003232, 101003242, 102003242, 103003242, 104003242, 105003242, 106003242, 107003242, 108003242, 109003242, 110003242, 111003242, 112003242, 113003242, 114003242, 115003242, 116003242, 117003242, 118003242, 119003242, 120003242, 101003252, 102003252, 103003252, 104003252, 105003252, 106003252, 107003252, 108003252, 109003252, 110003252, 111003252, 112003252, 113003252, 114003252, 115003252, 116003252, 117003252, 118003252, 119003252, 120003252, 101003262, 102003262, 103003262, 104003262, 105003262, 106003262, 107003262, 108003262, 109003262, 110003262, 111003262, 112003262, 113003262, 114003262, 115003262, 116003262, 117003262, 118003262, 119003262, 120003262, 101003272, 102003272, 103003272, 104003272, 105003272, 106003272, 107003272, 108003272, 109003272, 110003272, 111003272, 112003272, 113003272, 114003272, 115003272, 116003272, 117003272, 118003272, 119003272, 120003272, 101003282, 102003282, 103003282, 104003282, 105003282, 106003282, 107003282, 108003282, 109003282, 110003282, 111003282, 112003282, 113003282, 114003282, 115003282, 116003282, 117003282, 118003282, 119003282, 120003282, 101003292, 102003292, 103003292, 104003292, 105003292, 106003292, 107003292, 108003292, 109003292, 110003292, 111003292, 112003292, 113003292, 114003292, 115003292, 116003292, 117003292, 118003292, 119003292, 120003292, 101003302, 102003302, 103003302, 104003302, 105003302, 106003302, 107003302, 108003302, 109003302, 110003302, 111003302, 112003302, 113003302, 114003302, 115003302, 116003302, 117003302, 118003302, 119003302, 120003302, 101003312, 102003312, 103003312, 104003312, 105003312, 106003312, 107003312, 108003312, 109003312, 110003312, 111003312, 112003312, 113003312, 114003312, 115003312, 116003312, 117003312, 118003312, 119003312, 120003312, 101003322, 102003322, 103003322, 104003322, 105003322, 106003322, 107003322, 108003322, 109003322, 110003322, 111003322, 112003322, 113003322, 114003322, 115003322, 116003322, 117003322, 118003322, 119003322, 120003322, 101003332, 102003332, 103003332, 104003332, 105003332, 106003332, 107003332, 108003332, 109003332, 110003332, 111003332, 112003332, 113003332, 114003332, 115003332, 116003332, 117003332, 118003332, 119003332, 120003332, 101003342, 102003342, 103003342, 104003342, 105003342, 106003342, 107003342, 108003342, 109003342, 110003342, 111003342, 112003342, 113003342, 114003342, 115003342, 116003342, 117003342, 118003342, 119003342, 120003342, 101003352, 102003352, 103003352, 104003352, 105003352, 106003352, 107003352, 108003352, 109003352, 110003352, 111003352, 112003352, 113003352, 114003352, 115003352, 116003352, 117003352, 118003352, 119003352, 120003352, 101003362, 102003362, 103003362, 104003362, 105003362, 106003362, 107003362, 108003362, 109003362, 110003362, 111003362, 112003362, 113003362, 114003362, 115003362, 116003362, 117003362, 118003362, 119003362, 120003362, 101003372, 102003372, 103003372, 104003372, 105003372, 106003372, 107003372, 108003372, 109003372, 110003372, 111003372, 112003372, 113003372, 114003372, 115003372, 116003372, 117003372, 118003372, 119003372, 120003372, 101003382, 102003382, 103003382, 104003382, 105003382, 106003382, 107003382, 108003382, 109003382, 110003382, 111003382, 112003382, 113003382, 114003382, 115003382, 116003382, 117003382, 118003382, 119003382, 120003382)  GROUP BY t.cohort_definition_id, t.subject_id, t.cohort_start_date
                  ),
     init_data AS (
                  SELECT cohort_definition_id, ROUND(tab.cohort_start_date - tab.event_date, 0) AS value
                  FROM tab
                  ),