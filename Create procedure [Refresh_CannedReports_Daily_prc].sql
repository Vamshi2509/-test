    
CREATE procedure [dbo].[Refresh_CannedReports_Daily_prc] as     
  
begin    
    
    
MERGE Dim_ConsolidatedUsage_CannedReports_tbl AS TARGET    
USING CannedReports AS SOURCE     
ON (TARGET.KeyCannedReport = SOURCE.KeyCannedReport)   
    
WHEN MATCHED AND TARGET.CannedReport <> SOURCE.CannedReport     
OR TARGET.KeyCannedReportType <> SOURCE.KeyCannedReportType     
OR TARGET.CannedReportType <> SOURCE.CannedReportType    
OR TARGET.KeyCannedReportSource <> SOURCE.KeyCannedReportSource    
THEN UPDATE SET TARGET.CannedReport = SOURCE.CannedReport,     
TARGET.KeyCannedReportType = SOURCE.KeyCannedReportType,    
TARGET.CannedReportType=SOURCE.CannedReportType,    
TARGET.KeyCannedReportSource = SOURCE.KeyCannedReportSource,    
TARGET.UpdDate = GETDATE()    
--When no records are matched, insert the incoming records from source table to target table    
WHEN NOT MATCHED BY TARGET     
THEN INSERT (    
KeyCannedReport, CannedReport, KeyCannedReportType, CannedReportType, KeyCannedReportSource, UpdDate    
)    
VALUES     
(    
SOURCE.KeyCannedReport,     
SOURCE.CannedReport,     
SOURCE.KeyCannedReportType,    
SOURCE.CannedReportType,    
SOURCE.KeyCannedReportSource,  
Getdate()    
);    
     
end     
    
    
    
    
    
   