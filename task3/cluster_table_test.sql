CREATE TABLE task (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

CREATE INDEX index_id ON task(id);


DO $$
BEGIN
    FOR i in 1..10000
    loop
    insert into task(name) VALUES ('test');
    end loop;
end $$;

DO $$
BEGIN
    FOR i in 1..10000
        LOOP
            update task
            SET name=(array_to_string(array(select substr('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',((random()*(36-1)+1)::integer),1) from generate_series(1,100)),''))
            where id=i;
        end loop;
end $$;

ANALYZE task;

-- Pgbench script

begin;
	SELECT * FROM task WHERE id IN (100, 1000, 2000, 3000, 4000, 5000, 3235, 9999);
end;

-- Script to cluster
CLUSTER VERBOSE task USING index_id;
ANALYSE task;

-- Pgbench script
begin;
SELECT * FROM task WHERE id IN (100, 1000, 2000, 3000, 4000, 5000, 3235, 9999);
end;
