# How to

## Installer dependencies:

`brew install cmake ninja bison icu4c libevent lz4 protobuf openssl@1.1 zstd libfido2` (Søk `"SET(SYSTEM_LIBRARIES"` i `CMakeLists.txt` for å se biblioteker som behøves)

## Build:

1. Åpne build-mappe
2. `cmake .. -GNinja -DWITH_SYSTEM_LIBS=0 -DWITH_BOOST=../../boost -DCMAKE_BUILD_TYPE=Debug -DWITH_MYSQLX=0` (Legg til `-DDOWNLOAD_BOOST=1` første gang)
3. `ninja` (kjør på nytt ved kodeendringer)

## Test:

Kjør spesifikk test: `./mtr --mem <test-navn>`
Sett test-fasit for ny/eksisterende (snapshot): `./mtr --mem <test-navn> --record`

## Kjør:

1. Åpne build-mappe 
   - Start MySQL-server: Kjør `./mysql-test/mtr --mem --start`
   - Connect til server: Kjør `./bin/mysql -u root -S <sock>`
