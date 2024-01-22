SET optimizer_switch='hypergraph_optimizer=on';
create database tmp;

use tmp;
create table test(x int);
create table other(y int);

insert into test values (1),(2),(4),(9),(15);
insert into other values (1),(3),(2),(3),(5),(7),(15),(90),(678),(89),(89),(67),(456),(33),(4578);

-- explain analyze select * from test join other on test.x = other.x;
-- select * from test join other on test.x = other.x;

create table other2(z int);
insert into other2 values (1),(2),(4),(15);
explain analyze select * from test join other on test.x = other.y join other2 on other.y = other2.z WHERE other.y < 12 and other2.z < 10;
select * from test join other on test.x = other.y join other2 on other.y = other2.z WHERE other.y < 12 and other2.z < 10;



