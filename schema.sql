-- USA Zip Codes and Cities Database Schema
-- Data sourced from SimpleMaps (https://simplemaps.com)
--
-- Attribution required: Use of the free database in production requires
-- that you link back to:
--   https://simplemaps.com/data/us-cities
--   https://simplemaps.com/data/us-zips

-- -------------------------------------------------------------------------
-- US Cities
-- Source: https://simplemaps.com/data/us-cities
-- -------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS us_cities (
    id           INT          NOT NULL AUTO_INCREMENT,
    city         VARCHAR(100) NOT NULL,
    city_ascii   VARCHAR(100) NOT NULL,
    state_id     CHAR(2)      NOT NULL,
    state_name   VARCHAR(50)  NOT NULL,
    county_fips  VARCHAR(10)  DEFAULT NULL,
    county_name  VARCHAR(100) DEFAULT NULL,
    lat          DECIMAL(9,6) NOT NULL,
    lng          DECIMAL(9,6) NOT NULL,
    population   INT          DEFAULT NULL,
    density      DECIMAL(10,2) DEFAULT NULL,
    timezone     VARCHAR(50)  DEFAULT NULL,
    ranking      TINYINT      DEFAULT NULL COMMENT '1=large city, 2=medium city, 3=small city',
    incorporated BOOLEAN      DEFAULT NULL,
    zips         TEXT         DEFAULT NULL COMMENT 'Space-separated list of ZIP codes',
    PRIMARY KEY (id),
    INDEX idx_state_id   (state_id),
    INDEX idx_city       (city),
    INDEX idx_county_fips (county_fips)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------------------------------------
-- US Zip Codes
-- Source: https://simplemaps.com/data/us-zips
-- -------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS us_zips (
    zip                CHAR(5)       NOT NULL,
    lat                DECIMAL(9,6)  NOT NULL,
    lng                DECIMAL(9,6)  NOT NULL,
    city               VARCHAR(100)  NOT NULL,
    state_id           CHAR(2)       NOT NULL,
    state_name         VARCHAR(50)   NOT NULL,
    zcta               BOOLEAN       DEFAULT NULL COMMENT 'ZIP Code Tabulation Area',
    parent_zcta        CHAR(5)       DEFAULT NULL,
    population         INT           DEFAULT NULL,
    density            DECIMAL(10,2) DEFAULT NULL,
    county_fips        VARCHAR(10)   DEFAULT NULL,
    county_name        VARCHAR(100)  DEFAULT NULL,
    county_weights     TEXT          DEFAULT NULL COMMENT 'JSON: county FIPS codes to population weight',
    county_names_all   TEXT          DEFAULT NULL COMMENT 'Pipe-separated list of all county names',
    county_fips_all    TEXT          DEFAULT NULL COMMENT 'Pipe-separated list of all county FIPS codes',
    imprecise          BOOLEAN       DEFAULT NULL,
    military           BOOLEAN       DEFAULT NULL,
    timezone           VARCHAR(50)   DEFAULT NULL,
    PRIMARY KEY (zip),
    INDEX idx_city       (city),
    INDEX idx_state_id   (state_id),
    INDEX idx_county_fips (county_fips)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
