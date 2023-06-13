----------- Below query gives details about all jobs through a scheduled trigger
select top 10000 T.TenancyName as Tenant_Name,OU.DisplayName as Folder_Name,
Rel.Name as Process_Name,Rel.Description as Process_Discription,--Rel.Unattended,
Rel.JobPriority,PS.Name as Trigger_Name,
PS.TimeZoneId,PS.StartProcessCron,PS.StartProcessCronDetails,
PS.LastSuccessfulTime,PS.Enabled,PS.QueueDefinitionId,--PS.TotalSuccessful,PS.TotalFailures,
--J.RobotId,
R.Name as Robot_Name,
--j.MachineId,
M.Name as Machine_Name,
J.HostMachineName,j.JobPriority,j.Type,j.RuntimeType
,count(j.Id) as Number_Of_Jobs_Executed
,AVG( DATEDIFF(Second, J.StartTime, J.EndTime)) as Average_AHT_Seconds
,MAX( DATEDIFF(Second, J.StartTime, J.EndTime)) as Max_execution_Time_Seconds
--,MIN(J.StartTime),MAX( )
--R.RobotDescription,
--,* 
from dbo.tenants T 
inner join dbo.OrganizationUnits OU on T.Id = OU.TenantId
inner join dbo.ProcessSchedules PS on OU.Id = PS.OrganizationUnitId
--inner join dbo.ProcessScheduleMachineRobots PSMR on PS.Id = PSMR.ProcessScheduleId
--inner join dbo.Robots R on R.Id = PSMR.RobotId
inner join dbo.Jobs J on J.StartingScheduleId = PS.Id
inner join dbo.Releases Rel on J.ReleaseId = Rel.Id
inner join dbo.Machines M on M.ID = J.MachineId
inner join dbo.Robots R on R.Id = J.RobotId
--where 
--T.ID = 105 
--and OU.ID = 1766
--T.TenancyName = 'ITIO_ETS'
--and OU.DisplayName = 'Auto Report'
--and PS.Name = 'F11_PEE_PH_tag_EXPOSENGRWK_lot_attribute'
group by 
T.TenancyName,OU.DisplayName,Rel.Name,Rel.Description,--Rel.Unattended,
Rel.JobPriority,PS.Name,PS.TimeZoneId,J.HostMachineName,
PS.StartProcessCron,PS.StartProcessCronDetails,PS.QueueDefinitionId,
PS.LastSuccessfulTime,PS.Enabled,--PS.TotalSuccessful,PS.TotalFailures,
j.MachineId,M.Name,J.RobotId,R.Name,j.JobPriority,j.Type,j.RuntimeType
Order by
T.TenancyName,OU.DisplayName,PS.Name