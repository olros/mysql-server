SET optimizer_switch='hypergraph_optimizer=on';
SET cte_max_recursion_depth = 1000000;
create database tmp;

use tmp;
create table test(x int);
create table other(y int);
create table other2(z int);
create table other3(q int);
create table other4(w int);

INSERT INTO test(x) SELECT (RAND() * 10000) FROM (
    WITH RECURSIVE seq AS ( SELECT 1 AS v UNION ALL SELECT v + 1 FROM seq WHERE v < 10000 )
    SELECT v FROM seq
) gen;
INSERT INTO other(y) SELECT (RAND() * 10000) FROM (
    WITH RECURSIVE seq AS ( SELECT 1 AS v UNION ALL SELECT v + 1 FROM seq WHERE v < 500 )
    SELECT v FROM seq
) gen;
INSERT INTO other2(z) SELECT (RAND() * 10000) FROM (
    WITH RECURSIVE seq AS ( SELECT 1 AS v UNION ALL SELECT v + 1 FROM seq WHERE v < 200 )
    SELECT v FROM seq
) gen;
INSERT INTO other3(q) SELECT (RAND() * 10000) FROM (
    WITH RECURSIVE seq AS ( SELECT 1 AS v UNION ALL SELECT v + 1 FROM seq WHERE v < 800 )
    SELECT v FROM seq
) gen;
INSERT INTO other4(w) SELECT (RAND() * 10000) FROM (
    WITH RECURSIVE seq AS ( SELECT 1 AS v UNION ALL SELECT v + 1 FROM seq WHERE v < 300 )
    SELECT v FROM seq
) gen;

EXPLAIN ANALYZE SELECT COUNT(*) FROM test JOIN other ON test.x = other.y JOIN other2 ON other.y = other2.z JOIN other3 ON other2.z = other3.q WHERE other.y > 230;
EXPLAIN ANALYZE SELECT /*+ RUN_REOPT */ COUNT(*) FROM test JOIN other ON test.x = other.y JOIN other2 ON other.y = other2.z JOIN other3 ON other2.z = other3.q WHERE other.y > 230;
EXPLAIN ANALYZE SELECT /*+ RUN_REOPT */ COUNT(*) FROM test JOIN other ON test.x = other.y JOIN other2 ON other.y = other2.z WHERE other.y > 230 and test.x > 230;

EXPLAIN ANALYZE SELECT /*+ RUN_REOPT */ COUNT(*) FROM test JOIN other ON test.x = other.y JOIN other2 ON other.y = other2.z WHERE other.y > 23000;

explain analyze select count(*) from test join other on test.x = other.y join other2 on other.y = other2.z WHERE other.y > 12000;
explain analyze select /*+ RUN_REOPT */ count(*) from test join other on test.x = other.y join other2 on other.y = other2.z WHERE other.y > 12000;

-- select * from test join other on test.x = other.y join other2 on other.y = other2.z WHERE other.y < 12 and other2.z < 10;
-- select /*+ RUN_REOPT */ * from test join other on test.x = other.y join other2 on other.y = other2.z WHERE other.y < 12 and other2.z < 10;
