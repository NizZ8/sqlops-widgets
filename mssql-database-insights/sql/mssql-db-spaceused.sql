-- 
-- Author: Matticusau
-- Purpose: Provides summary data for the DB Space Used Insights Widget
-- License: https://github.com/Matticusau/sqlops-widgets/blob/master/LICENSE
-- 
SELECT 
    -- CONVERT(decimal(18,2), SUM(size)/128.0) [file_size_mb] ,
    -- CONVERT(decimal(18,2), SUM(max_size)/128.0) [max_growth_size_mb] ,
    -- CONVERT(decimal(18,2), SUM(FILEPROPERTY(name, 'SpaceUsed'))/128.0) [used_space_mb] ,
    -- CONVERT(decimal(18,2), SUM(size)/128.0) - CONVERT(decimal(18,2), SUM(FILEPROPERTY(name,'SpaceUsed'))/128.0) AS [free_space_mb] ,
    CONVERT(decimal(18,2), (SUM(FILEPROPERTY(name, 'SpaceUsed'))/128.0) / (SUM(size)/128.0) * 100) [used_space_percent],
    100 - CONVERT(decimal(18,2), (SUM(FILEPROPERTY(name, 'SpaceUsed'))/128.0) / (SUM(size)/128.0) * 100) AS [free_space_percent] 
FROM sys.database_files
WHERE type_desc IN ('ROWS','LOG')