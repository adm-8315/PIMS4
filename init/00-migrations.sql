-- Create migrations table if it doesn't exist
CREATE TABLE IF NOT EXISTS `schema_migrations` (
    `version` varchar(255) NOT NULL,
    `applied_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Function to check if migration exists
DELIMITER //
CREATE OR REPLACE FUNCTION migration_exists(version_num VARCHAR(255))
RETURNS BOOLEAN
BEGIN
    DECLARE exists_count INT;
    SELECT COUNT(*) INTO exists_count FROM schema_migrations WHERE version = version_num;
    RETURN exists_count > 0;
END //
DELIMITER ;

-- Procedure to log migration
DELIMITER //
CREATE OR REPLACE PROCEDURE log_migration(version_num VARCHAR(255))
BEGIN
    INSERT INTO schema_migrations (version) VALUES (version_num);
END //
DELIMITER ;