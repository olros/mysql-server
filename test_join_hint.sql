set optimizer_switch='hypergraph_optimizer=on';
create table t(x int);
create table t2(x int);
create table t3(x int);


insert into t values (1), (2), (3), (4), (5), (6), (7), (8), (9);
insert into t2 values  (5), (6), (7);
insert into t3 values (1), (2), (3);
explain analyze select /*+ FORCE_JOIN_METHOD( NESTED_LOOP_JOIN ) */ * from t join t2 on t2.x = t.x join t3 on t3.x *2 = (select /*+ FORCE_JOIN_METHOD ( HASH_JOIN ) */ count(*) from t, t3 where t.x =t3.x);

