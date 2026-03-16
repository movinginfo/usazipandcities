# usazipandcities

A simple database with USA zip codes and cities.

## Data Sources

The database is built using free datasets from [SimpleMaps](https://simplemaps.com):

- **US Cities**: https://simplemaps.com/data/us-cities
- **US Zip Codes**: https://simplemaps.com/data/us-zips

> **Attribution required**: Use of the free database in production requires that you link back to the data sources above. See [SimpleMaps licensing](https://simplemaps.com/data/us-cities) for details.

## Database Schema

See [`schema.sql`](schema.sql) for the full database schema.

### `us_cities` table

| Column         | Type    | Description                                  |
|----------------|---------|----------------------------------------------|
| `id`           | INT     | Primary key                                  |
| `city`         | VARCHAR | City name                                    |
| `city_ascii`   | VARCHAR | City name in ASCII                           |
| `state_id`     | CHAR    | Two-letter state abbreviation                |
| `state_name`   | VARCHAR | Full state name                              |
| `county_fips`  | VARCHAR | FIPS code for the county                     |
| `county_name`  | VARCHAR | County name                                  |
| `lat`          | DECIMAL | Latitude                                     |
| `lng`          | DECIMAL | Longitude                                    |
| `population`   | INT     | Population estimate                          |
| `density`      | DECIMAL | Population density (per sq km)               |
| `timezone`     | VARCHAR | Timezone (e.g. `America/New_York`)           |
| `ranking`      | TINYINT | City ranking (1=large, 3=small)              |
| `incorporated` | BOOLEAN | Whether the city is incorporated             |
| `zips`         | TEXT    | Space-separated list of zip codes            |

### `us_zips` table

| Column        | Type    | Description                                   |
|---------------|---------|-----------------------------------------------|
| `zip`         | CHAR    | 5-digit ZIP code (primary key)                |
| `lat`         | DECIMAL | Latitude of the ZIP code centroid             |
| `lng`         | DECIMAL | Longitude of the ZIP code centroid            |
| `city`        | VARCHAR | Primary city name for this ZIP code           |
| `state_id`    | CHAR    | Two-letter state abbreviation                 |
| `state_name`  | VARCHAR | Full state name                               |
| `zcta`        | BOOLEAN | Whether this is a ZIP Code Tabulation Area    |
| `parent_zcta` | CHAR    | Parent ZCTA zip code (if applicable)          |
| `population`  | INT     | Population estimate                           |
| `density`     | DECIMAL | Population density (per sq km)                |
| `county_fips` | VARCHAR | FIPS code for the county                      |
| `county_name` | VARCHAR | County name                                   |
| `county_weights`     | TEXT | JSON object of county FIPS codes and weights |
| `county_names_all`   | TEXT | All county names for this ZIP                |
| `county_fips_all`    | TEXT | All FIPS codes for this ZIP                  |
| `imprecise`   | BOOLEAN | Whether the coordinates are imprecise         |
| `military`    | BOOLEAN | Whether this is a military ZIP code           |
| `timezone`    | VARCHAR | Timezone (e.g. `America/New_York`)            |

## Setup

### 1. Download the data

Download the free CSV files from:
- https://simplemaps.com/data/us-cities (download `simplemaps_uscities_basicv*.zip`)
- https://simplemaps.com/data/us-zips (download `simplemaps_uszips_basicv*.zip`)

Extract the ZIP files to obtain `uscities.csv` and `uszips.csv`.

### 2. Create the database

Run the schema script to create the tables:

```bash
mysql -u <user> -p <database> < schema.sql
```

### 3. Import the data

Use your database's CSV import tool. For MySQL:

```sql
LOAD DATA INFILE '/path/to/uscities.csv'
INTO TABLE us_cities
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(city, city_ascii, state_id, state_name, county_fips, county_name,
 lat, lng, population, density, timezone, ranking, incorporated, zips);

LOAD DATA INFILE '/path/to/uszips.csv'
INTO TABLE us_zips
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(zip, lat, lng, city, state_id, state_name, zcta, parent_zcta,
 population, density, county_fips, county_name, county_weights,
 county_names_all, county_fips_all, imprecise, military, timezone);
```

## License

The data is provided by [SimpleMaps](https://simplemaps.com) under a free license for personal and commercial use, with the requirement to link back to the original data sources:

- https://simplemaps.com/data/us-cities
- https://simplemaps.com/data/us-zips
