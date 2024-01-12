# Structure

I `sql/sql_union.cc` ligger `ExecuteIteratorQuery`.
Her starter execution. Se `int error = m_root_iterator->Read();` som leses for hvert element i en query.
For hver rad som leses av iteratoren som representerer et element i spørringen, kjøres det 1 loop i løkken.
