SET optimizer_switch='hypergraph_optimizer=on';
SET cte_max_recursion_depth = 1000000;
create database tmp;

use tmp;
create table test(x int);
create table other(y int);
create table other2(z int);

INSERT INTO test(x) SELECT (RAND() * 1000000) FROM (
    WITH RECURSIVE seq AS ( SELECT 1 AS v UNION ALL SELECT v + 1 FROM seq WHERE v < 100000 )
    SELECT v FROM seq
) gen;
INSERT INTO other(y) SELECT (RAND() * 1000000) FROM (
    WITH RECURSIVE seq AS ( SELECT 1 AS v UNION ALL SELECT v + 1 FROM seq WHERE v < 50000 )
    SELECT v FROM seq
) gen;
INSERT INTO other2(z) SELECT (RAND() * 1000000) FROM (
    WITH RECURSIVE seq AS ( SELECT 1 AS v UNION ALL SELECT v + 1 FROM seq WHERE v < 20000 )
    SELECT v FROM seq
) gen;

explain analyze select /*+ RUN_REOPT */ count(*) from test join other on test.x = other.y WHERE other.y > 23000;

explain analyze select count(*) from test join other on test.x = other.y join other2 on other.y = other2.z WHERE other.y > 12000;
explain analyze select /*+ RUN_REOPT */ count(*) from test join other on test.x = other.y join other2 on other.y = other2.z WHERE other.y > 12000;

-- select * from test join other on test.x = other.y join other2 on other.y = other2.z WHERE other.y < 12 and other2.z < 10;
-- select /*+ RUN_REOPT */ * from test join other on test.x = other.y join other2 on other.y = other2.z WHERE other.y < 12 and other2.z < 10;
