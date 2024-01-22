SET optimizer_switch='hypergraph_optimizer=on';
create database tmp;

use tmp;
create table test(x int);
create table other(y int);
create table other2(z int);


DELIMITER //

CREATE PROCEDURE generate_random_numbers()
BEGIN
  DECLARE i INT;

  SET i = 1;
  WHILE i <= 300 DO
    INSERT INTO test (x) VALUES (RAND() * 1000);
    SET i = i + 1;
END WHILE;

  SET i = 1;
  WHILE i <= 2000 DO
    INSERT INTO other (y) VALUES (RAND() * 1000);

    SET i = i + 1;
END WHILE;

  SET i = 1;
  WHILE i <= 10000 DO
    INSERT INTO other2 (z) VALUES (RAND() * 1000);
    SET i = i + 1;
END WHILE;
END //

DELIMITER ;

CALL generate_random_numbers();

-- select * from test join other on test.x = other.y join other2 on other.y = other2.z WHERE other.y < 12 and other2.z < 10;
-- select /*+ RUN_REOPT */ * from test join other on test.x = other.y join other2 on other.y = other2.z WHERE other.y < 12 and other2.z < 10;

explain analyze select * from test join other on test.x = other.y join other2 on other.y = other2.z WHERE other.y < 12 and other2.z < 10;
explain analyze select /*+ RUN_REOPT */ * from test join other on test.x = other.y join other2 on other.y = other2.z WHERE other.y < 12 and other2.z < 10;