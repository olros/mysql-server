
set optimizer_switch='hypergraph_optimizer=on';

use test;

create table test(x int, INDEX (x));
create table test2(x int, INDEX (x));

insert into test values (1), (2), (3), (4), (5);
insert into test2 values (1), (2), (3), (4), (5), (6), (7), (8), (9), (10); 

select * from test join test2 on test.x = test2.x order by test.x;




