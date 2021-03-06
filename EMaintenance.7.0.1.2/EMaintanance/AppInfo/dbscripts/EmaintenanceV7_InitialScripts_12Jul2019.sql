USE [master]
GO
/****** Object:  Database [EmaintenanceDRT]    Script Date: 7/12/2019 12:06:32 PM ******/
CREATE DATABASE [EmaintenanceDRT]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Emaintenance', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\EmaintenanceDRT.mdf' , SIZE = 697152KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Emaintenance_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\EmaintenanceDRT_log.ldf' , SIZE = 26550272KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [EmaintenanceDRT] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EmaintenanceDRT].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EmaintenanceDRT] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EmaintenanceDRT] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EmaintenanceDRT] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EmaintenanceDRT] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EmaintenanceDRT] SET ARITHABORT OFF 
GO
ALTER DATABASE [EmaintenanceDRT] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EmaintenanceDRT] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EmaintenanceDRT] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EmaintenanceDRT] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EmaintenanceDRT] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EmaintenanceDRT] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EmaintenanceDRT] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EmaintenanceDRT] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EmaintenanceDRT] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EmaintenanceDRT] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EmaintenanceDRT] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EmaintenanceDRT] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EmaintenanceDRT] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EmaintenanceDRT] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EmaintenanceDRT] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EmaintenanceDRT] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EmaintenanceDRT] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EmaintenanceDRT] SET RECOVERY FULL 
GO
ALTER DATABASE [EmaintenanceDRT] SET  MULTI_USER 
GO
ALTER DATABASE [EmaintenanceDRT] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EmaintenanceDRT] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EmaintenanceDRT] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EmaintenanceDRT] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [EmaintenanceDRT] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [EmaintenanceDRT] SET QUERY_STORE = OFF
GO
USE [EmaintenanceDRT]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [EmaintenanceDRT]
GO
USE [EmaintenanceDRT]
GO
/****** Object:  Sequence [dbo].[SeqCloneUnit]    Script Date: 7/12/2019 12:06:34 PM ******/
CREATE SEQUENCE [dbo].[SeqCloneUnit] 
 AS [bigint]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -9223372036854775808
 MAXVALUE 9223372036854775807
 CACHE 
GO
USE [EmaintenanceDRT]
GO
/****** Object:  Sequence [dbo].[SeqJobNumber]    Script Date: 7/12/2019 12:06:34 PM ******/
CREATE SEQUENCE [dbo].[SeqJobNumber] 
 AS [bigint]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -9223372036854775808
 MAXVALUE 9223372036854775807
 CACHE 
GO
USE [EmaintenanceDRT]
GO
/****** Object:  Sequence [dbo].[SeqLeverageServiceExport]    Script Date: 7/12/2019 12:06:34 PM ******/
CREATE SEQUENCE [dbo].[SeqLeverageServiceExport] 
 AS [bigint]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -9223372036854775808
 MAXVALUE 9223372036854775807
 CACHE 
GO
USE [EmaintenanceDRT]
GO
/****** Object:  Sequence [dbo].[SeqWNumber]    Script Date: 7/12/2019 12:06:34 PM ******/
CREATE SEQUENCE [dbo].[SeqWNumber] 
 AS [bigint]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -9223372036854775808
 MAXVALUE 9223372036854775807
 CACHE 
GO
/****** Object:  UserDefinedFunction [dbo].[CheckJobStatus]    Script Date: 7/12/2019 12:06:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   Function [dbo].[CheckJobStatus](@StatusId Int)
returns int as
begin
Declare @IsEditable int = 0;
 
	select @IsEditable =  count(LookupId) from Lookups where LookupCode  not in ('NA','SU','C') and LookupId = @StatusId
 
Return isnull(@IsEditable,0) --Case when @IsEditable = 1 then 0 else 1 end
end

GO
/****** Object:  UserDefinedFunction [dbo].[fn_diagramobjects]    Script Date: 7/12/2019 12:06:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE   FUNCTION [dbo].[fn_diagramobjects]() 
	RETURNS int
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		declare @id_upgraddiagrams		int
		declare @id_sysdiagrams			int
		declare @id_helpdiagrams		int
		declare @id_helpdiagramdefinition	int
		declare @id_creatediagram	int
		declare @id_renamediagram	int
		declare @id_alterdiagram 	int 
		declare @id_dropdiagram		int
		declare @InstalledObjects	int

		select @InstalledObjects = 0

		select 	@id_upgraddiagrams = object_id(N'dbo.sp_upgraddiagrams'),
			@id_sysdiagrams = object_id(N'dbo.sysdiagrams'),
			@id_helpdiagrams = object_id(N'dbo.sp_helpdiagrams'),
			@id_helpdiagramdefinition = object_id(N'dbo.sp_helpdiagramdefinition'),
			@id_creatediagram = object_id(N'dbo.sp_creatediagram'),
			@id_renamediagram = object_id(N'dbo.sp_renamediagram'),
			@id_alterdiagram = object_id(N'dbo.sp_alterdiagram'), 
			@id_dropdiagram = object_id(N'dbo.sp_dropdiagram')

		if @id_upgraddiagrams is not null
			select @InstalledObjects = @InstalledObjects + 1
		if @id_sysdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 2
		if @id_helpdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 4
		if @id_helpdiagramdefinition is not null
			select @InstalledObjects = @InstalledObjects + 8
		if @id_creatediagram is not null
			select @InstalledObjects = @InstalledObjects + 16
		if @id_renamediagram is not null
			select @InstalledObjects = @InstalledObjects + 32
		if @id_alterdiagram  is not null
			select @InstalledObjects = @InstalledObjects + 64
		if @id_dropdiagram is not null
			select @InstalledObjects = @InstalledObjects + 128
		
		return @InstalledObjects 
	END
	
GO
/****** Object:  UserDefinedFunction [dbo].[GetAnalystJobStatusColour]    Script Date: 7/12/2019 12:06:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

CREATE   Function [dbo].[GetAnalystJobStatusColour](@Jobid BigInt, @UserId int)
returns Varchar(15) as
begin
	
	Declare @LanguageId int, @CurrentStatus int, @CurrentColour varchar(50), @EquipCount int , @NS int, @IP int, @SU int, @NA int, @JC int ,@OD int, @NSC int, @IPC int, @SUC int, @NAC int, @JCC int
	set @LanguageId = 1
	Select @NS = dbo.GetStatusId(@LanguageId,'JobProcessStatus','NS') , @IP =  dbo.GetStatusId(@LanguageId,'JobProcessStatus','IP'), 
	@SU =  dbo.GetStatusId(@LanguageId,'JobProcessStatus','SU'), @JC =  dbo.GetStatusId(@LanguageId,'JobProcessStatus','C'), 
	@NA =  dbo.GetStatusId(@LanguageId,'JobProcessStatus','NA')

	select @EquipCount = count(je.equipmentid),  
	@NSC = sum(Case when je.StatusId = @NS then 1 else 0 end),
	@IPC = sum(Case when je.StatusId = @IP then 1 else 0 end),
	@SUC = sum(Case when je.StatusId = @SU then 1 else 0 end),
	@NAC = sum(Case when je.StatusId = @NA then 1 else 0 end),
	@JCC = sum(Case when je.StatusId = @JC then 1 else 0 end)
	from JobEquipment je	
	where je.JobId = @jobId and je.AnalystId = @UserId and je.Active = 'Y'
 
 Select @CurrentColour = dbo.GetLookupTranslated(
 case when isnull(@NAC,0)   = isnull(@EquipCount,0) then dbo.GetStatusId(@LanguageId,'ReportStatusLegend','NA')
 when ((isnull(@NSC,0) + isnull(@NAC,0))  = isnull(@EquipCount,0) ) then dbo.GetStatusId(@LanguageId,'ReportStatusLegend','NS')
	  when ((isnull(@JCC,0) + isnull(@NAC,0))  = isnull(@EquipCount,0) ) then dbo.GetStatusId(@LanguageId,'ReportStatusLegend','C')
	  when ((isnull(@SUC,0) + isnull(@NAC,0)+isnull(@JCC,0))  = isnull(@EquipCount,0) ) then dbo.GetStatusId(@LanguageId,'ReportStatusLegend','SU') 
	  when  (isnull(@IPC,0) > 0 or (isnull(@NSC,0)>0 and isnull(@NSC,0)<> isnull(@EquipCount,0)) or (isnull(@SUC,0)>0 and isnull(@SUC,0)<> isnull(@EquipCount,0)) or
			(isnull(@JCC,0)>0 and isnull(@JCC,0)<> isnull(@EquipCount,0)) or (isnull(@NAC,0)>0 and (isnull(@NAC,0) )<> isnull(@EquipCount,0))) then dbo.GetStatusId(@LanguageId,'ReportStatusLegend','IP') 
 end
 ,@LanguageId,'LookupValue') 
 	    
 Return case when isnull(@EquipCount,0) = 0 then '#ffffff' else isnull(@CurrentColour,'#ffffff') end

end 

GO
/****** Object:  UserDefinedFunction [dbo].[GetConditionCodeTranslated]    Script Date: 7/12/2019 12:06:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   Function [dbo].[GetConditionCodeTranslated](@Id int,@ClientSiteId int, @LanguageId Int,@Flag varchar(50))
returns nvarchar(150) as
begin
declare @Name nvarchar(150),@Code varchar(10)

If @Flag in( 'ConditionName','ConditionDescription'  ) 
Begin								  
	select @Name = case when @Flag = 'ConditionName' then  ct.ConditionName 
	when @Flag = 'ConditionDescription' then ct.Descriptions end 
	from ConditionCodeClientMapping c  join ConditionCodeClientTranslated ct on ct.CMappingId = c.CMappingId and c.ConditionId = @Id and c.ClientSiteId =@ClientSiteId
	where ( ct.LanguageId = @LanguageId or (  ct.LanguageId  = c.CreatedLanguageId 
	and not exists (select 'x' from ConditionCodeClientTranslated where CMappingId = c.CMappingId and languageid = @Languageid)))
End
 
Return @Name
end
GO
/****** Object:  UserDefinedFunction [dbo].[GetDCUpdateCheck]    Script Date: 7/12/2019 12:06:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   Function [dbo].[GetDCUpdateCheck](@JobId BigInt, @UserId Int)
returns int as
begin
Declare @IsEditable int = 0, @UserCheck int =0, @DCDoneCheck int  =0

select @UserCheck = count(*) ,@DCDoneCheck = sum(isnull(DataCollectionDone,0))
from JobEquipment where JobId = @JobId and DataCollectorId = @UserId 
 
 select @IsEditable = case when (@UserCheck > 0 and @DCDoneCheck = 0) then 1 else 0 end 
  
Return isnull(@IsEditable,0)
end

GO
/****** Object:  UserDefinedFunction [dbo].[GetJobEquipCount]    Script Date: 7/12/2019 12:06:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   Function [dbo].[GetJobEquipCount](@Jobid BigInt, @ServiceId int, @LanguageId int, @UserId int)
returns int as
begin
	Declare @EquipCount int 
	select @EquipCount = count(je.equipmentid) 
	from JobEquipment je where je.JobId = @jobId and je.ServiceId = @ServiceId 
	and (je.DataCollectorId =  @UserId or je.AnalystId = @UserId or je.ReviewerId = @UserId or @UserId is null )   and je.Active = 'Y'
	
	Return @EquipCount 
end 
GO
/****** Object:  UserDefinedFunction [dbo].[GetJobProcessPct]    Script Date: 7/12/2019 12:06:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 
CREATE   Function [dbo].[GetJobProcessPct](@Jobid BigInt, @ServiceId int, @LanguageId int, @UserId int)
returns int as
begin
	Declare @EquipCount int , @SU int, @NA int,@JC int, @ResultPct int, @EquipSubmited int
	set @SU =  dbo.GetStatusId(@LanguageId,'JobProcessStatus','SU')
	set @NA =  dbo.GetStatusId(@LanguageId,'JobProcessStatus','NA')
	set @JC =  dbo.GetStatusId(@LanguageId,'JobProcessStatus','C')
	select @EquipCount =  count(je.equipmentid) , @EquipSubmited  = sum( case when je.StatusId = @JC then 1  when je.StatusId = @SU then 1 else 0 end)
	from JobEquipment je where je.JobId = @jobId and (je.ServiceId = @ServiceId or @ServiceId is null )
	and (je.DataCollectorId =  @UserId or je.AnalystId = @UserId or je.ReviewerId = @UserId or @UserId is null ) and je.StatusId <> @NA  and je.Active = 'Y'

	set @ResultPct = case when isnull(@EquipSubmited,0) = 0 then 0 else (isnull(@EquipSubmited,1) * 100/isnull(@EquipCount,1) ) end
	 
	Return @ResultPct 
end 
GO
/****** Object:  UserDefinedFunction [dbo].[GetJobStatusColour]    Script Date: 7/12/2019 12:06:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   Function [dbo].[GetJobStatusColour](@Jobid BigInt, @ServiceId int,@EstStartDate date, @LanguageId int,@UserId int)
returns Varchar(50) as
begin
 
	Declare @CurrentStatus int, @CurrentColour varchar(50), @EquipCount int , @NS int, @IP int, @SU int, @NA int, @JC int ,@OD int, @NSC int, @IPC int, @SUC int, @NAC int, @JCC int
	Select @NS = dbo.GetStatusId(@LanguageId,'JobProcessStatus','NS') , @IP =  dbo.GetStatusId(@LanguageId,'JobProcessStatus','IP'), 
	@SU =  dbo.GetStatusId(@LanguageId,'JobProcessStatus','SU'), @JC =  dbo.GetStatusId(@LanguageId,'JobProcessStatus','C'), 
	@NA =  dbo.GetStatusId(@LanguageId,'JobProcessStatus','NA'), @OD =  dbo.GetStatusId(@LanguageId,'JobProcessStatus','OD')

	select @EquipCount = count(je.equipmentid),  
	@NSC = sum(Case when je.StatusId = @NS then 1 else 0 end),
	@IPC = sum(Case when je.StatusId = @IP then 1 else 0 end),
	@SUC = sum(Case when je.StatusId = @SU then 1 else 0 end),
	@NAC = sum(Case when je.StatusId = @NA then 1 else 0 end),
	@JCC = sum(Case when je.StatusId = @JC then 1 else 0 end)
	from JobEquipment je	
	where je.JobId = @jobId and je.ServiceId = @ServiceId 
	and (je.DataCollectorId =  @UserId or je.AnalystId = @UserId or je.ReviewerId = @UserId or @UserId is null ) and je.Active = 'Y'
 
 Select @CurrentColour = dbo.GetLookupTranslated(
 case 
 when isnull(@NAC,0)   = isnull(@EquipCount,0) then dbo.GetStatusId(@LanguageId,'ReportStatusLegend','NA')
 when ((isnull(@NSC,0) + isnull(@NAC,0))  = isnull(@EquipCount,0) and datediff(D,@EstStartDate,getdate()) <= 5) then dbo.GetStatusId(@LanguageId,'ReportStatusLegend','NS')
	  when ((isnull(@NSC,0) + isnull(@NAC,0))  = isnull(@EquipCount,0) and datediff(D,@EstStartDate,getdate()) > 5) then dbo.GetStatusId(@LanguageId,'ReportStatusLegend','OD') 
	  when ((isnull(@SUC,0) + isnull(@NAC,0))  = isnull(@EquipCount,0) ) then dbo.GetStatusId(@LanguageId,'ReportStatusLegend','SU') 
	  when ((isnull(@JCC,0) + isnull(@NAC,0))  = isnull(@EquipCount,0) ) then dbo.GetStatusId(@LanguageId,'ReportStatusLegend','C')
	  when  (isnull(@IPC,0) > 0 or (isnull(@NSC,0)>0 and isnull(@NSC,0)<> isnull(@EquipCount,0)) or (isnull(@SUC,0)>0 and isnull(@SUC,0)<> isnull(@EquipCount,0)) or
			(isnull(@JCC,0)>0 and isnull(@JCC,0)<> isnull(@EquipCount,0)) or (isnull(@NAC,0)>0 and isnull(@NAC,0)<> isnull(@EquipCount,0))) then dbo.GetStatusId(@LanguageId,'ReportStatusLegend','IP') 

 end
 ,@LanguageId,'LookupValue') 
 	    
 Return case when isnull(@EquipCount,0) = 0 then '#ffffff' else isnull(@CurrentColour,'#ffffff') end

end 
GO
/****** Object:  UserDefinedFunction [dbo].[GetJobToolTip]    Script Date: 7/12/2019 12:06:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   Function [dbo].[GetJobToolTip](@Jobid BigInt, @ServiceId int, @LanguageId int, @UserId Int)
returns nvarchar(2500) as
begin
 Declare @ToolTip nvarchar(2500) 
 ;With ECount as
 (select concat(dbo.GetLookupTranslated(j.StatusId,@LanguageId,'LookupValue'), ' : ', count(j.equipmentid))EquipmentStatus 
 from JobEquipment j where j.JobId = @Jobid and j.ServiceId = @ServiceId 
 and (j.DataCollectorId =  @UserId or j.AnalystId = @UserId or j.ReviewerId = @UserId or @UserId is null )   and j.Active = 'Y' 
Group by j.StatusId
) 
SELECT @ToolTip = STRING_AGG (s.EquipmentStatus,',') 
FROM  Ecount s 

Return replace(@ToolTip,',',char(10))
end
  
GO
/****** Object:  UserDefinedFunction [dbo].[GetLookupTranslated]    Script Date: 7/12/2019 12:06:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   Function [dbo].[GetLookupTranslated](@Id int,@LanguageId Int,@Flag varchar(50))
returns nvarchar(150) as
begin
declare @Name nvarchar(150),@Code varchar(10)
 
	select @Name = Case when @Flag = 'LookupValue' then lt.LValue
						when @Flag = 'LookupCode' then l.LookupCode 
						when @Flag = 'LookupOrder' then cast(l.ListOrder as varchar) end
	from Lookups l  join LookupTranslated lt on lt.LookupId = l.LookupId and l.LookupId = @Id
	where ( lt.LanguageId = @LanguageId or (  lt.LanguageId  = l.CreatedLanguageId 
	and not exists (select 'x' from LookupTranslated where LookupId = l.LookupId and languageid = @Languageid)))
   
Return @Name
end
GO
/****** Object:  UserDefinedFunction [dbo].[GetNameTranslated]    Script Date: 7/12/2019 12:06:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   Function [dbo].[GetNameTranslated](@Id int,@LanguageId Int,@Flag varchar(50))
returns nvarchar(150) as
begin
declare @Name nvarchar(150),@Code varchar(10)

If @Flag in( 'ProgramMenuName' , 'ProgramName') 
	Begin
		select @Name = case when @Flag = 'ProgramName' then pt.ProgramName  else pt.MenuName end 
		from Programs p  join ProgramTranslated pt on pt.ProgramId = p.ProgramId and p.ProgramId = @Id
		where  pt.LanguageId = @LanguageId
	--	 ( pt.LanguageId = @LanguageId or (  pt.LanguageId  = p.CreatedLanguageId 	and not exists (select 'x' from ProgramTranslated where ProgramId = p.ProgramId and languageid = @Languageid)))
	End
 
else If @Flag = 'CountryName' 
	Begin
		select @Name = ct.CountryName
		from country c  join CountryTranslated ct on ct.CountryId = c.CountryId and c.CountryId = @Id
		where ct.LanguageId = @LanguageId --   ( ct.LanguageId = @LanguageId or (  ct.LanguageId  = c.CreatedLanguageId 		and not exists (select 'x' from CountryTranslated where countryid = c.countryid and languageid = @Languageid)))
	End
else If @Flag = 'CostCentreName' 
	Begin
		select @Name = ct.CostCentreName
		from CostCentre c  join CostCentreTranslated ct on ct.CostCentreId = c.CostCentreId and c.CostCentreId = @Id
		where ct.LanguageId = @LanguageId --  ( ct.LanguageId = @LanguageId or (  ct.LanguageId  = c.CreatedLanguageId 		and not exists (select 'x' from CostCentreTranslated where CostCentreId = c.CostCentreId and languageid = @Languageid)))
	End
else If @Flag = 'SectorName' 
Begin
	select @Name = st.SectorName 
	from Sector s  join SectorTranslated st on st.SectorId = s.SectorId and s.SectorId = @Id
	where st.LanguageId = @LanguageId 
	--  ( st.LanguageId = @LanguageId or (  st.LanguageId  = s.CreatedLanguageId 	and not exists (select 'x' from SectorTranslated where SectorId = s.SectorId and languageid = @Languageid)))
End
else If @Flag = 'SegmentName' 
Begin
	select @Name = st.SegmentName  
	from Segment s  join SegmentTranslated st on st.SegmentId = s.SegmentId and s.SegmentId = @Id
	where  st.LanguageId = @LanguageId --( st.LanguageId = @LanguageId or (  st.LanguageId  = s.CreatedLanguageId 	and not exists (select 'x' from SegmentTranslated where SegmentId = s.SegmentId and languageid = @Languageid)))
End

else If @Flag = 'IndustryName' 
Begin
	select @Name = ct.IndustryName
	from Industry c  join IndustryTranslated ct on ct.IndustryId = c.IndustryId and c.IndustryId = @Id
	where   ct.LanguageId = @LanguageId  -- ( ct.LanguageId = @LanguageId or (  ct.LanguageId  = c.CreatedLanguageId 	and not exists (select 'x' from IndustryTranslated where IndustryId = c.IndustryId and languageid = @Languageid)))
End

else If @Flag = 'ClientName' 
Begin
	select @Name = ct.ClientName
	from Client c  join ClientTranslated ct on ct.ClientId = c.ClientId and c.ClientId = @Id
	where   ct.LanguageId = @LanguageId  -- ( ct.LanguageId = @LanguageId or (  ct.LanguageId  = c.CreatedLanguageId 	and not exists (select 'x' from ClientTranslated where ClientId = c.ClientId and languageid = @Languageid)))
End
else If @Flag = 'ClientSiteName' 
Begin
	select @Name = ct.SiteName
	from ClientSite c  join ClientSiteTranslated ct on ct.ClientSiteId = c.ClientSiteId and c.ClientSiteId = @Id
	where  ct.LanguageId = @LanguageId  --  ( ct.LanguageId = @LanguageId or (  ct.LanguageId  = c.CreatedLanguageId 	and not exists (select 'x' from ClientSiteTranslated where ClientSiteId = c.ClientSiteId and languageid = @Languageid)))
End
else If @Flag = 'RoleGroupName' 
Begin
	select @Name = rt.RoleGroupName
	from RoleGroup r  join RoleGroupTranslated rt on rt.RoleGroupId = r.RoleGroupId and r.RoleGroupId = @Id
	where rt.LanguageId = @LanguageId  --   ( rt.LanguageId = @LanguageId or (  rt.LanguageId  = r.CreatedLanguageId 	and not exists (select 'x' from RoleGroupTranslated where RoleGroupId = r.RoleGroupId and languageid = @Languageid)))
End
else If @Flag = 'RoleName' 
Begin
	select @Name = r.RoleName
	from Roles r  where r.roleid = @Id
End
else If @Flag = 'PrivilegeName' 
Begin
	select @Name = p.PrivilegeName
	from Privileges p  where p.PrivilegeId = @Id
End
else If @Flag in ('LookupValue' , 'LookupCode')
Begin
	select @Name = case when @Flag = 'LookupValue' then lt.LValue
						when @Flag = 'LookupCode' then l.LookupCode end 
	from Lookups l  join LookupTranslated lt on lt.LookupId = l.LookupId and l.LookupId = @Id
	where ( lt.LanguageId = @LanguageId or (  lt.LanguageId  = l.CreatedLanguageId 
	and not exists (select 'x' from LookupTranslated where LookupId = l.LookupId and languageid = @Languageid)))
End
else If @Flag in( 'AssetCategoryName' , 'AssetCategoryCName')
Begin
	select @Name = case  when @Flag = 'AssetCategoryName' then ft.AssetCategoryName
						 when @Flag = 'AssetCategoryCName' then concat(f.AssetCategoryCode ,' - ', ft.AssetCategoryName) end  
	from AssetCategory f  join AssetCategoryTranslated ft on ft.AssetCategoryId = f.AssetCategoryId and f.AssetCategoryId = @Id
	where ( ft.LanguageId = @LanguageId or (  ft.LanguageId  = f.CreatedLanguageId 
	and not exists (select 'x' from AssetCategoryTranslated where AssetCategoryId = f.AssetCategoryId and languageid = @Languageid)))
End
else If @Flag in( 'AssetClassName' ,'AssetClassCName', 'AssetClassCode')
Begin
	select @Name = case when @Flag = 'AssetClassName' then ft.AssetClassName
						when @Flag = 'AssetClassCName' then concat(f.AssetClassCode ,' - ', ft.AssetClassName)
						when @Flag = 'AssetClassCode' then f.AssetClassCode end 
	from AssetClass f  join AssetClassTranslated ft on ft.AssetClassId = f.AssetClassId and f.AssetClassId = @Id
	where ( ft.LanguageId = @LanguageId or (  ft.LanguageId  = f.CreatedLanguageId 
	and not exists (select 'x' from AssetClassTranslated where AssetClassId = f.AssetClassId and languageid = @Languageid)))
End

else If @Flag in('AssetTypeName','AssetTypeCName','AssetTypeCode')
Begin
	select @Name = Case when @Flag = 'AssetTypeName' then att.AssetTypeName 
						when @Flag = 'AssetTypeCName' then concat(a.AssetTypeCode ,' - ', att.AssetTypeName) 
						when @Flag = 'AssetTypeCode' then a.AssetTypeCode end
	from AssetType a  join AssetTypeTranslated att on att.AssetTypeId = a.AssetTypeId and a.AssetTypeId = @Id
	where ( att.LanguageId = @LanguageId or (  att.LanguageId  = a.CreatedLanguageId 
	and not exists (select 'x' from AssetTypeTranslated where AssetTypeId = a.AssetTypeId and languageid = @Languageid)))
End
else If @Flag in ('AssetSequenceName','AssetSequenceCName','AssetSequenceCode')
Begin
	select @Name = case when @Flag = 'AssetSequenceName' then ft.AssetSequenceName 
						when @Flag = 'AssetSequenceCName' then concat(f.AssetSequenceCode ,' - ', ft.AssetSequenceName)
						when @Flag = 'AssetSequenceCode' then f.AssetSequenceCode end
	from AssetSequence f  join AssetSequenceTranslated ft on ft.AssetSequenceId = f.AssetSequenceId and f.AssetSequenceId = @Id
	where ( ft.LanguageId = @LanguageId or (  ft.LanguageId  = f.CreatedLanguageId 
	and not exists (select 'x' from AssetSequenceTranslated where AssetSequenceId = f.AssetSequenceId and languageid = @Languageid)))
End
else If @Flag in ('FailureModeName','FailureModeCode')
Begin
	select @Name = case when @Flag = 'FailureModeName' then ft.FailureModeName
						when @Flag = 'FailureModeCode' then f.FailureModeCode end
	from FailureMode f  join FailureModeTranslated ft on ft.FailureModeId = f.FailureModeId and f.FailureModeId = @Id
	where ( ft.LanguageId = @LanguageId or (  ft.LanguageId  = f.CreatedLanguageId 
	and not exists (select 'x' from FailureModeTranslated where FailureModeId = f.FailureModeId and languageid = @Languageid)))
End

else If @Flag in ('FailureCauseName','FailureCauseCode')
Begin
	select @Name = case when @Flag = 'FailureCauseName' then ft.FailureCauseName  
						when @Flag = 'FailureCauseCode' then f.FailureCauseCode end
	from FailureCause f  join FailureCauseTranslated ft on ft.FailureCauseId = f.FailureCauseId and f.FailureCauseId = @Id
	where ( ft.LanguageId = @LanguageId or (  ft.LanguageId  = f.CreatedLanguageId 
	and not exists (select 'x' from FailureCauseTranslated where FailureCauseId = f.FailureCauseId and languageid = @Languageid)))
End
else If @Flag = 'BearingName' 
Begin
	select @Name = bt.BearingName
	from Bearings b  join BearingTranslated bt on bt.BearingId = b.BearingId and b.BearingId = @Id
	where ( bt.LanguageId = @LanguageId or (  bt.LanguageId  = b.CreatedLanguageId 
	and not exists (select 'x' from BearingTranslated where BearingId = b.BearingId and languageid = @Languageid)))
End
else If @Flag = 'ManufacturerName' 
Begin
	select @Name = mt.ManufacturerName
	from Manufacturer m  join ManufacturerTranslated mt on mt.ManufacturerId = m.ManufacturerId and m.ManufacturerId = @Id
	where ( mt.LanguageId = @LanguageId or (  mt.LanguageId  = m.CreatedLanguageId 
	and not exists (select 'x' from ManufacturerTranslated where ManufacturerId = m.ManufacturerId and languageid = @Languageid)))
End
else If @Flag = 'PlantAreaName' 
Begin
	select @Name = pat.PlantAreaName
	from PlantArea pa  join PlantAreaTranslated pat on pat.PlantAreaId = pa.PlantAreaId and pa.PlantAreaId = @Id
	where ( pat.LanguageId = @LanguageId or (  pat.LanguageId  = pa.CreatedLanguageId 
	and not exists (select 'x' from PlantAreaTranslated where PlantAreaId = pa.PlantAreaId and languageid = @Languageid)))

End
else If @Flag  in ('AreaName','AreaDescriptions')
Begin
	select @Name = case when @Flag = 'AreaName' then st.AreaName when @Flag = 'AreaDescriptions' then st.Descriptions  end 
	from [Area] s  join AreaTranslated st on st.AreaId = s.AreaId and s.AreaId = @Id
	where ( st.LanguageId = @LanguageId or (  st.LanguageId  = s.AreaLanguageId 
	and not exists (select 'x' from AreaTranslated where AreaId = s.AreaId and languageid = @Languageid)))
End
else If @Flag in ('SystemName','SystemDescriptions')
Begin
	select @Name = case when @Flag = 'SystemName' then st.SystemName when @Flag = 'SystemDescriptions' then st.Descriptions  end
	from [System] s  join SystemTranslated st on st.SystemId = s.SystemId and s.SystemId = @Id
	where ( st.LanguageId = @LanguageId or (  st.LanguageId  = s.CreatedLanguageId 
	and not exists (select 'x' from SystemTranslated where SystemId = s.SystemId and languageid = @Languageid)))
End
else If @Flag = 'EquipmentName' 
Begin
	select @Name = e.EquipmentName from Equipment e where e.EquipmentId = @Id
End
else If @Flag in( 'DRUnitName' ,'DRUnitAssetId')
Begin
 	select @Name = case when @Flag = 'DRUnitName' then d.IdentificationName
						when @Flag = 'DRUnitAssetId' then cast(d.AssetId as varchar) end
     from EquipmentDriveUnit d where d.DriveUnitId = @Id
	End
else If @Flag in('DNUnitName' ,'DNUnitAssetId')
Begin
 	select @Name = case when @Flag = 'DNUnitName' then  d.IdentificationName
	                    when @Flag = 'DNUnitAssetId' then cast(d.AssetId as varchar) end
	from EquipmentDrivenUnit d where d.DrivenUnitId = @Id
	
End
else If @Flag in('INUnitName' ,'INUnitAssetId')
Begin
 	select @Name = case when @Flag = 'INUnitName' then d.IdentificationName 
	                    when @Flag = 'INUnitAssetId' then cast(d.AssetId as varchar) end
     from EquipmentIntermediateUnit d where d.IntermediateUnitId = @Id
End
else If @Flag = 'TaxonomyAssetCode' 
Begin
	select @Name = t.AssetClassTypeCode from Taxonomy t where t.TaxonomyId = @Id
End
Return @Name
end
GO
/****** Object:  UserDefinedFunction [dbo].[GetRSUpdateCheck]    Script Date: 7/12/2019 12:06:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   Function [dbo].[GetRSUpdateCheck](@JobId BigInt, @UserId Int)
returns int as
Begin
	Declare @IsEditable int = 0, @UserCheck int =0, @RSDoneCheck int  =0, @Jstatus int 
	set @Jstatus = dbo.GetStatusId(1,'JobProcessStatus','C')
 
	select @UserCheck = count(*) ,@RSDoneCheck = sum(isnull(je.ReportSent,0))
	from JobEquipment je join Jobs j on j.JobId = je.JobId and J.StatusId = @Jstatus
	where je.JobId = @JobId and je.ReviewerId = @UserId 
 
	select @IsEditable = case when (@UserCheck > 0 and @RSDoneCheck = 0) then 1 else 0 end 
  
	Return isnull(@IsEditable,0)
end

GO
/****** Object:  UserDefinedFunction [dbo].[GetSectorNameTranslated]    Script Date: 7/12/2019 12:06:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

create   Function [dbo].[GetSectorNameTranslated](@Id int,@LanguageId Int,@Flag varchar(50))
returns nvarchar(150) as
begin
declare @Name nvarchar(150),@Code varchar(10), @CreatedLanguageId int
	select @CreatedLanguageId = CreatedLanguageId, @Code = SectorCode from Sector where SectorId = @Id

	select @Name = Case when @Flag = 'Name' then st.SectorName
						when @Flag = 'Code' then @Code end
	from SectorTranslated st where st.SectorId = @Id  and st.LanguageId = @LanguageId
	if isnull(@Name,'') = '' 
	Begin
	select @Name = Case when @Flag = 'Name' then st.SectorName
						when @Flag = 'Code' then @Code end
	from SectorTranslated st where st.SectorId = @Id  and st.LanguageId = @CreatedLanguageId
	End
	 /*
else If @Flag = 'SegmentName' 
Begin
	select @Name = st.SegmentName  
	from Segment s  join SegmentTranslated st on st.SegmentId = s.SegmentId and s.SegmentId = @Id
	where ( st.LanguageId = @LanguageId or (  st.LanguageId  = s.CreatedLanguageId 
	and not exists (select 'x' from SegmentTranslated where SegmentId = s.SegmentId and languageid = @Languageid)))
End

else If @Flag = 'IndustryName' 
Begin
	select @Name = ct.IndustryName
	from Industry c  join IndustryTranslated ct on ct.IndustryId = c.IndustryId and c.IndustryId = @Id
	where   ( ct.LanguageId = @LanguageId or (  ct.LanguageId  = c.CreatedLanguageId 
	and not exists (select 'x' from IndustryTranslated where IndustryId = c.IndustryId and languageid = @Languageid)))
End

else If @Flag in( 'AssetCategoryName' , 'AssetCategoryCName')
Begin
	select @Name = case  when @Flag = 'AssetCategoryName' then ft.AssetCategoryName
						 when @Flag = 'AssetCategoryCName' then concat(f.AssetCategoryCode ,' - ', ft.AssetCategoryName) end  
	from AssetCategory f  join AssetCategoryTranslated ft on ft.AssetCategoryId = f.AssetCategoryId and f.AssetCategoryId = @Id
	where ( ft.LanguageId = @LanguageId or (  ft.LanguageId  = f.CreatedLanguageId 
	and not exists (select 'x' from AssetCategoryTranslated where AssetCategoryId = f.AssetCategoryId and languageid = @Languageid)))
End
else If @Flag in( 'AssetClassName' ,'AssetClassCName')
Begin
	select @Name = case when @Flag = 'AssetClassName' then ft.AssetClassName
						when @Flag = 'AssetClassCName' then concat(f.AssetClassCode ,' - ', ft.AssetClassName) end  
	from AssetClass f  join AssetClassTranslated ft on ft.AssetClassId = f.AssetClassId and f.AssetClassId = @Id
	where ( ft.LanguageId = @LanguageId or (  ft.LanguageId  = f.CreatedLanguageId 
	and not exists (select 'x' from AssetClassTranslated where AssetClassId = f.AssetClassId and languageid = @Languageid)))
End

else If @Flag in('AssetTypeName','AssetTypeCName')
Begin
	select @Name = Case when @Flag = 'AssetTypeName' then att.AssetTypeName 
						when @Flag = 'AssetTypeCName' then concat(a.AssetTypeCode ,' - ', att.AssetTypeName) end
	from AssetType a  join AssetTypeTranslated att on att.AssetTypeId = a.AssetTypeId and a.AssetTypeId = @Id
	where ( att.LanguageId = @LanguageId or (  att.LanguageId  = a.CreatedLanguageId 
	and not exists (select 'x' from AssetTypeTranslated where AssetTypeId = a.AssetTypeId and languageid = @Languageid)))
End
else If @Flag in ('AssetSequenceName','AssetSequenceCName')
Begin
	select @Name = case when @Flag = 'AssetSequenceName' then ft.AssetSequenceName 
						when @Flag = 'AssetSequenceCName' then concat(f.AssetSequenceCode ,' - ', ft.AssetSequenceName) end
	from AssetSequence f  join AssetSequenceTranslated ft on ft.AssetSequenceId = f.AssetSequenceId and f.AssetSequenceId = @Id
	where ( ft.LanguageId = @LanguageId or (  ft.LanguageId  = f.CreatedLanguageId 
	and not exists (select 'x' from AssetSequenceTranslated where AssetSequenceId = f.AssetSequenceId and languageid = @Languageid)))
End
else If @Flag = 'FailureModeName' 
Begin
	select @Name = ft.FailureModeName  
	from FailureMode f  join FailureModeTranslated ft on ft.FailureModeId = f.FailureModeId and f.FailureModeId = @Id
	where ( ft.LanguageId = @LanguageId or (  ft.LanguageId  = f.CreatedLanguageId 
	and not exists (select 'x' from FailureModeTranslated where FailureModeId = f.FailureModeId and languageid = @Languageid)))
End

else If @Flag = 'FailureCauseName' 
Begin
	select @Name = ft.FailureCauseName  
	from FailureCause f  join FailureCauseTranslated ft on ft.FailureCauseId = f.FailureCauseId and f.FailureCauseId = @Id
	where ( ft.LanguageId = @LanguageId or (  ft.LanguageId  = f.CreatedLanguageId 
	and not exists (select 'x' from FailureCauseTranslated where FailureCauseId = f.FailureCauseId and languageid = @Languageid)))
End*/  
Return @Name
end
GO
/****** Object:  UserDefinedFunction [dbo].[GetSegmentNameTranslated]    Script Date: 7/12/2019 12:06:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

create   Function [dbo].[GetSegmentNameTranslated](@Id int,@LanguageId Int,@Flag varchar(50))
returns nvarchar(150) as
begin
declare @Name nvarchar(150),@Code varchar(10), @CreatedLanguageId int
	select @CreatedLanguageId = CreatedLanguageId, @Code = SegmentCode from Segment where SegmentId = @Id

	select @Name = Case when @Flag = 'Name' then st.SegmentName
						when @Flag = 'Code' then @Code end
	from SegmentTranslated st where st.SegmentId = @Id  and st.LanguageId = @LanguageId
	if isnull(@Name,'') = '' 
	Begin
	select @Name = Case when @Flag = 'Name' then st.SegmentName
						when @Flag = 'Code' then @Code end
	from SegmentTranslated st where st.SegmentId = @Id  and st.LanguageId = @CreatedLanguageId
	End
	 /*
else If @Flag = 'SegmentName' 
Begin
	select @Name = st.SegmentName  
	from Segment s  join SegmentTranslated st on st.SegmentId = s.SegmentId and s.SegmentId = @Id
	where ( st.LanguageId = @LanguageId or (  st.LanguageId  = s.CreatedLanguageId 
	and not exists (select 'x' from SegmentTranslated where SegmentId = s.SegmentId and languageid = @Languageid)))
End

else If @Flag = 'IndustryName' 
Begin
	select @Name = ct.IndustryName
	from Industry c  join IndustryTranslated ct on ct.IndustryId = c.IndustryId and c.IndustryId = @Id
	where   ( ct.LanguageId = @LanguageId or (  ct.LanguageId  = c.CreatedLanguageId 
	and not exists (select 'x' from IndustryTranslated where IndustryId = c.IndustryId and languageid = @Languageid)))
End

else If @Flag in( 'AssetCategoryName' , 'AssetCategoryCName')
Begin
	select @Name = case  when @Flag = 'AssetCategoryName' then ft.AssetCategoryName
						 when @Flag = 'AssetCategoryCName' then concat(f.AssetCategoryCode ,' - ', ft.AssetCategoryName) end  
	from AssetCategory f  join AssetCategoryTranslated ft on ft.AssetCategoryId = f.AssetCategoryId and f.AssetCategoryId = @Id
	where ( ft.LanguageId = @LanguageId or (  ft.LanguageId  = f.CreatedLanguageId 
	and not exists (select 'x' from AssetCategoryTranslated where AssetCategoryId = f.AssetCategoryId and languageid = @Languageid)))
End
else If @Flag in( 'AssetClassName' ,'AssetClassCName')
Begin
	select @Name = case when @Flag = 'AssetClassName' then ft.AssetClassName
						when @Flag = 'AssetClassCName' then concat(f.AssetClassCode ,' - ', ft.AssetClassName) end  
	from AssetClass f  join AssetClassTranslated ft on ft.AssetClassId = f.AssetClassId and f.AssetClassId = @Id
	where ( ft.LanguageId = @LanguageId or (  ft.LanguageId  = f.CreatedLanguageId 
	and not exists (select 'x' from AssetClassTranslated where AssetClassId = f.AssetClassId and languageid = @Languageid)))
End

else If @Flag in('AssetTypeName','AssetTypeCName')
Begin
	select @Name = Case when @Flag = 'AssetTypeName' then att.AssetTypeName 
						when @Flag = 'AssetTypeCName' then concat(a.AssetTypeCode ,' - ', att.AssetTypeName) end
	from AssetType a  join AssetTypeTranslated att on att.AssetTypeId = a.AssetTypeId and a.AssetTypeId = @Id
	where ( att.LanguageId = @LanguageId or (  att.LanguageId  = a.CreatedLanguageId 
	and not exists (select 'x' from AssetTypeTranslated where AssetTypeId = a.AssetTypeId and languageid = @Languageid)))
End
else If @Flag in ('AssetSequenceName','AssetSequenceCName')
Begin
	select @Name = case when @Flag = 'AssetSequenceName' then ft.AssetSequenceName 
						when @Flag = 'AssetSequenceCName' then concat(f.AssetSequenceCode ,' - ', ft.AssetSequenceName) end
	from AssetSequence f  join AssetSequenceTranslated ft on ft.AssetSequenceId = f.AssetSequenceId and f.AssetSequenceId = @Id
	where ( ft.LanguageId = @LanguageId or (  ft.LanguageId  = f.CreatedLanguageId 
	and not exists (select 'x' from AssetSequenceTranslated where AssetSequenceId = f.AssetSequenceId and languageid = @Languageid)))
End
else If @Flag = 'FailureModeName' 
Begin
	select @Name = ft.FailureModeName  
	from FailureMode f  join FailureModeTranslated ft on ft.FailureModeId = f.FailureModeId and f.FailureModeId = @Id
	where ( ft.LanguageId = @LanguageId or (  ft.LanguageId  = f.CreatedLanguageId 
	and not exists (select 'x' from FailureModeTranslated where FailureModeId = f.FailureModeId and languageid = @Languageid)))
End

else If @Flag = 'FailureCauseName' 
Begin
	select @Name = ft.FailureCauseName  
	from FailureCause f  join FailureCauseTranslated ft on ft.FailureCauseId = f.FailureCauseId and f.FailureCauseId = @Id
	where ( ft.LanguageId = @LanguageId or (  ft.LanguageId  = f.CreatedLanguageId 
	and not exists (select 'x' from FailureCauseTranslated where FailureCauseId = f.FailureCauseId and languageid = @Languageid)))
End*/  
Return @Name
end
GO
/****** Object:  UserDefinedFunction [dbo].[GetStatusId]    Script Date: 7/12/2019 12:06:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   Function [dbo].[GetStatusId](@LanguageId Int,@Name nvarchar(100), @Code varchar(50))
returns int as
begin
 Declare @StatusId int 
 
	select @StatusId = l.LookupId
	from Lookups l where l.LookupCode = @Code  and l.LName = @Name  
 
Return @StatusId
end
GO
/****** Object:  UserDefinedFunction [dbo].[JobEquipUnitUnselected]    Script Date: 7/12/2019 12:06:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   Function [dbo].[JobEquipUnitUnselected](	
	@JobEquipmentId Bigint )
returns int as
begin
Declare @DRcount int = 0, @DNcount int = 0 , @INcount int = 0, @Totalcount int = 0 
 
	select @DRcount = count(*) 
	from vEquipDriveAnalysis je	
	Join Equipment e on e.EquipmentId = je.EquipmentId
	where je.JobEquipmentId = @JobEquipmentId
	and not exists (select 'x' from JobEquipUnitAnalysis ua where ua.JobEquipmentId = je.JobEquipmentId and ua.UnitType = 'DR' and ua.UnitId = je.DriveUnitId and ua.ServiceId = je.ServiceId ) 
 
 	select @INcount = Count(*)    
	from vEquipIntermediateAnalysis je	
	Join Equipment e on e.EquipmentId = je.EquipmentId	
	where je.JobEquipmentId = @JobEquipmentId
	and not exists (select 'x' from JobEquipUnitAnalysis ua where ua.JobEquipmentId = je.JobEquipmentId and ua.UnitType = 'IN' and ua.UnitId = je.IntermediateUnitId and ua.ServiceId = je.ServiceId ) 

	select @DNcount = Count(*)	
	from vEquipDrivenAnalysis je
	Join Equipment e on e.EquipmentId = je.EquipmentId
	where je.JobEquipmentId = @JobEquipmentId
	and not exists (select 'x' from JobEquipUnitAnalysis ua where ua.JobEquipmentId = je.JobEquipmentId and ua.UnitType = 'DN' and ua.UnitId = je.DrivenUnitId and ua.ServiceId = je.ServiceId ) 
	
	set @Totalcount = isnull(@DRcount,0) + isnull(@DNcount,0) + isnull(@INcount,0)

Return isnull(@Totalcount,0)  
end

GO
/****** Object:  UserDefinedFunction [dbo].[StringSplit]    Script Date: 7/12/2019 12:06:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  FUNCTION [dbo].[StringSplit]
(
    @String  VARCHAR(MAX), @Separator CHAR(1) , @SId int
)
RETURNS @RESULT TABLE(TSID int, TValue VARCHAR(MAX))
AS
BEGIN     
 DECLARE @SeparatorPosition INT = CHARINDEX(@Separator, @String ),
        @Value VARCHAR(MAX), @StartPosition INT = 1
 
 IF @SeparatorPosition = 0  
  BEGIN
   INSERT INTO @RESULT(TSID,TValue) VALUES(@SID, @String)
   RETURN
  END
     
 SET @String = @String + @Separator
 WHILE @SeparatorPosition > 0
  BEGIN
   SET @Value = SUBSTRING(@String , @StartPosition, @SeparatorPosition- @StartPosition)
 
   IF( @Value <> ''  ) 
    INSERT INTO @RESULT(TSID,TValue) VALUES(@SID, @Value)
   
   SET @StartPosition = @SeparatorPosition + 1
   SET @SeparatorPosition = CHARINDEX(@Separator, @String , @StartPosition)
  END    
     
 RETURN
END
GO
/****** Object:  Table [dbo].[EquipmentIntermediateUnit]    Script Date: 7/12/2019 12:06:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentIntermediateUnit](
	[IntermediateUnitId] [int] IDENTITY(1,1) NOT NULL,
	[EquipmentId] [int] NOT NULL,
	[AssetId] [int] NOT NULL,
	[IdentificationName] [nvarchar](150) NOT NULL,
	[ListOrder] [int] NULL,
	[ManufacturerId] [int] NULL,
	[Ratio] [nvarchar](100) NULL,
	[Size] [nvarchar](100) NULL,
	[BeltLength] [nvarchar](100) NULL,
	[PulleyDiaDrive] [nvarchar](100) NULL,
	[PulleyDiaDriven] [nvarchar](100) NULL,
	[RatedRPMInput] [nvarchar](100) NULL,
	[RatedRPMOutput] [nvarchar](100) NULL,
	[PinionInputGearTeeth] [nvarchar](100) NULL,
	[PinionOutputGearTeeth] [nvarchar](100) NULL,
	[IdlerInputGearTeeth] [nvarchar](100) NULL,
	[IdlerOutputGearTeeth] [nvarchar](100) NULL,
	[BullGearTeeth] [nvarchar](100) NULL,
	[Model] [nvarchar](100) NULL,
	[Serial] [nvarchar](100) NULL,
	[BearingInputId] [int] NULL,
	[BearingOutputId] [int] NULL,
	[MeanRepairManHours] [decimal](15, 4) NULL,
	[DownTimeCostPerHour] [decimal](15, 4) NULL,
	[CostToRepair] [decimal](15, 4) NULL,
	[MeanFailureRate] [decimal](15, 4) NULL,
	[Active] [varchar](1) NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[ManufactureYear] [int] NULL,
	[FirstInstallationDate] [date] NULL,
	[OperationModeId] [int] NULL,
 CONSTRAINT [EquipmentIntermediateUnit_pk] PRIMARY KEY CLUSTERED 
(
	[IntermediateUnitId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_InntermediateAssetName] UNIQUE NONCLUSTERED 
(
	[EquipmentId] ASC,
	[IdentificationName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobEquipment]    Script Date: 7/12/2019 12:06:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobEquipment](
	[JobEquipmentId] [bigint] IDENTITY(1,1) NOT NULL,
	[JobId] [bigint] NOT NULL,
	[EquipmentId] [int] NOT NULL,
	[StatusId] [int] NOT NULL,
	[ConditionId] [int] NULL,
	[ActStartDate] [date] NULL,
	[ActEndDate] [date] NULL,
	[Comment] [nvarchar](2500) NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[DataCollectionDate] [date] NULL,
	[ReportDate] [date] NULL,
	[ServiceId] [int] NOT NULL,
	[DataCollectorId] [int] NULL,
	[AnalystId] [int] NULL,
	[ReviewerId] [int] NULL,
	[DataCollectionDone] [int] NOT NULL,
	[ReviewDone] [int] NOT NULL,
	[ReportSent] [int] NOT NULL,
 CONSTRAINT [JobEquipment_pk] PRIMARY KEY CLUSTERED 
(
	[JobEquipmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_Equipment] UNIQUE NONCLUSTERED 
(
	[JobId] ASC,
	[EquipmentId] ASC,
	[ServiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IntermediateServices]    Script Date: 7/12/2019 12:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IntermediateServices](
	[IntermediateServiceId] [int] IDENTITY(1,1) NOT NULL,
	[IntermediateUnitId] [int] NOT NULL,
	[ReportId] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
	[Active] [varchar](1) NULL,
 CONSTRAINT [IntermediateServices_pk] PRIMARY KEY CLUSTERED 
(
	[IntermediateServiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_IntermediateReportId] UNIQUE NONCLUSTERED 
(
	[IntermediateUnitId] ASC,
	[ReportId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vEquipIntermediateAnalysis]    Script Date: 7/12/2019 12:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   view [dbo].[vEquipIntermediateAnalysis] as
Select Je.JobEquipmentId,Je.JobId,je.EquipmentId,
edu.IntermediateUnitId,edu.AssetId,edu.IdentificationName as AssetName,
ds.ReportId as ServiceId, edu.ListOrder as AssetListOrder
From JobEquipment je join EquipmentIntermediateUnit edu on edu.EquipmentId = je.EquipmentId and edu.Active = 'Y'
join IntermediateServices ds on ds.IntermediateUnitId = edu.IntermediateUnitId and ds.ReportId = je.ServiceId and ds.Active = 'Y'  
GO
/****** Object:  Table [dbo].[UserCountryRelation]    Script Date: 7/12/2019 12:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserCountryRelation](
	[UserCountryRelationId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[CountryId] [int] NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
 CONSTRAINT [UserCountryRelation_pk] PRIMARY KEY CLUSTERED 
(
	[UserCountryRelationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserCostCentreRelation]    Script Date: 7/12/2019 12:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserCostCentreRelation](
	[UserCostCentreRelationId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[CostCentreId] [int] NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
 CONSTRAINT [UserCostCentreRelation_pk] PRIMARY KEY CLUSTERED 
(
	[UserCostCentreRelationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserClientRelation]    Script Date: 7/12/2019 12:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserClientRelation](
	[UserClientRelationId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[ClientId] [int] NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
 CONSTRAINT [UserClientRelation_pk] PRIMARY KEY CLUSTERED 
(
	[UserClientRelationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientSite]    Script Date: 7/12/2019 12:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientSite](
	[ClientSiteId] [int] IDENTITY(1,1) NOT NULL,
	[CreatedLanguageId] [int] NOT NULL,
	[ClientSiteStatus] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
	[ClientId] [int] NULL,
	[IndustryId] [int] NOT NULL,
	[CostCentreId] [int] NOT NULL,
	[CountryId] [int] NOT NULL,
	[InternalRefId] [nvarchar](75) NULL,
	[POBox] [nvarchar](40) NULL,
	[Zip] [nvarchar](30) NULL,
	[Phone] [nvarchar](30) NULL,
	[Email] [nvarchar](150) NULL,
	[Logo] [varchar](250) NULL,
	[SiebelId] [varchar](75) NULL,
	[PMPOfflineProgram] [int] NOT NULL,
	[PMPOnlineProgram] [int] NOT NULL,
	[SmartSupplierProgram] [int] NOT NULL,
	[ExcludeInDashboard] [int] NOT NULL,
	[CertifiedMaintenancePartner] [int] NOT NULL,
	[ProactiveReliabilityMaintenance] [int] NOT NULL,
 CONSTRAINT [ClientSite_pk] PRIMARY KEY CLUSTERED 
(
	[ClientSiteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserClientSiteRelation]    Script Date: 7/12/2019 12:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserClientSiteRelation](
	[UserClientSiteRelationId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[ClientSiteId] [int] NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
 CONSTRAINT [UserClientSiteRelation_pk] PRIMARY KEY CLUSTERED 
(
	[UserClientSiteRelationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[udtfClientAccess]    Script Date: 7/12/2019 12:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   FUNCTION [dbo].[udtfClientAccess] (
    @UserId INT 
)
RETURNS TABLE
AS
Return
 		SELECT  cs.ClientSiteId ClientSiteId
		FROM ClientSite cs
		JOIN UserCountryRelation ucr ON ucr.CountryId = cs.CountryId
		WHERE ucr.UserId = @UserId and ExcludeInDashboard = 0
			AND ucr.Active = 'Y' 
		UNION 
		SELECT  cs.ClientSiteId ClientSiteId
		FROM ClientSite cs
		JOIN UserCostCentreRelation uccr ON uccr.CostCentreId = cs.CostCentreId
		WHERE uccr.UserId = @UserId and ExcludeInDashboard = 0
			AND uccr.Active = 'Y' 
		UNION  
		SELECT  cs.ClientSiteId ClientSiteId
		FROM ClientSite cs
		JOIN UserClientRelation ucr ON ucr.ClientId = cs.ClientId
		WHERE ucr.UserId = @UserId and ExcludeInDashboard = 0
			AND ucr.Active = 'Y' 
	    UNION  
		SELECT  cs.ClientSiteId ClientSiteId
		FROM ClientSite cs
		JOIN UserClientSiteRelation ucsr ON ucsr.ClientSiteId = cs.ClientSiteId
		WHERE ucsr.UserId = @UserId and ExcludeInDashboard = 0
			AND ucsr.Active = 'Y' 
GO
/****** Object:  Table [dbo].[JobEquipUnitAnalysis]    Script Date: 7/12/2019 12:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobEquipUnitAnalysis](
	[UnitAnalysisId] [bigint] IDENTITY(1,1) NOT NULL,
	[JobEquipmentId] [bigint] NOT NULL,
	[ServiceId] [int] NOT NULL,
	[UnitType] [varchar](3) NOT NULL,
	[UnitId] [int] NOT NULL,
	[ConditionId] [int] NULL,
	[ConfidentFactorId] [int] NULL,
	[FailureProbFactorId] [int] NULL,
	[PriorityId] [int] NULL,
	[IsWorkNotification] [varchar](1) NOT NULL,
	[NoOfDays] [decimal](4, 2) NULL,
	[Recommendation] [nvarchar](max) NULL,
	[Comment] [nvarchar](max) NULL,
	[StatusId] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
	[DataValidationStatus] [int] NOT NULL,
	[DataValidationText] [nvarchar](1500) NULL,
 CONSTRAINT [JobEquipUnitAnalysis_pk] PRIMARY KEY CLUSTERED 
(
	[UnitAnalysisId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_JobEquipUnitAnalysis] UNIQUE NONCLUSTERED 
(
	[JobEquipmentId] ASC,
	[ServiceId] ASC,
	[UnitType] ASC,
	[UnitId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vJobEquipUnitAnalysis]    Script Date: 7/12/2019 12:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  Create   view [dbo].[vJobEquipUnitAnalysis] as
  select ua.UnitAnalysisId,ua.JobEquipmentId,ua.ServiceId,ua.UnitType,ua.UnitId,ua.ConditionId,
  ua.ConfidentFactorId ,ua.FailureProbFactorId ,ua.PriorityId,ua.IsWorkNotification, ua.NoOfDays, 
  ua.Recommendation, ua.Comment, ua.StatusId
  from JobEquipUnitAnalysis ua
GO
/****** Object:  Table [dbo].[EquipmentDriveUnit]    Script Date: 7/12/2019 12:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentDriveUnit](
	[DriveUnitId] [int] IDENTITY(1,1) NOT NULL,
	[EquipmentId] [int] NOT NULL,
	[AssetId] [int] NOT NULL,
	[IdentificationName] [nvarchar](150) NOT NULL,
	[ListOrder] [int] NULL,
	[ManufacturerId] [int] NULL,
	[RPM] [nvarchar](100) NULL,
	[Frame] [nvarchar](100) NULL,
	[Voltage] [nvarchar](100) NULL,
	[PowerFactor] [nvarchar](100) NULL,
	[UnitRate] [nvarchar](100) NULL,
	[Model] [nvarchar](100) NULL,
	[HP] [nvarchar](100) NULL,
	[Type] [nvarchar](100) NULL,
	[MotorFanBlades] [nvarchar](100) NULL,
	[SerialNumber] [nvarchar](100) NULL,
	[RotorBars] [nvarchar](100) NULL,
	[Poles] [nvarchar](100) NULL,
	[Slots] [nvarchar](100) NULL,
	[BearingDriveEndId] [int] NULL,
	[BearingNonDriveEndId] [int] NULL,
	[PulleyDiaDrive] [nvarchar](100) NULL,
	[PulleyDiaDriven] [nvarchar](100) NULL,
	[BeltLength] [nvarchar](100) NULL,
	[CouplingId] [int] NULL,
	[MeanRepairManHours] [decimal](15, 4) NULL,
	[DownTimeCostPerHour] [decimal](15, 4) NULL,
	[CostToRepair] [decimal](15, 4) NULL,
	[MeanFailureRate] [decimal](15, 4) NULL,
	[Active] [varchar](1) NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[ManufactureYear] [int] NULL,
	[FirstInstallationDate] [date] NULL,
	[OperationModeId] [int] NULL,
 CONSTRAINT [EquipmentDriveUnit_pk] PRIMARY KEY CLUSTERED 
(
	[DriveUnitId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_DriveAssetName] UNIQUE NONCLUSTERED 
(
	[EquipmentId] ASC,
	[IdentificationName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DriveServices]    Script Date: 7/12/2019 12:06:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DriveServices](
	[DriveServiceId] [int] IDENTITY(1,1) NOT NULL,
	[DriveUnitId] [int] NOT NULL,
	[ReportId] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
	[Active] [varchar](1) NULL,
 CONSTRAINT [DriveServices_pk] PRIMARY KEY CLUSTERED 
(
	[DriveServiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_DriveReportId] UNIQUE NONCLUSTERED 
(
	[DriveUnitId] ASC,
	[ReportId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vEquipDriveAnalysis]    Script Date: 7/12/2019 12:06:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
CREATE   view [dbo].[vEquipDriveAnalysis] as
Select Je.JobEquipmentId,Je.JobId,je.EquipmentId,
edu.DriveUnitId,edu.AssetId,edu.IdentificationName as AssetName,
ds.ReportId as ServiceId, edu.ListOrder as AssetListOrder	
From JobEquipment je join EquipmentDriveUnit edu on edu.EquipmentId = je.EquipmentId and edu.Active = 'Y'
join DriveServices ds on ds.DriveUnitId = edu.DriveUnitId and ds.ReportId = je.ServiceId and ds.Active = 'Y'  
GO
/****** Object:  Table [dbo].[PlantArea]    Script Date: 7/12/2019 12:06:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlantArea](
	[PlantAreaId] [int] IDENTITY(1,1) NOT NULL,
	[PlantAreaCode] [varchar](15) NULL,
	[ClientSiteId] [int] NOT NULL,
	[CreatedLanguageId] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
	[Active] [varchar](1) NULL,
 CONSTRAINT [PlantArea_pk] PRIMARY KEY CLUSTERED 
(
	[PlantAreaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Equipment]    Script Date: 7/12/2019 12:06:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Equipment](
	[EquipmentId] [int] IDENTITY(1,1) NOT NULL,
	[PlantAreaId] [int] NOT NULL,
	[EquipmentCode] [nvarchar](30) NULL,
	[EquipmentName] [nvarchar](150) NOT NULL,
	[Descriptions] [nvarchar](250) NULL,
	[ListOrder] [int] NULL,
	[OrientationId] [int] NULL,
	[MountingId] [int] NULL,
	[StandByEquipId] [int] NULL,
	[Active] [varchar](1) NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[AreaId] [int] NULL,
	[SystemId] [int] NULL,
 CONSTRAINT [Equipment_pk] PRIMARY KEY CLUSTERED 
(
	[EquipmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_EquipmentName] UNIQUE NONCLUSTERED 
(
	[PlantAreaId] ASC,
	[EquipmentName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FailureReportHeader]    Script Date: 7/12/2019 12:06:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FailureReportHeader](
	[FailureReportHeaderId] [bigint] IDENTITY(1,1) NOT NULL,
	[ReportType] [varchar](10) NOT NULL,
	[ClientSiteId] [int] NOT NULL,
	[EquipmentId] [int] NOT NULL,
	[ReportDate] [date] NULL,
	[ActualRepairCost] [decimal](15, 4) NULL,
	[ActualOutageTime] [decimal](15, 4) NULL,
	[BreakDownCost] [decimal](15, 4) NULL,
	[BreakDownHrs] [decimal](15, 4) NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
	[DownTimeCost] [decimal](15, 4) NULL,
	[TrueSavingsCost] [decimal](15, 4) NULL,
	[TrueSavingsHrs] [decimal](15, 4) NULL,
 CONSTRAINT [FailureReportHeader_pk] PRIMARY KEY CLUSTERED 
(
	[FailureReportHeaderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_FailureReportHeader] UNIQUE NONCLUSTERED 
(
	[FailureReportHeaderId] ASC,
	[EquipmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FailureReportDetail]    Script Date: 7/12/2019 12:06:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FailureReportDetail](
	[FailureReportDetailId] [bigint] IDENTITY(1,1) NOT NULL,
	[FailureReportHeaderId] [bigint] NOT NULL,
	[UnitType] [varchar](3) NOT NULL,
	[UnitId] [int] NOT NULL,
	[FailureModeId] [int] NULL,
	[FailureCauseId] [int] NULL,
	[ActualRepairCost] [decimal](15, 4) NULL,
	[ActualOutageTime] [decimal](15, 4) NULL,
	[MTTR] [decimal](10, 2) NULL,
	[MTBF] [decimal](10, 2) NULL,
	[Descriptions] [nvarchar](2500) NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
	[Active] [varchar](1) NOT NULL,
 CONSTRAINT [FailureReportDetail_pk] PRIMARY KEY CLUSTERED 
(
	[FailureReportDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_FailureReportDetail] UNIQUE NONCLUSTERED 
(
	[FailureReportHeaderId] ASC,
	[UnitType] ASC,
	[UnitId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[udtfGetTotalFailureReportedAssets]    Script Date: 7/12/2019 12:06:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   FUNCTION [dbo].[udtfGetTotalFailureReportedAssets] (@ClientSiteId int, @PlantAreaId int, @ReportDate date)
RETURNS TABLE
AS 
Return
 select  count(d.UnitId)  TotalFailureReported
from FailureReportHeader h join equipment e on h.EquipmentId = e.EquipmentId and e.Active = 'Y'
join Plantarea p on p.PlantAreaId = e.PlantAreaId 
Join FailurereportDetail d on d.FailureReportHeaderId = h.FailureReportHeaderId
where h.ClientSiteId =@ClientSiteId and p.PlantAreaId  = @PlantAreaId and  DATEADD(month, DATEDIFF(month, 0, h.ReportDate), 0) = @ReportDate  
GO
/****** Object:  Table [dbo].[EquipmentDrivenUnit]    Script Date: 7/12/2019 12:06:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentDrivenUnit](
	[DrivenUnitId] [int] IDENTITY(1,1) NOT NULL,
	[EquipmentId] [int] NOT NULL,
	[AssetId] [int] NOT NULL,
	[IdentificationName] [nvarchar](150) NOT NULL,
	[ListOrder] [int] NULL,
	[ManufacturerId] [int] NULL,
	[MaxRPM] [nvarchar](100) NULL,
	[Capacity] [nvarchar](100) NULL,
	[Model] [nvarchar](100) NULL,
	[Lubrication] [nvarchar](100) NULL,
	[SerialNumber] [nvarchar](100) NULL,
	[RatedFlowGPM] [nvarchar](100) NULL,
	[PumpEfficiency] [nvarchar](100) NULL,
	[RatedSuctionPressure] [nvarchar](100) NULL,
	[Efficiency] [nvarchar](100) NULL,
	[RatedDischargePressure] [nvarchar](100) NULL,
	[CostPerUnit] [nvarchar](100) NULL,
	[BearingDriveEndId] [int] NULL,
	[BearingNonDriveEndId] [int] NULL,
	[ImpellerVanes] [nvarchar](100) NULL,
	[ImpellerVanesKW] [nvarchar](100) NULL,
	[Stages] [nvarchar](100) NULL,
	[NumberOfPistons] [nvarchar](100) NULL,
	[PumpType] [nvarchar](100) NULL,
	[MeanRepairManHours] [decimal](15, 4) NULL,
	[DownTimeCostPerHour] [decimal](15, 4) NULL,
	[CostToRepair] [decimal](15, 4) NULL,
	[MeanFailureRate] [decimal](15, 4) NULL,
	[Active] [varchar](1) NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[ManufactureYear] [int] NULL,
	[FirstInstallationDate] [date] NULL,
	[OperationModeId] [int] NULL,
 CONSTRAINT [EquipmentDrivenUnit_pk] PRIMARY KEY CLUSTERED 
(
	[DrivenUnitId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_DrivenAssetName] UNIQUE NONCLUSTERED 
(
	[EquipmentId] ASC,
	[IdentificationName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[udtfGetTotalAssets]    Script Date: 7/12/2019 12:06:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   FUNCTION [dbo].[udtfGetTotalAssets] (@ClientSiteId int, @PlantAreaId int)
RETURNS TABLE
AS 
Return
 select (count(dr.DriveUnitId) + count(dn.DrivenUnitId) + Count(ir.IntermediateUnitId)) TotalAsset
from equipment e join Plantarea p on p.PlantAreaId = e.PlantAreaId and e.Active = 'Y'
left join EquipmentDriveUnit dr on dr.EquipmentId = e.EquipmentId and dr.Active = 'Y'
left join EquipmentDrivenUnit dn on dn.EquipmentId = e.EquipmentId and dn.Active = 'Y'
left join EquipmentIntermediateUnit ir on ir.EquipmentId = e.EquipmentId and ir.Active = 'Y'
where p.ClientSiteId =@ClientSiteId and p.PlantAreaId  = @PlantAreaId
GO
/****** Object:  Table [dbo].[Segment]    Script Date: 7/12/2019 12:06:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Segment](
	[SegmentId] [int] IDENTITY(1,1) NOT NULL,
	[SegmentCode] [varchar](5) NOT NULL,
	[SectorId] [int] NOT NULL,
	[CreatedLanguageId] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
	[Active] [varchar](1) NULL,
 CONSTRAINT [Segment_pk] PRIMARY KEY CLUSTERED 
(
	[SegmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_Segment] UNIQUE NONCLUSTERED 
(
	[SegmentCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Industry]    Script Date: 7/12/2019 12:06:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Industry](
	[IndustryId] [int] IDENTITY(1,1) NOT NULL,
	[IndustryCode] [varchar](5) NOT NULL,
	[SegmentId] [int] NOT NULL,
	[CreatedLanguageId] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
	[Active] [varchar](1) NULL,
	[DownTimeCostPerHour] [decimal](15, 4) NOT NULL,
 CONSTRAINT [Industry_pk] PRIMARY KEY CLUSTERED 
(
	[IndustryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_Industry] UNIQUE NONCLUSTERED 
(
	[IndustryCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Jobs]    Script Date: 7/12/2019 12:06:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Jobs](
	[JobId] [bigint] IDENTITY(1,1) NOT NULL,
	[ScheduleSetupId] [bigint] NULL,
	[ClientSiteId] [int] NOT NULL,
	[JobNumber] [nvarchar](50) NOT NULL,
	[JobName] [nvarchar](150) NOT NULL,
	[EstStartDate] [date] NULL,
	[EstEndDate] [date] NULL,
	[DataCollectionDate] [date] NULL,
	[StatusId] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
	[ActStartDate] [date] NULL,
	[ActEndDate] [date] NULL,
	[ReportDate] [date] NULL,
	[DataCollectorId] [int] NULL,
	[AnalystId] [int] NULL,
	[ReviewerId] [int] NULL,
	[DataCollectionMode] [int] NOT NULL,
	[DataCollectionDone] [varchar](1) NOT NULL,
	[ReportSent] [int] NOT NULL,
 CONSTRAINT [Jobs_pk] PRIMARY KEY CLUSTERED 
(
	[JobId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UK_Jobs] UNIQUE NONCLUSTERED 
(
	[ClientSiteId] ASC,
	[JobName] ASC,
	[EstStartDate] ASC,
	[EstEndDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[udtfIntermediateHealthStatus]    Script Date: 7/12/2019 12:06:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
CREATE   FUNCTION [dbo].[udtfIntermediateHealthStatus] ()
RETURNS TABLE
AS 
Return
 	 WITH IntermediateLastTwoActivities
	AS
	(
	SELECT u.UnitType,j.ClientSiteId,e.PlantAreaId,je.ServiceId, u.UnitId,du.ManufacturerId, u.UnitAnalysisId,u.ConditionId
		,ROW_NUMBER() OVER (PARTITION BY u.Unittype,u.serviceid,u.UnitID ORDER BY u.UnitAnalysisId DESC) AS RowNum
		FROM JobEquipUnitAnalysis u 
		join JobEquipment je on je.JobEquipmentId = u. JobEquipmentId and u.UnitType = 'IN'
		join equipment e on e.EquipmentId = je.EquipmentId
		left Join EquipmentIntermediateUnit du on du.IntermediateUnitId = u.UnitId 
		Join Jobs j  on j.jobid = je.jobid  and  j.StatusId = dbo.GetStatusId(1,'JobProcessStatus','C')
		)
		 select c.CountryId,s.SectorId,s.SegmentId,i.IndustryId, c.CostCentreId, p.PlantAreaId, r.ClientSiteId, r.RowNum JobPeriod, 
		 r.UnitType,r.ManufacturerId,r.ServiceId,r.ConditionId,
	    dbo.GetNameTranslated(c.CountryId,1,'CountryName') CountryName,
		dbo.GetNameTranslated(s.SectorId,1,'SectorName') SectorName,
		dbo.GetNameTranslated(s.segmentId,1,'SegmentName') SegmentName,
		dbo.GetNameTranslated(i.IndustryId,1,'IndustryName') IndustryName,
		dbo.GetNameTranslated(c.CostCentreId,1,'CostCentreName') CostCentreName,
		dbo.GetNameTranslated(r.ClientSiteId,1,'ClientSiteName') ClientSiteName,
		dbo.GetNameTranslated(p.PlantAreaId,1,'PlantAreaName') PlantAreaName,   
			dbo.GetNameTranslated(r.ManufacturerId,1,'ManufacturerName') ManufacturerName,
			dbo.GetLookupTranslated(r.ServiceId,1,'LookupValue') ServiceType,
			concat(dbo.GetLookupTranslated(r.ConditionId,1,'LookupCode'),' ',dbo.GetLookupTranslated(r.ConditionId,1,'LookupValue')) ConditionName,
			Count(r.UnitId)EventCount 
		 from IntermediateLastTwoActivities r
		 join PlantArea p on p.plantareaid = r.PlantAreaId
		 Join ClientSite c on c.ClientSiteId = p.ClientSiteId 
		 Join Industry i on i.IndustryId = c.IndustryId
		 join Segment s on s.SegmentId = i.SegmentId
		 where RowNum <= 2 
		 Group by c.CountryId,s.SectorId,s.SegmentId,i.IndustryId, c.CostCentreId, p.PlantAreaId, r.ClientSiteId, RowNum,UnitType, ManufacturerId,ServiceId, ConditionId
 
GO
/****** Object:  Table [dbo].[IntermediateBearing]    Script Date: 7/12/2019 12:06:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IntermediateBearing](
	[IntermediateBearingId] [int] IDENTITY(1,1) NOT NULL,
	[Place] [varchar](3) NOT NULL,
	[IntermediateUnitId] [int] NOT NULL,
	[BearingId] [int] NOT NULL,
	[ManufacturerId] [int] NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
 CONSTRAINT [IntermediateBearing_pk] PRIMARY KEY CLUSTERED 
(
	[IntermediateBearingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_IntermediateBearingId] UNIQUE NONCLUSTERED 
(
	[IntermediateUnitId] ASC,
	[Place] ASC,
	[BearingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LeverageService]    Script Date: 7/12/2019 12:06:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeverageService](
	[LeverageServiceId] [bigint] IDENTITY(1,1) NOT NULL,
	[JobEquipmentId] [bigint] NOT NULL,
	[OpportunityTypeId] [int] NOT NULL,
	[Descriptions] [nvarchar](1500) NULL,
	[LeverageExportId] [bigint] NULL,
	[LeverageDate] [date] NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
 CONSTRAINT [LeverageService_pk] PRIMARY KEY CLUSTERED 
(
	[LeverageServiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DriveBearing]    Script Date: 7/12/2019 12:06:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DriveBearing](
	[DriveBearingId] [int] IDENTITY(1,1) NOT NULL,
	[Place] [varchar](3) NOT NULL,
	[DriveUnitId] [int] NOT NULL,
	[BearingId] [int] NOT NULL,
	[ManufacturerId] [int] NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
 CONSTRAINT [DriveBearing_pk] PRIMARY KEY CLUSTERED 
(
	[DriveBearingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_DriveBearingId] UNIQUE NONCLUSTERED 
(
	[DriveUnitId] ASC,
	[Place] ASC,
	[BearingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DrivenBearing]    Script Date: 7/12/2019 12:06:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DrivenBearing](
	[DrivenBearingId] [int] IDENTITY(1,1) NOT NULL,
	[Place] [varchar](3) NOT NULL,
	[DrivenUnitId] [int] NOT NULL,
	[BearingId] [int] NOT NULL,
	[ManufacturerId] [int] NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
 CONSTRAINT [DrivenBearing_pk] PRIMARY KEY CLUSTERED 
(
	[DrivenBearingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_DrivenBearingId] UNIQUE NONCLUSTERED 
(
	[DrivenUnitId] ASC,
	[Place] ASC,
	[BearingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[udtfGetOpportunityList]    Script Date: 7/12/2019 12:06:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
CREATE   FUNCTION [dbo].[udtfGetOpportunityList] ()
RETURNS TABLE
AS 
Return
 
	WITH GetLeverageService
	AS
	(  
	select p.ClientSiteId, p.PlantAreaId ,DATEADD(month, DATEDIFF(month, 0, ls.LeverageDate), 0) LeverageDate , ls.OpportunityTypeId, 
	'Drive' as AssetType,b.ManufacturerId as BManufacturerId, 
	Count(Distinct ls.LeverageServiceId) OpportunityCount,
	Count(Distinct b.DriveBearingId) BearingCount   
	from DriveBearing b join EquipmentDriveUnit d on b.DriveUnitId = d.DriveUnitId 
	join Equipment e on e.EquipmentId = d.EquipmentId
	Join PlantArea p on p.PlantAreaId = e.PlantAreaId 
	join JobEquipUnitAnalysis ua on ua.UnitId = b.DriveUnitId and ua.UnitType = 'DR' and ua.IsWorkNotification = 'Y'
	join LeverageService ls on ls.JobEquipmentId = ua.JobEquipmentId
	where b.Active = 'Y'
	Group by p.ClientSiteId,p.PlantAreaId,DATEADD(month, DATEDIFF(month, 0, ls.LeverageDate), 0),ls.LeverageDate,ls.OpportunityTypeId,b.ManufacturerId 
	union all
	select p.ClientSiteId, p.PlantAreaId ,DATEADD(month, DATEDIFF(month, 0, ls.LeverageDate), 0) LeverageDate , ls.OpportunityTypeId, 
	'Driven' as AssetType,b.ManufacturerId as BManufacturerId, 
	Count(Distinct ls.LeverageServiceId) OpportunityCount,
	Count(Distinct b.DrivenBearingId) BearingCount   
	from DrivenBearing b join EquipmentDriveUnit d on b.DrivenUnitId = d.DriveUnitId 
	join Equipment e on e.EquipmentId = d.EquipmentId
	Join PlantArea p on p.PlantAreaId = e.PlantAreaId 
	join JobEquipUnitAnalysis ua on ua.UnitId = b.DrivenUnitId and ua.UnitType = 'DN' and ua.IsWorkNotification = 'Y'
	join LeverageService ls on ls.JobEquipmentId = ua.JobEquipmentId
	where b.Active = 'Y'
	Group by p.ClientSiteId,p.PlantAreaId,DATEADD(month, DATEDIFF(month, 0, ls.LeverageDate), 0),ls.LeverageDate,ls.OpportunityTypeId,b.ManufacturerId 
	union all
 	select p.ClientSiteId, p.PlantAreaId ,DATEADD(month, DATEDIFF(month, 0, ls.LeverageDate), 0) LeverageDate , ls.OpportunityTypeId,
	'Intermediate' as AssetType,b.ManufacturerId as BManufacturerId,
	Count(Distinct ls.LeverageServiceId) OpportunityCount,
	Count(Distinct b.IntermediateBearingId) BearingCount   
	from IntermediateBearing b join EquipmentIntermediateUnit d on b.IntermediateUnitId = d.IntermediateUnitId 
	join Equipment e on e.EquipmentId = d.EquipmentId
	Join PlantArea p on p.PlantAreaId = e.PlantAreaId 
	join JobEquipUnitAnalysis ua on ua.UnitId = b.IntermediateUnitId and ua.UnitType = 'IN' and ua.IsWorkNotification = 'Y'
	join LeverageService ls on ls.JobEquipmentId = ua.JobEquipmentId
	where b.Active = 'Y'
	Group by p.ClientSiteId,p.PlantAreaId,DATEADD(month, DATEDIFF(month, 0, ls.LeverageDate), 0),ls.LeverageDate,ls.OpportunityTypeId,b.ManufacturerId 
  
		)
		 select c.CountryId,s.SectorId,s.SegmentId,i.IndustryId, c.CostCentreId, p.PlantAreaId, r.ClientSiteId, r.AssetType,
		 r.BManufacturerId,r.BearingCount,r.LeverageDate,r.OpportunityCount,
		dbo.GetNameTranslated(c.CountryId,1,'CountryName') CountryName,
		dbo.GetNameTranslated(s.SectorId,1,'SectorName') SectorName,
		dbo.GetNameTranslated(s.segmentId,1,'SegmentName') SegmentName,
		dbo.GetNameTranslated(i.IndustryId,1,'IndustryName') IndustryName,
		dbo.GetNameTranslated(c.CostCentreId,1,'CostCentreName') CostCentreName,
		dbo.GetNameTranslated(r.ClientSiteId,1,'ClientSiteName') ClientSiteName,
		dbo.GetNameTranslated(p.PlantAreaId,1,'PlantAreaName') PlantAreaName,   
		dbo.GetNameTranslated(r.bManufacturerId,1,'ManufacturerName') BManufacturerName,
		dbo.GetLookupTranslated(r.OpportunityTypeId,1,'LookupValue') OpportunityName,
		dbo.GetLookupTranslated(r.OpportunityTypeId,1,'LookupCode') OpportunityCode 
		 from GetLeverageService r
		 join PlantArea p on p.plantareaid = r.PlantAreaId
		 Join ClientSite c on c.ClientSiteId = p.ClientSiteId 
		 Join Industry i on i.IndustryId = c.IndustryId
		 join Segment s on s.SegmentId = i.SegmentId  
GO
/****** Object:  Table [dbo].[JobEquipUnitSymptoms]    Script Date: 7/12/2019 12:06:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobEquipUnitSymptoms](
	[UnitSymptomsId] [bigint] IDENTITY(1,1) NOT NULL,
	[UnitAnalysisId] [bigint] NULL,
	[SymptomTypeId] [int] NOT NULL,
	[Frequencyid] [int] NOT NULL,
	[IndicatedFaultId] [int] NULL,
	[Symptoms] [nvarchar](1500) NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
	[FailureModeId] [int] NULL,
 CONSTRAINT [JobEquipUnitSymptoms_pk] PRIMARY KEY CLUSTERED 
(
	[UnitSymptomsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[udtfFailureCauseStatistics]    Script Date: 7/12/2019 12:06:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[udtfFailureCauseStatistics] ()
RETURNS TABLE
AS 
Return
  With CReport as
(select 'CustomerReported' ReportType, h.ClientSiteId, h.ReportDate, f.UnitType,
(case when f.unitType = 'DR' then (select e.PlantAreaId from EquipmentDriveUnit dr Join Equipment e on e.equipmentid = dr.equipmentid 
where dr.DriveUnitId = f.UnitId )
when f.unitType = 'DN' then (select e.PlantAreaId from EquipmentDrivenUnit dn Join Equipment e on e.equipmentid = dn.equipmentid where dn.DrivenUnitId = f.UnitId )
when f.unitType = 'IN' then (select e.PlantAreaId from EquipmentIntermediateUnit dn Join Equipment e on e.equipmentid = dn.equipmentid  
where dn.IntermediateUnitId = f.UnitId )
end ) PlantAreaId,
(case when f.unitType = 'DR' then (select EquipmentId from EquipmentDriveUnit dr where dr.DriveUnitId = f.UnitId )
when f.unitType = 'DN' then (select EquipmentId from EquipmentDrivenUnit dn where dn.DrivenUnitId = f.UnitId )
when f.unitType = 'IN' then (select EquipmentId from EquipmentIntermediateUnit dn where dn.IntermediateUnitId = f.UnitId )
end ) EquipmentId,f.FailureCauseId,dbo.GetNameTranslated(f.FailureCauseId,1,'FailureCauseName') FailureCause,
Sum(f.FailureCauseId) EventCount,
sum(f.ActualRepairCost) Consequence 
 from FailureReportHeader h join FailureReportDetail f on f.FailureReportHeaderId = h.FailureReportHeaderId and f.FailureCauseId >0
 group by h.ClientSiteId,h.ReportDate,f.UnitType,f.UnitId,f.FailureCauseId
), AReport  as
(
select  'AnalystReported' ReportType, j.ClientSiteId,j.EstStartDate ReportDate, f.UnitType,e.PlantAreaId,
s.IndicatedFaultId FailureCauseId,dbo.GetNameTranslated(s.IndicatedFaultId,1,'FailureCauseName') FailureCause,
Count(s.IndicatedFaultId) EventCount,
(case when f.unitType = 'DR' then (select CostToRepair from EquipmentDriveUnit dr where dr.DriveUnitId = f.UnitId )
when f.unitType = 'DN' then (select CostToRepair from EquipmentDrivenUnit dn where dn.DrivenUnitId = f.UnitId )
when f.unitType = 'IN' then (select CostToRepair from EquipmentIntermediateUnit dn where dn.IntermediateUnitId = f.UnitId )
end ) Consequence
 from jobs j join JobEquipment je on je.JobId = j.jobid 
 join Equipment e on e.EquipmentId = je.EquipmentId
 join JobEquipUnitAnalysis f on f.JobEquipmentId =je.JobEquipmentId
 join JobEquipUnitSymptoms s on s.UnitAnalysisId = f.UnitAnalysisId and s.IndicatedFaultId > 0
 where j.StatusId =   dbo.GetStatusId(1,'JobProcessStatus','C')
 group by j.ClientSiteId,j.EstStartDate,e.PlantAreaId, f.UnitType,f.UnitId,s.IndicatedFaultId
 ), BReport  as
 (
select c.ClientSiteId, c.ReportType,c.ReportDate,c.PlantAreaId,c.UnitType,c.FailureCauseId,c.EventCount, c.FailureCause,c.Consequence  from CReport c  
union all
select a.ClientSiteId, a.ReportType,a.ReportDate,a.PlantAreaId , a.UnitType, a.FailureCauseId, a.EventCount,a.FailureCause,a.Consequence from AReport a 
 )
 Select ReportType, ClientSiteId,dbo.GetNameTranslated(ClientSiteId,1,'ClientSiteName')ClientSiteName,PlantAreaId,dbo.GetNameTranslated(PlantAreaId,1,'PlantAreaName') PlantAreaName,ReportDate,
 Case when UnitType = 'DR' then 'Drive' when UnitType = 'DN' then 'Driven' when unittype = 'IN' then 'Intermediate' end UnitType,
 FailureCauseId,FailureCause,sum(EventCount) EventCount, Sum(Consequence)Consequence from BReport b
 Group by  ReportType,ClientSiteId,PlantAreaId,ReportDate,UnitType,FailureCauseId,FailureCause
GO
/****** Object:  UserDefinedFunction [dbo].[udtfEquipmentHealthStatus]    Script Date: 7/12/2019 12:06:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   FUNCTION [dbo].[udtfEquipmentHealthStatus] ()
RETURNS TABLE
AS 
Return
 
	WITH EquipmentLastTwoActivities
	AS
	(  
	SELECT j.ClientSiteId,e.PlantAreaId,je.ServiceId,je.ConditionId,je.JobEquipmentId,Je.EquipmentId
	,ROW_NUMBER() OVER (PARTITION BY je.EquipmentId,je.ServiceId ORDER BY je.JobEquipmentId DESC) AS RowNum
	FROM  JobEquipment je 	join equipment e on e.EquipmentId = je.EquipmentId and je.Active = 'Y'
	Join Jobs j  on j.jobid = je.jobid  and  j.StatusId = dbo.GetStatusId(1,'JobProcessStatus','C')
	)
	select c.CountryId,s.SectorId,s.SegmentId,i.IndustryId, c.CostCentreId, p.PlantAreaId, r.ClientSiteId, r.RowNum JobPeriod, 
	r.ServiceId,r.ConditionId, 
	dbo.GetNameTranslated(c.CountryId,1,'CountryName') CountryName,
	dbo.GetNameTranslated(s.SectorId,1,'SectorName') SectorName,
	dbo.GetNameTranslated(s.segmentId,1,'SegmentName') SegmentName,
	dbo.GetNameTranslated(i.IndustryId,1,'IndustryName') IndustryName,
	dbo.GetNameTranslated(c.CostCentreId,1,'CostCentreName') CostCentreName,
	dbo.GetNameTranslated(r.ClientSiteId,1,'ClientSiteName') ClientSiteName,
	dbo.GetNameTranslated(p.PlantAreaId,1,'PlantAreaName') PlantAreaName, 
	dbo.GetLookupTranslated(r.ServiceId,1,'LookupValue') ServiceType,
	dbo.GetLookupTranslated(r.ConditionId,1,'LookupCode') ConditionCode,
	dbo.GetLookupTranslated(r.ConditionId,1,'LookupValue')  ConditionName,
	Count(r.JobEquipmentId)EventCount,
	Count(Distinct r.equipmentid) EquipmentCount
	from EquipmentLastTwoActivities r
	join PlantArea p on p.plantareaid = r.PlantAreaId
	Join ClientSite c on c.ClientSiteId = p.ClientSiteId 
	Join Industry i on i.IndustryId = c.IndustryId
	join Segment s on s.SegmentId = i.SegmentId
	where RowNum <= 2 
	Group by c.CountryId,s.SectorId,s.SegmentId,i.IndustryId, c.CostCentreId, p.PlantAreaId, r.ClientSiteId,RowNum, ServiceId, ConditionId
 
GO
/****** Object:  UserDefinedFunction [dbo].[udtfDrivenHealthStatus]    Script Date: 7/12/2019 12:06:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   FUNCTION [dbo].[udtfDrivenHealthStatus] ()
RETURNS TABLE
AS 
Return
 
	 WITH DrivenLastTwoActivities
	AS
	(
	SELECT u.UnitType,j.ClientSiteId,e.PlantAreaId,je.ServiceId, u.UnitId,du.ManufacturerId, u.UnitAnalysisId,u.ConditionId
		,ROW_NUMBER() OVER (PARTITION BY u.Unittype,u.serviceid,u.UnitID ORDER BY u.UnitAnalysisId DESC) AS RowNum
		FROM JobEquipUnitAnalysis u 
		join JobEquipment je on je.JobEquipmentId = u. JobEquipmentId and u.UnitType = 'DN'
		join equipment e on e.EquipmentId = je.EquipmentId
		left Join EquipmentDrivenUnit du on du.DrivenUnitId = u.UnitId 
		Join Jobs j  on j.jobid = je.jobid  and  j.StatusId = dbo.GetStatusId(1,'JobProcessStatus','C')
		)
		 select c.CountryId,s.SectorId,s.SegmentId,i.IndustryId, c.CostCentreId, p.PlantAreaId, r.ClientSiteId, r.RowNum JobPeriod, 
		 r.UnitType,r.ManufacturerId,r.ServiceId,r.ConditionId,
		dbo.GetNameTranslated(c.CountryId,1,'CountryName') CountryName,
		dbo.GetNameTranslated(s.SectorId,1,'SectorName') SectorName,
		dbo.GetNameTranslated(s.segmentId,1,'SegmentName') SegmentName,
		dbo.GetNameTranslated(i.IndustryId,1,'IndustryName') IndustryName,
		dbo.GetNameTranslated(c.CostCentreId,1,'CostCentreName') CostCentreName,
		dbo.GetNameTranslated(r.ClientSiteId,1,'ClientSiteName') ClientSiteName,
		dbo.GetNameTranslated(p.PlantAreaId,1,'PlantAreaName') PlantAreaName,   
			dbo.GetNameTranslated(r.ManufacturerId,1,'ManufacturerName') ManufacturerName,
			dbo.GetLookupTranslated(r.ServiceId,1,'LookupValue') ServiceType,
			concat(dbo.GetLookupTranslated(r.ConditionId,1,'LookupCode'),' ',dbo.GetLookupTranslated(r.ConditionId,1,'LookupValue')) ConditionName,
			Count(r.UnitId)EventCount 
		 from DrivenLastTwoActivities r
		 join PlantArea p on p.plantareaid = r.PlantAreaId
		 Join ClientSite c on c.ClientSiteId = p.ClientSiteId 
		 Join Industry i on i.IndustryId = c.IndustryId
		 join Segment s on s.SegmentId = i.SegmentId
		 where RowNum <= 2 
		 Group by c.CountryId,s.SectorId,s.SegmentId,i.IndustryId, c.CostCentreId, p.PlantAreaId, r.ClientSiteId, RowNum,UnitType, ManufacturerId,ServiceId, ConditionId
 
GO
/****** Object:  UserDefinedFunction [dbo].[udtfDriveHealthStatus]    Script Date: 7/12/2019 12:06:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   FUNCTION [dbo].[udtfDriveHealthStatus] ()
RETURNS TABLE
AS 
Return
 
	 WITH DriveLastTwoActivities
	AS
	(
	SELECT u.UnitType,j.ClientSiteId,e.PlantAreaId,je.ServiceId, u.UnitId,du.ManufacturerId, u.UnitAnalysisId,u.ConditionId
		,ROW_NUMBER() OVER (PARTITION BY u.Unittype,u.serviceid,u.UnitID ORDER BY u.UnitAnalysisId DESC) AS RowNum
		FROM JobEquipUnitAnalysis u 
		join JobEquipment je on je.JobEquipmentId = u. JobEquipmentId and u.UnitType = 'DR'
		join equipment e on e.EquipmentId = je.EquipmentId
		left Join EquipmentDriveUnit du on du.DriveUnitId = u.UnitId 
		Join Jobs j  on j.jobid = je.jobid  and  j.StatusId = dbo.GetStatusId(1,'JobProcessStatus','C')
		)
		 select c.CountryId,s.SectorId,s.SegmentId,i.IndustryId, c.CostCentreId, p.PlantAreaId, r.ClientSiteId, r.RowNum JobPeriod, 
		 r.UnitType,r.ManufacturerId,r.ServiceId,r.ConditionId,  
 		dbo.GetNameTranslated(c.CountryId,1,'CountryName') CountryName,
		dbo.GetNameTranslated(s.SectorId,1,'SectorName') SectorName,
		dbo.GetNameTranslated(s.segmentId,1,'SegmentName') SegmentName,
		dbo.GetNameTranslated(i.IndustryId,1,'IndustryName') IndustryName,
		dbo.GetNameTranslated(c.CostCentreId,1,'CostCentreName') CostCentreName,
		dbo.GetNameTranslated(r.ClientSiteId,1,'ClientSiteName') ClientSiteName,
		dbo.GetNameTranslated(p.PlantAreaId,1,'PlantAreaName') PlantAreaName, 
			dbo.GetNameTranslated(r.ManufacturerId,1,'ManufacturerName') ManufacturerName,
			dbo.GetLookupTranslated(r.ServiceId,1,'LookupValue') ServiceType,
			concat(dbo.GetLookupTranslated(r.ConditionId,1,'LookupCode'),' ',dbo.GetLookupTranslated(r.ConditionId,1,'LookupValue')) ConditionName,
			Count(r.UnitId)EventCount 
		 from DriveLastTwoActivities r
		 join PlantArea p on p.plantareaid = r.PlantAreaId
		 Join ClientSite c on c.ClientSiteId = p.ClientSiteId 
		 Join Industry i on i.IndustryId = c.IndustryId
		 join Segment s on s.SegmentId = i.SegmentId
		 where RowNum <= 2 
		 Group by c.CountryId,s.SectorId,s.SegmentId,i.IndustryId, c.CostCentreId, p.PlantAreaId, r.ClientSiteId, RowNum,UnitType, ManufacturerId,ServiceId, ConditionId
 
GO
/****** Object:  View [dbo].[vEquipment]    Script Date: 7/12/2019 12:06:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE    view [dbo].[vEquipment] as 
(
SELECT e.EquipmentId, e.EquipmentCode, e.EquipmentName, e.Descriptions, e.ListOrder, e.OrientationId, 
e.MountingId, e.StandByEquipId, e.Active, P.PlantAreaId, P.PlantAreaCode, P.ClientSiteId
FROM dbo.Equipment AS e 
INNER JOIN dbo.PlantArea AS P ON P.PlantAreaId = e.PlantAreaId 
)
GO
/****** Object:  Table [dbo].[DrivenServices]    Script Date: 7/12/2019 12:06:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DrivenServices](
	[DrivenServiceId] [int] IDENTITY(1,1) NOT NULL,
	[DrivenUnitId] [int] NOT NULL,
	[ReportId] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
	[Active] [varchar](1) NULL,
 CONSTRAINT [DrivenServices_pk] PRIMARY KEY CLUSTERED 
(
	[DrivenServiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_DrivenReportId] UNIQUE NONCLUSTERED 
(
	[DrivenUnitId] ASC,
	[ReportId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vEquipDrivenAnalysis]    Script Date: 7/12/2019 12:06:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   view [dbo].[vEquipDrivenAnalysis] as
Select Je.JobEquipmentId,Je.JobId,je.EquipmentId,
edu.DrivenUnitId,edu.AssetId,edu.IdentificationName as AssetName,
ds.ReportId as ServiceId, edu.ListOrder as AssetListOrder	
From JobEquipment je join EquipmentDrivenUnit edu on edu.EquipmentId = je.EquipmentId and edu.Active = 'Y'
join DrivenServices ds on ds.DrivenUnitId = edu.DrivenUnitId and ds.ReportId = je.ServiceId and ds.Active = 'Y'  
GO
/****** Object:  Table [dbo].[Users]    Script Date: 7/12/2019 12:06:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[MiddleName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[EmailId] [nvarchar](50) NOT NULL,
	[UserTypeId] [int] NOT NULL,
	[Mobile] [nvarchar](30) NULL,
	[Phone] [nvarchar](30) NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[PreferredLanguage] [int] NULL,
	[UserStatusId] [int] NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[Id] [nvarchar](450) NULL,
	[LastSessionClient] [int] NULL,
	[Password] [varchar](30) NULL,
 CONSTRAINT [Users_pk] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_Useremail] UNIQUE NONCLUSTERED 
(
	[EmailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_Username] UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[udtfAnalystPerformance]    Script Date: 7/12/2019 12:06:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create   FUNCTION [dbo].[udtfAnalystPerformance] ()
RETURNS TABLE
AS 
Return 
WITH UserPerformance
	AS
	(
		select 'IndicatedFault' ActivityType,c.CountryId,C.CostCentreId, g.SectorId,g.SegmentId,i.IndustryId,c.ClientSiteId, DATEADD(month, DATEDIFF(month, 0, je.ReportDate), 0) ReportDate, 
		s.CreatedBy as AnalystId,(select username from users where userid = s.createdby)AnalystName, 
		IndicatedFaultId TypeId, dbo.GetNameTranslated(IndicatedFaultId,1,'FailureCauseName')TypeName ,
		count(s.IndicatedFaultId) ActivityCount
		from JobEquipUnitSymptoms s 
		join JobEquipUnitAnalysis u on u.UnitAnalysisId = s.UnitAnalysisId
		join JobEquipment je on je.JobEquipmentId = u.JobEquipmentId
		join Jobs j on j.jobid = je.jobid and j.StatusId = dbo.GetStatusId(1,'JobProcessStatus','C')
		join equipment e on e.EquipmentId = je.EquipmentId
		join PlantArea p on p.PlantAreaId = e.PlantAreaId
		join ClientSite c on c.ClientSiteId = p.ClientSiteId
		join Industry i on i.IndustryId = c.IndustryId
		join Segment g on g.SegmentId = i.SegmentId
		where IndicatedFaultId is not null and je.reportdate is not null
		group by  c.CountryId,C.CostCentreId,g.SectorId,g.SegmentId,i.IndustryId,c.ClientSiteId,DATEADD(month, DATEDIFF(month, 0, je.ReportDate), 0) ,s.CreatedBy,IndicatedFaultId
		union all
		select 'Opportunity' ActivityType,c.CountryId,C.CostCentreId,g.SectorId,g.SegmentId,i.IndustryId,c.ClientSiteId, DATEADD(month, DATEDIFF(month, 0, l.LeverageDate), 0) ReportDate, 
		l.CreatedBy as AnalystId,(select username from users where userid = l.Createdby)AnalystName, 
		l.OpportunityTypeId TypeId, dbo.GetNameTranslated(l.OpportunityTypeId,1,'LookupValue')TypeName ,
		count(distinct l.LeverageServiceId) ActivityCount
		from LeverageService l  
		join JobEquipment je on l.JobEquipmentId = je.JobEquipmentId
		join equipment e on e.EquipmentId = je.EquipmentId
		join PlantArea p on p.PlantAreaId = e.PlantAreaId
		join ClientSite c on c.ClientSiteId = p.ClientSiteId
		join Industry i on i.IndustryId = c.IndustryId
		join Segment g on g.SegmentId = i.SegmentId 
		group by  c.CountryId,C.CostCentreId,g.SectorId,g.SegmentId,i.IndustryId,c.ClientSiteId,DATEADD(month, DATEDIFF(month, 0, l.LeverageDate), 0) 
		,l.CreatedBy,OpportunityTypeId 
		)
		 select r.CountryId,r.SectorId,r.SegmentId,r.IndustryId, r.CostCentreId,   r.ClientSiteId, 
		r.AnalystId,r.AnalystName, 
		r.TypeId, r.ActivityType,r.TypeName,r.ActivityCount,ReportDate,
 		dbo.GetNameTranslated(r.CountryId,1,'CountryName') CountryName,
		dbo.GetNameTranslated(r.SectorId,1,'SectorName') SectorName,
		dbo.GetNameTranslated(r.segmentId,1,'SegmentName') SegmentName,
		dbo.GetNameTranslated(r.IndustryId,1,'IndustryName') IndustryName,
		dbo.GetNameTranslated(r.CostCentreId,1,'CostCentreName') CostCentreName,
		dbo.GetNameTranslated(r.ClientSiteId,1,'ClientSiteName') ClientSiteName  
		 from UserPerformance r  
GO
/****** Object:  Table [dbo].[JobEquipUnitAmplitude]    Script Date: 7/12/2019 12:06:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobEquipUnitAmplitude](
	[UnitAmplitudeId] [bigint] IDENTITY(1,1) NOT NULL,
	[UnitAnalysisId] [bigint] NOT NULL,
	[OAVibration] [nvarchar](250) NULL,
	[OAGELevelPkPk] [nvarchar](250) NULL,
	[OASensorDirection] [int] NULL,
	[OASensorLocation] [int] NULL,
	[OAVibChangePercentage] [int] NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
 CONSTRAINT [JobEquipUnitAmplitude_pk] PRIMARY KEY CLUSTERED 
(
	[UnitAmplitudeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[udtfgetUnitAmplitude]    Script Date: 7/12/2019 12:06:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   FUNCTION [dbo].[udtfgetUnitAmplitude] (@UnitAnalysisId bigint)
RETURNS TABLE
AS 
Return
 select Top 1 UnitAnalysisId, OAVibration,OAGELevelPkPk From JobEquipUnitAmplitude where UnitAnalysisId = @UnitAnalysisId
	 
GO
/****** Object:  Table [dbo].[ApplicationConfiguration]    Script Date: 7/12/2019 12:06:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApplicationConfiguration](
	[AppConfigId] [int] IDENTITY(1,1) NOT NULL,
	[AppConfigCode] [varchar](50) NOT NULL,
	[AppConfigName] [varchar](150) NOT NULL,
	[AppConfigValue] [varchar](150) NOT NULL,
	[Descriptions] [varchar](250) NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
 CONSTRAINT [AppConfig_pk] PRIMARY KEY CLUSTERED 
(
	[AppConfigId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_AppConfig] UNIQUE NONCLUSTERED 
(
	[AppConfigCode] ASC,
	[AppConfigName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Area]    Script Date: 7/12/2019 12:06:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Area](
	[AreaId] [int] IDENTITY(1,1) NOT NULL,
	[PlantAreaId] [int] NOT NULL,
	[AreaLanguageId] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
	[Active] [varchar](1) NULL,
 CONSTRAINT [Area_pk] PRIMARY KEY CLUSTERED 
(
	[AreaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AreaTranslated]    Script Date: 7/12/2019 12:06:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AreaTranslated](
	[AreaTId] [int] IDENTITY(1,1) NOT NULL,
	[AreaId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[AreaName] [nvarchar](150) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Descriptions] [nvarchar](250) NULL,
 CONSTRAINT [AreaTranslated_pk] PRIMARY KEY CLUSTERED 
(
	[AreaTId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AssetCategory]    Script Date: 7/12/2019 12:06:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AssetCategory](
	[AssetCategoryId] [int] IDENTITY(1,1) NOT NULL,
	[AssetCategoryCode] [varchar](15) NOT NULL,
	[CreatedLanguageId] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
	[Active] [varchar](1) NOT NULL,
 CONSTRAINT [AssetCategory_pk] PRIMARY KEY CLUSTERED 
(
	[AssetCategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_AssetCategoryCode] UNIQUE NONCLUSTERED 
(
	[AssetCategoryCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AssetCategoryClassRelation]    Script Date: 7/12/2019 12:06:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AssetCategoryClassRelation](
	[AssetCategoryClassRelId] [int] IDENTITY(1,1) NOT NULL,
	[AssetCategoryId] [int] NOT NULL,
	[AssetClassId] [int] NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
 CONSTRAINT [AssetCategoryClassRelation_pk] PRIMARY KEY CLUSTERED 
(
	[AssetCategoryClassRelId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AssetCategoryTranslated]    Script Date: 7/12/2019 12:06:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AssetCategoryTranslated](
	[AssetCategoryTId] [int] IDENTITY(1,1) NOT NULL,
	[AssetCategoryId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[AssetCategoryName] [nvarchar](150) NOT NULL,
	[Descriptions] [nvarchar](250) NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
 CONSTRAINT [AssetCategoryTranslated_pk] PRIMARY KEY CLUSTERED 
(
	[AssetCategoryTId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_AssetCategoryTrans] UNIQUE NONCLUSTERED 
(
	[AssetCategoryId] ASC,
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AssetClass]    Script Date: 7/12/2019 12:06:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AssetClass](
	[AssetClassId] [int] IDENTITY(1,1) NOT NULL,
	[AssetClassCode] [varchar](15) NOT NULL,
	[CreatedLanguageId] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
	[Active] [varchar](1) NOT NULL,
 CONSTRAINT [AssetClass_pk] PRIMARY KEY CLUSTERED 
(
	[AssetClassId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_AssetClassCode] UNIQUE NONCLUSTERED 
(
	[AssetClassCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AssetClassIndustryRelation]    Script Date: 7/12/2019 12:06:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AssetClassIndustryRelation](
	[AssetClassIndustryRelationId] [int] IDENTITY(1,1) NOT NULL,
	[AssetClassId] [int] NOT NULL,
	[IndustryId] [int] NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
 CONSTRAINT [AssetClassIndustryRelation_pk] PRIMARY KEY CLUSTERED 
(
	[AssetClassIndustryRelationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AssetClassTranslated]    Script Date: 7/12/2019 12:06:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AssetClassTranslated](
	[AssetClassTId] [int] IDENTITY(1,1) NOT NULL,
	[AssetClassId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[AssetClassName] [nvarchar](150) NOT NULL,
	[Descriptions] [nvarchar](250) NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
 CONSTRAINT [AssetClassTranslated_pk] PRIMARY KEY CLUSTERED 
(
	[AssetClassTId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_AssetClassTrans] UNIQUE NONCLUSTERED 
(
	[AssetClassId] ASC,
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AssetSequence]    Script Date: 7/12/2019 12:06:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AssetSequence](
	[AssetSequenceId] [int] IDENTITY(1,1) NOT NULL,
	[AssetSequenceCode] [varchar](15) NOT NULL,
	[CreatedLanguageId] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[AssetTypeId] [int] NOT NULL,
 CONSTRAINT [AssetSequence_pk] PRIMARY KEY CLUSTERED 
(
	[AssetSequenceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_AssetTypeSequenceCode] UNIQUE NONCLUSTERED 
(
	[AssetTypeId] ASC,
	[AssetSequenceCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AssetSequenceTranslated]    Script Date: 7/12/2019 12:06:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AssetSequenceTranslated](
	[AssetSequenceTId] [int] IDENTITY(1,1) NOT NULL,
	[AssetSequenceId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[AssetSequenceName] [nvarchar](150) NOT NULL,
	[Descriptions] [nvarchar](250) NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
 CONSTRAINT [AssetSequenceTranslated_pk] PRIMARY KEY CLUSTERED 
(
	[AssetSequenceTId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_AssetSequenceTrans] UNIQUE NONCLUSTERED 
(
	[AssetSequenceId] ASC,
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AssetType]    Script Date: 7/12/2019 12:06:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AssetType](
	[AssetTypeId] [int] IDENTITY(1,1) NOT NULL,
	[AssetTypeCode] [varchar](15) NOT NULL,
	[CreatedLanguageId] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
	[Active] [varchar](1) NOT NULL,
 CONSTRAINT [AssetType_pk] PRIMARY KEY CLUSTERED 
(
	[AssetTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_AssetTypeCode] UNIQUE NONCLUSTERED 
(
	[AssetTypeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AssetTypeClassRelation]    Script Date: 7/12/2019 12:06:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AssetTypeClassRelation](
	[AssetTypeClassRelId] [int] IDENTITY(1,1) NOT NULL,
	[AssetClassId] [int] NOT NULL,
	[AssetTypeId] [int] NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
 CONSTRAINT [AssetTypeClassRelation_pk] PRIMARY KEY CLUSTERED 
(
	[AssetTypeClassRelId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AssetTypeTranslated]    Script Date: 7/12/2019 12:06:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AssetTypeTranslated](
	[AssetTypeTId] [int] IDENTITY(1,1) NOT NULL,
	[AssetTypeId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[AssetTypeName] [nvarchar](150) NOT NULL,
	[Descriptions] [nvarchar](250) NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
 CONSTRAINT [AssetTypeTranslated_pk] PRIMARY KEY CLUSTERED 
(
	[AssetTypeTId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_AssetTypeTrans] UNIQUE NONCLUSTERED 
(
	[AssetTypeId] ASC,
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AuditLogDetail]    Script Date: 7/12/2019 12:06:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditLogDetail](
	[AuditLogDetailId] [bigint] IDENTITY(1,1) NOT NULL,
	[AuditLogHeaderId] [bigint] NULL,
	[UserId] [int] NOT NULL,
	[ClientSiteId] [int] NULL,
	[CurrentPage] [varchar](100) NOT NULL,
	[Activity] [varchar](150) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CountryId] [int] NULL,
	[CostCentreId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[AuditLogDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AuditLogHeader]    Script Date: 7/12/2019 12:06:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditLogHeader](
	[AuditLogHeaderId] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[HostIP] [varchar](50) NOT NULL,
	[SessionId] [varchar](300) NULL,
	[InTime] [datetime] NULL,
	[OutTime] [datetime] NULL,
	[IsForceLogOut] [varchar](1) NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ClientSiteId] [int] NULL,
	[CountryId] [int] NULL,
	[CostCentreId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[AuditLogHeaderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bearings]    Script Date: 7/12/2019 12:06:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bearings](
	[BearingId] [int] IDENTITY(1,1) NOT NULL,
	[BearingCode] [varchar](50) NOT NULL,
	[ManufacturerId] [int] NOT NULL,
	[CreatedLanguageId] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
	[Active] [varchar](1) NULL,
 CONSTRAINT [Bearings_pk] PRIMARY KEY CLUSTERED 
(
	[BearingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BearingTranslated]    Script Date: 7/12/2019 12:06:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BearingTranslated](
	[BearingTId] [int] IDENTITY(1,1) NOT NULL,
	[BearingId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[BearingName] [nvarchar](150) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Descriptions] [nvarchar](250) NULL,
 CONSTRAINT [BearingTranslated_pk] PRIMARY KEY CLUSTERED 
(
	[BearingTId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Client]    Script Date: 7/12/2019 12:06:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Client](
	[ClientId] [int] IDENTITY(1,1) NOT NULL,
	[CreatedLanguageId] [int] NOT NULL,
	[ClientStatus] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
 CONSTRAINT [Client_pk] PRIMARY KEY CLUSTERED 
(
	[ClientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientDocAttachment]    Script Date: 7/12/2019 12:06:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientDocAttachment](
	[ClientDocAttachId] [bigint] IDENTITY(1,1) NOT NULL,
	[ClientSiteId] [int] NOT NULL,
	[FileName] [varchar](150) NOT NULL,
	[FileDescription] [nvarchar](250) NOT NULL,
	[LogicalName] [varchar](150) NOT NULL,
	[PhysicalPath] [varchar](250) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
	[Active] [varchar](1) NULL,
 CONSTRAINT [ClientDocAttachment_pk] PRIMARY KEY CLUSTERED 
(
	[ClientDocAttachId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientSiteConfiguration]    Script Date: 7/12/2019 12:06:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientSiteConfiguration](
	[ClientSiteConfigId] [int] IDENTITY(1,1) NOT NULL,
	[ClientSiteId] [int] NOT NULL,
	[ClientSiteConfigValue] [varchar](150) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ConfigId] [int] NULL,
 CONSTRAINT [ClientSiteConfig_pk] PRIMARY KEY CLUSTERED 
(
	[ClientSiteConfigId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_ClientConfig] UNIQUE NONCLUSTERED 
(
	[ClientSiteId] ASC,
	[ConfigId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientSiteTranslated]    Script Date: 7/12/2019 12:06:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientSiteTranslated](
	[ClientSiteTId] [int] IDENTITY(1,1) NOT NULL,
	[ClientSiteId] [int] NOT NULL,
	[SiteName] [nvarchar](150) NOT NULL,
	[Address1] [nvarchar](250) NULL,
	[Address2] [nvarchar](150) NULL,
	[City] [nvarchar](50) NULL,
	[StateName] [nvarchar](50) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
 CONSTRAINT [ClientSiteTranslated_pk] PRIMARY KEY CLUSTERED 
(
	[ClientSiteTId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_ClientSiteName] UNIQUE NONCLUSTERED 
(
	[LanguageId] ASC,
	[SiteName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_ClientSiteTranslated] UNIQUE NONCLUSTERED 
(
	[ClientSiteId] ASC,
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientTranslated]    Script Date: 7/12/2019 12:06:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientTranslated](
	[ClientTId] [int] IDENTITY(1,1) NOT NULL,
	[ClientId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[ClientName] [nvarchar](150) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
 CONSTRAINT [ClientTranslated_pk] PRIMARY KEY CLUSTERED 
(
	[ClientTId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CMSSetup]    Script Date: 7/12/2019 12:06:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMSSetup](
	[CMSId] [int] IDENTITY(1,1) NOT NULL,
	[TypeCode] [varchar](10) NOT NULL,
	[TypeName] [varchar](100) NOT NULL,
	[Descriptions] [nvarchar](500) NULL,
	[TypeText] [nvarchar](max) NULL,
	[TypeOrder] [int] NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
 CONSTRAINT [CMS_pk] PRIMARY KEY CLUSTERED 
(
	[CMSId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ConditionCodeClientMapping]    Script Date: 7/12/2019 12:06:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConditionCodeClientMapping](
	[CMappingId] [int] IDENTITY(1,1) NOT NULL,
	[ConditionId] [int] NOT NULL,
	[ClientSiteId] [int] NOT NULL,
	[CreatedLanguageId] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
	[Active] [varchar](1) NOT NULL,
 CONSTRAINT [ConditionClient_pk] PRIMARY KEY CLUSTERED 
(
	[CMappingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ConditionCodeClientTranslated]    Script Date: 7/12/2019 12:06:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConditionCodeClientTranslated](
	[CMappingTId] [int] IDENTITY(1,1) NOT NULL,
	[CMappingId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[ConditionName] [nvarchar](150) NOT NULL,
	[Descriptions] [nvarchar](250) NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
 CONSTRAINT [ConditionCodeClientTranslated_pk] PRIMARY KEY CLUSTERED 
(
	[CMappingTId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CostCentre]    Script Date: 7/12/2019 12:06:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CostCentre](
	[CostCentreId] [int] IDENTITY(1,1) NOT NULL,
	[CountryId] [int] NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedLanguageId] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CostCentreCode] [nvarchar](30) NULL,
 CONSTRAINT [CostCentre_pk] PRIMARY KEY CLUSTERED 
(
	[CostCentreId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[CostCentreCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CostCentreTranslated]    Script Date: 7/12/2019 12:06:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CostCentreTranslated](
	[CostCentreTId] [int] IDENTITY(1,1) NOT NULL,
	[CostCentreId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[CostCentreName] [nvarchar](150) NOT NULL,
	[Descriptions] [nvarchar](250) NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
 CONSTRAINT [CostCentreTranslated_pk] PRIMARY KEY CLUSTERED 
(
	[CostCentreTId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [CostCentreTranslated_UK] UNIQUE NONCLUSTERED 
(
	[CostCentreId] ASC,
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Country]    Script Date: 7/12/2019 12:06:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country](
	[CountryId] [int] IDENTITY(1,1) NOT NULL,
	[CreatedLanguageId] [int] NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CountryCode] [varchar](5) NOT NULL,
 CONSTRAINT [Country_pk] PRIMARY KEY CLUSTERED 
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [Country_UK] UNIQUE NONCLUSTERED 
(
	[CountryCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UK_CountryCode] UNIQUE NONCLUSTERED 
(
	[CountryCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CountryTranslated]    Script Date: 7/12/2019 12:06:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CountryTranslated](
	[CountryTId] [int] IDENTITY(1,1) NOT NULL,
	[CountryId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[CountryName] [nvarchar](150) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
 CONSTRAINT [CountryTranslated_pk] PRIMARY KEY CLUSTERED 
(
	[CountryTId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [CountryTranslated_UK] UNIQUE NONCLUSTERED 
(
	[CountryId] ASC,
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DriveAttachments]    Script Date: 7/12/2019 12:06:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DriveAttachments](
	[DriveAttachId] [int] IDENTITY(1,1) NOT NULL,
	[DriveUnitId] [int] NOT NULL,
	[FileName] [varchar](150) NOT NULL,
	[LogicalName] [varchar](150) NOT NULL,
	[PhysicalPath] [varchar](250) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
	[Active] [varchar](1) NULL,
 CONSTRAINT [DriveAttachments_pk] PRIMARY KEY CLUSTERED 
(
	[DriveAttachId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DrivenAttachments]    Script Date: 7/12/2019 12:06:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DrivenAttachments](
	[DrivenAttachId] [int] IDENTITY(1,1) NOT NULL,
	[DrivenUnitId] [int] NOT NULL,
	[FileName] [varchar](150) NOT NULL,
	[LogicalName] [varchar](150) NOT NULL,
	[PhysicalPath] [varchar](250) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
	[Active] [varchar](1) NULL,
 CONSTRAINT [DrivenAttachments_pk] PRIMARY KEY CLUSTERED 
(
	[DrivenAttachId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipmentAttachments]    Script Date: 7/12/2019 12:06:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentAttachments](
	[EquipmentAttachId] [int] IDENTITY(1,1) NOT NULL,
	[EquipmentId] [int] NOT NULL,
	[FileName] [varchar](150) NOT NULL,
	[LogicalName] [varchar](150) NOT NULL,
	[PhysicalPath] [varchar](250) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
	[Active] [varchar](1) NULL,
 CONSTRAINT [EquipmentAttachments_pk] PRIMARY KEY CLUSTERED 
(
	[EquipmentAttachId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FailureCause]    Script Date: 7/12/2019 12:06:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FailureCause](
	[FailureCauseId] [int] IDENTITY(1,1) NOT NULL,
	[FailureCauseCode] [varchar](15) NOT NULL,
	[CreatedLanguageId] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
	[Active] [varchar](1) NULL,
 CONSTRAINT [FailureCause_pk] PRIMARY KEY CLUSTERED 
(
	[FailureCauseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_FailureCause] UNIQUE NONCLUSTERED 
(
	[FailureCauseCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FailureCauseModeRelation]    Script Date: 7/12/2019 12:06:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FailureCauseModeRelation](
	[FailureCauseModeRelationId] [int] IDENTITY(1,1) NOT NULL,
	[FailureModeId] [int] NOT NULL,
	[FailureCauseId] [int] NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
 CONSTRAINT [FailureCauseModeRelation_Pk] PRIMARY KEY CLUSTERED 
(
	[FailureCauseModeRelationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FailureCauseTranslated]    Script Date: 7/12/2019 12:06:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FailureCauseTranslated](
	[FailureCauseTId] [int] IDENTITY(1,1) NOT NULL,
	[FailureCauseId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[FailureCauseName] [nvarchar](150) NOT NULL,
	[Descriptions] [nvarchar](250) NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
 CONSTRAINT [FailureCauseTranslated_pk] PRIMARY KEY CLUSTERED 
(
	[FailureCauseTId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FailureMode]    Script Date: 7/12/2019 12:06:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FailureMode](
	[FailureModeId] [int] IDENTITY(1,1) NOT NULL,
	[FailureModeCode] [varchar](15) NOT NULL,
	[CreatedLanguageId] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
	[Active] [varchar](1) NULL,
 CONSTRAINT [FailureMode_pk] PRIMARY KEY CLUSTERED 
(
	[FailureModeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_FailureCode] UNIQUE NONCLUSTERED 
(
	[FailureModeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FailureModeAssetClassRelation]    Script Date: 7/12/2019 12:06:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FailureModeAssetClassRelation](
	[FailureModeAssetRelationId] [int] IDENTITY(1,1) NOT NULL,
	[AssetClassId] [int] NOT NULL,
	[FailureModeId] [int] NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
 CONSTRAINT [FailureModeAssetClassRelation_Pk] PRIMARY KEY CLUSTERED 
(
	[FailureModeAssetRelationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FailureModeTranslated]    Script Date: 7/12/2019 12:06:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FailureModeTranslated](
	[FailureModeTId] [int] IDENTITY(1,1) NOT NULL,
	[FailureModeId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[FailureModeName] [nvarchar](150) NOT NULL,
	[Descriptions] [nvarchar](250) NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
 CONSTRAINT [FailureModeTranslated_pk] PRIMARY KEY CLUSTERED 
(
	[FailureModeTId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FailureReportAttachment]    Script Date: 7/12/2019 12:06:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FailureReportAttachment](
	[FailureReportAttachId] [bigint] IDENTITY(1,1) NOT NULL,
	[FailureReportHeaderId] [bigint] NOT NULL,
	[FileName] [nvarchar](150) NOT NULL,
	[LogicalName] [nvarchar](150) NOT NULL,
	[PhysicalPath] [nvarchar](250) NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
 CONSTRAINT [FailureReportAttachment_pk] PRIMARY KEY CLUSTERED 
(
	[FailureReportAttachId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FaultReport]    Script Date: 7/12/2019 12:06:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FaultReport](
	[FaultReportId] [int] IDENTITY(1,1) NOT NULL,
	[FaultSource] [nvarchar](100) NULL,
	[ClientSiteId] [int] NULL,
	[ClientName] [nvarchar](50) NULL,
	[PlantName] [nvarchar](50) NULL,
	[JobID] [int] NULL,
	[MachineName] [nvarchar](250) NULL,
	[AssetName] [nvarchar](250) NULL,
	[FaultCode] [nvarchar](250) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IndustryTranslated]    Script Date: 7/12/2019 12:06:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IndustryTranslated](
	[IndustryTId] [int] IDENTITY(1,1) NOT NULL,
	[IndustryId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[IndustryName] [nvarchar](150) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Descriptions] [nvarchar](250) NULL,
 CONSTRAINT [IndustryTranslated_pk] PRIMARY KEY CLUSTERED 
(
	[IndustryTId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IntermediateAttachments]    Script Date: 7/12/2019 12:06:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IntermediateAttachments](
	[IntermediateAttachId] [int] IDENTITY(1,1) NOT NULL,
	[IntermediateUnitId] [int] NOT NULL,
	[FileName] [varchar](150) NOT NULL,
	[LogicalName] [varchar](150) NOT NULL,
	[PhysicalPath] [varchar](250) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
	[Active] [varchar](1) NULL,
 CONSTRAINT [IntermediateAttachments_pk] PRIMARY KEY CLUSTERED 
(
	[IntermediateAttachId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobComments]    Script Date: 7/12/2019 12:06:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobComments](
	[JobCommentId] [bigint] IDENTITY(1,1) NOT NULL,
	[JobId] [bigint] NOT NULL,
	[StatusId] [int] NOT NULL,
	[Comments] [nvarchar](1500) NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
 CONSTRAINT [JobComments_pk] PRIMARY KEY CLUSTERED 
(
	[JobCommentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobEquipmentComments]    Script Date: 7/12/2019 12:06:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobEquipmentComments](
	[JobEquipCommentId] [bigint] IDENTITY(1,1) NOT NULL,
	[JobEquipmentId] [bigint] NOT NULL,
	[StatusId] [int] NOT NULL,
	[Comments] [nvarchar](1500) NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
 CONSTRAINT [JobEquipmentComments_pk] PRIMARY KEY CLUSTERED 
(
	[JobEquipCommentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobEquipmentOilProperties]    Script Date: 7/12/2019 12:06:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobEquipmentOilProperties](
	[JobEquipOilPropertiesId] [bigint] IDENTITY(1,1) NOT NULL,
	[JobEquipmentId] [bigint] NOT NULL,
	[OilPropertiesId] [int] NULL,
	[OilLevel] [nvarchar](250) NULL,
	[SeverityId] [int] NULL,
	[OAVibChangePercentageId] [int] NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
 CONSTRAINT [JobEquipmentOilProperties_pk] PRIMARY KEY CLUSTERED 
(
	[JobEquipOilPropertiesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_JobEquipmentOilProperties] UNIQUE NONCLUSTERED 
(
	[JobEquipmentId] ASC,
	[OilPropertiesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobEquipmentUnitAnalysisComments]    Script Date: 7/12/2019 12:06:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobEquipmentUnitAnalysisComments](
	[UnitAnalysisCommentId] [bigint] IDENTITY(1,1) NOT NULL,
	[UnitAnalysisId] [bigint] NOT NULL,
	[StatusId] [int] NOT NULL,
	[Comments] [nvarchar](1500) NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
 CONSTRAINT [JobEquipmentUnitAnalysisComments_pk] PRIMARY KEY CLUSTERED 
(
	[UnitAnalysisCommentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobEquipUnitAnalysisAttachments]    Script Date: 7/12/2019 12:06:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobEquipUnitAnalysisAttachments](
	[UnitAnalysisAttachId] [bigint] IDENTITY(1,1) NOT NULL,
	[UnitAnalysisId] [bigint] NOT NULL,
	[FileName] [nvarchar](150) NOT NULL,
	[LogicalName] [nvarchar](150) NOT NULL,
	[PhysicalPath] [nvarchar](250) NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
 CONSTRAINT [UnitAnalysisAttachments_pk] PRIMARY KEY CLUSTERED 
(
	[UnitAnalysisAttachId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobServices]    Script Date: 7/12/2019 12:06:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobServices](
	[JobServiceId] [bigint] IDENTITY(1,1) NOT NULL,
	[JobId] [bigint] NOT NULL,
	[ServiceId] [int] NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
 CONSTRAINT [JobService_pk] PRIMARY KEY CLUSTERED 
(
	[JobServiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Languages]    Script Date: 7/12/2019 12:06:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Languages](
	[LanguageId] [int] IDENTITY(1,1) NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CountryCode] [varchar](5) NOT NULL,
	[LName] [nvarchar](75) NOT NULL,
 CONSTRAINT [Language_pk] PRIMARY KEY CLUSTERED 
(
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [Languages_UK] UNIQUE NONCLUSTERED 
(
	[CountryCode] ASC,
	[LName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LeverageExport]    Script Date: 7/12/2019 12:06:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeverageExport](
	[LeverageExportId] [bigint] IDENTITY(1,1) NOT NULL,
	[FileDate] [date] NOT NULL,
	[FileName] [nvarchar](150) NOT NULL,
	[FilePath] [nvarchar](250) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
 CONSTRAINT [LeverageExport_pk] PRIMARY KEY CLUSTERED 
(
	[LeverageExportId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lookups]    Script Date: 7/12/2019 12:06:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lookups](
	[LookupId] [int] IDENTITY(1,1) NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedLanguageId] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[LookupCode] [varchar](50) NOT NULL,
	[LName] [varchar](150) NULL,
	[ListOrder] [int] NULL,
 CONSTRAINT [Lookup_pk] PRIMARY KEY CLUSTERED 
(
	[LookupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_Lookup] UNIQUE NONCLUSTERED 
(
	[LName] ASC,
	[LookupCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LookupTranslated]    Script Date: 7/12/2019 12:06:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LookupTranslated](
	[LookupTId] [int] IDENTITY(1,1) NOT NULL,
	[LanguageId] [int] NOT NULL,
	[LookupId] [int] NOT NULL,
	[LValue] [nvarchar](75) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[Descriptions] [nvarchar](250) NULL,
 CONSTRAINT [LookupTranslated_pk] PRIMARY KEY CLUSTERED 
(
	[LookupTId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Manufacturer]    Script Date: 7/12/2019 12:06:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Manufacturer](
	[ManufacturerId] [int] IDENTITY(1,1) NOT NULL,
	[ManufacturerCode] [varchar](5) NOT NULL,
	[CreatedLanguageId] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
	[Active] [varchar](1) NULL,
	[BearingMFT] [varchar](1) NULL,
	[DriveMFT] [varchar](1) NULL,
	[IntermediateMFT] [varchar](1) NULL,
	[DrivenMFT] [varchar](1) NULL,
 CONSTRAINT [PK_Manufacturer] PRIMARY KEY CLUSTERED 
(
	[ManufacturerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_Manufacturer] UNIQUE NONCLUSTERED 
(
	[ManufacturerCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ManufacturerTranslated]    Script Date: 7/12/2019 12:06:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ManufacturerTranslated](
	[ManufacturerTId] [int] IDENTITY(1,1) NOT NULL,
	[ManufacturerId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[ManufacturerName] [nvarchar](150) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Descriptions] [nvarchar](250) NULL,
 CONSTRAINT [ManufacturerTranslated_pk] PRIMARY KEY CLUSTERED 
(
	[ManufacturerTId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OtherReportsAttachment]    Script Date: 7/12/2019 12:06:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OtherReportsAttachment](
	[OtherReportsAttachId] [bigint] IDENTITY(1,1) NOT NULL,
	[ClientSiteId] [int] NOT NULL,
	[ReportTypeId] [int] NOT NULL,
	[PlantAreaId] [int] NOT NULL,
	[ReportDate] [date] NULL,
	[FileName] [varchar](150) NOT NULL,
	[FileDescription] [nvarchar](250) NOT NULL,
	[LogicalName] [varchar](150) NOT NULL,
	[PhysicalPath] [varchar](250) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
	[Active] [varchar](1) NULL,
	[EquipmentId] [int] NULL,
 CONSTRAINT [OtherReportsAttachment_pk] PRIMARY KEY CLUSTERED 
(
	[OtherReportsAttachId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlantAreaTranslated]    Script Date: 7/12/2019 12:06:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlantAreaTranslated](
	[PlantAreaTId] [int] IDENTITY(1,1) NOT NULL,
	[PlantAreaId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[PlantAreaName] [nvarchar](150) NOT NULL,
	[Descriptions] [nvarchar](250) NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[ClientSiteid] [int] NOT NULL,
 CONSTRAINT [PlantAreaTranslated_pk] PRIMARY KEY CLUSTERED 
(
	[PlantAreaTId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_PlantAreaName] UNIQUE NONCLUSTERED 
(
	[ClientSiteid] ASC,
	[LanguageId] ASC,
	[PlantAreaName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Privileges]    Script Date: 7/12/2019 12:06:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Privileges](
	[PrivilegeID] [int] IDENTITY(1,1) NOT NULL,
	[PrivilegeCode] [varchar](50) NOT NULL,
	[PrivilegeName] [varchar](50) NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
 CONSTRAINT [Privilege_pk] PRIMARY KEY CLUSTERED 
(
	[PrivilegeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProgramPrivilegeRelation]    Script Date: 7/12/2019 12:06:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProgramPrivilegeRelation](
	[PrgRelationID] [int] IDENTITY(1,1) NOT NULL,
	[ProgramId] [int] NOT NULL,
	[PrivilegeId] [int] NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
 CONSTRAINT [ProgramPrivilegeRelation_pk] PRIMARY KEY CLUSTERED 
(
	[PrgRelationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Programs]    Script Date: 7/12/2019 12:06:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Programs](
	[ProgramId] [int] IDENTITY(1,1) NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedLanguageId] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[ProgramCode] [varchar](5) NOT NULL,
	[MenuOrder] [int] NULL,
	[ControllerName] [varchar](50) NULL,
	[ActionName] [varchar](50) NULL,
	[LinkUrl] [varchar](100) NULL,
	[IconName] [varchar](35) NULL,
	[CssClassName] [varchar](50) NULL,
	[GroupCode] [varchar](20) NULL,
	[SubGroupCode] [varchar](20) NULL,
	[MenuGroupId] [int] NULL,
	[Internal] [varchar](1) NOT NULL,
	[ProgramType] [varchar](5) NULL,
	[WidgetLogo] [varchar](150) NULL,
	[Height] [int] NULL,
	[Width] [int] NULL,
	[Param1] [nvarchar](75) NULL,
	[Param2] [nvarchar](75) NULL,
	[Param3] [nvarchar](75) NULL,
	[Param4] [nvarchar](75) NULL,
	[Param5] [nvarchar](75) NULL,
 CONSTRAINT [Programs_pk] PRIMARY KEY CLUSTERED 
(
	[ProgramId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_Programs] UNIQUE NONCLUSTERED 
(
	[ProgramCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProgramTranslated]    Script Date: 7/12/2019 12:06:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProgramTranslated](
	[ProgramTId] [int] IDENTITY(1,1) NOT NULL,
	[ProgramId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[ProgramName] [nvarchar](150) NOT NULL,
	[Descriptions] [nvarchar](250) NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[MenuName] [nvarchar](75) NULL,
 CONSTRAINT [ProgramTranslated_pk] PRIMARY KEY CLUSTERED 
(
	[ProgramTId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleGroup]    Script Date: 7/12/2019 12:06:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleGroup](
	[RoleGroupId] [int] IDENTITY(1,1) NOT NULL,
	[CreatedLanguageId] [int] NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
 CONSTRAINT [RoleGroup_pk] PRIMARY KEY CLUSTERED 
(
	[RoleGroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleGroupRoleRelation]    Script Date: 7/12/2019 12:06:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleGroupRoleRelation](
	[RoleGroupRoleRelationId] [int] IDENTITY(1,1) NOT NULL,
	[RoleGroupId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
 CONSTRAINT [RoleGroupRoleRelation_pk] PRIMARY KEY CLUSTERED 
(
	[RoleGroupRoleRelationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_RoleGroupRoleRelation] UNIQUE NONCLUSTERED 
(
	[RoleGroupId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleGroupTranslated]    Script Date: 7/12/2019 12:06:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleGroupTranslated](
	[RoleGroupTId] [int] IDENTITY(1,1) NOT NULL,
	[RoleGroupId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[RoleGroupName] [nvarchar](100) NOT NULL,
	[Descriptions] [nvarchar](250) NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
 CONSTRAINT [RoleGroupTranslated_pk] PRIMARY KEY CLUSTERED 
(
	[RoleGroupTId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RolePrgPrivilegeRelation]    Script Date: 7/12/2019 12:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RolePrgPrivilegeRelation](
	[RolePrgRelationID] [int] IDENTITY(1,1) NOT NULL,
	[ProgramId] [int] NOT NULL,
	[PrivilegeId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[HideProgram] [varchar](1) NOT NULL,
 CONSTRAINT [RolePrgPrivilegeRelation_pk] PRIMARY KEY CLUSTERED 
(
	[RolePrgRelationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 7/12/2019 12:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[Internal] [varchar](1) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[RoleName] [nvarchar](100) NOT NULL,
	[Descriptions] [nvarchar](250) NULL,
	[Active] [varchar](1) NOT NULL,
 CONSTRAINT [Role_pk] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_Roles] UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleWorkFlowRelation]    Script Date: 7/12/2019 12:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleWorkFlowRelation](
	[RoleWorkFlowRelationId] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [int] NOT NULL,
	[WorkFlowId] [int] NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
 CONSTRAINT [RoleWorkFlowRelation_pk] PRIMARY KEY CLUSTERED 
(
	[RoleWorkFlowRelationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_RoleWorkFlowRelation] UNIQUE NONCLUSTERED 
(
	[RoleId] ASC,
	[WorkFlowId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RptAnalystPerformance]    Script Date: 7/12/2019 12:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RptAnalystPerformance](
	[CountryId] [int] NULL,
	[CostCentreId] [int] NULL,
	[SectorId] [int] NULL,
	[SegmentId] [int] NULL,
	[IndustryId] [int] NULL,
	[ClientSiteId] [int] NULL,
	[AnalystId] [int] NULL,
	[AnalystName] [nvarchar](250) NULL,
	[ReportDate] [date] NULL,
	[TypeId] [int] NULL,
	[ActivityType] [varchar](50) NULL,
	[TypeName] [nvarchar](250) NULL,
	[ActivityCount] [int] NULL,
	[CountryName] [nvarchar](250) NULL,
	[CostCentreName] [nvarchar](250) NULL,
	[SectorName] [nvarchar](250) NULL,
	[SegmentName] [nvarchar](250) NULL,
	[Industryname] [nvarchar](250) NULL,
	[ClientSiteName] [nvarchar](250) NULL,
	[CreateOn] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RptBearingList]    Script Date: 7/12/2019 12:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RptBearingList](
	[BearingListID] [bigint] IDENTITY(1,1) NOT NULL,
	[ClientSiteId] [int] NULL,
	[PlantAreaId] [int] NULL,
	[PlantAreaName] [nvarchar](500) NULL,
	[AssetType] [varchar](50) NULL,
	[AssetLocation] [varchar](50) NULL,
	[ManufacturerId] [int] NULL,
	[ManufacturerName] [nvarchar](500) NULL,
	[BearingCount] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedOn] [datetime] NULL,
	[UnitManufacturerId] [int] NULL,
	[UnitManufacturerName] [nvarchar](500) NULL,
	[AssetCount] [int] NULL,
	[ClientSiteName] [nvarchar](500) NULL,
	[CountryId] [int] NULL,
	[CostCentreId] [int] NULL,
	[SectorId] [int] NULL,
	[SegmentId] [int] NULL,
	[IndustryId] [int] NULL,
	[CountryName] [nvarchar](250) NULL,
	[CostCentreName] [nvarchar](250) NULL,
	[SectorName] [nvarchar](250) NULL,
	[SegmentName] [nvarchar](250) NULL,
	[IndustryName] [nvarchar](250) NULL,
	[EquipmentCount] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RptClientList]    Script Date: 7/12/2019 12:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RptClientList](
	[CountryId] [int] NULL,
	[CostCentreId] [int] NULL,
	[ClientSiteId] [int] NULL,
	[SectorId] [int] NULL,
	[SegmentId] [int] NULL,
	[IndustryId] [int] NULL,
	[CountryName] [nvarchar](250) NULL,
	[CostCentreName] [nvarchar](250) NULL,
	[ClientSiteName] [nvarchar](250) NULL,
	[SectorName] [nvarchar](250) NULL,
	[SegmentName] [nvarchar](250) NULL,
	[IndustryName] [nvarchar](250) NULL,
	[PMPOfflineProgram] [int] NOT NULL,
	[PMPOnlineProgram] [int] NOT NULL,
	[SmartSupplierProgram] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RptContractPerformance]    Script Date: 7/12/2019 12:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RptContractPerformance](
	[CPID] [bigint] IDENTITY(1,1) NOT NULL,
	[ClientSiteId] [int] NOT NULL,
	[RType] [varchar](50) NULL,
	[RName] [varchar](50) NULL,
	[RDate] [date] NULL,
	[RValue] [decimal](20, 2) NULL,
	[ClientSiteName] [nvarchar](500) NULL,
	[PlantAreaId] [int] NULL,
	[PlantAreaName] [nvarchar](500) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RptEquipmentHealthStatus]    Script Date: 7/12/2019 12:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RptEquipmentHealthStatus](
	[CountryId] [int] NULL,
	[SectorId] [int] NULL,
	[segmentId] [int] NULL,
	[IndustryId] [int] NULL,
	[CostCentreId] [int] NULL,
	[ClientSiteId] [int] NULL,
	[PlantAreaId] [int] NULL,
	[ServiceId] [int] NULL,
	[ConditionId] [int] NULL,
	[CountryName] [nvarchar](100) NULL,
	[CostCentreName] [nvarchar](250) NULL,
	[SectorName] [nvarchar](250) NULL,
	[SegmentName] [nvarchar](250) NULL,
	[IndustryName] [nvarchar](250) NULL,
	[ClientSiteName] [nvarchar](250) NULL,
	[PlantAreaName] [nvarchar](250) NULL,
	[ServiceType] [nvarchar](100) NULL,
	[ConditionCode] [varchar](5) NULL,
	[ConditionName] [nvarchar](100) NULL,
	[EventCount] [int] NULL,
	[EquipmentCount] [int] NULL,
	[JobPeriod] [int] NULL,
	[CreatedOn] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RptFailureCauseStatistics]    Script Date: 7/12/2019 12:06:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RptFailureCauseStatistics](
	[CountryId] [int] NULL,
	[CostCentreId] [int] NULL,
	[ClientSiteId] [int] NULL,
	[SectorId] [int] NULL,
	[SegmentId] [int] NULL,
	[IndustryId] [int] NULL,
	[CountryName] [nvarchar](250) NULL,
	[CostCentreName] [nvarchar](250) NULL,
	[ClientSiteName] [nvarchar](250) NULL,
	[SectorName] [nvarchar](250) NULL,
	[SegmentName] [nvarchar](250) NULL,
	[IndustryName] [nvarchar](250) NULL,
	[PlantAreaId] [int] NULL,
	[UnitType] [varchar](50) NULL,
	[FailureCauseId] [int] NULL,
	[Consequence] [decimal](20, 5) NULL,
	[PlantAreaName] [nvarchar](500) NULL,
	[FailureCause] [nvarchar](500) NULL,
	[Createdon] [datetime] NOT NULL,
	[ReportDate] [date] NULL,
	[ReportType] [varchar](50) NULL,
	[EventCount] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RptJobAssetHealthStatus]    Script Date: 7/12/2019 12:06:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RptJobAssetHealthStatus](
	[CountryId] [int] NULL,
	[SectorId] [int] NULL,
	[segmentId] [int] NULL,
	[IndustryId] [int] NULL,
	[CostCentreId] [int] NULL,
	[ClientSiteId] [int] NULL,
	[PlantAreaId] [int] NULL,
	[UnitType] [varchar](50) NULL,
	[ManufacturerId] [int] NULL,
	[ServiceId] [int] NULL,
	[ConditionId] [int] NULL,
	[CountryName] [nvarchar](100) NULL,
	[CostCentreName] [nvarchar](250) NULL,
	[SectorName] [nvarchar](250) NULL,
	[SegmentName] [nvarchar](250) NULL,
	[IndustryName] [nvarchar](250) NULL,
	[ClientSiteName] [nvarchar](250) NULL,
	[PlantAreaName] [nvarchar](250) NULL,
	[ManufacturerName] [nvarchar](250) NULL,
	[ServiceType] [nvarchar](100) NULL,
	[ConditionCode] [varchar](5) NULL,
	[ConditionName] [nvarchar](100) NULL,
	[JobPeriod] [int] NULL,
	[EventCount] [int] NULL,
	[CreatedOn] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RptJobEquipHealthStatus]    Script Date: 7/12/2019 12:06:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RptJobEquipHealthStatus](
	[JobId] [bigint] NULL,
	[JobType] [varchar](50) NULL,
	[EstStartDate] [date] NULL,
	[CountryId] [int] NULL,
	[CostCentreId] [int] NULL,
	[SectorId] [int] NULL,
	[segmentId] [int] NULL,
	[IndustryId] [int] NULL,
	[ClientSiteId] [int] NULL,
	[PlantAreaId] [int] NULL,
	[ServiceId] [int] NULL,
	[ConditionId] [int] NULL,
	[DataCollectorId] [int] NULL,
	[AnalystId] [int] NULL,
	[ReviewerId] [int] NULL,
	[CountryName] [nvarchar](100) NULL,
	[CostCentreName] [nvarchar](250) NULL,
	[SectorName] [nvarchar](250) NULL,
	[SegmentName] [nvarchar](250) NULL,
	[IndustryName] [nvarchar](250) NULL,
	[ClientSiteName] [nvarchar](250) NULL,
	[PlantAreaName] [nvarchar](250) NULL,
	[ServiceType] [nvarchar](100) NULL,
	[ConditionCode] [varchar](5) NULL,
	[ConditionName] [nvarchar](100) NULL,
	[DataCollectorName] [nvarchar](250) NULL,
	[AnalystName] [nvarchar](250) NULL,
	[ReviewerName] [nvarchar](250) NULL,
	[EquipmentCount] [int] NULL,
	[CreatedOn] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RptJobEquipList]    Script Date: 7/12/2019 12:06:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RptJobEquipList](
	[JobId] [bigint] NULL,
	[EstStartDate] [date] NULL,
	[CountryId] [int] NULL,
	[CostCentreId] [int] NULL,
	[SectorId] [int] NULL,
	[segmentId] [int] NULL,
	[IndustryId] [int] NULL,
	[ClientSiteId] [int] NULL,
	[PlantAreaId] [int] NULL,
	[ServiceId] [int] NULL,
	[DataCollectorId] [int] NULL,
	[AnalystId] [int] NULL,
	[ReviewerId] [int] NULL,
	[CountryName] [nvarchar](100) NULL,
	[CostCentreName] [nvarchar](250) NULL,
	[SectorName] [nvarchar](250) NULL,
	[SegmentName] [nvarchar](250) NULL,
	[IndustryName] [nvarchar](250) NULL,
	[ClientSiteName] [nvarchar](250) NULL,
	[PlantAreaName] [nvarchar](250) NULL,
	[ServiceType] [nvarchar](100) NULL,
	[DataCollectorName] [nvarchar](250) NULL,
	[AnalystName] [nvarchar](250) NULL,
	[ReviewerName] [nvarchar](250) NULL,
	[EquipmentCount] [int] NULL,
	[CreatedOn] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RptJobList]    Script Date: 7/12/2019 12:06:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RptJobList](
	[ClientSiteId] [int] NULL,
	[JobId] [bigint] NULL,
	[EstStartDate] [date] NULL,
	[EstEndDate] [date] NULL,
	[Jobtype] [varchar](50) NULL,
	[ReportSent] [varchar](1) NULL,
	[StatusName] [nvarchar](100) NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedOn] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RptOpportunities]    Script Date: 7/12/2019 12:06:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RptOpportunities](
	[CountryId] [int] NULL,
	[SectorId] [int] NULL,
	[SegmentId] [int] NULL,
	[IndustryId] [int] NULL,
	[CostCentreId] [int] NULL,
	[PlantAreaId] [int] NULL,
	[ClientSiteid] [int] NULL,
	[LeverageDate] [date] NULL,
	[AssetType] [nvarchar](50) NULL,
	[BManufacturerId] [int] NULL,
	[OpportunityCount] [int] NULL,
	[BearingCount] [int] NULL,
	[CountryName] [nvarchar](250) NULL,
	[SectorName] [nvarchar](250) NULL,
	[SegmentName] [nvarchar](250) NULL,
	[IndustryName] [nvarchar](250) NULL,
	[CostCentreName] [nvarchar](250) NULL,
	[ClientSiteName] [nvarchar](250) NULL,
	[PlantAreaName] [nvarchar](250) NULL,
	[BManufacturerName] [nvarchar](250) NULL,
	[OpportunityName] [nvarchar](250) NULL,
	[OpportunityCode] [nvarchar](30) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RptWorkNotification]    Script Date: 7/12/2019 12:06:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RptWorkNotification](
	[CountryId] [int] NULL,
	[CostCentreId] [int] NULL,
	[SectorId] [int] NULL,
	[segmentId] [int] NULL,
	[IndustryId] [int] NULL,
	[ClientSiteId] [int] NULL,
	[PlantAreaId] [int] NULL,
	[CountryName] [nvarchar](250) NULL,
	[CostCentreName] [nvarchar](250) NULL,
	[SectorName] [nvarchar](250) NULL,
	[SegmentName] [nvarchar](250) NULL,
	[IndustryName] [nvarchar](250) NULL,
	[ClientSiteName] [nvarchar](250) NULL,
	[PlantAreaName] [nvarchar](250) NULL,
	[WorkNotificationDate] [date] NULL,
	[TotalJobs] [int] NULL,
	[TotalWN] [int] NULL,
	[OpenWN] [int] NULL,
	[CancelledWN] [int] NULL,
	[ClosedWN] [int] NULL,
	[TotalAssets] [int] NULL,
	[TotalFailureReported] [int] NULL,
	[TT] [int] NULL,
	[TF] [int] NULL,
	[FT] [int] NULL,
	[FF] [int] NULL,
	[CreatedOn] [datetime] NOT NULL,
	[AnalystId] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ScheduleEquipments]    Script Date: 7/12/2019 12:06:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ScheduleEquipments](
	[ScheduleEquipmentId] [bigint] IDENTITY(1,1) NOT NULL,
	[ScheduleSetupId] [bigint] NOT NULL,
	[EquipmentId] [int] NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
 CONSTRAINT [ScheduleEquipments_pk] PRIMARY KEY CLUSTERED 
(
	[ScheduleEquipmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_ScheduleEquipment] UNIQUE NONCLUSTERED 
(
	[ScheduleSetupId] ASC,
	[EquipmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ScheduleServices]    Script Date: 7/12/2019 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ScheduleServices](
	[ScheduleServiceId] [bigint] IDENTITY(1,1) NOT NULL,
	[ScheduleSetupId] [bigint] NOT NULL,
	[ServiceId] [int] NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
 CONSTRAINT [ScheduleServices_pk] PRIMARY KEY CLUSTERED 
(
	[ScheduleServiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_ScheduleService] UNIQUE NONCLUSTERED 
(
	[ScheduleSetupId] ASC,
	[ServiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ScheduleSetup]    Script Date: 7/12/2019 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ScheduleSetup](
	[ScheduleSetupId] [bigint] IDENTITY(1,1) NOT NULL,
	[ClientSiteId] [int] NOT NULL,
	[ScheduleName] [nvarchar](150) NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[IntervalDays] [int] NULL,
	[EstjobDays] [int] NULL,
	[StatusId] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
 CONSTRAINT [ScheduleSetup_pk] PRIMARY KEY CLUSTERED 
(
	[ScheduleSetupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UK_ScheduleSetup] UNIQUE NONCLUSTERED 
(
	[ScheduleName] ASC,
	[StartDate] ASC,
	[EndDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sector]    Script Date: 7/12/2019 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sector](
	[SectorId] [int] IDENTITY(1,1) NOT NULL,
	[SectorCode] [varchar](5) NOT NULL,
	[CreatedLanguageId] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
	[Active] [varchar](1) NULL,
 CONSTRAINT [Sector_pk] PRIMARY KEY CLUSTERED 
(
	[SectorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_Sector] UNIQUE NONCLUSTERED 
(
	[SectorCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SectorTranslated]    Script Date: 7/12/2019 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SectorTranslated](
	[SectorTId] [int] IDENTITY(1,1) NOT NULL,
	[SectorId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[SectorName] [nvarchar](150) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Descriptions] [nvarchar](250) NULL,
 CONSTRAINT [SectorTranslated_pk] PRIMARY KEY CLUSTERED 
(
	[SectorTId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SegmentTranslated]    Script Date: 7/12/2019 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SegmentTranslated](
	[SegmentTId] [int] IDENTITY(1,1) NOT NULL,
	[SegmentId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[SegmentName] [nvarchar](150) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Descriptions] [nvarchar](250) NULL,
 CONSTRAINT [SegmentTranslated_pk] PRIMARY KEY CLUSTERED 
(
	[SegmentTId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SKFSQLMaintenanceLog]    Script Date: 7/12/2019 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SKFSQLMaintenanceLog](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[OperationTime] [datetime2](7) NULL,
	[command] [varchar](4000) NULL,
	[ExtraInfo] [varchar](4000) NULL,
	[StartTime] [datetime2](7) NULL,
	[EndTime] [datetime2](7) NULL,
	[StatusMessage] [varchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sysdiagrams]    Script Date: 7/12/2019 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sysdiagrams](
	[name] [sysname] NOT NULL,
	[principal_id] [int] NOT NULL,
	[diagram_id] [int] IDENTITY(1,1) NOT NULL,
	[version] [int] NULL,
	[definition] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[diagram_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UK_principal_name] UNIQUE NONCLUSTERED 
(
	[principal_id] ASC,
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[System]    Script Date: 7/12/2019 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[System](
	[SystemId] [int] IDENTITY(1,1) NOT NULL,
	[AreaId] [int] NOT NULL,
	[CreatedLanguageId] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
	[Active] [varchar](1) NULL,
	[PlantAreaId] [int] NOT NULL,
 CONSTRAINT [System_pk] PRIMARY KEY CLUSTERED 
(
	[SystemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SystemTranslated]    Script Date: 7/12/2019 12:06:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemTranslated](
	[SystemTId] [int] IDENTITY(1,1) NOT NULL,
	[SystemId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[SystemName] [nvarchar](150) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Descriptions] [nvarchar](250) NULL,
 CONSTRAINT [SystemTranslated_pk] PRIMARY KEY CLUSTERED 
(
	[SystemTId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Taxonomy]    Script Date: 7/12/2019 12:06:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Taxonomy](
	[TaxonomyId] [int] IDENTITY(1,1) NOT NULL,
	[TaxonomyCode] [varchar](25) NOT NULL,
	[IndustryId] [int] NOT NULL,
	[AssetTypeId] [int] NOT NULL,
	[FailureModeId] [int] NULL,
	[FailureCauseId] [int] NULL,
	[MTTR] [decimal](10, 2) NULL,
	[MTBF] [decimal](10, 2) NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
	[Active] [varchar](1) NULL,
	[SectorId] [int] NULL,
	[SegmentId] [int] NULL,
	[MTTROld] [decimal](10, 2) NULL,
	[MTBFOld] [decimal](10, 2) NULL,
	[AssetCategoryId] [int] NOT NULL,
	[AssetClassId] [int] NOT NULL,
	[AssetSequenceId] [int] NOT NULL,
	[AssetClassTypeCode] [varchar](50) NOT NULL,
	[TaxonomyType] [varchar](1) NOT NULL,
 CONSTRAINT [Taxonomy_pk] PRIMARY KEY CLUSTERED 
(
	[TaxonomyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [Taxonomy_UK] UNIQUE NONCLUSTERED 
(
	[IndustryId] ASC,
	[AssetCategoryId] ASC,
	[AssetClassId] ASC,
	[AssetTypeId] ASC,
	[AssetSequenceId] ASC,
	[FailureModeId] ASC,
	[FailureCauseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TechUpgrade]    Script Date: 7/12/2019 12:06:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TechUpgrade](
	[TechUpgradeId] [bigint] IDENTITY(1,1) NOT NULL,
	[ClientSiteId] [int] NOT NULL,
	[ReportDate] [date] NULL,
	[RecommendationDate] [date] NULL,
	[EquipmentId] [int] NOT NULL,
	[Saving] [decimal](20, 4) NULL,
	[Recommendation] [nvarchar](1500) NULL,
	[Remarks] [nvarchar](1500) NULL,
	[FileName] [varchar](150) NULL,
	[LogicalName] [varchar](150) NULL,
	[PhysicalPath] [varchar](250) NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
	[Active] [varchar](1) NULL,
 CONSTRAINT [TechUpgrade_pk] PRIMARY KEY CLUSTERED 
(
	[TechUpgradeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserDashboard]    Script Date: 7/12/2019 12:06:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserDashboard](
	[UserDashboardId] [int] IDENTITY(1,1) NOT NULL,
	[WidgetId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[XAxis] [int] NOT NULL,
	[YAxis] [int] NOT NULL,
	[WRow] [int] NOT NULL,
	[WColumn] [int] NOT NULL,
	[DataViewPrefId] [int] NULL,
	[Param1] [nvarchar](75) NULL,
	[Param2] [nvarchar](75) NULL,
	[Param3] [nvarchar](75) NULL,
	[Param4] [nvarchar](75) NULL,
	[Param5] [nvarchar](75) NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Active] [varchar](1) NOT NULL,
 CONSTRAINT [PK_UserDashboard] PRIMARY KEY CLUSTERED 
(
	[UserDashboardId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoleGroupRelation]    Script Date: 7/12/2019 12:06:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoleGroupRelation](
	[UserRoleGroupRelId] [bigint] IDENTITY(1,1) NOT NULL,
	[RoleGroupId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[Active] [varchar](2) NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [date] NOT NULL,
 CONSTRAINT [PK_UserRoleGroupRelId] PRIMARY KEY CLUSTERED 
(
	[UserRoleGroupRelId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkFlow]    Script Date: 7/12/2019 12:06:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkFlow](
	[WorkFlowId] [int] IDENTITY(1,1) NOT NULL,
	[WorkFlowCode] [varchar](5) NOT NULL,
	[WorkFlowName] [nvarchar](100) NOT NULL,
	[Descriptions] [nvarchar](250) NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
 CONSTRAINT [WorkFlow_pk] PRIMARY KEY CLUSTERED 
(
	[WorkFlowId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_WorkFlowCode] UNIQUE NONCLUSTERED 
(
	[WorkFlowCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_WorkFlowName] UNIQUE NONCLUSTERED 
(
	[WorkFlowName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkFlowDetail]    Script Date: 7/12/2019 12:06:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkFlowDetail](
	[WorkFlowDetailId] [int] IDENTITY(1,1) NOT NULL,
	[WorkFlowId] [int] NOT NULL,
	[CurrentStatusId] [int] NOT NULL,
	[AvailableStatusId] [int] NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
 CONSTRAINT [WorkFlowDetail_pk] PRIMARY KEY CLUSTERED 
(
	[WorkFlowDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkNotificationAttachment]    Script Date: 7/12/2019 12:06:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkNotificationAttachment](
	[WNAttachmentId] [int] IDENTITY(1,1) NOT NULL,
	[WNEquipmentId] [int] NOT NULL,
	[FileName] [varchar](150) NOT NULL,
	[LogicalName] [varchar](150) NOT NULL,
	[PhysicalPath] [varchar](250) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
	[Active] [varchar](1) NULL,
 CONSTRAINT [WNAttachment_pk] PRIMARY KEY CLUSTERED 
(
	[WNAttachmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkNotificationEquipment]    Script Date: 7/12/2019 12:06:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkNotificationEquipment](
	[WNEquipmentId] [bigint] IDENTITY(1,1) NOT NULL,
	[WorkNotificationNumber] [nvarchar](100) NOT NULL,
	[ClientSiteId] [int] NOT NULL,
	[JobId] [bigint] NOT NULL,
	[EquipmentId] [int] NOT NULL,
	[ConditionId] [int] NULL,
	[Comment] [nvarchar](max) NULL,
	[DataCollectionDate] [date] NULL,
	[RiAmperage] [decimal](10, 2) NULL,
	[RiskAvoidanceRevenue] [decimal](10, 2) NULL,
	[RiskAvoidanceHours] [decimal](10, 2) NULL,
	[TrueSavings] [decimal](10, 2) NULL,
	[EnergySavings] [decimal](10, 2) NULL,
	[IsAccurate] [bit] NULL,
	[StatusId] [int] NOT NULL,
	[WNDoneBy] [int] NULL,
	[WNCompletionDate] [date] NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[EquipmentName] [nvarchar](250) NULL,
	[WorkNotificationDate] [date] NULL,
	[Feedback] [nvarchar](2500) NULL,
	[MeanRepairManHours] [decimal](15, 2) NULL,
	[DownTimeCostPerHour] [decimal](15, 2) NULL,
	[CostToRepair] [decimal](15, 2) NULL,
	[TotalCost] [decimal](15, 2) NULL,
 CONSTRAINT [WorkNotificationEquipment_pk] PRIMARY KEY CLUSTERED 
(
	[WNEquipmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_WNEquipment] UNIQUE NONCLUSTERED 
(
	[JobId] ASC,
	[EquipmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkNotificationOpportunity]    Script Date: 7/12/2019 12:06:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkNotificationOpportunity](
	[WNOpportunityId] [bigint] IDENTITY(1,1) NOT NULL,
	[WNEquipmentId] [bigint] NOT NULL,
	[WorkNotificationNumber] [nvarchar](100) NOT NULL,
	[ActualOutageHours] [decimal](4, 2) NULL,
	[ActualRepairCost] [decimal](10, 2) NULL,
	[TrueSavings] [decimal](10, 2) NULL,
	[FailureModeId] [int] NULL,
	[FailureCauseId] [int] NULL,
	[ActionDoneBy] [int] NULL,
	[Active] [varchar](1) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
	[EquipmentId] [int] NOT NULL,
 CONSTRAINT [WNOpportunity_pk] PRIMARY KEY CLUSTERED 
(
	[WNOpportunityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_WNOpportunity] UNIQUE NONCLUSTERED 
(
	[WNEquipmentId] ASC,
	[WNOpportunityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkNotificationUnits]    Script Date: 7/12/2019 12:06:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkNotificationUnits](
	[WNUnitAnalysisId] [bigint] IDENTITY(1,1) NOT NULL,
	[WNEquipmentId] [bigint] NOT NULL,
	[UnitType] [varchar](3) NOT NULL,
	[UnitId] [int] NOT NULL,
	[TaxonomyId] [int] NOT NULL,
	[MeanRepairManHours] [decimal](10, 2) NULL,
	[DownTimeCostPerHour] [decimal](10, 2) NULL,
	[CostToRepair] [decimal](10, 2) NULL,
	[ConditionId] [int] NULL,
	[ConfidentFactorId] [int] NULL,
	[FailureProbFactorId] [int] NULL,
	[PriorityId] [int] NULL,
	[NoOfDays] [decimal](4, 2) NULL,
	[Recommendation] [nvarchar](max) NULL,
	[Comment] [nvarchar](max) NULL,
	[ActualRepairCost] [decimal](15, 4) NULL,
	[ActualOutageHours] [decimal](15, 4) NULL,
	[StatusId] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Createdon] [datetime] NOT NULL,
	[Active] [varchar](1) NOT NULL,
	[AssetName] [nvarchar](250) NULL,
	[IndicatedFault] [nvarchar](max) NULL,
	[CancelRemarks] [nvarchar](max) NULL,
 CONSTRAINT [WNUnitAnalysis_pk] PRIMARY KEY CLUSTERED 
(
	[WNUnitAnalysisId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_WNUnitAnalysis] UNIQUE NONCLUSTERED 
(
	[WNEquipmentId] ASC,
	[UnitType] ASC,
	[UnitId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ZMig_AssetMapping]    Script Date: 7/12/2019 12:06:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ZMig_AssetMapping](
	[AssetMappingId] [bigint] IDENTITY(1,1) NOT NULL,
	[v7UnitType] [varchar](30) NULL,
	[v7UnitId] [bigint] NULL,
	[v6UnitId] [bigint] NULL,
	[v7ClientSiteId] [int] NULL,
	[v7PlantAreaId] [int] NULL,
	[v7EquipmentId] [int] NULL,
	[v7ClientName] [varchar](150) NULL,
	[v7PlantName] [varchar](150) NULL,
	[v7EquipmentName] [varchar](150) NULL,
	[v7UnitName] [varchar](150) NULL,
	[v6ClientName] [varchar](150) NULL,
	[v6PlantName] [varchar](150) NULL,
	[v6EquipmentName] [varchar](150) NULL,
	[v6UnitName] [varchar](150) NULL,
	[v6TaxonomyId] [varchar](150) NULL,
	[v7TaxonomyId] [bigint] NULL,
	[v7IndustryId] [int] NULL,
	[v6AssetClassTypeCode] [varchar](30) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ZMig_AssetMapping_FromExcel]    Script Date: 7/12/2019 12:06:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ZMig_AssetMapping_FromExcel](
	[AssetMappingId] [bigint] IDENTITY(1,1) NOT NULL,
	[UnitType] [varchar](30) NULL,
	[v7UnitId] [bigint] NULL,
	[v6UnitId] [bigint] NULL,
	[v7ClientSiteId] [int] NULL,
	[v7PlantAreaId] [int] NULL,
	[v7EquipmentId] [int] NULL,
	[v7ClientName] [varchar](150) NULL,
	[v7PlantName] [varchar](150) NULL,
	[v7EquipmentName] [varchar](150) NULL,
	[v7UnitName] [varchar](150) NULL,
	[v6ClientName] [varchar](150) NULL,
	[v6PlantName] [varchar](150) NULL,
	[v6EquipmentName] [varchar](150) NULL,
	[v6UnitName] [varchar](150) NULL,
	[v6TaxonomyId] [varchar](150) NULL,
	[v7TaxonomyId] [bigint] NULL,
	[v7IndustryId] [int] NULL,
	[v6AssetClassTypeCode] [varchar](30) NULL,
	[MatchDone] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ZMig_Client_IndustryMapping]    Script Date: 7/12/2019 12:06:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ZMig_Client_IndustryMapping](
	[ClientIndustryMappingId] [int] IDENTITY(1,1) NOT NULL,
	[ClientV6] [varchar](150) NULL,
	[v7SectorId] [int] NULL,
	[SectorCode] [varchar](50) NULL,
	[v7SectorCode] [varchar](50) NULL,
	[SectorName] [varchar](150) NULL,
	[v7SectorName] [varchar](150) NULL,
	[v7SegmentId] [int] NULL,
	[SegmentCode] [varchar](50) NULL,
	[v7SegmentCode] [varchar](50) NULL,
	[SegmentName] [varchar](150) NULL,
	[v7SegmentName] [varchar](150) NULL,
	[v7IndustryId] [int] NULL,
	[IndustryCode] [varchar](50) NULL,
	[IndustryName] [varchar](150) NULL,
	[v7IndustryCode] [varchar](50) NULL,
	[v7IndustryName] [varchar](150) NULL,
	[v6ClientStatus] [int] NULL,
	[MigrationDone] [int] NULL,
	[Plantmigrationdone] [int] NOT NULL,
	[EquipmentMigrationDone] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ZMig_Client_IndustryMappingTmp]    Script Date: 7/12/2019 12:06:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ZMig_Client_IndustryMappingTmp](
	[ClientIndustryMappingId] [int] IDENTITY(1,1) NOT NULL,
	[ClientV6] [varchar](150) NULL,
	[SectorCode] [varchar](50) NULL,
	[SegmentCode] [varchar](50) NULL,
	[IndustryCode] [varchar](50) NULL,
	[SectorName] [varchar](150) NULL,
	[SegmentName] [varchar](150) NULL,
	[IndustryName] [varchar](150) NULL,
	[v7SectorId] [int] NULL,
	[v7SegmentId] [int] NULL,
	[v7IndustryId] [int] NULL,
	[v7SectorCode] [varchar](50) NULL,
	[v7SegmentCode] [varchar](50) NULL,
	[v7IndustryCode] [varchar](50) NULL,
	[v7SectorName] [varchar](150) NULL,
	[v7SegmentName] [varchar](150) NULL,
	[v7IndustryName] [varchar](150) NULL
) ON [PRIMARY]
GO
/****** Object:  Index [IdxBearingLanguage]    Script Date: 7/12/2019 12:06:52 PM ******/
CREATE NONCLUSTERED INDEX [IdxBearingLanguage] ON [dbo].[BearingTranslated]
(
	[BearingId] ASC,
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IdxConditionLanguageId]    Script Date: 7/12/2019 12:06:52 PM ******/
CREATE NONCLUSTERED INDEX [IdxConditionLanguageId] ON [dbo].[ConditionCodeClientTranslated]
(
	[CMappingId] ASC
)
INCLUDE ( 	[LanguageId],
	[ConditionName],
	[Descriptions]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IdxConditionId]    Script Date: 7/12/2019 12:06:52 PM ******/
CREATE NONCLUSTERED INDEX [IdxConditionId] ON [dbo].[JobEquipment]
(
	[ConditionId] ASC
)
INCLUDE ( 	[JobId],
	[EquipmentId]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IdxEquipmentServiceId]    Script Date: 7/12/2019 12:06:53 PM ******/
CREATE NONCLUSTERED INDEX [IdxEquipmentServiceId] ON [dbo].[JobEquipment]
(
	[EquipmentId] ASC,
	[ServiceId] ASC,
	[ReportDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IdxUnitService]    Script Date: 7/12/2019 12:06:53 PM ******/
CREATE NONCLUSTERED INDEX [IdxUnitService] ON [dbo].[JobEquipUnitAnalysis]
(
	[ServiceId] ASC,
	[UnitType] ASC,
	[UnitId] ASC
)
INCLUDE ( 	[JobEquipmentId],
	[ConditionId]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IdxJEUSIndicatedFaultId]    Script Date: 7/12/2019 12:06:53 PM ******/
CREATE NONCLUSTERED INDEX [IdxJEUSIndicatedFaultId] ON [dbo].[JobEquipUnitSymptoms]
(
	[IndicatedFaultId] ASC
)
INCLUDE ( 	[UnitAnalysisId]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IdxClientSiteStatusId]    Script Date: 7/12/2019 12:06:53 PM ******/
CREATE NONCLUSTERED INDEX [IdxClientSiteStatusId] ON [dbo].[Jobs]
(
	[ClientSiteId] ASC,
	[StatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IdxJobId]    Script Date: 7/12/2019 12:06:53 PM ******/
CREATE NONCLUSTERED INDEX [IdxJobId] ON [dbo].[JobServices]
(
	[JobId] ASC,
	[Active] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IdxLanguageTranslated]    Script Date: 7/12/2019 12:06:53 PM ******/
CREATE NONCLUSTERED INDEX [IdxLanguageTranslated] ON [dbo].[LookupTranslated]
(
	[LookupId] ASC,
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IdxAnalystPerforClient]    Script Date: 7/12/2019 12:06:53 PM ******/
CREATE NONCLUSTERED INDEX [IdxAnalystPerforClient] ON [dbo].[RptAnalystPerformance]
(
	[ClientSiteId] ASC,
	[ReportDate] ASC
)
INCLUDE ( 	[CountryId],
	[CostCentreId],
	[SectorId],
	[SegmentId],
	[IndustryId],
	[AnalystId],
	[AnalystName],
	[TypeId],
	[ActivityType],
	[TypeName],
	[ActivityCount],
	[CountryName],
	[CostCentreName],
	[SectorName],
	[SegmentName],
	[Industryname],
	[ClientSiteName]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IdxBearingListClientSite]    Script Date: 7/12/2019 12:06:53 PM ******/
CREATE NONCLUSTERED INDEX [IdxBearingListClientSite] ON [dbo].[RptBearingList]
(
	[ClientSiteId] ASC
)
INCLUDE ( 	[PlantAreaId],
	[PlantAreaName],
	[AssetType],
	[ManufacturerId],
	[ManufacturerName],
	[BearingCount],
	[UnitManufacturerId],
	[UnitManufacturerName],
	[AssetCount],
	[ClientSiteName],
	[CountryId],
	[CostCentreId],
	[SectorId],
	[SegmentId],
	[IndustryId],
	[CountryName],
	[CostCentreName],
	[SectorName],
	[SegmentName],
	[IndustryName],
	[EquipmentCount]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [NonClusteredIndex-20190620-155708]    Script Date: 7/12/2019 12:06:53 PM ******/
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20190620-155708] ON [dbo].[RptClientList]
(
	[ClientSiteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IdxRptContractPerformanceClientSite]    Script Date: 7/12/2019 12:06:53 PM ******/
CREATE NONCLUSTERED INDEX [IdxRptContractPerformanceClientSite] ON [dbo].[RptContractPerformance]
(
	[ClientSiteId] ASC,
	[RDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IdxEquipHealthClientSite]    Script Date: 7/12/2019 12:06:53 PM ******/
CREATE NONCLUSTERED INDEX [IdxEquipHealthClientSite] ON [dbo].[RptEquipmentHealthStatus]
(
	[ClientSiteId] ASC
)
INCLUDE ( 	[CountryId],
	[SectorId],
	[segmentId],
	[IndustryId],
	[CostCentreId],
	[PlantAreaId],
	[ServiceId],
	[ConditionId],
	[CountryName],
	[CostCentreName],
	[SectorName],
	[SegmentName],
	[IndustryName],
	[ClientSiteName],
	[PlantAreaName],
	[ServiceType],
	[ConditionCode],
	[ConditionName],
	[EventCount],
	[EquipmentCount],
	[JobPeriod]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IdxFailureCauseClientReportDate]    Script Date: 7/12/2019 12:06:53 PM ******/
CREATE NONCLUSTERED INDEX [IdxFailureCauseClientReportDate] ON [dbo].[RptFailureCauseStatistics]
(
	[ClientSiteId] ASC,
	[ReportDate] ASC
)
INCLUDE ( 	[CountryId],
	[CostCentreId],
	[SectorId],
	[SegmentId],
	[IndustryId],
	[CountryName],
	[CostCentreName],
	[ClientSiteName],
	[SectorName],
	[SegmentName],
	[IndustryName],
	[PlantAreaId],
	[UnitType],
	[FailureCauseId],
	[Consequence],
	[PlantAreaName],
	[FailureCause],
	[ReportType],
	[EventCount]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IdxJobAssetClientSiteId]    Script Date: 7/12/2019 12:06:53 PM ******/
CREATE NONCLUSTERED INDEX [IdxJobAssetClientSiteId] ON [dbo].[RptJobAssetHealthStatus]
(
	[ClientSiteId] ASC
)
INCLUDE ( 	[CountryId],
	[SectorId],
	[segmentId],
	[IndustryId],
	[CostCentreId],
	[PlantAreaId],
	[UnitType],
	[ManufacturerId],
	[ServiceId],
	[ConditionId],
	[CountryName],
	[CostCentreName],
	[SectorName],
	[SegmentName],
	[IndustryName],
	[ClientSiteName],
	[PlantAreaName],
	[ManufacturerName],
	[ServiceType],
	[ConditionName],
	[JobPeriod],
	[EventCount]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IdxJobEquipHealthClients]    Script Date: 7/12/2019 12:06:53 PM ******/
CREATE NONCLUSTERED INDEX [IdxJobEquipHealthClients] ON [dbo].[RptJobEquipHealthStatus]
(
	[ClientSiteId] ASC,
	[EstStartDate] ASC
)
INCLUDE ( 	[JobId],
	[JobType],
	[CountryId],
	[CostCentreId],
	[SectorId],
	[segmentId],
	[IndustryId],
	[PlantAreaId],
	[ServiceId],
	[ConditionId],
	[DataCollectorId],
	[AnalystId],
	[ReviewerId],
	[CountryName],
	[CostCentreName],
	[SectorName],
	[SegmentName],
	[IndustryName],
	[ClientSiteName],
	[PlantAreaName],
	[ServiceType],
	[ConditionCode],
	[ConditionName],
	[DataCollectorName],
	[AnalystName],
	[ReviewerName],
	[EquipmentCount]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IdxJobEquipId]    Script Date: 7/12/2019 12:06:53 PM ******/
CREATE NONCLUSTERED INDEX [IdxJobEquipId] ON [dbo].[RptJobEquipList]
(
	[ClientSiteId] ASC,
	[EstStartDate] ASC
)
INCLUDE ( 	[JobId],
	[CountryId],
	[CostCentreId],
	[SectorId],
	[segmentId],
	[IndustryId],
	[PlantAreaId],
	[ServiceId],
	[DataCollectorId],
	[AnalystId],
	[ReviewerId],
	[CountryName],
	[CostCentreName],
	[SectorName],
	[SegmentName],
	[IndustryName],
	[ClientSiteName],
	[PlantAreaName],
	[ServiceType],
	[DataCollectorName],
	[AnalystName],
	[ReviewerName],
	[EquipmentCount]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IdxJobClientSite]    Script Date: 7/12/2019 12:06:53 PM ******/
CREATE NONCLUSTERED INDEX [IdxJobClientSite] ON [dbo].[RptJobList]
(
	[ClientSiteId] ASC,
	[EstStartDate] ASC
)
INCLUDE ( 	[JobId],
	[Jobtype],
	[ReportSent],
	[StatusName]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IdsWNClientSite]    Script Date: 7/12/2019 12:06:53 PM ******/
CREATE NONCLUSTERED INDEX [IdsWNClientSite] ON [dbo].[RptWorkNotification]
(
	[ClientSiteId] ASC
)
INCLUDE ( 	[CountryId],
	[CostCentreId],
	[SectorId],
	[segmentId],
	[IndustryId],
	[PlantAreaId],
	[CountryName],
	[CostCentreName],
	[SectorName],
	[SegmentName],
	[IndustryName],
	[ClientSiteName],
	[PlantAreaName],
	[WorkNotificationDate],
	[TotalJobs],
	[TotalWN],
	[OpenWN],
	[CancelledWN],
	[ClosedWN],
	[TotalAssets],
	[TotalFailureReported],
	[TT],
	[TF],
	[FT],
	[FF]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IdxSector]    Script Date: 7/12/2019 12:06:53 PM ******/
CREATE NONCLUSTERED INDEX [IdxSector] ON [dbo].[Taxonomy]
(
	[SectorId] ASC
)
INCLUDE ( 	[TaxonomyCode],
	[IndustryId],
	[AssetTypeId],
	[FailureModeId],
	[FailureCauseId],
	[MTTR],
	[MTBF],
	[Active],
	[SegmentId],
	[MTTROld],
	[MTBFOld],
	[AssetCategoryId],
	[AssetClassId],
	[AssetSequenceId],
	[AssetClassTypeCode]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ApplicationConfiguration] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[ApplicationConfiguration] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[Area] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[Area] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[AreaTranslated] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[AssetCategory] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[AssetCategory] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[AssetCategoryClassRelation] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[AssetCategoryClassRelation] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[AssetCategoryTranslated] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[AssetClass] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[AssetClass] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[AssetClassIndustryRelation] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[AssetClassIndustryRelation] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[AssetClassTranslated] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[AssetSequence] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[AssetSequence] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[AssetSequenceTranslated] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[AssetType] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[AssetType] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[AssetTypeClassRelation] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[AssetTypeClassRelation] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[AssetTypeTranslated] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[AuditLogDetail] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[AuditLogHeader] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[Bearings] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[Bearings] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[BearingTranslated] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[Client] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[ClientDocAttachment] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[ClientDocAttachment] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[ClientSite] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[ClientSite] ADD  DEFAULT ((0)) FOR [PMPOfflineProgram]
GO
ALTER TABLE [dbo].[ClientSite] ADD  DEFAULT ((0)) FOR [PMPOnlineProgram]
GO
ALTER TABLE [dbo].[ClientSite] ADD  DEFAULT ((0)) FOR [SmartSupplierProgram]
GO
ALTER TABLE [dbo].[ClientSite] ADD  DEFAULT ((0)) FOR [ExcludeInDashboard]
GO
ALTER TABLE [dbo].[ClientSite] ADD  DEFAULT ((0)) FOR [CertifiedMaintenancePartner]
GO
ALTER TABLE [dbo].[ClientSite] ADD  DEFAULT ((0)) FOR [ProactiveReliabilityMaintenance]
GO
ALTER TABLE [dbo].[ClientSiteConfiguration] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[ClientSiteTranslated] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[ClientTranslated] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[CMSSetup] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[CMSSetup] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[ConditionCodeClientMapping] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[ConditionCodeClientMapping] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[ConditionCodeClientTranslated] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[CostCentre] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[CostCentre] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[CostCentreTranslated] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[Country] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[Country] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[CountryTranslated] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[DriveAttachments] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[DriveAttachments] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[DriveBearing] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[DriveBearing] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[DrivenAttachments] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[DrivenAttachments] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[DrivenBearing] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[DrivenBearing] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[DrivenServices] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[DrivenServices] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[DriveServices] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[DriveServices] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[Equipment] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[Equipment] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[EquipmentAttachments] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[EquipmentAttachments] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[EquipmentDrivenUnit] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[EquipmentDrivenUnit] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[EquipmentDriveUnit] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[EquipmentDriveUnit] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[EquipmentIntermediateUnit] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[EquipmentIntermediateUnit] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[FailureCause] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[FailureCause] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[FailureCauseModeRelation] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[FailureCauseModeRelation] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[FailureCauseTranslated] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[FailureMode] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[FailureMode] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[FailureModeAssetClassRelation] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[FailureModeAssetClassRelation] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[FailureModeTranslated] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[FailureReportAttachment] ADD  DEFAULT ('N') FOR [Active]
GO
ALTER TABLE [dbo].[FailureReportAttachment] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[FailureReportDetail] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[FailureReportHeader] ADD  DEFAULT ('N') FOR [Active]
GO
ALTER TABLE [dbo].[FailureReportHeader] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[Industry] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[Industry] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[Industry] ADD  DEFAULT ('5000') FOR [DownTimeCostPerHour]
GO
ALTER TABLE [dbo].[IndustryTranslated] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[IntermediateAttachments] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[IntermediateAttachments] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[IntermediateBearing] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[IntermediateBearing] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[IntermediateServices] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[IntermediateServices] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[JobComments] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[JobComments] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[JobEquipment] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[JobEquipment] ADD  DEFAULT ('N') FOR [Active]
GO
ALTER TABLE [dbo].[JobEquipment] ADD  DEFAULT ((0)) FOR [DataCollectionDone]
GO
ALTER TABLE [dbo].[JobEquipment] ADD  DEFAULT ((0)) FOR [ReviewDone]
GO
ALTER TABLE [dbo].[JobEquipment] ADD  DEFAULT ((0)) FOR [ReportSent]
GO
ALTER TABLE [dbo].[JobEquipmentComments] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[JobEquipmentComments] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[JobEquipmentOilProperties] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[JobEquipmentOilProperties] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[JobEquipmentUnitAnalysisComments] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[JobEquipmentUnitAnalysisComments] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[JobEquipUnitAmplitude] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[JobEquipUnitAmplitude] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[JobEquipUnitAnalysis] ADD  DEFAULT ('N') FOR [IsWorkNotification]
GO
ALTER TABLE [dbo].[JobEquipUnitAnalysis] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[JobEquipUnitAnalysis] ADD  DEFAULT ((0)) FOR [DataValidationStatus]
GO
ALTER TABLE [dbo].[JobEquipUnitAnalysisAttachments] ADD  DEFAULT ('N') FOR [Active]
GO
ALTER TABLE [dbo].[JobEquipUnitAnalysisAttachments] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[JobEquipUnitSymptoms] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[JobEquipUnitSymptoms] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[Jobs] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[Jobs] ADD  DEFAULT ((0)) FOR [DataCollectionMode]
GO
ALTER TABLE [dbo].[Jobs] ADD  DEFAULT ('N') FOR [DataCollectionDone]
GO
ALTER TABLE [dbo].[Jobs] ADD  DEFAULT ((0)) FOR [ReportSent]
GO
ALTER TABLE [dbo].[JobServices] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[JobServices] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[Languages] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[Languages] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[LeverageExport] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[LeverageService] ADD  DEFAULT (getdate()) FOR [LeverageDate]
GO
ALTER TABLE [dbo].[LeverageService] ADD  DEFAULT ('N') FOR [Active]
GO
ALTER TABLE [dbo].[LeverageService] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[Lookups] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[Lookups] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[LookupTranslated] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[Manufacturer] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[Manufacturer] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[ManufacturerTranslated] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[OtherReportsAttachment] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[OtherReportsAttachment] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[PlantArea] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[PlantArea] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[PlantAreaTranslated] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[Privileges] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[Privileges] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[ProgramPrivilegeRelation] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[ProgramPrivilegeRelation] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[Programs] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[Programs] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[Programs] ADD  DEFAULT ('N') FOR [Internal]
GO
ALTER TABLE [dbo].[ProgramTranslated] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[RoleGroup] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[RoleGroup] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[RoleGroupRoleRelation] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[RoleGroupRoleRelation] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[RoleGroupTranslated] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[RolePrgPrivilegeRelation] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[RolePrgPrivilegeRelation] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[RolePrgPrivilegeRelation] ADD  DEFAULT ('N') FOR [HideProgram]
GO
ALTER TABLE [dbo].[Roles] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[Roles] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[RoleWorkFlowRelation] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[RoleWorkFlowRelation] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[RptAnalystPerformance] ADD  DEFAULT (getdate()) FOR [CreateOn]
GO
ALTER TABLE [dbo].[RptClientList] ADD  DEFAULT ((0)) FOR [PMPOfflineProgram]
GO
ALTER TABLE [dbo].[RptClientList] ADD  DEFAULT ((0)) FOR [PMPOnlineProgram]
GO
ALTER TABLE [dbo].[RptClientList] ADD  DEFAULT ((0)) FOR [SmartSupplierProgram]
GO
ALTER TABLE [dbo].[RptEquipmentHealthStatus] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[RptFailureCauseStatistics] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[RptJobAssetHealthStatus] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[RptJobEquipHealthStatus] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[RptJobEquipList] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[RptJobList] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[RptWorkNotification] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[ScheduleEquipments] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[ScheduleEquipments] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[ScheduleServices] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[ScheduleServices] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[ScheduleSetup] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[Sector] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[Sector] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[SectorTranslated] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[Segment] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[Segment] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[SegmentTranslated] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[System] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[System] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[SystemTranslated] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[Taxonomy] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[Taxonomy] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[Taxonomy] ADD  DEFAULT ('N') FOR [TaxonomyType]
GO
ALTER TABLE [dbo].[TechUpgrade] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[TechUpgrade] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[UserClientRelation] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[UserClientRelation] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[UserClientSiteRelation] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[UserClientSiteRelation] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[UserCostCentreRelation] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[UserCostCentreRelation] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[UserCountryRelation] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[UserCountryRelation] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[UserDashboard] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[UserDashboard] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[UserRoleGroupRelation] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[UserRoleGroupRelation] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ('N') FOR [Active]
GO
ALTER TABLE [dbo].[WorkFlow] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[WorkFlow] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[WorkFlowDetail] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[WorkFlowDetail] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[WorkNotificationAttachment] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[WorkNotificationAttachment] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[WorkNotificationEquipment] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[WorkNotificationEquipment] ADD  DEFAULT ('N') FOR [Active]
GO
ALTER TABLE [dbo].[WorkNotificationOpportunity] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[WorkNotificationOpportunity] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[WorkNotificationUnits] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[WorkNotificationUnits] ADD  DEFAULT ('N') FOR [Active]
GO
ALTER TABLE [dbo].[ZMig_Client_IndustryMapping] ADD  DEFAULT ((0)) FOR [Plantmigrationdone]
GO
ALTER TABLE [dbo].[ZMig_Client_IndustryMapping] ADD  DEFAULT ((0)) FOR [EquipmentMigrationDone]
GO
ALTER TABLE [dbo].[ApplicationConfiguration]  WITH NOCHECK ADD  CONSTRAINT [AppConfig_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[ApplicationConfiguration] CHECK CONSTRAINT [AppConfig_Users]
GO
ALTER TABLE [dbo].[Area]  WITH CHECK ADD  CONSTRAINT [Area_PlantArea] FOREIGN KEY([PlantAreaId])
REFERENCES [dbo].[PlantArea] ([PlantAreaId])
GO
ALTER TABLE [dbo].[Area] CHECK CONSTRAINT [Area_PlantArea]
GO
ALTER TABLE [dbo].[Area]  WITH CHECK ADD  CONSTRAINT [Area_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Area] CHECK CONSTRAINT [Area_Users]
GO
ALTER TABLE [dbo].[AreaTranslated]  WITH CHECK ADD  CONSTRAINT [AreaTranslated_Area] FOREIGN KEY([AreaId])
REFERENCES [dbo].[Area] ([AreaId])
GO
ALTER TABLE [dbo].[AreaTranslated] CHECK CONSTRAINT [AreaTranslated_Area]
GO
ALTER TABLE [dbo].[AreaTranslated]  WITH CHECK ADD  CONSTRAINT [AreaTranslated_Language] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Languages] ([LanguageId])
GO
ALTER TABLE [dbo].[AreaTranslated] CHECK CONSTRAINT [AreaTranslated_Language]
GO
ALTER TABLE [dbo].[AreaTranslated]  WITH NOCHECK ADD  CONSTRAINT [AreaTranslated_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[AreaTranslated] CHECK CONSTRAINT [AreaTranslated_Users]
GO
ALTER TABLE [dbo].[AssetCategory]  WITH NOCHECK ADD  CONSTRAINT [AssetCategory_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[AssetCategory] CHECK CONSTRAINT [AssetCategory_Users]
GO
ALTER TABLE [dbo].[AssetCategoryClassRelation]  WITH CHECK ADD  CONSTRAINT [AssetCategoryClassRelation_AssetClass] FOREIGN KEY([AssetClassId])
REFERENCES [dbo].[AssetClass] ([AssetClassId])
GO
ALTER TABLE [dbo].[AssetCategoryClassRelation] CHECK CONSTRAINT [AssetCategoryClassRelation_AssetClass]
GO
ALTER TABLE [dbo].[AssetCategoryClassRelation]  WITH CHECK ADD  CONSTRAINT [AssetCategoryClassRelation_Category] FOREIGN KEY([AssetCategoryId])
REFERENCES [dbo].[AssetCategory] ([AssetCategoryId])
GO
ALTER TABLE [dbo].[AssetCategoryClassRelation] CHECK CONSTRAINT [AssetCategoryClassRelation_Category]
GO
ALTER TABLE [dbo].[AssetCategoryClassRelation]  WITH CHECK ADD  CONSTRAINT [AssetCategoryClassRelation_CreatedBy] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[AssetCategoryClassRelation] CHECK CONSTRAINT [AssetCategoryClassRelation_CreatedBy]
GO
ALTER TABLE [dbo].[AssetCategoryTranslated]  WITH CHECK ADD  CONSTRAINT [AssetCategoryTranslated_AssetCategory] FOREIGN KEY([AssetCategoryId])
REFERENCES [dbo].[AssetCategory] ([AssetCategoryId])
GO
ALTER TABLE [dbo].[AssetCategoryTranslated] CHECK CONSTRAINT [AssetCategoryTranslated_AssetCategory]
GO
ALTER TABLE [dbo].[AssetCategoryTranslated]  WITH CHECK ADD  CONSTRAINT [AssetCategoryTranslated_Language] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Languages] ([LanguageId])
GO
ALTER TABLE [dbo].[AssetCategoryTranslated] CHECK CONSTRAINT [AssetCategoryTranslated_Language]
GO
ALTER TABLE [dbo].[AssetCategoryTranslated]  WITH NOCHECK ADD  CONSTRAINT [AssetCategoryTranslated_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[AssetCategoryTranslated] CHECK CONSTRAINT [AssetCategoryTranslated_Users]
GO
ALTER TABLE [dbo].[AssetClass]  WITH NOCHECK ADD  CONSTRAINT [AssetClass_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[AssetClass] CHECK CONSTRAINT [AssetClass_Users]
GO
ALTER TABLE [dbo].[AssetClassIndustryRelation]  WITH CHECK ADD  CONSTRAINT [AssetClassIndustryRelation_AssetClass] FOREIGN KEY([AssetClassId])
REFERENCES [dbo].[AssetClass] ([AssetClassId])
GO
ALTER TABLE [dbo].[AssetClassIndustryRelation] CHECK CONSTRAINT [AssetClassIndustryRelation_AssetClass]
GO
ALTER TABLE [dbo].[AssetClassIndustryRelation]  WITH CHECK ADD  CONSTRAINT [AssetClassIndustryRelation_CreatedBy] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[AssetClassIndustryRelation] CHECK CONSTRAINT [AssetClassIndustryRelation_CreatedBy]
GO
ALTER TABLE [dbo].[AssetClassIndustryRelation]  WITH CHECK ADD  CONSTRAINT [AssetClassIndustryRelation_Industry] FOREIGN KEY([IndustryId])
REFERENCES [dbo].[Industry] ([IndustryId])
GO
ALTER TABLE [dbo].[AssetClassIndustryRelation] CHECK CONSTRAINT [AssetClassIndustryRelation_Industry]
GO
ALTER TABLE [dbo].[AssetClassTranslated]  WITH CHECK ADD  CONSTRAINT [AssetClassTranslated_AssetClass] FOREIGN KEY([AssetClassId])
REFERENCES [dbo].[AssetClass] ([AssetClassId])
GO
ALTER TABLE [dbo].[AssetClassTranslated] CHECK CONSTRAINT [AssetClassTranslated_AssetClass]
GO
ALTER TABLE [dbo].[AssetClassTranslated]  WITH CHECK ADD  CONSTRAINT [AssetClassTranslated_Language] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Languages] ([LanguageId])
GO
ALTER TABLE [dbo].[AssetClassTranslated] CHECK CONSTRAINT [AssetClassTranslated_Language]
GO
ALTER TABLE [dbo].[AssetClassTranslated]  WITH NOCHECK ADD  CONSTRAINT [AssetClassTranslated_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[AssetClassTranslated] CHECK CONSTRAINT [AssetClassTranslated_Users]
GO
ALTER TABLE [dbo].[AssetSequence]  WITH CHECK ADD  CONSTRAINT [AssetSequence_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[AssetSequence] CHECK CONSTRAINT [AssetSequence_Users]
GO
ALTER TABLE [dbo].[AssetSequenceTranslated]  WITH CHECK ADD  CONSTRAINT [AssetSequenceTranslated_AssetSequence] FOREIGN KEY([AssetSequenceId])
REFERENCES [dbo].[AssetSequence] ([AssetSequenceId])
GO
ALTER TABLE [dbo].[AssetSequenceTranslated] CHECK CONSTRAINT [AssetSequenceTranslated_AssetSequence]
GO
ALTER TABLE [dbo].[AssetSequenceTranslated]  WITH CHECK ADD  CONSTRAINT [AssetSequenceTranslated_Language] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Languages] ([LanguageId])
GO
ALTER TABLE [dbo].[AssetSequenceTranslated] CHECK CONSTRAINT [AssetSequenceTranslated_Language]
GO
ALTER TABLE [dbo].[AssetSequenceTranslated]  WITH NOCHECK ADD  CONSTRAINT [AssetSequenceTranslated_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[AssetSequenceTranslated] CHECK CONSTRAINT [AssetSequenceTranslated_Users]
GO
ALTER TABLE [dbo].[AssetType]  WITH NOCHECK ADD  CONSTRAINT [AssetType_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[AssetType] CHECK CONSTRAINT [AssetType_Users]
GO
ALTER TABLE [dbo].[AssetTypeClassRelation]  WITH CHECK ADD  CONSTRAINT [AssetTypeClassRelation_AssetClass] FOREIGN KEY([AssetClassId])
REFERENCES [dbo].[AssetClass] ([AssetClassId])
GO
ALTER TABLE [dbo].[AssetTypeClassRelation] CHECK CONSTRAINT [AssetTypeClassRelation_AssetClass]
GO
ALTER TABLE [dbo].[AssetTypeClassRelation]  WITH CHECK ADD  CONSTRAINT [AssetTypeClassRelation_AssetType] FOREIGN KEY([AssetTypeId])
REFERENCES [dbo].[AssetType] ([AssetTypeId])
GO
ALTER TABLE [dbo].[AssetTypeClassRelation] CHECK CONSTRAINT [AssetTypeClassRelation_AssetType]
GO
ALTER TABLE [dbo].[AssetTypeClassRelation]  WITH CHECK ADD  CONSTRAINT [AssetTypeClassRelation_CreatedBy] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[AssetTypeClassRelation] CHECK CONSTRAINT [AssetTypeClassRelation_CreatedBy]
GO
ALTER TABLE [dbo].[AssetTypeTranslated]  WITH CHECK ADD  CONSTRAINT [AssetTypeTranslated_AssetType] FOREIGN KEY([AssetTypeId])
REFERENCES [dbo].[AssetType] ([AssetTypeId])
GO
ALTER TABLE [dbo].[AssetTypeTranslated] CHECK CONSTRAINT [AssetTypeTranslated_AssetType]
GO
ALTER TABLE [dbo].[AssetTypeTranslated]  WITH CHECK ADD  CONSTRAINT [AssetTypeTranslated_Language] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Languages] ([LanguageId])
GO
ALTER TABLE [dbo].[AssetTypeTranslated] CHECK CONSTRAINT [AssetTypeTranslated_Language]
GO
ALTER TABLE [dbo].[AssetTypeTranslated]  WITH NOCHECK ADD  CONSTRAINT [AssetTypeTranslated_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[AssetTypeTranslated] CHECK CONSTRAINT [AssetTypeTranslated_Users]
GO
ALTER TABLE [dbo].[AuditLogDetail]  WITH CHECK ADD FOREIGN KEY([AuditLogHeaderId])
REFERENCES [dbo].[AuditLogHeader] ([AuditLogHeaderId])
GO
ALTER TABLE [dbo].[AuditLogDetail]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[AuditLogHeader]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Bearings]  WITH NOCHECK ADD  CONSTRAINT [Bearings_Manufacturer] FOREIGN KEY([ManufacturerId])
REFERENCES [dbo].[Manufacturer] ([ManufacturerId])
GO
ALTER TABLE [dbo].[Bearings] CHECK CONSTRAINT [Bearings_Manufacturer]
GO
ALTER TABLE [dbo].[Bearings]  WITH NOCHECK ADD  CONSTRAINT [Bearings_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Bearings] CHECK CONSTRAINT [Bearings_Users]
GO
ALTER TABLE [dbo].[BearingTranslated]  WITH NOCHECK ADD  CONSTRAINT [BearingTranslated_Bearing] FOREIGN KEY([BearingId])
REFERENCES [dbo].[Bearings] ([BearingId])
GO
ALTER TABLE [dbo].[BearingTranslated] CHECK CONSTRAINT [BearingTranslated_Bearing]
GO
ALTER TABLE [dbo].[BearingTranslated]  WITH NOCHECK ADD  CONSTRAINT [BearingTranslated_Language] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Languages] ([LanguageId])
GO
ALTER TABLE [dbo].[BearingTranslated] CHECK CONSTRAINT [BearingTranslated_Language]
GO
ALTER TABLE [dbo].[BearingTranslated]  WITH NOCHECK ADD  CONSTRAINT [BearingTranslated_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[BearingTranslated] CHECK CONSTRAINT [BearingTranslated_Users]
GO
ALTER TABLE [dbo].[Client]  WITH CHECK ADD  CONSTRAINT [Client_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Client] CHECK CONSTRAINT [Client_Users]
GO
ALTER TABLE [dbo].[Client]  WITH CHECK ADD  CONSTRAINT [ClientCreated_Language] FOREIGN KEY([CreatedLanguageId])
REFERENCES [dbo].[Languages] ([LanguageId])
GO
ALTER TABLE [dbo].[Client] CHECK CONSTRAINT [ClientCreated_Language]
GO
ALTER TABLE [dbo].[Client]  WITH NOCHECK ADD  CONSTRAINT [ClientStatus_Lookup] FOREIGN KEY([ClientStatus])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[Client] CHECK CONSTRAINT [ClientStatus_Lookup]
GO
ALTER TABLE [dbo].[ClientDocAttachment]  WITH CHECK ADD  CONSTRAINT [ClientDocAttachment_ClientSite] FOREIGN KEY([ClientSiteId])
REFERENCES [dbo].[ClientSite] ([ClientSiteId])
GO
ALTER TABLE [dbo].[ClientDocAttachment] CHECK CONSTRAINT [ClientDocAttachment_ClientSite]
GO
ALTER TABLE [dbo].[ClientDocAttachment]  WITH NOCHECK ADD  CONSTRAINT [ClientDocAttachment_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[ClientDocAttachment] CHECK CONSTRAINT [ClientDocAttachment_Users]
GO
ALTER TABLE [dbo].[ClientSite]  WITH CHECK ADD  CONSTRAINT [ClientSite_Client] FOREIGN KEY([ClientId])
REFERENCES [dbo].[Client] ([ClientId])
GO
ALTER TABLE [dbo].[ClientSite] CHECK CONSTRAINT [ClientSite_Client]
GO
ALTER TABLE [dbo].[ClientSite]  WITH CHECK ADD  CONSTRAINT [ClientSite_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[ClientSite] CHECK CONSTRAINT [ClientSite_Users]
GO
ALTER TABLE [dbo].[ClientSite]  WITH CHECK ADD  CONSTRAINT [ClientSiteCreated_Language] FOREIGN KEY([CreatedLanguageId])
REFERENCES [dbo].[Languages] ([LanguageId])
GO
ALTER TABLE [dbo].[ClientSite] CHECK CONSTRAINT [ClientSiteCreated_Language]
GO
ALTER TABLE [dbo].[ClientSite]  WITH NOCHECK ADD  CONSTRAINT [ClientSiteStatus_Lookup] FOREIGN KEY([ClientSiteStatus])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[ClientSite] CHECK CONSTRAINT [ClientSiteStatus_Lookup]
GO
ALTER TABLE [dbo].[ClientSiteConfiguration]  WITH NOCHECK ADD  CONSTRAINT [ClientSiteConfig_ClientConfigId] FOREIGN KEY([ConfigId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[ClientSiteConfiguration] CHECK CONSTRAINT [ClientSiteConfig_ClientConfigId]
GO
ALTER TABLE [dbo].[ClientSiteConfiguration]  WITH CHECK ADD  CONSTRAINT [ClientSiteConfig_ClientSite] FOREIGN KEY([ClientSiteConfigId])
REFERENCES [dbo].[ClientSite] ([ClientSiteId])
GO
ALTER TABLE [dbo].[ClientSiteConfiguration] CHECK CONSTRAINT [ClientSiteConfig_ClientSite]
GO
ALTER TABLE [dbo].[ClientSiteConfiguration]  WITH CHECK ADD  CONSTRAINT [ClientSiteConfig_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[ClientSiteConfiguration] CHECK CONSTRAINT [ClientSiteConfig_Users]
GO
ALTER TABLE [dbo].[ClientSiteTranslated]  WITH NOCHECK ADD  CONSTRAINT [ClientSiteTranslated_Client] FOREIGN KEY([ClientSiteId])
REFERENCES [dbo].[ClientSite] ([ClientSiteId])
GO
ALTER TABLE [dbo].[ClientSiteTranslated] CHECK CONSTRAINT [ClientSiteTranslated_Client]
GO
ALTER TABLE [dbo].[ClientSiteTranslated]  WITH NOCHECK ADD  CONSTRAINT [ClientSiteTranslated_Language] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Languages] ([LanguageId])
GO
ALTER TABLE [dbo].[ClientSiteTranslated] CHECK CONSTRAINT [ClientSiteTranslated_Language]
GO
ALTER TABLE [dbo].[ClientSiteTranslated]  WITH NOCHECK ADD  CONSTRAINT [ClientSiteTranslated_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[ClientSiteTranslated] CHECK CONSTRAINT [ClientSiteTranslated_Users]
GO
ALTER TABLE [dbo].[ClientTranslated]  WITH CHECK ADD  CONSTRAINT [ClientTranslated_Client] FOREIGN KEY([ClientId])
REFERENCES [dbo].[Client] ([ClientId])
GO
ALTER TABLE [dbo].[ClientTranslated] CHECK CONSTRAINT [ClientTranslated_Client]
GO
ALTER TABLE [dbo].[ClientTranslated]  WITH CHECK ADD  CONSTRAINT [ClientTranslated_Language] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Languages] ([LanguageId])
GO
ALTER TABLE [dbo].[ClientTranslated] CHECK CONSTRAINT [ClientTranslated_Language]
GO
ALTER TABLE [dbo].[ClientTranslated]  WITH NOCHECK ADD  CONSTRAINT [ClientTranslated_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[ClientTranslated] CHECK CONSTRAINT [ClientTranslated_Users]
GO
ALTER TABLE [dbo].[CMSSetup]  WITH NOCHECK ADD  CONSTRAINT [CMSSetup_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[CMSSetup] CHECK CONSTRAINT [CMSSetup_Users]
GO
ALTER TABLE [dbo].[ConditionCodeClientMapping]  WITH CHECK ADD  CONSTRAINT [ConditionCodeClient_ClientSiteId] FOREIGN KEY([ClientSiteId])
REFERENCES [dbo].[ClientSite] ([ClientSiteId])
GO
ALTER TABLE [dbo].[ConditionCodeClientMapping] CHECK CONSTRAINT [ConditionCodeClient_ClientSiteId]
GO
ALTER TABLE [dbo].[ConditionCodeClientMapping]  WITH NOCHECK ADD  CONSTRAINT [ConditionCodeClient_ConditionId] FOREIGN KEY([ConditionId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[ConditionCodeClientMapping] CHECK CONSTRAINT [ConditionCodeClient_ConditionId]
GO
ALTER TABLE [dbo].[ConditionCodeClientMapping]  WITH CHECK ADD  CONSTRAINT [ConditionCodeClient_Created_Language] FOREIGN KEY([CreatedLanguageId])
REFERENCES [dbo].[Languages] ([LanguageId])
GO
ALTER TABLE [dbo].[ConditionCodeClientMapping] CHECK CONSTRAINT [ConditionCodeClient_Created_Language]
GO
ALTER TABLE [dbo].[ConditionCodeClientMapping]  WITH CHECK ADD  CONSTRAINT [ConditionCodeClient_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[ConditionCodeClientMapping] CHECK CONSTRAINT [ConditionCodeClient_Users]
GO
ALTER TABLE [dbo].[ConditionCodeClientTranslated]  WITH CHECK ADD  CONSTRAINT [ConditionCodeClientTranslated_CMapping] FOREIGN KEY([CMappingId])
REFERENCES [dbo].[ConditionCodeClientMapping] ([CMappingId])
GO
ALTER TABLE [dbo].[ConditionCodeClientTranslated] CHECK CONSTRAINT [ConditionCodeClientTranslated_CMapping]
GO
ALTER TABLE [dbo].[ConditionCodeClientTranslated]  WITH CHECK ADD  CONSTRAINT [ConditionCodeClientTranslated_CMappingId] FOREIGN KEY([CMappingId])
REFERENCES [dbo].[ConditionCodeClientMapping] ([CMappingId])
GO
ALTER TABLE [dbo].[ConditionCodeClientTranslated] CHECK CONSTRAINT [ConditionCodeClientTranslated_CMappingId]
GO
ALTER TABLE [dbo].[ConditionCodeClientTranslated]  WITH CHECK ADD  CONSTRAINT [ConditionCodeClientTranslated_Language] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Languages] ([LanguageId])
GO
ALTER TABLE [dbo].[ConditionCodeClientTranslated] CHECK CONSTRAINT [ConditionCodeClientTranslated_Language]
GO
ALTER TABLE [dbo].[ConditionCodeClientTranslated]  WITH NOCHECK ADD  CONSTRAINT [ConditionCodeClientTranslated_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[ConditionCodeClientTranslated] CHECK CONSTRAINT [ConditionCodeClientTranslated_Users]
GO
ALTER TABLE [dbo].[CostCentre]  WITH CHECK ADD  CONSTRAINT [CostCentre_Country] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Country] ([CountryId])
GO
ALTER TABLE [dbo].[CostCentre] CHECK CONSTRAINT [CostCentre_Country]
GO
ALTER TABLE [dbo].[CostCentre]  WITH CHECK ADD  CONSTRAINT [CostCentre_Language] FOREIGN KEY([CreatedLanguageId])
REFERENCES [dbo].[Languages] ([LanguageId])
GO
ALTER TABLE [dbo].[CostCentre] CHECK CONSTRAINT [CostCentre_Language]
GO
ALTER TABLE [dbo].[CostCentre]  WITH NOCHECK ADD  CONSTRAINT [CostCentre_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[CostCentre] CHECK CONSTRAINT [CostCentre_Users]
GO
ALTER TABLE [dbo].[CostCentreTranslated]  WITH CHECK ADD  CONSTRAINT [CostCentreTranslated_CostCentre] FOREIGN KEY([CostCentreId])
REFERENCES [dbo].[CostCentre] ([CostCentreId])
GO
ALTER TABLE [dbo].[CostCentreTranslated] CHECK CONSTRAINT [CostCentreTranslated_CostCentre]
GO
ALTER TABLE [dbo].[CostCentreTranslated]  WITH CHECK ADD  CONSTRAINT [CostCentreTranslated_Language] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Languages] ([LanguageId])
GO
ALTER TABLE [dbo].[CostCentreTranslated] CHECK CONSTRAINT [CostCentreTranslated_Language]
GO
ALTER TABLE [dbo].[CostCentreTranslated]  WITH NOCHECK ADD  CONSTRAINT [CostCentreTranslated_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[CostCentreTranslated] CHECK CONSTRAINT [CostCentreTranslated_Users]
GO
ALTER TABLE [dbo].[Country]  WITH CHECK ADD  CONSTRAINT [Country_Language] FOREIGN KEY([CreatedLanguageId])
REFERENCES [dbo].[Languages] ([LanguageId])
GO
ALTER TABLE [dbo].[Country] CHECK CONSTRAINT [Country_Language]
GO
ALTER TABLE [dbo].[Country]  WITH NOCHECK ADD  CONSTRAINT [Country_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Country] CHECK CONSTRAINT [Country_Users]
GO
ALTER TABLE [dbo].[CountryTranslated]  WITH CHECK ADD  CONSTRAINT [CountryTranslated_Country] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Country] ([CountryId])
GO
ALTER TABLE [dbo].[CountryTranslated] CHECK CONSTRAINT [CountryTranslated_Country]
GO
ALTER TABLE [dbo].[CountryTranslated]  WITH CHECK ADD  CONSTRAINT [CountryTranslated_Language] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Languages] ([LanguageId])
GO
ALTER TABLE [dbo].[CountryTranslated] CHECK CONSTRAINT [CountryTranslated_Language]
GO
ALTER TABLE [dbo].[CountryTranslated]  WITH NOCHECK ADD  CONSTRAINT [CountryTranslated_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[CountryTranslated] CHECK CONSTRAINT [CountryTranslated_Users]
GO
ALTER TABLE [dbo].[DriveAttachments]  WITH CHECK ADD  CONSTRAINT [DriveAttachments_EquipmentDriveUnit] FOREIGN KEY([DriveUnitId])
REFERENCES [dbo].[EquipmentDriveUnit] ([DriveUnitId])
GO
ALTER TABLE [dbo].[DriveAttachments] CHECK CONSTRAINT [DriveAttachments_EquipmentDriveUnit]
GO
ALTER TABLE [dbo].[DriveAttachments]  WITH NOCHECK ADD  CONSTRAINT [DriveAttachments_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[DriveAttachments] CHECK CONSTRAINT [DriveAttachments_Users]
GO
ALTER TABLE [dbo].[DriveBearing]  WITH NOCHECK ADD  CONSTRAINT [DriveBearing_BearingId] FOREIGN KEY([BearingId])
REFERENCES [dbo].[Bearings] ([BearingId])
GO
ALTER TABLE [dbo].[DriveBearing] CHECK CONSTRAINT [DriveBearing_BearingId]
GO
ALTER TABLE [dbo].[DriveBearing]  WITH CHECK ADD  CONSTRAINT [DriveBearing_EquipmentDriveUnit] FOREIGN KEY([DriveUnitId])
REFERENCES [dbo].[EquipmentDriveUnit] ([DriveUnitId])
GO
ALTER TABLE [dbo].[DriveBearing] CHECK CONSTRAINT [DriveBearing_EquipmentDriveUnit]
GO
ALTER TABLE [dbo].[DriveBearing]  WITH CHECK ADD  CONSTRAINT [DriveBearing_ManufacturerId] FOREIGN KEY([ManufacturerId])
REFERENCES [dbo].[Manufacturer] ([ManufacturerId])
GO
ALTER TABLE [dbo].[DriveBearing] CHECK CONSTRAINT [DriveBearing_ManufacturerId]
GO
ALTER TABLE [dbo].[DriveBearing]  WITH NOCHECK ADD  CONSTRAINT [DriveBearing_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[DriveBearing] CHECK CONSTRAINT [DriveBearing_Users]
GO
ALTER TABLE [dbo].[DrivenAttachments]  WITH CHECK ADD  CONSTRAINT [DrivenAttachments_EquipmentDrivenUnit] FOREIGN KEY([DrivenUnitId])
REFERENCES [dbo].[EquipmentDrivenUnit] ([DrivenUnitId])
GO
ALTER TABLE [dbo].[DrivenAttachments] CHECK CONSTRAINT [DrivenAttachments_EquipmentDrivenUnit]
GO
ALTER TABLE [dbo].[DrivenAttachments]  WITH NOCHECK ADD  CONSTRAINT [DrivenAttachments_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[DrivenAttachments] CHECK CONSTRAINT [DrivenAttachments_Users]
GO
ALTER TABLE [dbo].[DrivenBearing]  WITH NOCHECK ADD  CONSTRAINT [DrivenBearing_BearingId] FOREIGN KEY([BearingId])
REFERENCES [dbo].[Bearings] ([BearingId])
GO
ALTER TABLE [dbo].[DrivenBearing] CHECK CONSTRAINT [DrivenBearing_BearingId]
GO
ALTER TABLE [dbo].[DrivenBearing]  WITH CHECK ADD  CONSTRAINT [DrivenBearing_EquipmentDrivenUnit] FOREIGN KEY([DrivenUnitId])
REFERENCES [dbo].[EquipmentDrivenUnit] ([DrivenUnitId])
GO
ALTER TABLE [dbo].[DrivenBearing] CHECK CONSTRAINT [DrivenBearing_EquipmentDrivenUnit]
GO
ALTER TABLE [dbo].[DrivenBearing]  WITH CHECK ADD  CONSTRAINT [DrivenBearing_ManufacturerId] FOREIGN KEY([ManufacturerId])
REFERENCES [dbo].[Manufacturer] ([ManufacturerId])
GO
ALTER TABLE [dbo].[DrivenBearing] CHECK CONSTRAINT [DrivenBearing_ManufacturerId]
GO
ALTER TABLE [dbo].[DrivenBearing]  WITH NOCHECK ADD  CONSTRAINT [DrivenBearing_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[DrivenBearing] CHECK CONSTRAINT [DrivenBearing_Users]
GO
ALTER TABLE [dbo].[DrivenServices]  WITH CHECK ADD  CONSTRAINT [DrivenServices_EquipmentDrivenUnit] FOREIGN KEY([DrivenUnitId])
REFERENCES [dbo].[EquipmentDrivenUnit] ([DrivenUnitId])
GO
ALTER TABLE [dbo].[DrivenServices] CHECK CONSTRAINT [DrivenServices_EquipmentDrivenUnit]
GO
ALTER TABLE [dbo].[DrivenServices]  WITH NOCHECK ADD  CONSTRAINT [DrivenServices_Report] FOREIGN KEY([ReportId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[DrivenServices] CHECK CONSTRAINT [DrivenServices_Report]
GO
ALTER TABLE [dbo].[DrivenServices]  WITH CHECK ADD  CONSTRAINT [DrivenServices_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[DrivenServices] CHECK CONSTRAINT [DrivenServices_Users]
GO
ALTER TABLE [dbo].[DriveServices]  WITH CHECK ADD  CONSTRAINT [DriveServices_EquipmentDriveUnit] FOREIGN KEY([DriveUnitId])
REFERENCES [dbo].[EquipmentDriveUnit] ([DriveUnitId])
GO
ALTER TABLE [dbo].[DriveServices] CHECK CONSTRAINT [DriveServices_EquipmentDriveUnit]
GO
ALTER TABLE [dbo].[DriveServices]  WITH NOCHECK ADD  CONSTRAINT [DriveServices_Report] FOREIGN KEY([ReportId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[DriveServices] CHECK CONSTRAINT [DriveServices_Report]
GO
ALTER TABLE [dbo].[DriveServices]  WITH CHECK ADD  CONSTRAINT [DriveServices_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[DriveServices] CHECK CONSTRAINT [DriveServices_Users]
GO
ALTER TABLE [dbo].[Equipment]  WITH CHECK ADD  CONSTRAINT [Equipment_Area] FOREIGN KEY([AreaId])
REFERENCES [dbo].[Area] ([AreaId])
GO
ALTER TABLE [dbo].[Equipment] CHECK CONSTRAINT [Equipment_Area]
GO
ALTER TABLE [dbo].[Equipment]  WITH CHECK ADD  CONSTRAINT [Equipment_Mounting] FOREIGN KEY([MountingId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[Equipment] CHECK CONSTRAINT [Equipment_Mounting]
GO
ALTER TABLE [dbo].[Equipment]  WITH CHECK ADD  CONSTRAINT [Equipment_Orientation] FOREIGN KEY([OrientationId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[Equipment] CHECK CONSTRAINT [Equipment_Orientation]
GO
ALTER TABLE [dbo].[Equipment]  WITH CHECK ADD  CONSTRAINT [Equipment_PlantArea] FOREIGN KEY([PlantAreaId])
REFERENCES [dbo].[PlantArea] ([PlantAreaId])
GO
ALTER TABLE [dbo].[Equipment] CHECK CONSTRAINT [Equipment_PlantArea]
GO
ALTER TABLE [dbo].[Equipment]  WITH CHECK ADD  CONSTRAINT [Equipment_StandByEquipment] FOREIGN KEY([StandByEquipId])
REFERENCES [dbo].[Equipment] ([EquipmentId])
GO
ALTER TABLE [dbo].[Equipment] CHECK CONSTRAINT [Equipment_StandByEquipment]
GO
ALTER TABLE [dbo].[Equipment]  WITH CHECK ADD  CONSTRAINT [Equipment_System] FOREIGN KEY([SystemId])
REFERENCES [dbo].[System] ([SystemId])
GO
ALTER TABLE [dbo].[Equipment] CHECK CONSTRAINT [Equipment_System]
GO
ALTER TABLE [dbo].[Equipment]  WITH CHECK ADD  CONSTRAINT [Equipment_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Equipment] CHECK CONSTRAINT [Equipment_Users]
GO
ALTER TABLE [dbo].[EquipmentAttachments]  WITH CHECK ADD  CONSTRAINT [EquipmentAttachments_Equipment] FOREIGN KEY([EquipmentId])
REFERENCES [dbo].[Equipment] ([EquipmentId])
GO
ALTER TABLE [dbo].[EquipmentAttachments] CHECK CONSTRAINT [EquipmentAttachments_Equipment]
GO
ALTER TABLE [dbo].[EquipmentAttachments]  WITH NOCHECK ADD  CONSTRAINT [EquipmentAttachments_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[EquipmentAttachments] CHECK CONSTRAINT [EquipmentAttachments_Users]
GO
ALTER TABLE [dbo].[EquipmentDrivenUnit]  WITH CHECK ADD  CONSTRAINT [EquipmentDrivenUnit_Asset] FOREIGN KEY([AssetId])
REFERENCES [dbo].[Taxonomy] ([TaxonomyId])
GO
ALTER TABLE [dbo].[EquipmentDrivenUnit] CHECK CONSTRAINT [EquipmentDrivenUnit_Asset]
GO
ALTER TABLE [dbo].[EquipmentDrivenUnit]  WITH CHECK ADD  CONSTRAINT [EquipmentDrivenUnit_BearingDrive] FOREIGN KEY([BearingDriveEndId])
REFERENCES [dbo].[Bearings] ([BearingId])
GO
ALTER TABLE [dbo].[EquipmentDrivenUnit] CHECK CONSTRAINT [EquipmentDrivenUnit_BearingDrive]
GO
ALTER TABLE [dbo].[EquipmentDrivenUnit]  WITH CHECK ADD  CONSTRAINT [EquipmentDrivenUnit_BearingNonDrive] FOREIGN KEY([BearingNonDriveEndId])
REFERENCES [dbo].[Bearings] ([BearingId])
GO
ALTER TABLE [dbo].[EquipmentDrivenUnit] CHECK CONSTRAINT [EquipmentDrivenUnit_BearingNonDrive]
GO
ALTER TABLE [dbo].[EquipmentDrivenUnit]  WITH CHECK ADD  CONSTRAINT [EquipmentDrivenUnit_Equipment] FOREIGN KEY([EquipmentId])
REFERENCES [dbo].[Equipment] ([EquipmentId])
GO
ALTER TABLE [dbo].[EquipmentDrivenUnit] CHECK CONSTRAINT [EquipmentDrivenUnit_Equipment]
GO
ALTER TABLE [dbo].[EquipmentDrivenUnit]  WITH CHECK ADD  CONSTRAINT [EquipmentDrivenUnit_Manufacturer] FOREIGN KEY([ManufacturerId])
REFERENCES [dbo].[Manufacturer] ([ManufacturerId])
GO
ALTER TABLE [dbo].[EquipmentDrivenUnit] CHECK CONSTRAINT [EquipmentDrivenUnit_Manufacturer]
GO
ALTER TABLE [dbo].[EquipmentDrivenUnit]  WITH CHECK ADD  CONSTRAINT [EquipmentDrivenUnit_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[EquipmentDrivenUnit] CHECK CONSTRAINT [EquipmentDrivenUnit_Users]
GO
ALTER TABLE [dbo].[EquipmentDriveUnit]  WITH CHECK ADD  CONSTRAINT [EquipmentDriveUnit_Asset] FOREIGN KEY([AssetId])
REFERENCES [dbo].[Taxonomy] ([TaxonomyId])
GO
ALTER TABLE [dbo].[EquipmentDriveUnit] CHECK CONSTRAINT [EquipmentDriveUnit_Asset]
GO
ALTER TABLE [dbo].[EquipmentDriveUnit]  WITH CHECK ADD  CONSTRAINT [EquipmentDriveUnit_BearingDrive] FOREIGN KEY([BearingDriveEndId])
REFERENCES [dbo].[Bearings] ([BearingId])
GO
ALTER TABLE [dbo].[EquipmentDriveUnit] CHECK CONSTRAINT [EquipmentDriveUnit_BearingDrive]
GO
ALTER TABLE [dbo].[EquipmentDriveUnit]  WITH CHECK ADD  CONSTRAINT [EquipmentDriveUnit_BearingNonDrive] FOREIGN KEY([BearingNonDriveEndId])
REFERENCES [dbo].[Bearings] ([BearingId])
GO
ALTER TABLE [dbo].[EquipmentDriveUnit] CHECK CONSTRAINT [EquipmentDriveUnit_BearingNonDrive]
GO
ALTER TABLE [dbo].[EquipmentDriveUnit]  WITH CHECK ADD  CONSTRAINT [EquipmentDriveUnit_Equipment] FOREIGN KEY([EquipmentId])
REFERENCES [dbo].[Equipment] ([EquipmentId])
GO
ALTER TABLE [dbo].[EquipmentDriveUnit] CHECK CONSTRAINT [EquipmentDriveUnit_Equipment]
GO
ALTER TABLE [dbo].[EquipmentDriveUnit]  WITH CHECK ADD  CONSTRAINT [EquipmentDriveUnit_Manufacturer] FOREIGN KEY([ManufacturerId])
REFERENCES [dbo].[Manufacturer] ([ManufacturerId])
GO
ALTER TABLE [dbo].[EquipmentDriveUnit] CHECK CONSTRAINT [EquipmentDriveUnit_Manufacturer]
GO
ALTER TABLE [dbo].[EquipmentDriveUnit]  WITH CHECK ADD  CONSTRAINT [EquipmentDriveUnit_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[EquipmentDriveUnit] CHECK CONSTRAINT [EquipmentDriveUnit_Users]
GO
ALTER TABLE [dbo].[EquipmentIntermediateUnit]  WITH CHECK ADD  CONSTRAINT [EquipmentIntermediateUnit_Asset] FOREIGN KEY([AssetId])
REFERENCES [dbo].[Taxonomy] ([TaxonomyId])
GO
ALTER TABLE [dbo].[EquipmentIntermediateUnit] CHECK CONSTRAINT [EquipmentIntermediateUnit_Asset]
GO
ALTER TABLE [dbo].[EquipmentIntermediateUnit]  WITH CHECK ADD  CONSTRAINT [EquipmentIntermediateUnit_BearingInput] FOREIGN KEY([BearingInputId])
REFERENCES [dbo].[Bearings] ([BearingId])
GO
ALTER TABLE [dbo].[EquipmentIntermediateUnit] CHECK CONSTRAINT [EquipmentIntermediateUnit_BearingInput]
GO
ALTER TABLE [dbo].[EquipmentIntermediateUnit]  WITH CHECK ADD  CONSTRAINT [EquipmentIntermediateUnit_BearingOutput] FOREIGN KEY([BearingOutputId])
REFERENCES [dbo].[Bearings] ([BearingId])
GO
ALTER TABLE [dbo].[EquipmentIntermediateUnit] CHECK CONSTRAINT [EquipmentIntermediateUnit_BearingOutput]
GO
ALTER TABLE [dbo].[EquipmentIntermediateUnit]  WITH CHECK ADD  CONSTRAINT [EquipmentIntermediateUnit_Equipment] FOREIGN KEY([EquipmentId])
REFERENCES [dbo].[Equipment] ([EquipmentId])
GO
ALTER TABLE [dbo].[EquipmentIntermediateUnit] CHECK CONSTRAINT [EquipmentIntermediateUnit_Equipment]
GO
ALTER TABLE [dbo].[EquipmentIntermediateUnit]  WITH CHECK ADD  CONSTRAINT [EquipmentIntermediateUnit_Manufacturer] FOREIGN KEY([ManufacturerId])
REFERENCES [dbo].[Manufacturer] ([ManufacturerId])
GO
ALTER TABLE [dbo].[EquipmentIntermediateUnit] CHECK CONSTRAINT [EquipmentIntermediateUnit_Manufacturer]
GO
ALTER TABLE [dbo].[EquipmentIntermediateUnit]  WITH CHECK ADD  CONSTRAINT [EquipmentIntermediateUnit_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[EquipmentIntermediateUnit] CHECK CONSTRAINT [EquipmentIntermediateUnit_Users]
GO
ALTER TABLE [dbo].[EquipmentIntermediateUnit]  WITH CHECK ADD  CONSTRAINT [EquipmentIntermediateUnitt_BearingOutput] FOREIGN KEY([BearingOutputId])
REFERENCES [dbo].[Bearings] ([BearingId])
GO
ALTER TABLE [dbo].[EquipmentIntermediateUnit] CHECK CONSTRAINT [EquipmentIntermediateUnitt_BearingOutput]
GO
ALTER TABLE [dbo].[FailureCause]  WITH NOCHECK ADD  CONSTRAINT [FailureCause_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[FailureCause] CHECK CONSTRAINT [FailureCause_Users]
GO
ALTER TABLE [dbo].[FailureCauseModeRelation]  WITH CHECK ADD  CONSTRAINT [FailureCauseModeRelation_CreatedBy] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[FailureCauseModeRelation] CHECK CONSTRAINT [FailureCauseModeRelation_CreatedBy]
GO
ALTER TABLE [dbo].[FailureCauseModeRelation]  WITH CHECK ADD  CONSTRAINT [FailureCauseModeRelation_FailureCause] FOREIGN KEY([FailureCauseId])
REFERENCES [dbo].[FailureCause] ([FailureCauseId])
GO
ALTER TABLE [dbo].[FailureCauseModeRelation] CHECK CONSTRAINT [FailureCauseModeRelation_FailureCause]
GO
ALTER TABLE [dbo].[FailureCauseModeRelation]  WITH CHECK ADD  CONSTRAINT [FailureCauseModeRelation_FailureMode] FOREIGN KEY([FailureModeId])
REFERENCES [dbo].[FailureMode] ([FailureModeId])
GO
ALTER TABLE [dbo].[FailureCauseModeRelation] CHECK CONSTRAINT [FailureCauseModeRelation_FailureMode]
GO
ALTER TABLE [dbo].[FailureCauseTranslated]  WITH CHECK ADD  CONSTRAINT [FailureCauseTranslated_FailureCause] FOREIGN KEY([FailureCauseId])
REFERENCES [dbo].[FailureCause] ([FailureCauseId])
GO
ALTER TABLE [dbo].[FailureCauseTranslated] CHECK CONSTRAINT [FailureCauseTranslated_FailureCause]
GO
ALTER TABLE [dbo].[FailureCauseTranslated]  WITH CHECK ADD  CONSTRAINT [FailureCauseTranslated_Language] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Languages] ([LanguageId])
GO
ALTER TABLE [dbo].[FailureCauseTranslated] CHECK CONSTRAINT [FailureCauseTranslated_Language]
GO
ALTER TABLE [dbo].[FailureCauseTranslated]  WITH NOCHECK ADD  CONSTRAINT [FailureCauseTranslated_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[FailureCauseTranslated] CHECK CONSTRAINT [FailureCauseTranslated_Users]
GO
ALTER TABLE [dbo].[FailureMode]  WITH NOCHECK ADD  CONSTRAINT [FailureMode_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[FailureMode] CHECK CONSTRAINT [FailureMode_Users]
GO
ALTER TABLE [dbo].[FailureModeAssetClassRelation]  WITH CHECK ADD  CONSTRAINT [FailureModeAssetRelation_AssetClass] FOREIGN KEY([AssetClassId])
REFERENCES [dbo].[AssetClass] ([AssetClassId])
GO
ALTER TABLE [dbo].[FailureModeAssetClassRelation] CHECK CONSTRAINT [FailureModeAssetRelation_AssetClass]
GO
ALTER TABLE [dbo].[FailureModeAssetClassRelation]  WITH CHECK ADD  CONSTRAINT [FailureModeAssetRelation_CreatedBy] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[FailureModeAssetClassRelation] CHECK CONSTRAINT [FailureModeAssetRelation_CreatedBy]
GO
ALTER TABLE [dbo].[FailureModeAssetClassRelation]  WITH CHECK ADD  CONSTRAINT [FailureModeAssetRelation_FailureMode] FOREIGN KEY([FailureModeId])
REFERENCES [dbo].[FailureMode] ([FailureModeId])
GO
ALTER TABLE [dbo].[FailureModeAssetClassRelation] CHECK CONSTRAINT [FailureModeAssetRelation_FailureMode]
GO
ALTER TABLE [dbo].[FailureModeTranslated]  WITH CHECK ADD  CONSTRAINT [FailureModeTranslated_FailureMode] FOREIGN KEY([FailureModeId])
REFERENCES [dbo].[FailureMode] ([FailureModeId])
GO
ALTER TABLE [dbo].[FailureModeTranslated] CHECK CONSTRAINT [FailureModeTranslated_FailureMode]
GO
ALTER TABLE [dbo].[FailureModeTranslated]  WITH CHECK ADD  CONSTRAINT [FailureModeTranslated_Language] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Languages] ([LanguageId])
GO
ALTER TABLE [dbo].[FailureModeTranslated] CHECK CONSTRAINT [FailureModeTranslated_Language]
GO
ALTER TABLE [dbo].[FailureModeTranslated]  WITH NOCHECK ADD  CONSTRAINT [FailureModeTranslated_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[FailureModeTranslated] CHECK CONSTRAINT [FailureModeTranslated_Users]
GO
ALTER TABLE [dbo].[FailureReportAttachment]  WITH CHECK ADD  CONSTRAINT [FailureReportAttachment_ReportHeader] FOREIGN KEY([FailureReportHeaderId])
REFERENCES [dbo].[FailureReportHeader] ([FailureReportHeaderId])
GO
ALTER TABLE [dbo].[FailureReportAttachment] CHECK CONSTRAINT [FailureReportAttachment_ReportHeader]
GO
ALTER TABLE [dbo].[FailureReportAttachment]  WITH NOCHECK ADD  CONSTRAINT [FailureReportAttachment_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[FailureReportAttachment] CHECK CONSTRAINT [FailureReportAttachment_Users]
GO
ALTER TABLE [dbo].[FailureReportDetail]  WITH CHECK ADD  CONSTRAINT [FailureReportDetail_FailureReportHeader] FOREIGN KEY([FailureReportHeaderId])
REFERENCES [dbo].[FailureReportHeader] ([FailureReportHeaderId])
GO
ALTER TABLE [dbo].[FailureReportDetail] CHECK CONSTRAINT [FailureReportDetail_FailureReportHeader]
GO
ALTER TABLE [dbo].[FailureReportDetail]  WITH NOCHECK ADD  CONSTRAINT [FailureReportDetail_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[FailureReportDetail] CHECK CONSTRAINT [FailureReportDetail_Users]
GO
ALTER TABLE [dbo].[FailureReportHeader]  WITH CHECK ADD  CONSTRAINT [FailureReportHeader_ClientSite] FOREIGN KEY([ClientSiteId])
REFERENCES [dbo].[ClientSite] ([ClientSiteId])
GO
ALTER TABLE [dbo].[FailureReportHeader] CHECK CONSTRAINT [FailureReportHeader_ClientSite]
GO
ALTER TABLE [dbo].[FailureReportHeader]  WITH CHECK ADD  CONSTRAINT [FailureReportHeader_Equipment] FOREIGN KEY([EquipmentId])
REFERENCES [dbo].[Equipment] ([EquipmentId])
GO
ALTER TABLE [dbo].[FailureReportHeader] CHECK CONSTRAINT [FailureReportHeader_Equipment]
GO
ALTER TABLE [dbo].[FailureReportHeader]  WITH NOCHECK ADD  CONSTRAINT [FailureReportHeader_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[FailureReportHeader] CHECK CONSTRAINT [FailureReportHeader_Users]
GO
ALTER TABLE [dbo].[Industry]  WITH CHECK ADD  CONSTRAINT [Industry_Sector] FOREIGN KEY([SegmentId])
REFERENCES [dbo].[Segment] ([SegmentId])
GO
ALTER TABLE [dbo].[Industry] CHECK CONSTRAINT [Industry_Sector]
GO
ALTER TABLE [dbo].[Industry]  WITH CHECK ADD  CONSTRAINT [Industry_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Industry] CHECK CONSTRAINT [Industry_Users]
GO
ALTER TABLE [dbo].[Industry]  WITH CHECK ADD  CONSTRAINT [IndustryCreated_Language] FOREIGN KEY([CreatedLanguageId])
REFERENCES [dbo].[Languages] ([LanguageId])
GO
ALTER TABLE [dbo].[Industry] CHECK CONSTRAINT [IndustryCreated_Language]
GO
ALTER TABLE [dbo].[IndustryTranslated]  WITH CHECK ADD  CONSTRAINT [IndustryTranslated_Industry] FOREIGN KEY([IndustryId])
REFERENCES [dbo].[Industry] ([IndustryId])
GO
ALTER TABLE [dbo].[IndustryTranslated] CHECK CONSTRAINT [IndustryTranslated_Industry]
GO
ALTER TABLE [dbo].[IndustryTranslated]  WITH CHECK ADD  CONSTRAINT [IndustryTranslated_Language] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Languages] ([LanguageId])
GO
ALTER TABLE [dbo].[IndustryTranslated] CHECK CONSTRAINT [IndustryTranslated_Language]
GO
ALTER TABLE [dbo].[IndustryTranslated]  WITH NOCHECK ADD  CONSTRAINT [IndustryTranslated_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[IndustryTranslated] CHECK CONSTRAINT [IndustryTranslated_Users]
GO
ALTER TABLE [dbo].[IntermediateAttachments]  WITH CHECK ADD  CONSTRAINT [IntermediateAttachments_EquipmentIntermediateUnit] FOREIGN KEY([IntermediateUnitId])
REFERENCES [dbo].[EquipmentIntermediateUnit] ([IntermediateUnitId])
GO
ALTER TABLE [dbo].[IntermediateAttachments] CHECK CONSTRAINT [IntermediateAttachments_EquipmentIntermediateUnit]
GO
ALTER TABLE [dbo].[IntermediateAttachments]  WITH NOCHECK ADD  CONSTRAINT [IntermediateAttachments_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[IntermediateAttachments] CHECK CONSTRAINT [IntermediateAttachments_Users]
GO
ALTER TABLE [dbo].[IntermediateBearing]  WITH NOCHECK ADD  CONSTRAINT [IntermediateBearing_BearingId] FOREIGN KEY([BearingId])
REFERENCES [dbo].[Bearings] ([BearingId])
GO
ALTER TABLE [dbo].[IntermediateBearing] CHECK CONSTRAINT [IntermediateBearing_BearingId]
GO
ALTER TABLE [dbo].[IntermediateBearing]  WITH CHECK ADD  CONSTRAINT [IntermediateBearing_EquipmentIntermediateUnit] FOREIGN KEY([IntermediateUnitId])
REFERENCES [dbo].[EquipmentIntermediateUnit] ([IntermediateUnitId])
GO
ALTER TABLE [dbo].[IntermediateBearing] CHECK CONSTRAINT [IntermediateBearing_EquipmentIntermediateUnit]
GO
ALTER TABLE [dbo].[IntermediateBearing]  WITH CHECK ADD  CONSTRAINT [IntermediateBearing_ManufacturerId] FOREIGN KEY([ManufacturerId])
REFERENCES [dbo].[Manufacturer] ([ManufacturerId])
GO
ALTER TABLE [dbo].[IntermediateBearing] CHECK CONSTRAINT [IntermediateBearing_ManufacturerId]
GO
ALTER TABLE [dbo].[IntermediateBearing]  WITH NOCHECK ADD  CONSTRAINT [IntermediateBearing_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[IntermediateBearing] CHECK CONSTRAINT [IntermediateBearing_Users]
GO
ALTER TABLE [dbo].[IntermediateServices]  WITH CHECK ADD  CONSTRAINT [IntermediateServices_EquipmentIntermediateUnit] FOREIGN KEY([IntermediateUnitId])
REFERENCES [dbo].[EquipmentIntermediateUnit] ([IntermediateUnitId])
GO
ALTER TABLE [dbo].[IntermediateServices] CHECK CONSTRAINT [IntermediateServices_EquipmentIntermediateUnit]
GO
ALTER TABLE [dbo].[IntermediateServices]  WITH NOCHECK ADD  CONSTRAINT [IntermediateServices_Report] FOREIGN KEY([ReportId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[IntermediateServices] CHECK CONSTRAINT [IntermediateServices_Report]
GO
ALTER TABLE [dbo].[IntermediateServices]  WITH CHECK ADD  CONSTRAINT [IntermediateServices_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[IntermediateServices] CHECK CONSTRAINT [IntermediateServices_Users]
GO
ALTER TABLE [dbo].[JobComments]  WITH CHECK ADD  CONSTRAINT [JobComments_Jobs] FOREIGN KEY([JobId])
REFERENCES [dbo].[Jobs] ([JobId])
GO
ALTER TABLE [dbo].[JobComments] CHECK CONSTRAINT [JobComments_Jobs]
GO
ALTER TABLE [dbo].[JobComments]  WITH NOCHECK ADD  CONSTRAINT [JobComments_Status] FOREIGN KEY([StatusId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[JobComments] CHECK CONSTRAINT [JobComments_Status]
GO
ALTER TABLE [dbo].[JobComments]  WITH CHECK ADD  CONSTRAINT [JobComments_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[JobComments] CHECK CONSTRAINT [JobComments_Users]
GO
ALTER TABLE [dbo].[JobEquipment]  WITH CHECK ADD  CONSTRAINT [JobEquipment_Analyst] FOREIGN KEY([AnalystId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[JobEquipment] CHECK CONSTRAINT [JobEquipment_Analyst]
GO
ALTER TABLE [dbo].[JobEquipment]  WITH CHECK ADD  CONSTRAINT [JobEquipment_Conditions] FOREIGN KEY([ConditionId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[JobEquipment] CHECK CONSTRAINT [JobEquipment_Conditions]
GO
ALTER TABLE [dbo].[JobEquipment]  WITH CHECK ADD  CONSTRAINT [JobEquipment_DataCollector] FOREIGN KEY([DataCollectorId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[JobEquipment] CHECK CONSTRAINT [JobEquipment_DataCollector]
GO
ALTER TABLE [dbo].[JobEquipment]  WITH CHECK ADD  CONSTRAINT [JobEquipment_Equipment] FOREIGN KEY([EquipmentId])
REFERENCES [dbo].[Equipment] ([EquipmentId])
GO
ALTER TABLE [dbo].[JobEquipment] CHECK CONSTRAINT [JobEquipment_Equipment]
GO
ALTER TABLE [dbo].[JobEquipment]  WITH CHECK ADD  CONSTRAINT [JobEquipment_Jobs] FOREIGN KEY([JobId])
REFERENCES [dbo].[Jobs] ([JobId])
GO
ALTER TABLE [dbo].[JobEquipment] CHECK CONSTRAINT [JobEquipment_Jobs]
GO
ALTER TABLE [dbo].[JobEquipment]  WITH CHECK ADD  CONSTRAINT [JobEquipment_Reviewer] FOREIGN KEY([ReviewerId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[JobEquipment] CHECK CONSTRAINT [JobEquipment_Reviewer]
GO
ALTER TABLE [dbo].[JobEquipment]  WITH CHECK ADD  CONSTRAINT [JobEquipment_Service] FOREIGN KEY([ServiceId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[JobEquipment] CHECK CONSTRAINT [JobEquipment_Service]
GO
ALTER TABLE [dbo].[JobEquipment]  WITH CHECK ADD  CONSTRAINT [JobEquipment_Status] FOREIGN KEY([StatusId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[JobEquipment] CHECK CONSTRAINT [JobEquipment_Status]
GO
ALTER TABLE [dbo].[JobEquipment]  WITH CHECK ADD  CONSTRAINT [JobEquipment_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[JobEquipment] CHECK CONSTRAINT [JobEquipment_Users]
GO
ALTER TABLE [dbo].[JobEquipmentComments]  WITH CHECK ADD  CONSTRAINT [JobEquipmentComments_Jobs] FOREIGN KEY([JobEquipmentId])
REFERENCES [dbo].[JobEquipment] ([JobEquipmentId])
GO
ALTER TABLE [dbo].[JobEquipmentComments] CHECK CONSTRAINT [JobEquipmentComments_Jobs]
GO
ALTER TABLE [dbo].[JobEquipmentComments]  WITH NOCHECK ADD  CONSTRAINT [JobEquipmentComments_Status] FOREIGN KEY([StatusId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[JobEquipmentComments] CHECK CONSTRAINT [JobEquipmentComments_Status]
GO
ALTER TABLE [dbo].[JobEquipmentComments]  WITH CHECK ADD  CONSTRAINT [JobEquipmentComments_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[JobEquipmentComments] CHECK CONSTRAINT [JobEquipmentComments_Users]
GO
ALTER TABLE [dbo].[JobEquipmentOilProperties]  WITH CHECK ADD  CONSTRAINT [JobEquipmentOilProperties_JobEquipment] FOREIGN KEY([JobEquipmentId])
REFERENCES [dbo].[JobEquipment] ([JobEquipmentId])
GO
ALTER TABLE [dbo].[JobEquipmentOilProperties] CHECK CONSTRAINT [JobEquipmentOilProperties_JobEquipment]
GO
ALTER TABLE [dbo].[JobEquipmentOilProperties]  WITH NOCHECK ADD  CONSTRAINT [JobEquipmentOilProperties_OAVibChangePercentage] FOREIGN KEY([OAVibChangePercentageId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[JobEquipmentOilProperties] CHECK CONSTRAINT [JobEquipmentOilProperties_OAVibChangePercentage]
GO
ALTER TABLE [dbo].[JobEquipmentOilProperties]  WITH CHECK ADD  CONSTRAINT [JobEquipmentOilProperties_OilProperties] FOREIGN KEY([OilPropertiesId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[JobEquipmentOilProperties] CHECK CONSTRAINT [JobEquipmentOilProperties_OilProperties]
GO
ALTER TABLE [dbo].[JobEquipmentOilProperties]  WITH CHECK ADD  CONSTRAINT [JobEquipmentOilProperties_Severity] FOREIGN KEY([SeverityId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[JobEquipmentOilProperties] CHECK CONSTRAINT [JobEquipmentOilProperties_Severity]
GO
ALTER TABLE [dbo].[JobEquipmentOilProperties]  WITH CHECK ADD  CONSTRAINT [JobEquipmentOilProperties_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[JobEquipmentOilProperties] CHECK CONSTRAINT [JobEquipmentOilProperties_Users]
GO
ALTER TABLE [dbo].[JobEquipmentUnitAnalysisComments]  WITH NOCHECK ADD  CONSTRAINT [JobEquipmentUnitAnalysisComments_Status] FOREIGN KEY([StatusId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[JobEquipmentUnitAnalysisComments] CHECK CONSTRAINT [JobEquipmentUnitAnalysisComments_Status]
GO
ALTER TABLE [dbo].[JobEquipmentUnitAnalysisComments]  WITH CHECK ADD  CONSTRAINT [JobEquipmentUnitAnalysisComments_UnitAnalysis] FOREIGN KEY([UnitAnalysisId])
REFERENCES [dbo].[JobEquipUnitAnalysis] ([UnitAnalysisId])
GO
ALTER TABLE [dbo].[JobEquipmentUnitAnalysisComments] CHECK CONSTRAINT [JobEquipmentUnitAnalysisComments_UnitAnalysis]
GO
ALTER TABLE [dbo].[JobEquipmentUnitAnalysisComments]  WITH CHECK ADD  CONSTRAINT [JobEquipmentUnitAnalysisComments_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[JobEquipmentUnitAnalysisComments] CHECK CONSTRAINT [JobEquipmentUnitAnalysisComments_Users]
GO
ALTER TABLE [dbo].[JobEquipUnitAmplitude]  WITH NOCHECK ADD  CONSTRAINT [JobEquipUnitAmplitude_OASensorDirection] FOREIGN KEY([OASensorDirection])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[JobEquipUnitAmplitude] CHECK CONSTRAINT [JobEquipUnitAmplitude_OASensorDirection]
GO
ALTER TABLE [dbo].[JobEquipUnitAmplitude]  WITH CHECK ADD  CONSTRAINT [JobEquipUnitAmplitude_OASensorLocation] FOREIGN KEY([OASensorLocation])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[JobEquipUnitAmplitude] CHECK CONSTRAINT [JobEquipUnitAmplitude_OASensorLocation]
GO
ALTER TABLE [dbo].[JobEquipUnitAmplitude]  WITH CHECK ADD  CONSTRAINT [JobEquipUnitAmplitude_OAVibChangePercentage] FOREIGN KEY([OAVibChangePercentage])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[JobEquipUnitAmplitude] CHECK CONSTRAINT [JobEquipUnitAmplitude_OAVibChangePercentage]
GO
ALTER TABLE [dbo].[JobEquipUnitAmplitude]  WITH CHECK ADD  CONSTRAINT [JobEquipUnitAmplitude_UnitAnalysis] FOREIGN KEY([UnitAnalysisId])
REFERENCES [dbo].[JobEquipUnitAnalysis] ([UnitAnalysisId])
GO
ALTER TABLE [dbo].[JobEquipUnitAmplitude] CHECK CONSTRAINT [JobEquipUnitAmplitude_UnitAnalysis]
GO
ALTER TABLE [dbo].[JobEquipUnitAmplitude]  WITH CHECK ADD  CONSTRAINT [JobEquipUnitAmplitude_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[JobEquipUnitAmplitude] CHECK CONSTRAINT [JobEquipUnitAmplitude_Users]
GO
ALTER TABLE [dbo].[JobEquipUnitAnalysis]  WITH CHECK ADD  CONSTRAINT [JobEquipUnitAnalysis_Condition] FOREIGN KEY([ConditionId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[JobEquipUnitAnalysis] CHECK CONSTRAINT [JobEquipUnitAnalysis_Condition]
GO
ALTER TABLE [dbo].[JobEquipUnitAnalysis]  WITH CHECK ADD  CONSTRAINT [JobEquipUnitAnalysis_ConfidentFactor] FOREIGN KEY([ConfidentFactorId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[JobEquipUnitAnalysis] CHECK CONSTRAINT [JobEquipUnitAnalysis_ConfidentFactor]
GO
ALTER TABLE [dbo].[JobEquipUnitAnalysis]  WITH CHECK ADD  CONSTRAINT [JobEquipUnitAnalysis_FailureProbFactor] FOREIGN KEY([FailureProbFactorId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[JobEquipUnitAnalysis] CHECK CONSTRAINT [JobEquipUnitAnalysis_FailureProbFactor]
GO
ALTER TABLE [dbo].[JobEquipUnitAnalysis]  WITH CHECK ADD  CONSTRAINT [JobEquipUnitAnalysis_JobEquipmnets] FOREIGN KEY([JobEquipmentId])
REFERENCES [dbo].[JobEquipment] ([JobEquipmentId])
GO
ALTER TABLE [dbo].[JobEquipUnitAnalysis] CHECK CONSTRAINT [JobEquipUnitAnalysis_JobEquipmnets]
GO
ALTER TABLE [dbo].[JobEquipUnitAnalysis]  WITH CHECK ADD  CONSTRAINT [JobEquipUnitAnalysis_Priority] FOREIGN KEY([FailureProbFactorId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[JobEquipUnitAnalysis] CHECK CONSTRAINT [JobEquipUnitAnalysis_Priority]
GO
ALTER TABLE [dbo].[JobEquipUnitAnalysis]  WITH CHECK ADD  CONSTRAINT [JobEquipUnitAnalysis_Services] FOREIGN KEY([ServiceId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[JobEquipUnitAnalysis] CHECK CONSTRAINT [JobEquipUnitAnalysis_Services]
GO
ALTER TABLE [dbo].[JobEquipUnitAnalysis]  WITH CHECK ADD  CONSTRAINT [JobEquipUnitAnalysis_Status] FOREIGN KEY([StatusId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[JobEquipUnitAnalysis] CHECK CONSTRAINT [JobEquipUnitAnalysis_Status]
GO
ALTER TABLE [dbo].[JobEquipUnitAnalysis]  WITH CHECK ADD  CONSTRAINT [JobEquipUnitAnalysis_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[JobEquipUnitAnalysis] CHECK CONSTRAINT [JobEquipUnitAnalysis_Users]
GO
ALTER TABLE [dbo].[JobEquipUnitAnalysisAttachments]  WITH CHECK ADD  CONSTRAINT [UnitAttachments_UnitAnalysis] FOREIGN KEY([UnitAnalysisId])
REFERENCES [dbo].[JobEquipUnitAnalysis] ([UnitAnalysisId])
GO
ALTER TABLE [dbo].[JobEquipUnitAnalysisAttachments] CHECK CONSTRAINT [UnitAttachments_UnitAnalysis]
GO
ALTER TABLE [dbo].[JobEquipUnitAnalysisAttachments]  WITH NOCHECK ADD  CONSTRAINT [UnitAttachments_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[JobEquipUnitAnalysisAttachments] CHECK CONSTRAINT [UnitAttachments_Users]
GO
ALTER TABLE [dbo].[JobEquipUnitSymptoms]  WITH NOCHECK ADD  CONSTRAINT [JobEquipUnitAnalysis_SymptomType] FOREIGN KEY([SymptomTypeId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[JobEquipUnitSymptoms] CHECK CONSTRAINT [JobEquipUnitAnalysis_SymptomType]
GO
ALTER TABLE [dbo].[JobEquipUnitSymptoms]  WITH CHECK ADD  CONSTRAINT [JobEquipUnitSymptoms_FailureCause] FOREIGN KEY([IndicatedFaultId])
REFERENCES [dbo].[FailureCause] ([FailureCauseId])
GO
ALTER TABLE [dbo].[JobEquipUnitSymptoms] CHECK CONSTRAINT [JobEquipUnitSymptoms_FailureCause]
GO
ALTER TABLE [dbo].[JobEquipUnitSymptoms]  WITH CHECK ADD  CONSTRAINT [JobEquipUnitSymptoms_FailureMode] FOREIGN KEY([FailureModeId])
REFERENCES [dbo].[FailureMode] ([FailureModeId])
GO
ALTER TABLE [dbo].[JobEquipUnitSymptoms] CHECK CONSTRAINT [JobEquipUnitSymptoms_FailureMode]
GO
ALTER TABLE [dbo].[JobEquipUnitSymptoms]  WITH CHECK ADD  CONSTRAINT [JobEquipUnitSymptoms_UnitAnalysis] FOREIGN KEY([UnitAnalysisId])
REFERENCES [dbo].[JobEquipUnitAnalysis] ([UnitAnalysisId])
GO
ALTER TABLE [dbo].[JobEquipUnitSymptoms] CHECK CONSTRAINT [JobEquipUnitSymptoms_UnitAnalysis]
GO
ALTER TABLE [dbo].[JobEquipUnitSymptoms]  WITH CHECK ADD  CONSTRAINT [JobEquipUnitSymptoms_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[JobEquipUnitSymptoms] CHECK CONSTRAINT [JobEquipUnitSymptoms_Users]
GO
ALTER TABLE [dbo].[Jobs]  WITH CHECK ADD  CONSTRAINT [Jobs_Analyst] FOREIGN KEY([AnalystId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Jobs] CHECK CONSTRAINT [Jobs_Analyst]
GO
ALTER TABLE [dbo].[Jobs]  WITH CHECK ADD  CONSTRAINT [Jobs_ClientSite] FOREIGN KEY([ClientSiteId])
REFERENCES [dbo].[ClientSite] ([ClientSiteId])
GO
ALTER TABLE [dbo].[Jobs] CHECK CONSTRAINT [Jobs_ClientSite]
GO
ALTER TABLE [dbo].[Jobs]  WITH CHECK ADD  CONSTRAINT [Jobs_DataCollector] FOREIGN KEY([DataCollectorId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Jobs] CHECK CONSTRAINT [Jobs_DataCollector]
GO
ALTER TABLE [dbo].[Jobs]  WITH CHECK ADD  CONSTRAINT [Jobs_Reviewer] FOREIGN KEY([ReviewerId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Jobs] CHECK CONSTRAINT [Jobs_Reviewer]
GO
ALTER TABLE [dbo].[Jobs]  WITH CHECK ADD  CONSTRAINT [Jobs_Schedule] FOREIGN KEY([ScheduleSetupId])
REFERENCES [dbo].[ScheduleSetup] ([ScheduleSetupId])
GO
ALTER TABLE [dbo].[Jobs] CHECK CONSTRAINT [Jobs_Schedule]
GO
ALTER TABLE [dbo].[Jobs]  WITH CHECK ADD  CONSTRAINT [Jobs_Stataus] FOREIGN KEY([StatusId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[Jobs] CHECK CONSTRAINT [Jobs_Stataus]
GO
ALTER TABLE [dbo].[Jobs]  WITH CHECK ADD  CONSTRAINT [Jobs_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Jobs] CHECK CONSTRAINT [Jobs_Users]
GO
ALTER TABLE [dbo].[JobServices]  WITH CHECK ADD  CONSTRAINT [JobServices_Jobs] FOREIGN KEY([JobId])
REFERENCES [dbo].[Jobs] ([JobId])
GO
ALTER TABLE [dbo].[JobServices] CHECK CONSTRAINT [JobServices_Jobs]
GO
ALTER TABLE [dbo].[JobServices]  WITH NOCHECK ADD  CONSTRAINT [JobServices_Services] FOREIGN KEY([ServiceId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[JobServices] CHECK CONSTRAINT [JobServices_Services]
GO
ALTER TABLE [dbo].[JobServices]  WITH CHECK ADD  CONSTRAINT [JobServices_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[JobServices] CHECK CONSTRAINT [JobServices_Users]
GO
ALTER TABLE [dbo].[Languages]  WITH NOCHECK ADD  CONSTRAINT [Language_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Languages] CHECK CONSTRAINT [Language_Users]
GO
ALTER TABLE [dbo].[LeverageExport]  WITH NOCHECK ADD  CONSTRAINT [LeverageExport_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[LeverageExport] CHECK CONSTRAINT [LeverageExport_Users]
GO
ALTER TABLE [dbo].[LeverageService]  WITH CHECK ADD  CONSTRAINT [LeverageService_Equipment] FOREIGN KEY([JobEquipmentId])
REFERENCES [dbo].[JobEquipment] ([JobEquipmentId])
GO
ALTER TABLE [dbo].[LeverageService] CHECK CONSTRAINT [LeverageService_Equipment]
GO
ALTER TABLE [dbo].[LeverageService]  WITH CHECK ADD  CONSTRAINT [LeverageService_LeverageExport] FOREIGN KEY([LeverageExportId])
REFERENCES [dbo].[LeverageExport] ([LeverageExportId])
GO
ALTER TABLE [dbo].[LeverageService] CHECK CONSTRAINT [LeverageService_LeverageExport]
GO
ALTER TABLE [dbo].[LeverageService]  WITH NOCHECK ADD  CONSTRAINT [LeverageService_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[LeverageService] CHECK CONSTRAINT [LeverageService_Users]
GO
ALTER TABLE [dbo].[Lookups]  WITH NOCHECK ADD  CONSTRAINT [Lookup_Language] FOREIGN KEY([CreatedLanguageId])
REFERENCES [dbo].[Languages] ([LanguageId])
GO
ALTER TABLE [dbo].[Lookups] CHECK CONSTRAINT [Lookup_Language]
GO
ALTER TABLE [dbo].[Lookups]  WITH NOCHECK ADD  CONSTRAINT [Lookup_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Lookups] CHECK CONSTRAINT [Lookup_Users]
GO
ALTER TABLE [dbo].[LookupTranslated]  WITH NOCHECK ADD  CONSTRAINT [LookupTranslated_Language] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Languages] ([LanguageId])
GO
ALTER TABLE [dbo].[LookupTranslated] CHECK CONSTRAINT [LookupTranslated_Language]
GO
ALTER TABLE [dbo].[LookupTranslated]  WITH NOCHECK ADD  CONSTRAINT [LookupTranslated_Lookup] FOREIGN KEY([LookupId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[LookupTranslated] CHECK CONSTRAINT [LookupTranslated_Lookup]
GO
ALTER TABLE [dbo].[LookupTranslated]  WITH NOCHECK ADD  CONSTRAINT [LookupTranslated_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[LookupTranslated] CHECK CONSTRAINT [LookupTranslated_Users]
GO
ALTER TABLE [dbo].[Manufacturer]  WITH NOCHECK ADD  CONSTRAINT [Manufacturer_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Manufacturer] CHECK CONSTRAINT [Manufacturer_Users]
GO
ALTER TABLE [dbo].[ManufacturerTranslated]  WITH NOCHECK ADD  CONSTRAINT [ManufacturerTranslated_Language] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Languages] ([LanguageId])
GO
ALTER TABLE [dbo].[ManufacturerTranslated] CHECK CONSTRAINT [ManufacturerTranslated_Language]
GO
ALTER TABLE [dbo].[ManufacturerTranslated]  WITH NOCHECK ADD  CONSTRAINT [ManufacturerTranslated_Manufacturer] FOREIGN KEY([ManufacturerId])
REFERENCES [dbo].[Manufacturer] ([ManufacturerId])
GO
ALTER TABLE [dbo].[ManufacturerTranslated] CHECK CONSTRAINT [ManufacturerTranslated_Manufacturer]
GO
ALTER TABLE [dbo].[ManufacturerTranslated]  WITH NOCHECK ADD  CONSTRAINT [ManufacturerTranslated_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[ManufacturerTranslated] CHECK CONSTRAINT [ManufacturerTranslated_Users]
GO
ALTER TABLE [dbo].[OtherReportsAttachment]  WITH CHECK ADD  CONSTRAINT [OtherReportsAttachment_ClientSite] FOREIGN KEY([ClientSiteId])
REFERENCES [dbo].[ClientSite] ([ClientSiteId])
GO
ALTER TABLE [dbo].[OtherReportsAttachment] CHECK CONSTRAINT [OtherReportsAttachment_ClientSite]
GO
ALTER TABLE [dbo].[OtherReportsAttachment]  WITH CHECK ADD  CONSTRAINT [OtherReportsAttachment_PlantArea] FOREIGN KEY([PlantAreaId])
REFERENCES [dbo].[PlantArea] ([PlantAreaId])
GO
ALTER TABLE [dbo].[OtherReportsAttachment] CHECK CONSTRAINT [OtherReportsAttachment_PlantArea]
GO
ALTER TABLE [dbo].[OtherReportsAttachment]  WITH NOCHECK ADD  CONSTRAINT [OtherReportsAttachment_Reports] FOREIGN KEY([ReportTypeId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[OtherReportsAttachment] CHECK CONSTRAINT [OtherReportsAttachment_Reports]
GO
ALTER TABLE [dbo].[OtherReportsAttachment]  WITH CHECK ADD  CONSTRAINT [OtherReportsAttachment_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[OtherReportsAttachment] CHECK CONSTRAINT [OtherReportsAttachment_Users]
GO
ALTER TABLE [dbo].[PlantArea]  WITH CHECK ADD  CONSTRAINT [PlantArea_ClientSite] FOREIGN KEY([ClientSiteId])
REFERENCES [dbo].[ClientSite] ([ClientSiteId])
GO
ALTER TABLE [dbo].[PlantArea] CHECK CONSTRAINT [PlantArea_ClientSite]
GO
ALTER TABLE [dbo].[PlantArea]  WITH NOCHECK ADD  CONSTRAINT [PlantArea_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[PlantArea] CHECK CONSTRAINT [PlantArea_Users]
GO
ALTER TABLE [dbo].[PlantAreaTranslated]  WITH CHECK ADD  CONSTRAINT [PlantAreaTranslated_ClientSite] FOREIGN KEY([ClientSiteid])
REFERENCES [dbo].[ClientSite] ([ClientSiteId])
GO
ALTER TABLE [dbo].[PlantAreaTranslated] CHECK CONSTRAINT [PlantAreaTranslated_ClientSite]
GO
ALTER TABLE [dbo].[PlantAreaTranslated]  WITH CHECK ADD  CONSTRAINT [PlantAreaTranslated_Language] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Languages] ([LanguageId])
GO
ALTER TABLE [dbo].[PlantAreaTranslated] CHECK CONSTRAINT [PlantAreaTranslated_Language]
GO
ALTER TABLE [dbo].[PlantAreaTranslated]  WITH CHECK ADD  CONSTRAINT [PlantAreaTranslated_PlantArea] FOREIGN KEY([PlantAreaId])
REFERENCES [dbo].[PlantArea] ([PlantAreaId])
GO
ALTER TABLE [dbo].[PlantAreaTranslated] CHECK CONSTRAINT [PlantAreaTranslated_PlantArea]
GO
ALTER TABLE [dbo].[PlantAreaTranslated]  WITH NOCHECK ADD  CONSTRAINT [PlantAreaTranslated_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[PlantAreaTranslated] CHECK CONSTRAINT [PlantAreaTranslated_Users]
GO
ALTER TABLE [dbo].[Privileges]  WITH NOCHECK ADD  CONSTRAINT [Privileges_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Privileges] CHECK CONSTRAINT [Privileges_Users]
GO
ALTER TABLE [dbo].[ProgramPrivilegeRelation]  WITH CHECK ADD  CONSTRAINT [ProgramPrivilegeRelation_Privilege] FOREIGN KEY([PrivilegeId])
REFERENCES [dbo].[Privileges] ([PrivilegeID])
GO
ALTER TABLE [dbo].[ProgramPrivilegeRelation] CHECK CONSTRAINT [ProgramPrivilegeRelation_Privilege]
GO
ALTER TABLE [dbo].[ProgramPrivilegeRelation]  WITH CHECK ADD  CONSTRAINT [ProgramPrivilegeRelation_Programs] FOREIGN KEY([ProgramId])
REFERENCES [dbo].[Programs] ([ProgramId])
GO
ALTER TABLE [dbo].[ProgramPrivilegeRelation] CHECK CONSTRAINT [ProgramPrivilegeRelation_Programs]
GO
ALTER TABLE [dbo].[ProgramPrivilegeRelation]  WITH NOCHECK ADD  CONSTRAINT [ProgramPrivilegeRelation_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[ProgramPrivilegeRelation] CHECK CONSTRAINT [ProgramPrivilegeRelation_Users]
GO
ALTER TABLE [dbo].[Programs]  WITH CHECK ADD  CONSTRAINT [Programs_Language] FOREIGN KEY([CreatedLanguageId])
REFERENCES [dbo].[Languages] ([LanguageId])
GO
ALTER TABLE [dbo].[Programs] CHECK CONSTRAINT [Programs_Language]
GO
ALTER TABLE [dbo].[Programs]  WITH NOCHECK ADD  CONSTRAINT [Programs_MenuGroup] FOREIGN KEY([MenuGroupId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[Programs] CHECK CONSTRAINT [Programs_MenuGroup]
GO
ALTER TABLE [dbo].[Programs]  WITH CHECK ADD  CONSTRAINT [Programs_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Programs] CHECK CONSTRAINT [Programs_Users]
GO
ALTER TABLE [dbo].[ProgramTranslated]  WITH CHECK ADD  CONSTRAINT [ProgramTranslated_Language] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Languages] ([LanguageId])
GO
ALTER TABLE [dbo].[ProgramTranslated] CHECK CONSTRAINT [ProgramTranslated_Language]
GO
ALTER TABLE [dbo].[ProgramTranslated]  WITH CHECK ADD  CONSTRAINT [ProgramTranslated_Programs] FOREIGN KEY([ProgramId])
REFERENCES [dbo].[Programs] ([ProgramId])
GO
ALTER TABLE [dbo].[ProgramTranslated] CHECK CONSTRAINT [ProgramTranslated_Programs]
GO
ALTER TABLE [dbo].[ProgramTranslated]  WITH NOCHECK ADD  CONSTRAINT [ProgramTranslated_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[ProgramTranslated] CHECK CONSTRAINT [ProgramTranslated_Users]
GO
ALTER TABLE [dbo].[RoleGroup]  WITH CHECK ADD  CONSTRAINT [RoleGroup_Language] FOREIGN KEY([CreatedLanguageId])
REFERENCES [dbo].[Languages] ([LanguageId])
GO
ALTER TABLE [dbo].[RoleGroup] CHECK CONSTRAINT [RoleGroup_Language]
GO
ALTER TABLE [dbo].[RoleGroup]  WITH NOCHECK ADD  CONSTRAINT [RoleGroup_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[RoleGroup] CHECK CONSTRAINT [RoleGroup_Users]
GO
ALTER TABLE [dbo].[RoleGroupRoleRelation]  WITH NOCHECK ADD  CONSTRAINT [RoleGroupRoleRelation_RoleGroup] FOREIGN KEY([RoleGroupId])
REFERENCES [dbo].[RoleGroup] ([RoleGroupId])
GO
ALTER TABLE [dbo].[RoleGroupRoleRelation] CHECK CONSTRAINT [RoleGroupRoleRelation_RoleGroup]
GO
ALTER TABLE [dbo].[RoleGroupRoleRelation]  WITH NOCHECK ADD  CONSTRAINT [RoleGroupRoleRelation_Roles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
GO
ALTER TABLE [dbo].[RoleGroupRoleRelation] CHECK CONSTRAINT [RoleGroupRoleRelation_Roles]
GO
ALTER TABLE [dbo].[RoleGroupRoleRelation]  WITH NOCHECK ADD  CONSTRAINT [RoleGroupRoleRelation_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[RoleGroupRoleRelation] CHECK CONSTRAINT [RoleGroupRoleRelation_Users]
GO
ALTER TABLE [dbo].[RoleGroupTranslated]  WITH CHECK ADD  CONSTRAINT [RoleGroupTranslated_Language] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Languages] ([LanguageId])
GO
ALTER TABLE [dbo].[RoleGroupTranslated] CHECK CONSTRAINT [RoleGroupTranslated_Language]
GO
ALTER TABLE [dbo].[RoleGroupTranslated]  WITH CHECK ADD  CONSTRAINT [RoleGroupTranslated_RoleGroup] FOREIGN KEY([RoleGroupId])
REFERENCES [dbo].[RoleGroup] ([RoleGroupId])
GO
ALTER TABLE [dbo].[RoleGroupTranslated] CHECK CONSTRAINT [RoleGroupTranslated_RoleGroup]
GO
ALTER TABLE [dbo].[RoleGroupTranslated]  WITH NOCHECK ADD  CONSTRAINT [RoleGroupTranslated_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[RoleGroupTranslated] CHECK CONSTRAINT [RoleGroupTranslated_Users]
GO
ALTER TABLE [dbo].[RolePrgPrivilegeRelation]  WITH NOCHECK ADD  CONSTRAINT [RolePrgPrivilegeRelation_Privilege] FOREIGN KEY([PrivilegeId])
REFERENCES [dbo].[Privileges] ([PrivilegeID])
GO
ALTER TABLE [dbo].[RolePrgPrivilegeRelation] CHECK CONSTRAINT [RolePrgPrivilegeRelation_Privilege]
GO
ALTER TABLE [dbo].[RolePrgPrivilegeRelation]  WITH NOCHECK ADD  CONSTRAINT [RolePrgPrivilegeRelation_Programs] FOREIGN KEY([ProgramId])
REFERENCES [dbo].[Programs] ([ProgramId])
GO
ALTER TABLE [dbo].[RolePrgPrivilegeRelation] CHECK CONSTRAINT [RolePrgPrivilegeRelation_Programs]
GO
ALTER TABLE [dbo].[RolePrgPrivilegeRelation]  WITH NOCHECK ADD  CONSTRAINT [RolePrgPrivilegeRelation_Role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
GO
ALTER TABLE [dbo].[RolePrgPrivilegeRelation] CHECK CONSTRAINT [RolePrgPrivilegeRelation_Role]
GO
ALTER TABLE [dbo].[RolePrgPrivilegeRelation]  WITH NOCHECK ADD  CONSTRAINT [RolePrgPrivilegeRelation_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[RolePrgPrivilegeRelation] CHECK CONSTRAINT [RolePrgPrivilegeRelation_Users]
GO
ALTER TABLE [dbo].[Roles]  WITH NOCHECK ADD  CONSTRAINT [Role_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Roles] CHECK CONSTRAINT [Role_Users]
GO
ALTER TABLE [dbo].[RoleWorkFlowRelation]  WITH NOCHECK ADD  CONSTRAINT [RoleWorkFlowRelation_Roles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
GO
ALTER TABLE [dbo].[RoleWorkFlowRelation] CHECK CONSTRAINT [RoleWorkFlowRelation_Roles]
GO
ALTER TABLE [dbo].[RoleWorkFlowRelation]  WITH NOCHECK ADD  CONSTRAINT [RoleWorkFlowRelation_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[RoleWorkFlowRelation] CHECK CONSTRAINT [RoleWorkFlowRelation_Users]
GO
ALTER TABLE [dbo].[RoleWorkFlowRelation]  WITH NOCHECK ADD  CONSTRAINT [RoleWorkFlowRelation_WorkFlow] FOREIGN KEY([WorkFlowId])
REFERENCES [dbo].[WorkFlow] ([WorkFlowId])
GO
ALTER TABLE [dbo].[RoleWorkFlowRelation] CHECK CONSTRAINT [RoleWorkFlowRelation_WorkFlow]
GO
ALTER TABLE [dbo].[ScheduleEquipments]  WITH CHECK ADD  CONSTRAINT [ScheduleEquipments_Equipment] FOREIGN KEY([EquipmentId])
REFERENCES [dbo].[Equipment] ([EquipmentId])
GO
ALTER TABLE [dbo].[ScheduleEquipments] CHECK CONSTRAINT [ScheduleEquipments_Equipment]
GO
ALTER TABLE [dbo].[ScheduleEquipments]  WITH CHECK ADD  CONSTRAINT [ScheduleEquipments_SetupId] FOREIGN KEY([ScheduleSetupId])
REFERENCES [dbo].[ScheduleSetup] ([ScheduleSetupId])
GO
ALTER TABLE [dbo].[ScheduleEquipments] CHECK CONSTRAINT [ScheduleEquipments_SetupId]
GO
ALTER TABLE [dbo].[ScheduleEquipments]  WITH CHECK ADD  CONSTRAINT [ScheduleEquipments_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[ScheduleEquipments] CHECK CONSTRAINT [ScheduleEquipments_Users]
GO
ALTER TABLE [dbo].[ScheduleServices]  WITH NOCHECK ADD  CONSTRAINT [ScheduleServices_Reports] FOREIGN KEY([ServiceId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[ScheduleServices] CHECK CONSTRAINT [ScheduleServices_Reports]
GO
ALTER TABLE [dbo].[ScheduleServices]  WITH CHECK ADD  CONSTRAINT [ScheduleServices_SetupId] FOREIGN KEY([ScheduleSetupId])
REFERENCES [dbo].[ScheduleSetup] ([ScheduleSetupId])
GO
ALTER TABLE [dbo].[ScheduleServices] CHECK CONSTRAINT [ScheduleServices_SetupId]
GO
ALTER TABLE [dbo].[ScheduleSetup]  WITH CHECK ADD  CONSTRAINT [ScheduleSetup_ClientSite] FOREIGN KEY([ClientSiteId])
REFERENCES [dbo].[ClientSite] ([ClientSiteId])
GO
ALTER TABLE [dbo].[ScheduleSetup] CHECK CONSTRAINT [ScheduleSetup_ClientSite]
GO
ALTER TABLE [dbo].[ScheduleSetup]  WITH NOCHECK ADD  CONSTRAINT [ScheduleSetup_Status] FOREIGN KEY([StatusId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[ScheduleSetup] CHECK CONSTRAINT [ScheduleSetup_Status]
GO
ALTER TABLE [dbo].[ScheduleSetup]  WITH CHECK ADD  CONSTRAINT [ScheduleSetup_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[ScheduleSetup] CHECK CONSTRAINT [ScheduleSetup_Users]
GO
ALTER TABLE [dbo].[Sector]  WITH NOCHECK ADD  CONSTRAINT [Sector_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Sector] CHECK CONSTRAINT [Sector_Users]
GO
ALTER TABLE [dbo].[Sector]  WITH CHECK ADD  CONSTRAINT [SectorCreated_Language] FOREIGN KEY([CreatedLanguageId])
REFERENCES [dbo].[Languages] ([LanguageId])
GO
ALTER TABLE [dbo].[Sector] CHECK CONSTRAINT [SectorCreated_Language]
GO
ALTER TABLE [dbo].[SectorTranslated]  WITH CHECK ADD  CONSTRAINT [SectorTranslated_Language] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Languages] ([LanguageId])
GO
ALTER TABLE [dbo].[SectorTranslated] CHECK CONSTRAINT [SectorTranslated_Language]
GO
ALTER TABLE [dbo].[SectorTranslated]  WITH CHECK ADD  CONSTRAINT [SectorTranslated_Sector] FOREIGN KEY([SectorId])
REFERENCES [dbo].[Sector] ([SectorId])
GO
ALTER TABLE [dbo].[SectorTranslated] CHECK CONSTRAINT [SectorTranslated_Sector]
GO
ALTER TABLE [dbo].[SectorTranslated]  WITH NOCHECK ADD  CONSTRAINT [SectorTranslated_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[SectorTranslated] CHECK CONSTRAINT [SectorTranslated_Users]
GO
ALTER TABLE [dbo].[Segment]  WITH CHECK ADD  CONSTRAINT [Segment_Sector] FOREIGN KEY([SectorId])
REFERENCES [dbo].[Sector] ([SectorId])
GO
ALTER TABLE [dbo].[Segment] CHECK CONSTRAINT [Segment_Sector]
GO
ALTER TABLE [dbo].[Segment]  WITH CHECK ADD  CONSTRAINT [Segment_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Segment] CHECK CONSTRAINT [Segment_Users]
GO
ALTER TABLE [dbo].[SegmentTranslated]  WITH CHECK ADD  CONSTRAINT [SegmentTranslated_Language] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Languages] ([LanguageId])
GO
ALTER TABLE [dbo].[SegmentTranslated] CHECK CONSTRAINT [SegmentTranslated_Language]
GO
ALTER TABLE [dbo].[SegmentTranslated]  WITH CHECK ADD  CONSTRAINT [SegmentTranslated_Segment] FOREIGN KEY([SegmentId])
REFERENCES [dbo].[Segment] ([SegmentId])
GO
ALTER TABLE [dbo].[SegmentTranslated] CHECK CONSTRAINT [SegmentTranslated_Segment]
GO
ALTER TABLE [dbo].[SegmentTranslated]  WITH NOCHECK ADD  CONSTRAINT [SegmentTranslated_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[SegmentTranslated] CHECK CONSTRAINT [SegmentTranslated_Users]
GO
ALTER TABLE [dbo].[System]  WITH CHECK ADD  CONSTRAINT [System_Area] FOREIGN KEY([AreaId])
REFERENCES [dbo].[Area] ([AreaId])
GO
ALTER TABLE [dbo].[System] CHECK CONSTRAINT [System_Area]
GO
ALTER TABLE [dbo].[System]  WITH CHECK ADD  CONSTRAINT [System_PlantArea] FOREIGN KEY([PlantAreaId])
REFERENCES [dbo].[PlantArea] ([PlantAreaId])
GO
ALTER TABLE [dbo].[System] CHECK CONSTRAINT [System_PlantArea]
GO
ALTER TABLE [dbo].[System]  WITH CHECK ADD  CONSTRAINT [System_Sector] FOREIGN KEY([AreaId])
REFERENCES [dbo].[Area] ([AreaId])
GO
ALTER TABLE [dbo].[System] CHECK CONSTRAINT [System_Sector]
GO
ALTER TABLE [dbo].[System]  WITH CHECK ADD  CONSTRAINT [System_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[System] CHECK CONSTRAINT [System_Users]
GO
ALTER TABLE [dbo].[System]  WITH CHECK ADD  CONSTRAINT [SystemCreated_Language] FOREIGN KEY([CreatedLanguageId])
REFERENCES [dbo].[Languages] ([LanguageId])
GO
ALTER TABLE [dbo].[System] CHECK CONSTRAINT [SystemCreated_Language]
GO
ALTER TABLE [dbo].[SystemTranslated]  WITH CHECK ADD  CONSTRAINT [SystemTranslated_Language] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Languages] ([LanguageId])
GO
ALTER TABLE [dbo].[SystemTranslated] CHECK CONSTRAINT [SystemTranslated_Language]
GO
ALTER TABLE [dbo].[SystemTranslated]  WITH CHECK ADD  CONSTRAINT [SystemTranslated_System] FOREIGN KEY([SystemId])
REFERENCES [dbo].[System] ([SystemId])
GO
ALTER TABLE [dbo].[SystemTranslated] CHECK CONSTRAINT [SystemTranslated_System]
GO
ALTER TABLE [dbo].[SystemTranslated]  WITH NOCHECK ADD  CONSTRAINT [SystemTranslated_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[SystemTranslated] CHECK CONSTRAINT [SystemTranslated_Users]
GO
ALTER TABLE [dbo].[Taxonomy]  WITH CHECK ADD  CONSTRAINT [Taxonomy_AssetCategory] FOREIGN KEY([AssetCategoryId])
REFERENCES [dbo].[AssetCategory] ([AssetCategoryId])
GO
ALTER TABLE [dbo].[Taxonomy] CHECK CONSTRAINT [Taxonomy_AssetCategory]
GO
ALTER TABLE [dbo].[Taxonomy]  WITH CHECK ADD  CONSTRAINT [Taxonomy_AssetClass] FOREIGN KEY([AssetClassId])
REFERENCES [dbo].[AssetClass] ([AssetClassId])
GO
ALTER TABLE [dbo].[Taxonomy] CHECK CONSTRAINT [Taxonomy_AssetClass]
GO
ALTER TABLE [dbo].[Taxonomy]  WITH CHECK ADD  CONSTRAINT [Taxonomy_AssetSequence] FOREIGN KEY([AssetSequenceId])
REFERENCES [dbo].[AssetSequence] ([AssetSequenceId])
GO
ALTER TABLE [dbo].[Taxonomy] CHECK CONSTRAINT [Taxonomy_AssetSequence]
GO
ALTER TABLE [dbo].[Taxonomy]  WITH CHECK ADD  CONSTRAINT [Taxonomy_AssetType] FOREIGN KEY([AssetTypeId])
REFERENCES [dbo].[AssetType] ([AssetTypeId])
GO
ALTER TABLE [dbo].[Taxonomy] CHECK CONSTRAINT [Taxonomy_AssetType]
GO
ALTER TABLE [dbo].[Taxonomy]  WITH CHECK ADD  CONSTRAINT [Taxonomy_FailureCause] FOREIGN KEY([FailureCauseId])
REFERENCES [dbo].[FailureCause] ([FailureCauseId])
GO
ALTER TABLE [dbo].[Taxonomy] CHECK CONSTRAINT [Taxonomy_FailureCause]
GO
ALTER TABLE [dbo].[Taxonomy]  WITH CHECK ADD  CONSTRAINT [Taxonomy_FailureMode] FOREIGN KEY([FailureModeId])
REFERENCES [dbo].[FailureMode] ([FailureModeId])
GO
ALTER TABLE [dbo].[Taxonomy] CHECK CONSTRAINT [Taxonomy_FailureMode]
GO
ALTER TABLE [dbo].[Taxonomy]  WITH CHECK ADD  CONSTRAINT [Taxonomy_Industry] FOREIGN KEY([IndustryId])
REFERENCES [dbo].[Industry] ([IndustryId])
GO
ALTER TABLE [dbo].[Taxonomy] CHECK CONSTRAINT [Taxonomy_Industry]
GO
ALTER TABLE [dbo].[Taxonomy]  WITH CHECK ADD  CONSTRAINT [Taxonomy_Sector] FOREIGN KEY([SectorId])
REFERENCES [dbo].[Sector] ([SectorId])
GO
ALTER TABLE [dbo].[Taxonomy] CHECK CONSTRAINT [Taxonomy_Sector]
GO
ALTER TABLE [dbo].[Taxonomy]  WITH CHECK ADD  CONSTRAINT [Taxonomy_Segment] FOREIGN KEY([SegmentId])
REFERENCES [dbo].[Segment] ([SegmentId])
GO
ALTER TABLE [dbo].[Taxonomy] CHECK CONSTRAINT [Taxonomy_Segment]
GO
ALTER TABLE [dbo].[Taxonomy]  WITH CHECK ADD  CONSTRAINT [Taxonomy_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Taxonomy] CHECK CONSTRAINT [Taxonomy_Users]
GO
ALTER TABLE [dbo].[TechUpgrade]  WITH CHECK ADD  CONSTRAINT [TechUpgrade_ClientSite] FOREIGN KEY([ClientSiteId])
REFERENCES [dbo].[ClientSite] ([ClientSiteId])
GO
ALTER TABLE [dbo].[TechUpgrade] CHECK CONSTRAINT [TechUpgrade_ClientSite]
GO
ALTER TABLE [dbo].[TechUpgrade]  WITH CHECK ADD  CONSTRAINT [TechUpgrade_Equipment] FOREIGN KEY([EquipmentId])
REFERENCES [dbo].[Equipment] ([EquipmentId])
GO
ALTER TABLE [dbo].[TechUpgrade] CHECK CONSTRAINT [TechUpgrade_Equipment]
GO
ALTER TABLE [dbo].[TechUpgrade]  WITH NOCHECK ADD  CONSTRAINT [TechUpgrade_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[TechUpgrade] CHECK CONSTRAINT [TechUpgrade_Users]
GO
ALTER TABLE [dbo].[UserClientRelation]  WITH CHECK ADD  CONSTRAINT [UserClientRelation_Client] FOREIGN KEY([ClientId])
REFERENCES [dbo].[Client] ([ClientId])
GO
ALTER TABLE [dbo].[UserClientRelation] CHECK CONSTRAINT [UserClientRelation_Client]
GO
ALTER TABLE [dbo].[UserClientRelation]  WITH NOCHECK ADD  CONSTRAINT [UserClientRelation_CreatedBy] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[UserClientRelation] CHECK CONSTRAINT [UserClientRelation_CreatedBy]
GO
ALTER TABLE [dbo].[UserClientRelation]  WITH CHECK ADD  CONSTRAINT [UserClientRelation_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[UserClientRelation] CHECK CONSTRAINT [UserClientRelation_User]
GO
ALTER TABLE [dbo].[UserClientSiteRelation]  WITH CHECK ADD  CONSTRAINT [UserClientSiteRelation_Client] FOREIGN KEY([ClientSiteId])
REFERENCES [dbo].[ClientSite] ([ClientSiteId])
GO
ALTER TABLE [dbo].[UserClientSiteRelation] CHECK CONSTRAINT [UserClientSiteRelation_Client]
GO
ALTER TABLE [dbo].[UserClientSiteRelation]  WITH NOCHECK ADD  CONSTRAINT [UserClientSiteRelation_CreatedBy] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[UserClientSiteRelation] CHECK CONSTRAINT [UserClientSiteRelation_CreatedBy]
GO
ALTER TABLE [dbo].[UserClientSiteRelation]  WITH CHECK ADD  CONSTRAINT [UserClientSiteRelation_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[UserClientSiteRelation] CHECK CONSTRAINT [UserClientSiteRelation_User]
GO
ALTER TABLE [dbo].[UserCostCentreRelation]  WITH CHECK ADD  CONSTRAINT [UserCostCentreRelation_CostCentre] FOREIGN KEY([CostCentreId])
REFERENCES [dbo].[CostCentre] ([CostCentreId])
GO
ALTER TABLE [dbo].[UserCostCentreRelation] CHECK CONSTRAINT [UserCostCentreRelation_CostCentre]
GO
ALTER TABLE [dbo].[UserCostCentreRelation]  WITH NOCHECK ADD  CONSTRAINT [UserCostCentreRelation_CreatedBy] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[UserCostCentreRelation] CHECK CONSTRAINT [UserCostCentreRelation_CreatedBy]
GO
ALTER TABLE [dbo].[UserCostCentreRelation]  WITH CHECK ADD  CONSTRAINT [UserCostCentreRelation_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[UserCostCentreRelation] CHECK CONSTRAINT [UserCostCentreRelation_Users]
GO
ALTER TABLE [dbo].[UserCountryRelation]  WITH CHECK ADD  CONSTRAINT [UserCountryRelation_Country] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Country] ([CountryId])
GO
ALTER TABLE [dbo].[UserCountryRelation] CHECK CONSTRAINT [UserCountryRelation_Country]
GO
ALTER TABLE [dbo].[UserCountryRelation]  WITH NOCHECK ADD  CONSTRAINT [UserCountryRelation_CreatedBy] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[UserCountryRelation] CHECK CONSTRAINT [UserCountryRelation_CreatedBy]
GO
ALTER TABLE [dbo].[UserCountryRelation]  WITH CHECK ADD  CONSTRAINT [UserCountryRelation_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[UserCountryRelation] CHECK CONSTRAINT [UserCountryRelation_User]
GO
ALTER TABLE [dbo].[UserDashboard]  WITH NOCHECK ADD  CONSTRAINT [UserDashboard_DataViewPref] FOREIGN KEY([DataViewPrefId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[UserDashboard] CHECK CONSTRAINT [UserDashboard_DataViewPref]
GO
ALTER TABLE [dbo].[UserDashboard]  WITH CHECK ADD  CONSTRAINT [UserDashboard_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[UserDashboard] CHECK CONSTRAINT [UserDashboard_Users]
GO
ALTER TABLE [dbo].[UserDashboard]  WITH CHECK ADD  CONSTRAINT [UserDashboard_Widget] FOREIGN KEY([WidgetId])
REFERENCES [dbo].[Programs] ([ProgramId])
GO
ALTER TABLE [dbo].[UserDashboard] CHECK CONSTRAINT [UserDashboard_Widget]
GO
ALTER TABLE [dbo].[UserRoleGroupRelation]  WITH NOCHECK ADD  CONSTRAINT [FK_UserRoleGroupRelCreatedBy] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[UserRoleGroupRelation] CHECK CONSTRAINT [FK_UserRoleGroupRelCreatedBy]
GO
ALTER TABLE [dbo].[UserRoleGroupRelation]  WITH NOCHECK ADD  CONSTRAINT [FK_UserRoleGroupRelId] FOREIGN KEY([RoleGroupId])
REFERENCES [dbo].[RoleGroup] ([RoleGroupId])
GO
ALTER TABLE [dbo].[UserRoleGroupRelation] CHECK CONSTRAINT [FK_UserRoleGroupRelId]
GO
ALTER TABLE [dbo].[UserRoleGroupRelation]  WITH NOCHECK ADD  CONSTRAINT [FK_UserRoleGroupRelUserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[UserRoleGroupRelation] CHECK CONSTRAINT [FK_UserRoleGroupRelUserId]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [User_Lookup] FOREIGN KEY([UserTypeId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [User_Lookup]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [Users_Status] FOREIGN KEY([UserStatusId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [Users_Status]
GO
ALTER TABLE [dbo].[WorkFlow]  WITH NOCHECK ADD  CONSTRAINT [WorkFlow_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[WorkFlow] CHECK CONSTRAINT [WorkFlow_Users]
GO
ALTER TABLE [dbo].[WorkFlowDetail]  WITH NOCHECK ADD  CONSTRAINT [WorkFlowDetail_AvailableStatus] FOREIGN KEY([AvailableStatusId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[WorkFlowDetail] CHECK CONSTRAINT [WorkFlowDetail_AvailableStatus]
GO
ALTER TABLE [dbo].[WorkFlowDetail]  WITH NOCHECK ADD  CONSTRAINT [WorkFlowDetail_CurrentStatus] FOREIGN KEY([CurrentStatusId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[WorkFlowDetail] CHECK CONSTRAINT [WorkFlowDetail_CurrentStatus]
GO
ALTER TABLE [dbo].[WorkFlowDetail]  WITH NOCHECK ADD  CONSTRAINT [WorkFlowDetail_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[WorkFlowDetail] CHECK CONSTRAINT [WorkFlowDetail_Users]
GO
ALTER TABLE [dbo].[WorkFlowDetail]  WITH NOCHECK ADD  CONSTRAINT [WorkFlowDetail_WorkFlow] FOREIGN KEY([WorkFlowId])
REFERENCES [dbo].[WorkFlow] ([WorkFlowId])
GO
ALTER TABLE [dbo].[WorkFlowDetail] CHECK CONSTRAINT [WorkFlowDetail_WorkFlow]
GO
ALTER TABLE [dbo].[WorkNotificationAttachment]  WITH CHECK ADD  CONSTRAINT [WNAttachment_Equipment] FOREIGN KEY([WNEquipmentId])
REFERENCES [dbo].[Equipment] ([EquipmentId])
GO
ALTER TABLE [dbo].[WorkNotificationAttachment] CHECK CONSTRAINT [WNAttachment_Equipment]
GO
ALTER TABLE [dbo].[WorkNotificationAttachment]  WITH NOCHECK ADD  CONSTRAINT [WNAttachment_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[WorkNotificationAttachment] CHECK CONSTRAINT [WNAttachment_Users]
GO
ALTER TABLE [dbo].[WorkNotificationEquipment]  WITH CHECK ADD  CONSTRAINT [WorkNotificationEquipment_ClientSite] FOREIGN KEY([ClientSiteId])
REFERENCES [dbo].[ClientSite] ([ClientSiteId])
GO
ALTER TABLE [dbo].[WorkNotificationEquipment] CHECK CONSTRAINT [WorkNotificationEquipment_ClientSite]
GO
ALTER TABLE [dbo].[WorkNotificationEquipment]  WITH NOCHECK ADD  CONSTRAINT [WorkNotificationEquipment_Conditions] FOREIGN KEY([ConditionId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[WorkNotificationEquipment] CHECK CONSTRAINT [WorkNotificationEquipment_Conditions]
GO
ALTER TABLE [dbo].[WorkNotificationEquipment]  WITH CHECK ADD  CONSTRAINT [WorkNotificationEquipment_Equipment] FOREIGN KEY([EquipmentId])
REFERENCES [dbo].[Equipment] ([EquipmentId])
GO
ALTER TABLE [dbo].[WorkNotificationEquipment] CHECK CONSTRAINT [WorkNotificationEquipment_Equipment]
GO
ALTER TABLE [dbo].[WorkNotificationEquipment]  WITH CHECK ADD  CONSTRAINT [WorkNotificationEquipment_Jobs] FOREIGN KEY([JobId])
REFERENCES [dbo].[Jobs] ([JobId])
GO
ALTER TABLE [dbo].[WorkNotificationEquipment] CHECK CONSTRAINT [WorkNotificationEquipment_Jobs]
GO
ALTER TABLE [dbo].[WorkNotificationEquipment]  WITH CHECK ADD  CONSTRAINT [WorkNotificationEquipment_Status] FOREIGN KEY([StatusId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[WorkNotificationEquipment] CHECK CONSTRAINT [WorkNotificationEquipment_Status]
GO
ALTER TABLE [dbo].[WorkNotificationEquipment]  WITH CHECK ADD  CONSTRAINT [WorkNotificationEquipment_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[WorkNotificationEquipment] CHECK CONSTRAINT [WorkNotificationEquipment_Users]
GO
ALTER TABLE [dbo].[WorkNotificationEquipment]  WITH CHECK ADD  CONSTRAINT [WorkNotificationEquipment_WNDoneBy] FOREIGN KEY([WNDoneBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[WorkNotificationEquipment] CHECK CONSTRAINT [WorkNotificationEquipment_WNDoneBy]
GO
ALTER TABLE [dbo].[WorkNotificationOpportunity]  WITH CHECK ADD  CONSTRAINT [WNOpportunity_FailureCause] FOREIGN KEY([FailureCauseId])
REFERENCES [dbo].[FailureCause] ([FailureCauseId])
GO
ALTER TABLE [dbo].[WorkNotificationOpportunity] CHECK CONSTRAINT [WNOpportunity_FailureCause]
GO
ALTER TABLE [dbo].[WorkNotificationOpportunity]  WITH CHECK ADD  CONSTRAINT [WNOpportunity_FailureMode] FOREIGN KEY([FailureModeId])
REFERENCES [dbo].[FailureMode] ([FailureModeId])
GO
ALTER TABLE [dbo].[WorkNotificationOpportunity] CHECK CONSTRAINT [WNOpportunity_FailureMode]
GO
ALTER TABLE [dbo].[WorkNotificationOpportunity]  WITH NOCHECK ADD  CONSTRAINT [WNOpportunity_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[WorkNotificationOpportunity] CHECK CONSTRAINT [WNOpportunity_Users]
GO
ALTER TABLE [dbo].[WorkNotificationOpportunity]  WITH CHECK ADD  CONSTRAINT [WNOpportunity_Users1] FOREIGN KEY([ActionDoneBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[WorkNotificationOpportunity] CHECK CONSTRAINT [WNOpportunity_Users1]
GO
ALTER TABLE [dbo].[WorkNotificationOpportunity]  WITH CHECK ADD  CONSTRAINT [WNOpportunity_WorkNotificationEquipment] FOREIGN KEY([WNEquipmentId])
REFERENCES [dbo].[WorkNotificationEquipment] ([WNEquipmentId])
GO
ALTER TABLE [dbo].[WorkNotificationOpportunity] CHECK CONSTRAINT [WNOpportunity_WorkNotificationEquipment]
GO
ALTER TABLE [dbo].[WorkNotificationOpportunity]  WITH CHECK ADD  CONSTRAINT [WorkNotificationOpportunity_Equipment] FOREIGN KEY([EquipmentId])
REFERENCES [dbo].[Equipment] ([EquipmentId])
GO
ALTER TABLE [dbo].[WorkNotificationOpportunity] CHECK CONSTRAINT [WorkNotificationOpportunity_Equipment]
GO
ALTER TABLE [dbo].[WorkNotificationUnits]  WITH NOCHECK ADD  CONSTRAINT [WNUnitAnalysis_Condition] FOREIGN KEY([ConditionId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[WorkNotificationUnits] CHECK CONSTRAINT [WNUnitAnalysis_Condition]
GO
ALTER TABLE [dbo].[WorkNotificationUnits]  WITH CHECK ADD  CONSTRAINT [WNUnitAnalysis_ConfidentFactor] FOREIGN KEY([ConfidentFactorId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[WorkNotificationUnits] CHECK CONSTRAINT [WNUnitAnalysis_ConfidentFactor]
GO
ALTER TABLE [dbo].[WorkNotificationUnits]  WITH CHECK ADD  CONSTRAINT [WNUnitAnalysis_FailureProbFactor] FOREIGN KEY([FailureProbFactorId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[WorkNotificationUnits] CHECK CONSTRAINT [WNUnitAnalysis_FailureProbFactor]
GO
ALTER TABLE [dbo].[WorkNotificationUnits]  WITH CHECK ADD  CONSTRAINT [WNUnitAnalysis_Priority] FOREIGN KEY([FailureProbFactorId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[WorkNotificationUnits] CHECK CONSTRAINT [WNUnitAnalysis_Priority]
GO
ALTER TABLE [dbo].[WorkNotificationUnits]  WITH CHECK ADD  CONSTRAINT [WNUnitAnalysis_Status] FOREIGN KEY([StatusId])
REFERENCES [dbo].[Lookups] ([LookupId])
GO
ALTER TABLE [dbo].[WorkNotificationUnits] CHECK CONSTRAINT [WNUnitAnalysis_Status]
GO
ALTER TABLE [dbo].[WorkNotificationUnits]  WITH CHECK ADD  CONSTRAINT [WNUnitAnalysis_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[WorkNotificationUnits] CHECK CONSTRAINT [WNUnitAnalysis_Users]
GO
ALTER TABLE [dbo].[WorkNotificationUnits]  WITH CHECK ADD  CONSTRAINT [WNUnitAnalysis_WorkNotificationEquipment] FOREIGN KEY([WNEquipmentId])
REFERENCES [dbo].[WorkNotificationEquipment] ([WNEquipmentId])
GO
ALTER TABLE [dbo].[WorkNotificationUnits] CHECK CONSTRAINT [WNUnitAnalysis_WorkNotificationEquipment]
GO
/****** Object:  StoredProcedure [dbo].[EAppCloneEquipment]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppCloneEquipment] 
	 @EquipmentId Bigint
	,@PlantAreaId Int
	,@CloneCount int 
	,@UserId Int
	,@PlantClone int
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
	  	
		DECLARE @Cloned TABLE (
		[EquipmentId] Bigint
		,PRIMARY KEY ([EquipmentId])
		);

	WHILE (@CloneCount >0)
	BEGIN 
		Declare @NewEquipmentId Bigint, @EquipmentCode VARCHAR(5) ,@EquipmentName NVARCHAR(150),@EquipmentNName NVARCHAR(150) ,@Descriptions NVARCHAR(250) ,@ListOrder INT 
		,@OrientationId INT  ,@MountingId INT ,@StandByEquipId INT, @DriveUnitJson nvarchar(max), @DrivenUnitJson nvarchar(max)  
		,@IntermediateUnitJson nvarchar(max) ,@Active varchar(1), @Seq bigint
		, @AssetId int 	,@IdentificationName nvarchar(150)	,@DRListOrder int	,@ManufacturerId int	,   @RPM nvarchar(100)
		,@Frame nvarchar(100)	,@Voltage nvarchar(100)	,@PowerFactor nvarchar(100)	,@UnitRate nvarchar(100)	,@Model nvarchar(100)	,@HP nvarchar(100)
		,@Type nvarchar(100)	,@MotorFanBlades nvarchar(100)	,@SerialNumber nvarchar(100)	,@RotorBars nvarchar(100)	,@Poles nvarchar(100)
		,@Slots nvarchar(100)	,@BearingDriveEndId int	,@BearingNonDriveEndId int	,@PulleyDiaDrive nvarchar(100)	,@PulleyDiaDriven nvarchar(100)
		,@BeltLength nvarchar(100)	,@CouplingId int	,@MeanRepairManHours decimal(15, 5)	,@DownTimeCostPerHour decimal(15, 5)	,@CostToRepair decimal(15, 5)
		,@MeanFailureRate decimal(15, 5)	,@DriveServicesJson nvarchar(max),@DEBearingJson nvarchar(max),@NDEBearingJson nvarchar(max)
		,@DNListOrder int , @MaxRPM nvarchar(100) 
		,@Capacity nvarchar(100) , @Lubrication nvarchar(100), @RatedFlowGPM nvarchar(100),@PumpEfficiency nvarchar(100) 
		,@RatedSuctionPressure nvarchar(100),@Efficiency nvarchar(100) ,@RatedDischargePressure nvarchar(100) ,@CostPerUnit nvarchar(100)  
		,@ImpellerVanes nvarchar(100) ,@ImpellerVanesKW nvarchar(100),@Stages nvarchar(100),@NumberOfPistons nvarchar(100) 
		,@PumpType nvarchar(100),@DrivenServicesJson nvarchar(max) 
		,@Ratio nvarchar(100) ,@Size nvarchar(100)
		,@RatedRPMInput nvarchar(100)  ,@RatedRPMOutput nvarchar(100)  ,@PinionInputGearTeeth nvarchar(100) ,@PinionOutputGearTeeth nvarchar(100) 
		,@IdlerInputGearTeeth nvarchar(100)  ,@IdlerOutputGearTeeth nvarchar(100)  ,@BullGearTeeth nvarchar(100)  ,@Serial nvarchar(100) 
		,@BearingInputId int  ,@BearingOutputId int ,@IntermediateServicesJson nvarchar(max),@ManufactureYear int , @FirstInstallationDate date, @OperationModeId int 		
		,@AreaId int, @SystemId int
		DECLARE GetEquipmentCloneCur CURSOR READ_ONLY
		FOR
		Select e.EquipmentCode,e.EquipmentName, e.Descriptions,e.ListOrder,e.OrientationId,e.MountingId, e.StandByEquipId,'Y',
		AreaId,SystemId
		,(SELECT dr.DriveUnitId from EquipmentDriveUnit dr where dr.EquipmentId = e.EquipmentId and dr.Active = 'Y'  
		FOR JSON AUTO 
		)DriveUnitJson 
		,(SELECT dn.DrivenUnitId from EquipmentDrivenUnit dn where dn.EquipmentId = e.EquipmentId and dn.Active = 'Y'  
		FOR JSON AUTO 
		)DrivenUnitJson
		,(SELECT iu.IntermediateUnitId from EquipmentIntermediateUnit iu where iu.EquipmentId = e.EquipmentId and iu.Active = 'Y'  
		FOR JSON AUTO 
		)IntermediateUnitJson	 
	   From Equipment e Where e.EquipmentId = @EquipmentId
		
		OPEN GetEquipmentCloneCur
		FETCH NEXT FROM GetEquipmentCloneCur INTO @EquipmentCode,@EquipmentName, @Descriptions,@ListOrder,@OrientationId,@MountingId, @StandByEquipId,@Active,
		@AreaId,@SystemId,@DriveUnitJson,@DrivenUnitJson,@IntermediateUnitJson
		CLOSE GetEquipmentCloneCur
		DEALLOCATE GetEquipmentCloneCur

		if isnull(@PlantAreaId,0) <> 0
		Begin--Equipment Clone Starts 
			DECLARE @Created TABLE (
			[EquipId] INT
			,PRIMARY KEY ([EquipId])
			);
			 
			select  @NewEquipmentId = 0
			set @EquipmentNName = @EquipmentName
			if isnull(@PlantClone,0) = 0 
			Begin
				set @Seq = (NEXT VALUE FOR [SeqCloneUnit])
				Select @EquipmentCode = concat('E',@Seq)   , 
				@EquipmentNName =  concat(@EquipmentName, @Seq) 
			End

			MERGE [dbo].[Equipment] AS [target]
			USING (
				SELECT @NewEquipmentId 
				) AS source(EquipmentId)
				ON ([target].[EquipmentId] = [source].[EquipmentId])
			WHEN NOT MATCHED BY TARGET
				THEN
					INSERT (
					 PlantAreaId
					,AreaId
					,SystemId
					,EquipmentCode
					,EquipmentName
					,Descriptions
					,ListOrder
					,OrientationId
					,MountingId
					,StandByEquipId
					,Active
					,CreatedBy
						)
					VALUES (
					 @PlantAreaId
					,@AreaId
					,@SystemId
					,@EquipmentCode
					,@EquipmentNName
					,@Descriptions
					,@ListOrder
					,@OrientationId
					,@MountingId
					,@StandByEquipId
					,@Active
					,@UserId
						)  
				OUTPUT INSERTED.EquipmentId
				INTO @Created;
		  
				SELECT @NewEquipmentId = [EquipId]
				FROM @Created;
				Insert into @Cloned(EquipmentId)values(@NewEquipmentId);
		-------------Equipment Clone Ends -----------------

			if isnull(@NewEquipmentId,0) <> 0 
			Begin
				Begin--Drive Unit Clone Starts			
					DECLARE @DriveUnitId Bigint, @Scount int
					DROP TABLE IF EXISTS #LoadDRUnitJson
					CREATE TABLE #LoadDRUnitJson
					(
						LoaderId int not null identity(1,1),
						DriveUnitId Bigint 
					) 
	 
					Insert into #LoadDRUnitJson (DriveUnitId)
					SELECT
						JSON_Value (c.value, '$.DriveUnitId') as DriveUnitId 
					FROM OPENJSON ( @DriveUnitJson) as c 
					Select 
					@AssetId = Null, @IdentificationName = Null,@DRListOrder = Null,@ManufacturerId = Null,@RPM = Null,@Frame = Null,@Voltage = Null,
					@PowerFactor = Null,@UnitRate= Null,@Model = Null,@HP= Null,@Type= Null,@MotorFanBlades = Null,@SerialNumber = Null,@RotorBars= Null,@Poles= Null,@Slots = Null,
					@BearingDriveEndId = Null,@BearingNonDriveEndId	= Null,@PulleyDiaDrive	= Null,@PulleyDiaDriven	= Null,@BeltLength = Null,
					@CouplingId = Null,@MeanRepairManHours = Null,@DownTimeCostPerHour = Null,@CostToRepair = Null,@MeanFailureRate = Null,
					@DriveServicesJson = Null,@Active = 'Y', @ManufactureYear = null, @FirstInstallationDate = null, @OperationModeId = null,
					@DEBearingJson = Null, @NDEBearingJson = Null


					DECLARE GetDRCloneCur CURSOR READ_ONLY
					FOR
					SELECT 
					du.AssetId,du.IdentificationName,du.ListOrder,du.ManufacturerId,du.RPM ,du.Frame ,du.Voltage 
					,du.PowerFactor,du.UnitRate,du.Model,du.HP,du.[Type],du.MotorFanBlades,du.SerialNumber,du.RotorBars,du.Poles,du.Slots 
					,du.PulleyDiaDrive	,du.PulleyDiaDriven	,du.BeltLength 
					,du.CouplingId,du.MeanRepairManHours,du.DownTimeCostPerHour,du.CostToRepair,du.MeanFailureRate
					,du.ManufactureYear,du.FirstInstallationDate,du.OperationModeId,
					(SELECT db.BearingId ,db.ManufacturerId, 'Y' as Active from DriveBearing db 
					 where db.DriveUnitId = du.DriveUnitId and db.Place = 'DE' and db.Active = 'Y'
					FOR JSON AUTO 
					) DEBearings,
					(SELECT db.BearingId ,db.ManufacturerId, 'Y' as Active from DriveBearing db 
					 where db.DriveUnitId = du.DriveUnitId and db.Place = 'NDE' and db.Active = 'Y'
					FOR JSON AUTO 
					) NDEBearings,
					(SELECT ds.ReportId as ServiceId,ds.Active from DriveServices ds where ds.DriveUnitId = du.DriveUnitId and ds.Active = 'Y'  
					FOR JSON AUTO 
					) ReportingServices
					from EquipmentDriveUnit du join #LoadDRUnitJson s on s.DriveUnitId = du.DriveUnitId 

					OPEN GetDRCloneCur
					FETCH NEXT FROM GetDRCloneCur INTO
					@AssetId, @IdentificationName,@DRListOrder,@ManufacturerId,@RPM ,@Frame ,@Voltage 
					,@PowerFactor,@UnitRate,@Model,@HP,@Type,@MotorFanBlades,@SerialNumber,@RotorBars,@Poles,@Slots 
					,@PulleyDiaDrive	,@PulleyDiaDriven	,@BeltLength 
					,@CouplingId,@MeanRepairManHours,@DownTimeCostPerHour,@CostToRepair,@MeanFailureRate
					,@ManufactureYear,@FirstInstallationDate,@OperationModeId
					,@DEBearingJson,@NDEBearingJson,@DriveServicesJson
					WHILE @@FETCH_STATUS = 0
					BEGIN

						EXEC [dbo].[EAppSaveEquipmentDriveUnit] 
						0,@NewEquipmentId,@AssetId,@IdentificationName,@DRListOrder,@ManufacturerId,@RPM,@Frame,@Voltage,@PowerFactor
						,@UnitRate,@Model,@HP,@Type,@MotorFanBlades,@SerialNumber,@RotorBars,@Poles,@Slots
						,@PulleyDiaDrive,@PulleyDiaDriven,@BeltLength,@CouplingId,@MeanRepairManHours,@DownTimeCostPerHour,@CostToRepair,@MeanFailureRate
						,@DriveServicesJson,@DEBearingJson,@NDEBearingJson, @Active,@UserId,@ManufactureYear,@FirstInstallationDate,@OperationModeId

 					FETCH NEXT FROM GetDRCloneCur INTO
					@AssetId,@IdentificationName,@DRListOrder,@ManufacturerId,@RPM ,@Frame ,@Voltage 
					,@PowerFactor,@UnitRate,@Model,@HP,@Type,@MotorFanBlades,@SerialNumber,@RotorBars,@Poles,@Slots 
					,@PulleyDiaDrive	,@PulleyDiaDriven	,@BeltLength 
					,@CouplingId,@MeanRepairManHours,@DownTimeCostPerHour,@CostToRepair,@MeanFailureRate
					,@ManufactureYear,@FirstInstallationDate,@OperationModeId
					,@DEBearingJson,@NDEBearingJson,@DriveServicesJson
					END
					CLOSE GetDRCloneCur
					DEALLOCATE GetDRCloneCur

				END--DriveUnit Clone End

				Begin--Driven Unit Clone Starts			
					DECLARE @DrivenUnitId Bigint 
					DROP TABLE IF EXISTS #LoadDNUnitJson
					CREATE TABLE #LoadDNUnitJson
					(
						LoaderId int not null identity(1,1),
						DrivenUnitId Bigint 
					) 
	 
					Insert into #LoadDNUnitJson (DrivenUnitId)
					SELECT
						JSON_Value (c.value, '$.DrivenUnitId') as DrivenUnitId 
					FROM OPENJSON ( @DrivenUnitJson) as c 
					SELECT @EquipmentId = Null , @AssetId  = Null , @IdentificationName = Null , @ListOrder = Null , @ManufacturerId = Null , @MaxRPM = Null ,  
					 @Capacity   = Null , @Model  = Null , @Lubrication  = Null , @SerialNumber  = Null , @RatedFlowGPM  = Null , @PumpEfficiency   = Null , 
					 @RatedSuctionPressure  = Null , @Efficiency   = Null , @RatedDischargePressure   = Null , @CostPerUnit   = Null , @BearingDriveEndId = Null , 
					 @BearingNonDriveEndId = Null , @ImpellerVanes   = Null , @ImpellerVanesKW  = Null , @Stages  = Null , @NumberOfPistons  = Null ,  
					 @PumpType = Null , @MeanRepairManHours = Null , @DownTimeCostPerHour = Null , @CostToRepair = Null , @MeanFailureRate = Null , 
					 @DrivenServicesJson  = Null , @ManufactureYear = null, @FirstInstallationDate = null, @OperationModeId = null  ,
					 @DEBearingJson = Null, @NDEBearingJson = Null

					DECLARE GetDNCloneCur CURSOR READ_ONLY
					FOR
					SELECT 
					du.AssetId ,du.IdentificationName,du.ListOrder,du.ManufacturerId,du.MaxRPM  
					,du.Capacity  ,du.Model ,du.Lubrication ,du.SerialNumber ,du.RatedFlowGPM ,du.PumpEfficiency  
					,du.RatedSuctionPressure ,du.Efficiency  ,du.RatedDischargePressure  ,du.CostPerUnit
					,du.ImpellerVanes  ,du.ImpellerVanesKW ,du.Stages ,du.NumberOfPistons  
					,du.PumpType,du.MeanRepairManHours,du.DownTimeCostPerHour,du.CostToRepair,du.MeanFailureRate
					,du.ManufactureYear,du.FirstInstallationDate,du.OperationModeId
					,(SELECT db.BearingId ,db.ManufacturerId, 'Y' as Active from DrivenBearing db 
					 where db.DrivenUnitId = du.DrivenUnitId and db.Place = 'DE' and db.Active = 'Y'
					FOR JSON AUTO 
					) DEBearings,
					(SELECT db.BearingId ,db.ManufacturerId, 'Y' as Active from DrivenBearing db 
					 where db.DrivenUnitId = du.DrivenUnitId and db.Place = 'NDE' and db.Active = 'Y'
					FOR JSON AUTO 
					) NDEBearings
					, (SELECT ds.ReportId as ServiceId,ds.Active from DrivenServices ds where ds.DrivenUnitId = @DrivenUnitId and ds.Active = 'Y'  
					FOR JSON AUTO 
					) ReportingServices
					from EquipmentDrivenUnit du join #LoadDNUnitJson n on n.DrivenUnitId =du.DrivenUnitId 

					OPEN GetDNCloneCur
					FETCH NEXT FROM GetDNCloneCur INTO
					@AssetId ,@IdentificationName,@ListOrder,@ManufacturerId,@MaxRPM  
					,@Capacity  ,@Model ,@Lubrication ,@SerialNumber ,@RatedFlowGPM ,@PumpEfficiency  
					,@RatedSuctionPressure ,@Efficiency  ,@RatedDischargePressure  ,@CostPerUnit
					,@ImpellerVanes  ,@ImpellerVanesKW ,@Stages ,@NumberOfPistons  
					,@PumpType,@MeanRepairManHours,@DownTimeCostPerHour,@CostToRepair,@MeanFailureRate
					,@ManufactureYear,@FirstInstallationDate,@OperationModeId
					,@DEBearingJson,@NDEBearingJson,@DrivenServicesJson
					WHILE @@FETCH_STATUS = 0
					BEGIN
						EXEC [dbo].[EAppSaveEquipmentDrivenUnit] 
						0,@NewEquipmentId,@AssetId ,@IdentificationName,@ListOrder,@ManufacturerId,@MaxRPM  
						,@Capacity  ,@Model ,@Lubrication ,@SerialNumber ,@RatedFlowGPM ,@PumpEfficiency  
						,@RatedSuctionPressure ,@Efficiency  ,@RatedDischargePressure  ,@CostPerUnit,@ImpellerVanes  
						,@ImpellerVanesKW ,@Stages ,@NumberOfPistons  
						,@PumpType,@MeanRepairManHours,@DownTimeCostPerHour,@CostToRepair,@MeanFailureRate
						,@DrivenServicesJson,@DEBearingJson,@NDEBearingJson,@Active,@UserId,@ManufactureYear,@FirstInstallationDate,@OperationModeId

 					FETCH NEXT FROM GetDNCloneCur INTO
					@AssetId ,@IdentificationName,@ListOrder,@ManufacturerId,@MaxRPM  
					,@Capacity  ,@Model ,@Lubrication ,@SerialNumber ,@RatedFlowGPM ,@PumpEfficiency  
					,@RatedSuctionPressure ,@Efficiency  ,@RatedDischargePressure  ,@CostPerUnit  
					,@ImpellerVanes  ,@ImpellerVanesKW ,@Stages ,@NumberOfPistons  
					,@PumpType,@MeanRepairManHours,@DownTimeCostPerHour,@CostToRepair,@MeanFailureRate
					,@ManufactureYear,@FirstInstallationDate,@OperationModeId
					,@DEBearingJson,@NDEBearingJson,@DrivenServicesJson
					END
					CLOSE GetDNCloneCur
					DEALLOCATE GetDNCloneCur

				END--DrivenUnit Clone End

				Begin--IntermediateUnit Clone Starts			
					DECLARE @IntermediateUnitId Bigint 
					DROP TABLE IF EXISTS #LoadINUnitJson
					CREATE TABLE #LoadINUnitJson
					(
						LoaderId int not null identity(1,1),
						IntermediateUnitId Bigint 
					) 
	 
					Insert into #LoadINUnitJson (IntermediateUnitId)
					SELECT
						JSON_Value (c.value, '$.IntermediateUnitId') as IntermediateUnitId 
					FROM OPENJSON ( @IntermediateUnitJson) as c 

					SELECT @AssetId  = Null , @IdentificationName  = Null , @ListOrder  = Null , @ManufacturerId  = Null , @Ratio  = Null ,					 
					 @Size    = Null , @Model   = Null , @BeltLength   = Null , @PulleyDiaDrive    = Null , @PulleyDiaDriven   = Null ,
					 @RatedRPMInput    = Null , @RatedRPMOutput    = Null , @PinionInputGearTeeth   = Null , @PinionOutputGearTeeth  = Null , 
					 @IdlerInputGearTeeth    = Null , @IdlerOutputGearTeeth    = Null , @BullGearTeeth    = Null , @Serial   = Null ,
					 @BearingInputId  = Null , @BearingOutputId = Null , @MeanRepairManHours   = Null , @DownTimeCostPerHour  = Null ,
					 @CostToRepair   = Null , @MeanFailureRate  = Null , @IntermediateServicesJson  = Null, @Active = 'Y',
					 @ManufactureYear = Null, @FirstInstallationDate = Null, @OperationModeId = Null,
					 @DEBearingJson = Null, @NDEBearingJson = Null

					DECLARE GetINCloneCur CURSOR READ_ONLY
					FOR
					SELECT 
					 iu.AssetId ,iu.IdentificationName ,iu.ListOrder ,iu.ManufacturerId ,iu.Ratio  
					,iu.Size   ,iu.Model  ,iu.BeltLength  ,iu.PulleyDiaDrive   ,iu.PulleyDiaDriven  
					,iu.RatedRPMInput   ,iu.RatedRPMOutput   ,iu.PinionInputGearTeeth  ,iu.PinionOutputGearTeeth  
					,iu.IdlerInputGearTeeth   ,iu.IdlerOutputGearTeeth   ,iu.BullGearTeeth   ,iu.Serial  
					,iu.MeanRepairManHours  ,iu.DownTimeCostPerHour 
					,iu.CostToRepair  ,iu.MeanFailureRate
					,iu.ManufactureYear,iu.FirstInstallationDate,iu.OperationModeId 
					,(SELECT ib.BearingId ,ib.ManufacturerId, 'Y' as Active from IntermediateBearing ib 
					 where ib.IntermediateUnitId = iu.IntermediateUnitId and ib.Place = 'DE' and ib.Active = 'Y'
					FOR JSON AUTO 
					) DEBearings,
					(SELECT ib.BearingId ,ib.ManufacturerId, 'Y' as Active from IntermediateBearing ib 
					 where ib.IntermediateUnitId = iu.IntermediateUnitId and ib.Place = 'NDE' and ib.Active = 'Y'
					FOR JSON AUTO 
					) NDEBearings
					, (SELECT ds.ReportId as ServiceId,ds.Active from IntermediateServices ds where ds.IntermediateUnitId = iu.IntermediateUnitId and ds.Active = 'Y'  
					FOR JSON AUTO 
					) ReportingServices
					from EquipmentIntermediateUnit iu join #LoadINUnitJson n on n.IntermediateUnitId =iu.IntermediateUnitId
 

					OPEN GetINCloneCur
					FETCH NEXT FROM GetINCloneCur INTO
					 @AssetId ,@IdentificationName ,@ListOrder ,@ManufacturerId ,@Ratio  
					,@Size   ,@Model  ,@BeltLength  ,@PulleyDiaDrive   ,@PulleyDiaDriven  
					,@RatedRPMInput   ,@RatedRPMOutput   ,@PinionInputGearTeeth  ,@PinionOutputGearTeeth  
					,@IdlerInputGearTeeth   ,@IdlerOutputGearTeeth   ,@BullGearTeeth   ,@Serial  
					,@MeanRepairManHours  ,@DownTimeCostPerHour 
					,@CostToRepair  ,@MeanFailureRate,@ManufactureYear,@FirstInstallationDate,@OperationModeId
					,@DEBearingJson, @NDEBearingJson ,@IntermediateServicesJson
					WHILE @@FETCH_STATUS = 0
					BEGIN
						EXEC [dbo].[EAppSaveEquipmentIntermediateUnit] 
							0,@NewEquipmentId,@AssetId ,@IdentificationName ,@ListOrder ,@ManufacturerId ,@Ratio  
						,@Size   ,@Model  ,@BeltLength  ,@PulleyDiaDrive   ,@PulleyDiaDriven  
						,@RatedRPMInput   ,@RatedRPMOutput   ,@PinionInputGearTeeth  ,@PinionOutputGearTeeth  
						,@IdlerInputGearTeeth   ,@IdlerOutputGearTeeth   ,@BullGearTeeth   ,@Serial  
						,@MeanRepairManHours  ,@DownTimeCostPerHour 
						,@CostToRepair  ,@MeanFailureRate 
						,@IntermediateServicesJson,@DEBearingJson, @NDEBearingJson ,@Active,@UserId,@ManufactureYear,@FirstInstallationDate,@OperationModeId
 
 					FETCH NEXT FROM GetINCloneCur INTO
					 @AssetId ,@IdentificationName ,@ListOrder ,@ManufacturerId ,@Ratio  
					,@Size   ,@Model  ,@BeltLength  ,@PulleyDiaDrive   ,@PulleyDiaDriven  
					,@RatedRPMInput   ,@RatedRPMOutput   ,@PinionInputGearTeeth  ,@PinionOutputGearTeeth  
					,@IdlerInputGearTeeth   ,@IdlerOutputGearTeeth   ,@BullGearTeeth   ,@Serial  
					,@MeanRepairManHours  ,@DownTimeCostPerHour 
					,@CostToRepair  ,@MeanFailureRate,@ManufactureYear,@FirstInstallationDate,@OperationModeId
					,@DEBearingJson, @NDEBearingJson ,@IntermediateServicesJson
					END
					CLOSE GetINCloneCur
					DEALLOCATE GetINCloneCur

				END--IntermediateUnit Clone End
			End
			
		End --Equipment Clone End
 
	SET @CloneCount = @CloneCount - 1
	END
	COMMIT TRANSACTION;
	
	if isnull(@plantClone,0) = 0  
		Begin
		select e.Equipmentid as TId, e.EquipmentName as TName from  Equipment e
		join @Cloned c on c.EquipmentId = e.EquipmentId 
		End 
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppCloneEquipmentDrivenUnit]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppCloneEquipmentDrivenUnit] 
	 @DrivenUnitId Bigint
	,@CloneCount int 
	,@UserId Int
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
		DECLARE @Cloned TABLE (
		[DriveId] Bigint
		,PRIMARY KEY ([DriveId])
		);

		DECLARE @EquipmentId int ,@AssetId int  ,@IdentificationName nvarchar(150),@IdentificationNName nvarchar(150) ,@ListOrder int ,@ManufacturerId int ,@MaxRPM nvarchar(100) 
		,@Capacity nvarchar(100) ,@Model nvarchar(100),@Lubrication nvarchar(100),@SerialNumber nvarchar(100),@RatedFlowGPM nvarchar(100),@PumpEfficiency nvarchar(100) 
		,@RatedSuctionPressure nvarchar(100),@Efficiency nvarchar(100) ,@RatedDischargePressure nvarchar(100) ,@CostPerUnit nvarchar(100) ,@BearingDriveEndId int 
		,@BearingNonDriveEndId int ,@ImpellerVanes nvarchar(100) ,@ImpellerVanesKW nvarchar(100),@Stages nvarchar(100),@NumberOfPistons nvarchar(100) 
		,@PumpType nvarchar(100),@MeanRepairManHours decimal(15, 4) ,@DownTimeCostPerHour decimal(15, 4) ,@CostToRepair decimal(15, 4) 
		,@MeanFailureRate decimal(15, 4) ,@DrivenServicesJson nvarchar(max)	,@ManufactureYear int , @FirstInstallationDate date, @OperationModeId int	
		, @Active Varchar(1), @DEBearingJson nvarchar(max), @NDEBearingJson nvarchar(max)
		set @Active = 'Y'
		DECLARE GetDNCloneCur CURSOR READ_ONLY
		FOR
		SELECT 
		du.EquipmentId,du.AssetId ,du.IdentificationName,du.ListOrder,du.ManufacturerId,du.MaxRPM  
		,du.Capacity  ,du.Model ,du.Lubrication ,du.SerialNumber ,du.RatedFlowGPM ,du.PumpEfficiency  
		,du.RatedSuctionPressure ,du.Efficiency  ,du.RatedDischargePressure  ,du.CostPerUnit,
		 du.ImpellerVanes  ,du.ImpellerVanesKW ,du.Stages ,du.NumberOfPistons  
		,du.PumpType,du.MeanRepairManHours,du.DownTimeCostPerHour,du.CostToRepair,du.MeanFailureRate
		,du.ManufactureYear,du.FirstInstallationDate,du.OperationModeId
		,(SELECT db.BearingId ,db.ManufacturerId, 'Y' as Active from DrivenBearing db 
		where db.DrivenUnitId = du.DrivenUnitId and db.Place = 'DE' and db.Active = 'Y'
		FOR JSON AUTO 
		) DEBearings,
		(SELECT db.BearingId ,db.ManufacturerId, 'Y' as Active from DrivenBearing db 
		where db.DrivenUnitId = du.DrivenUnitId and db.Place = 'NDE' and db.Active = 'Y'
		FOR JSON AUTO 
		) NDEBearings
		, (SELECT ds.ReportId as ServiceId,ds.Active from DrivenServices ds where ds.DrivenUnitId = @DrivenUnitId and ds.Active = 'Y'  
		FOR JSON AUTO 
		) ReportingServices
		from EquipmentDrivenUnit du 
		Where du.DrivenUnitId = @DrivenUnitId

		OPEN GetDNCloneCur
		FETCH NEXT FROM GetDNCloneCur INTO
		@EquipmentId,@AssetId ,@IdentificationName,@ListOrder,@ManufacturerId,@MaxRPM  
		,@Capacity  ,@Model ,@Lubrication ,@SerialNumber ,@RatedFlowGPM ,@PumpEfficiency  
		,@RatedSuctionPressure ,@Efficiency  ,@RatedDischargePressure  ,@CostPerUnit
		,@ImpellerVanes  ,@ImpellerVanesKW ,@Stages ,@NumberOfPistons  
		,@PumpType,@MeanRepairManHours,@DownTimeCostPerHour,@CostToRepair,@MeanFailureRate
		,@ManufactureYear,@FirstInstallationDate,@OperationModeId
		,@DEBearingJson,@NDEBearingJson,@DrivenServicesJson
		WHILE @@FETCH_STATUS = 0
		BEGIN
			WHILE (@CloneCount >0)
			BEGIN
				Set @IdentificationNName = concat(@IdentificationName, (NEXT VALUE FOR [SeqCloneUnit]) )  
				EXEC [dbo].[EAppSaveEquipmentDrivenUnit] 
				0,@EquipmentId,@AssetId ,@IdentificationNName,@ListOrder,@ManufacturerId,@MaxRPM  
				,@Capacity  ,@Model ,@Lubrication ,@SerialNumber ,@RatedFlowGPM ,@PumpEfficiency  
				,@RatedSuctionPressure ,@Efficiency  ,@RatedDischargePressure  ,@CostPerUnit 
				,@ImpellerVanes  ,@ImpellerVanesKW ,@Stages ,@NumberOfPistons  
				,@PumpType,@MeanRepairManHours,@DownTimeCostPerHour,@CostToRepair,@MeanFailureRate
				,@DrivenServicesJson,@DEBearingJson,@NDEBearingJson,@Active,@UserId,@ManufactureYear,@FirstInstallationDate,@OperationModeId

				Insert into @Cloned(DriveId)
				Select DrivenUnitId from EquipmentDrivenUnit 
				where EquipmentId = @EquipmentId and IdentificationName =  @IdentificationNName 

				SET @CloneCount = @CloneCount - 1
			END
 		FETCH NEXT FROM GetDNCloneCur INTO
		@EquipmentId,@AssetId ,@IdentificationName,@ListOrder,@ManufacturerId,@MaxRPM  
		,@Capacity  ,@Model ,@Lubrication ,@SerialNumber ,@RatedFlowGPM ,@PumpEfficiency  
		,@RatedSuctionPressure ,@Efficiency  ,@RatedDischargePressure  ,@CostPerUnit
		,@ImpellerVanes  ,@ImpellerVanesKW ,@Stages ,@NumberOfPistons  
		,@PumpType,@MeanRepairManHours,@DownTimeCostPerHour,@CostToRepair,@MeanFailureRate
		,@ManufactureYear,@FirstInstallationDate,@OperationModeId
		,@DEBearingJson,@NDEBearingJson,@DrivenServicesJson
		END
		CLOSE GetDNCloneCur
		DEALLOCATE GetDNCloneCur
	
	COMMIT TRANSACTION
	 
	select du.DrivenUnitId as TId,du.IdentificationName as TName from  EquipmentDrivenUnit du
	join @Cloned c on c.DriveId = du.DrivenUnitId 

	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppCloneEquipmentDriveUnit]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppCloneEquipmentDriveUnit] 
	 @DriveUnitId Bigint
	,@CloneCount int 
	,@UserId Int
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
		DECLARE @Cloned TABLE (
		[DriveId] Bigint
		,PRIMARY KEY ([DriveId])
		);
		DECLARE @EquipmentId int	,@AssetId int 	,@IdentificationName nvarchar(150),@IdentificationNName nvarchar(150)	,@ListOrder int	,@ManufacturerId int	,@RPM nvarchar(100)
		,@Frame nvarchar(100)	,@Voltage nvarchar(100)	,@PowerFactor nvarchar(100)	,@UnitRate nvarchar(100)	,@Model nvarchar(100)	,@HP nvarchar(100)
		,@Type nvarchar(100)	,@MotorFanBlades nvarchar(100)	,@SerialNumber nvarchar(100)	,@RotorBars nvarchar(100)	,@Poles nvarchar(100)
		,@Slots nvarchar(100)	,@BearingDriveEndId int	,@BearingNonDriveEndId int	,@PulleyDiaDrive nvarchar(100)	,@PulleyDiaDriven nvarchar(100)
		,@BeltLength nvarchar(100)	,@CouplingId int	,@MeanRepairManHours decimal(15, 4)	,@DownTimeCostPerHour decimal(15, 4)	
		,@CostToRepair decimal(15, 4)	,@MeanFailureRate decimal(15, 4),@DEBearingJson nvarchar(max),@NDEBearingJson nvarchar(max),
		@DriveServicesJson nvarchar(max), @Active Varchar(1)
		,@ManufactureYear int , @FirstInstallationDate date, @OperationModeId int	
		set @Active = 'Y'
		DECLARE GetDRCloneCur CURSOR READ_ONLY
		FOR
		SELECT 
		du.DriveUnitId,du.EquipmentId,du.IdentificationName, du.AssetId,du.ListOrder,du.ManufacturerId,du.RPM ,du.Frame ,du.Voltage 
		,du.PowerFactor,du.UnitRate,du.Model,du.HP,du.[Type],du.MotorFanBlades,du.SerialNumber,du.RotorBars,du.Poles,du.Slots 
		,du.PulleyDiaDrive	,du.PulleyDiaDriven	,du.BeltLength 
		,du.CouplingId,du.MeanRepairManHours,du.DownTimeCostPerHour,du.CostToRepair,du.MeanFailureRate
		,du.ManufactureYear,du.FirstInstallationDate,du.OperationModeId,
		(SELECT db.BearingId ,db.ManufacturerId, 'Y' as Active from DriveBearing db 
		where db.DriveUnitId = du.DriveUnitId and db.Place = 'DE' and db.Active = 'Y'
		FOR JSON AUTO 
		) DEBearings,
		(SELECT db.BearingId ,db.ManufacturerId, 'Y' as Active from DriveBearing db 
		where db.DriveUnitId = du.DriveUnitId and db.Place = 'NDE' and db.Active = 'Y'
		FOR JSON AUTO 
		) NDEBearings,
		(SELECT ds.ReportId as ServiceId,ds.Active from DriveServices ds where ds.DriveUnitId = @DriveUnitId and ds.Active = 'Y'  
		FOR JSON AUTO 
		) ReportingServices
		from EquipmentDriveUnit du 
		Where du.DriveUnitId = @DriveUnitId

		OPEN GetDRCloneCur
		FETCH NEXT FROM GetDRCloneCur INTO
		@DriveUnitId,@EquipmentId ,@IdentificationName,@AssetId, @ListOrder,@ManufacturerId,@RPM ,@Frame ,@Voltage 
		,@PowerFactor,@UnitRate,@Model,@HP,@Type,@MotorFanBlades,@SerialNumber,@RotorBars,@Poles,@Slots 
		,@PulleyDiaDrive	,@PulleyDiaDriven	,@BeltLength 
		,@CouplingId,@MeanRepairManHours,@DownTimeCostPerHour,@CostToRepair,@MeanFailureRate
		,@ManufactureYear,@FirstInstallationDate,@OperationModeId
		,@DEBearingJson,@NDEBearingJson,@DriveServicesJson
		WHILE @@FETCH_STATUS = 0
		BEGIN
			WHILE (@CloneCount >0)
			BEGIN
				Set @IdentificationNName = concat(@IdentificationName, (NEXT VALUE FOR [SeqCloneUnit]) )  
				EXEC [dbo].[EAppSaveEquipmentDriveUnit] 
				 0,@EquipmentId,@AssetId,@IdentificationNName,@ListOrder,@ManufacturerId,@RPM,@Frame,@Voltage,@PowerFactor
				,@UnitRate,@Model,@HP,@Type,@MotorFanBlades,@SerialNumber,@RotorBars,@Poles,@Slots
				,@PulleyDiaDrive,@PulleyDiaDriven,@BeltLength,@CouplingId,@MeanRepairManHours,@DownTimeCostPerHour,@CostToRepair,@MeanFailureRate
				,@DriveServicesJson,@DEBearingJson,@NDEBearingJson,@Active,@UserId,@ManufactureYear,@FirstInstallationDate,@OperationModeId

				Insert into @Cloned(DriveId)
				Select DriveUnitId from EquipmentDriveUnit 
				where EquipmentId = @EquipmentId and IdentificationName =  @IdentificationNName 

				SET @CloneCount = @CloneCount - 1
			END
 		FETCH NEXT FROM GetDRCloneCur INTO
		@DriveUnitId,@EquipmentId ,@IdentificationName,@AssetId,@ListOrder,@ManufacturerId,@RPM ,@Frame ,@Voltage 
		,@PowerFactor,@UnitRate,@Model,@HP,@Type,@MotorFanBlades,@SerialNumber,@RotorBars,@Poles,@Slots 
		,@PulleyDiaDrive	,@PulleyDiaDriven	,@BeltLength 
		,@CouplingId,@MeanRepairManHours,@DownTimeCostPerHour,@CostToRepair,@MeanFailureRate
		,@ManufactureYear,@FirstInstallationDate,@OperationModeId
		,@DEBearingJson,@NDEBearingJson,@DriveServicesJson
		END
		CLOSE GetDRCloneCur
		DEALLOCATE GetDRCloneCur
	
	COMMIT TRANSACTION

	select du.DriveUnitId as TId, du.IdentificationName as TName from  EquipmentDriveUnit du
	join @Cloned c on c.DriveId = du.DriveUnitId 

	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppCloneEquipmentIntermediateUnit]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppCloneEquipmentIntermediateUnit] 
	 @IntermediateUnitId Bigint
	,@CloneCount int 
	,@UserId Int
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
		DECLARE @Cloned TABLE (
		[DriveId] Bigint
		,PRIMARY KEY ([DriveId])
		);
		DECLARE @EquipmentId int ,@AssetId int  ,@IdentificationName nvarchar(150),@IdentificationNName nvarchar(150)   ,@ListOrder int  ,@ManufacturerId int  ,@Ratio nvarchar(100) 
		,@Size nvarchar(100)  ,@Model nvarchar(100) ,@BeltLength nvarchar(100) ,@PulleyDiaDrive nvarchar(100)  ,@PulleyDiaDriven nvarchar(100) 
		,@RatedRPMInput nvarchar(100)  ,@RatedRPMOutput nvarchar(100)  ,@PinionInputGearTeeth nvarchar(100) ,@PinionOutputGearTeeth nvarchar(100) 
		,@IdlerInputGearTeeth nvarchar(100)  ,@IdlerOutputGearTeeth nvarchar(100)  ,@BullGearTeeth nvarchar(100)  ,@Serial nvarchar(100) 
		,@BearingInputId int  ,@BearingOutputId int ,@MeanRepairManHours decimal(15, 4)  ,@DownTimeCostPerHour decimal(15, 4) 
		,@CostToRepair decimal(15, 4)  ,@MeanFailureRate decimal(15, 4)  ,@IntermediateServicesJson nvarchar(max)
		,@DEBearingJson nvarchar(max),@NDEBearingJson nvarchar(max)
		, @Active Varchar(1),@ManufactureYear int , @FirstInstallationDate date, @OperationModeId int
	
		set @Active = 'Y'
		DECLARE GetINCloneCur CURSOR READ_ONLY
		FOR
		SELECT 
		 iu.EquipmentId,iu.AssetId ,iu.IdentificationName ,iu.ListOrder ,iu.ManufacturerId ,iu.Ratio  
		,iu.Size   ,iu.Model  ,iu.BeltLength  ,iu.PulleyDiaDrive   ,iu.PulleyDiaDriven  
		,iu.RatedRPMInput   ,iu.RatedRPMOutput   ,iu.PinionInputGearTeeth  ,iu.PinionOutputGearTeeth  
		,iu.IdlerInputGearTeeth   ,iu.IdlerOutputGearTeeth   ,iu.BullGearTeeth   ,iu.Serial  
		,iu.MeanRepairManHours  ,iu.DownTimeCostPerHour 
		,iu.CostToRepair  ,iu.MeanFailureRate ,iu.ManufactureYear,iu.FirstInstallationDate,iu.OperationModeId,
		(SELECT ib.BearingId ,ib.ManufacturerId, 'Y' as Active from IntermediateBearing ib 
		where ib.IntermediateUnitId = iu.IntermediateUnitId and ib.Place = 'DE' and ib.Active = 'Y'
		FOR JSON AUTO 
		) DEBearings,
		(SELECT ib.BearingId ,ib.ManufacturerId, 'Y' as Active from IntermediateBearing ib 
		where ib.IntermediateUnitId = iu.IntermediateUnitId and ib.Place = 'NDE' and ib.Active = 'Y'
		FOR JSON AUTO 
		) NDEBearings
		,(SELECT ds.ReportId as ServiceId,ds.Active from IntermediateServices ds where ds.IntermediateUnitId = @IntermediateUnitId and ds.Active = 'Y'  
		FOR JSON AUTO 
		) IntermediateServicesJson
		from EquipmentIntermediateUnit iu 
		Where iu.IntermediateUnitId = @IntermediateUnitId

		OPEN GetINCloneCur
		FETCH NEXT FROM GetINCloneCur INTO
		 @EquipmentId,@AssetId ,@IdentificationName ,@ListOrder ,@ManufacturerId ,@Ratio  
		,@Size ,@Model ,@BeltLength ,@PulleyDiaDrive ,@PulleyDiaDriven  
		,@RatedRPMInput ,@RatedRPMOutput ,@PinionInputGearTeeth ,@PinionOutputGearTeeth  
		,@IdlerInputGearTeeth ,@IdlerOutputGearTeeth ,@BullGearTeeth   ,@Serial  
		,@MeanRepairManHours  ,@DownTimeCostPerHour 
		,@CostToRepair ,@MeanFailureRate,@ManufactureYear,@FirstInstallationDate,@OperationModeId 
		,@DEBearingJson,@NDEBearingJson,@IntermediateServicesJson
		WHILE @@FETCH_STATUS = 0
		BEGIN
			WHILE (@CloneCount >0)
			BEGIN
				Set @IdentificationNName  = concat(@IdentificationName, (NEXT VALUE FOR [SeqCloneUnit]) )  
			 	EXEC [dbo].[EAppSaveEquipmentIntermediateUnit] 
				 0,@EquipmentId,@AssetId ,@IdentificationNName ,@ListOrder ,@ManufacturerId ,@Ratio  
				,@Size   ,@Model  ,@BeltLength  ,@PulleyDiaDrive   ,@PulleyDiaDriven  
				,@RatedRPMInput   ,@RatedRPMOutput   ,@PinionInputGearTeeth  ,@PinionOutputGearTeeth  
				,@IdlerInputGearTeeth   ,@IdlerOutputGearTeeth   ,@BullGearTeeth   ,@Serial  
				,@MeanRepairManHours  ,@DownTimeCostPerHour 
				,@CostToRepair  ,@MeanFailureRate 
				,@IntermediateServicesJson,@DEBearingJson,@NDEBearingJson,@Active,@UserId,@ManufactureYear,@FirstInstallationDate,@OperationModeId
				 
				Insert into @Cloned(DriveId)
				Select IntermediateUnitId from EquipmentIntermediateUnit
				where EquipmentId = @EquipmentId and IdentificationName =  @IdentificationNName 

				SET @CloneCount = @CloneCount - 1
			END
 		FETCH NEXT FROM GetINCloneCur INTO
		 @EquipmentId,@AssetId ,@IdentificationName ,@ListOrder ,@ManufacturerId ,@Ratio  
		,@Size ,@Model ,@BeltLength ,@PulleyDiaDrive ,@PulleyDiaDriven  
		,@RatedRPMInput ,@RatedRPMOutput ,@PinionInputGearTeeth ,@PinionOutputGearTeeth  
		,@IdlerInputGearTeeth ,@IdlerOutputGearTeeth ,@BullGearTeeth   ,@Serial  
		,@MeanRepairManHours  ,@DownTimeCostPerHour 
		,@CostToRepair ,@MeanFailureRate,@ManufactureYear,@FirstInstallationDate,@OperationModeId 
		,@DEBearingJson,@NDEBearingJson,@IntermediateServicesJson
		END
		CLOSE GetINCloneCur
		DEALLOCATE GetINCloneCur
	
	COMMIT TRANSACTION

	select du.IntermediateUnitId as TId,du.IdentificationName as TName from  EquipmentIntermediateUnit du
	join @Cloned c on c.DriveId = du.IntermediateUnitId 

	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppClonePlant]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 
CREATE   PROCEDURE [dbo].[EAppClonePlant]  
	 @PlantAreaId Int
	,@CloneCount int 
	,@UserId Int
	,@LanguageId int
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
  	DECLARE @Created TABLE (
		[PlantAreaId] Bigint
		,PRIMARY KEY ([PlantAreaId])
		);
	WHILE (@CloneCount >0)
	BEGIN 
		Declare @EquipmentId Bigint 		
		Declare @PlantAreaNId Int, @ClientSiteId INT, @PlantAreaCode VARCHAR(5), @PlantAreaName NVARCHAR(150),@PlantAreaNName NVARCHAR(150), @Descriptions NVARCHAR(150),@Seq Bigint, @Active Varchar(1)

		Select @PlantAreaName = isnull(dbo.GetNameTranslated(@PlantAreaId,@LanguageId,'PlantAreaName'),'') 
		if isnull(@PlantAreaName,'') <> ''
		Begin -- PlantAreaCloneStarts
			Set @Seq = (NEXT VALUE FOR [SeqCloneUnit]) 
			Select @ClientSiteId = (select ClientSiteId from PlantArea  where PlantAreaId = @PlantAreaId)
			Select  @PlantAreaCode = concat('C', @Seq)   , @PlantAreaNName =  concat(@PlantAreaName, @Seq)
					,@Active = 'Y'
			
		    EXEC [EAppSavePlantArea] 0 ,@LanguageId,@ClientSiteId,@PlantAreaCode,@PlantAreaNName,@Descriptions,@UserId,@Active,0
			
			Select @PlantAreaNId = PlantAreaId from PlantArea where ClientSiteid = @ClientSiteId and @PlantAreaCode = @PlantAreaCode
			Insert into @Created(PlantAreaId) Values (@PlantAreaNId)
			 
			DECLARE GetPlantCloneCur CURSOR READ_ONLY
			FOR
			Select  e.EquipmentId
			From Equipment e Where  e.PlantAreaId = @PlantAreaId and e.Active = 'Y'
		
			OPEN GetPlantCloneCur
			FETCH NEXT FROM GetPlantCloneCur INTO @EquipmentId
			WHILE @@FETCH_STATUS = 0
			BEGIN 

				EXEC [EAppCloneEquipment] @EquipmentId,@PlantAreaNId,1,@UserId, 1

			FETCH NEXT FROM GetPlantCloneCur INTO @EquipmentId
			END
			CLOSE GetPlantCloneCur
			DEALLOCATE GetPlantCloneCur 

		End -- PlantAreaCloneEnd
  
	SET @CloneCount = @CloneCount - 1
	END
	COMMIT TRANSACTION;

	select p.PlantAreaTId as TId,p.PlantAreaName as TName from PlantAreaTranslated  p 
	join @Created c on c.PlantAreaId = p.PlantAreaId and p.languageId = @LanguageId 
	
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppDBActiveUserAudit]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppDBActiveUserAudit]
	@LanguageId int 
AS
BEGIN
 	select h.AuditLogHeaderId,d.AuditLogDetailId, d.CreatedOn as ActivityTime,
	h.userId,(Select UserName from users where userid = h.userid) UserName,
	h.HostIP,h.SessionId,h.Active
	,h.CountryId as HCountryId
	,h.CostCentreId as HCostCentreId  
	,h.ClientSiteId as HClientSiteId
	,d.CountryId, dbo.GetNameTranslated(d.CountryId,@LanguageId,'CountryName') CountryName,
	d.CostCentreId, dbo.GetNameTranslated(d.CostCentreId,@LanguageId,'CostCentreName') CostCentreName,
	d.ClientSiteId, dbo.GetNameTranslated(d.ClientSiteId,@LanguageId,'ClientSiteName') ClientSiteName,
	d.CurrentPage,d.Activity
	From AuditLogHeader h join AuditLogDetail d on h.AuditLogHeaderId = d.AuditLogHeaderId
	where h.Active = 'Y' 
	order by d.UserId, h.HostIP,h.SessionId, d.CreatedOn
END
GO
/****** Object:  StoredProcedure [dbo].[EAppDBAnalystPerformance]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppDBAnalystPerformance] 
	 @LanguageId Int,
	 @UserId Int
AS
BEGIN
	select  CountryId, CostCentreId, SectorId, segmentId, IndustryId , w.ClientSiteId ,AnalystId,
	CountryName , CostCentreName ,SectorName ,SegmentName ,IndustryName, ClientSiteName, ReportDate , 
	AnalystName , TypeId , ActivityType , TypeName , ActivityCount
	From RptAnalystPerformance w join (select ClientSiteId from dbo.udtfClientAccess(@UserId)) a on a.ClientSiteId = w.ClientSiteId 
	where w.ReportDate  >= DATEADD(month,-6,getdate())
END
GO
/****** Object:  StoredProcedure [dbo].[EAppDBBearingList]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppDBBearingList] 
	 @LanguageId Int,
	 @UserId Int
AS
BEGIN
 
	select  b.CountryId,b.CostCentreId, b.SectorId,b.SegmentId,b.IndustryId, 
	b.CountryName, b.CostCentreName,   b.SectorName, b.SegmentName,b.IndustryName,b.ClientSiteId, b.ClientSiteName, b.PlantAreaId, b.PlantAreaName,b.AssetType,b.ManufacturerId as BearingManufacturerId,
	 b.ManufacturerName as BearingManufacturerName,
	 b.EquipmentCount, b.AssetCount,b.BearingCount , b.UnitManufacturerid as AssetManufacturerId, b.UnitManufacturerName as AssetManufacturer, 
	 case when b.assettype = 'Drive' then 1 when b.AssetType = 'Intermediate' then 2 when b.AssetType = 'Driven' then 3 end AssetOrder
	From RptBearingList b join (select ClientSiteId from dbo.udtfClientAccess(@UserId)) a on a.ClientSiteId = b.ClientSiteId 
	
 
END
GO
/****** Object:  StoredProcedure [dbo].[EAppDBClientList]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppDBClientList] 
	 @LanguageId Int,
	 @UserId Int
AS
BEGIN
  
	select   t.CountryId,t.CostCentreId,t.ClientSiteId,t.SectorId,t.SegmentId,t.IndustryId, 
	t.CountryName, t.CostCentreName, t.ClientSiteName, t.SectorName, t.SegmentName,t.IndustryName,
	t.PMPOfflineProgram, t.PMPOnlineProgram, t.SmartSupplierProgram
	From RptClientList t join (select ClientSiteId from dbo.udtfClientAccess(@UserId)) a on a.ClientSiteId = t.ClientSiteId 
 select * from RptClientList
END
GO
/****** Object:  StoredProcedure [dbo].[EAppDBContractPerformanceStatistics]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppDBContractPerformanceStatistics]
	 @UserId Int  
AS
BEGIN
  
 	select  r.ClientSiteId,r.ClientSiteName,r.PlantAreaId, r.PlantAreaName, r.RDate,r.RType,r.RName,r.RValue 
 	from [RptContractPerformance] r join (select   ClientSiteId from dbo.udtfClientAccess(@UserId)) c on c.ClientSiteId = r.ClientSiteId
 	where RDate >= DATEADD(year,-1,getdate())
	order by ClientSiteId,RType  
 
End
GO
/****** Object:  StoredProcedure [dbo].[EAppDBEquipmentHealthStatus]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
create   PROCEDURE [dbo].[EAppDBEquipmentHealthStatus]
	 @UserId Int 
	,@LanguageId Int 
AS
BEGIN

 select r.CountryId,r.SectorId,r.segmentId,r.IndustryId,r.CostCentreId,r.ClientSiteId,r.PlantAreaId,r.ServiceId,r.ConditionId,r.
CountryName,r.CostCentreName,r.SectorName,r.SegmentName,r.IndustryName,r.ClientSiteName,r.PlantAreaName,r.ServiceType,r.ConditionCode,
r.ConditionName,r.EventCount,r.EquipmentCount,r.JobPeriod 
 From RptEquipmentHealthStatus r  join (select ClientSiteId from dbo.udtfClientAccess(@UserId)) a on a.ClientSiteId = r.ClientSiteId  
  
END
GO
/****** Object:  StoredProcedure [dbo].[EAppDBFailureCauseStatistics]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppDBFailureCauseStatistics]
	 @UserId Int  
AS
BEGIN
  
 	select r.ReportType, r.ReportDate,r.ClientSiteId ,r.PlantAreaId ,r.UnitType ,r.FailureCauseId ,r.Consequence ,
	r.ClientSiteName , r.PlantAreaName , r.FailureCause, r.EventCount,
	r.CountryId, r.CostCentreId, r.SectorId, r.segmentId, r.IndustryId, r.CountryName, r.CostCentreName,r.SectorName,r.SegmentName,r.IndustryName
 	from RptFailureCauseStatistics r  join (select   ClientSiteId from dbo.udtfClientAccess(@UserId)) c on c.ClientSiteId = r.ClientSiteId
 	where r.ReportDate >= DATEADD(year,-1,getdate()) 
 
End
GO
/****** Object:  StoredProcedure [dbo].[EAppDBJobAssetHealthStatus]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
CREATE   PROCEDURE [dbo].[EAppDBJobAssetHealthStatus]
	 @UserId Int 
	,@LanguageId Int 
AS
BEGIN

 select  r.CountryId,r.SectorId,r.segmentId,r.IndustryId,r.CostCentreId,r.ClientSiteId,r.PlantAreaId,r.ServiceId,r.ManufacturerId, UnitType,
 CountryName,CostCentreName,SectorName,SegmentName,IndustryName,ClientSiteName,PlantAreaName, r.ServiceType,r.ManufacturerName,
 r.ConditionId,r.ConditionName,r.JobPeriod,r.EventCount 
  From [RptJobAssetHealthStatus] r  join (select ClientSiteId from dbo.udtfClientAccess(@UserId)) a on a.ClientSiteId = r.ClientSiteId 
  
    
END


 
GO
/****** Object:  StoredProcedure [dbo].[EAppDBJobEquipHealthStatus]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppDBJobEquipHealthStatus]
	 @UserId Int 
	,@LanguageId Int 
AS
BEGIN

 select r.JobId, r.JobType, r.EstStartDate,r.CountryId, r.CostCentreId,r.SectorId,r.SegmentId, r.IndustryId,
 r.ClientSiteid, r.PlantAreaId, r.ServiceId as ServiceTypeId,r.ConditionId,r.ConditionCode,r.ConditionName, r.DataCollectorId,r.AnalystId, r.Reviewerid,
 r.CountryName,r.CostCentreName, r.SectorName,r.SegmentName,r.Industryname,r.ClientSiteName, r.PlantAreaName, r.ServiceType,
 r.DataCollectorName, r.AnalystName, r. ReviewerName, r.EquipmentCount
 From RptJobEquipHealthStatus r  join (select ClientSiteId from dbo.udtfClientAccess(@UserId)) a on a.ClientSiteId = r.ClientSiteId 
 where  r.EstStartDate >= DATEADD(year,-1,getdate())
  
END
GO
/****** Object:  StoredProcedure [dbo].[EAppDBJobEquipmentList]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   PROCEDURE [dbo].[EAppDBJobEquipmentList]
	 @UserId Int 
	,@LanguageId Int 
AS
BEGIN

 select r.JobId,r.EstStartDate,r.CountryId, r.CostCentreId,r.SectorId,r.SegmentId, r.IndustryId,
 r.ClientSiteid, r.PlantAreaId, r.ServiceId as ServiceTypeId, r.DataCollectorId,r.AnalystId, r.Reviewerid,
 r.CountryName,r.CostCentreName, r.SectorName,r.SegmentName,r.Industryname,r.ClientSiteName, r.PlantAreaName, r.ServiceType,
 r.DataCollectorName, r.AnalystName, r. ReviewerName, r.EquipmentCount
 From RptJobEquipList r  join (select ClientSiteId from dbo.udtfClientAccess(@UserId)) a on a.ClientSiteId = r.ClientSiteId 
 where  r.EstStartDate >= DATEADD(year,-1,getdate())
  
END
GO
/****** Object:  StoredProcedure [dbo].[EAppDBJobList]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppDBJobList]
	 @UserId Int 
	,@LanguageId Int 
AS
BEGIN

 select r.ClientSiteid, r.Jobid, r.EstStartDate, r.JobType, r.StatusName as JobStatus, r.ReportSent as ReportSentStatus
 From RptJobList r  join (select ClientSiteId from dbo.udtfClientAccess(@UserId)) a on a.ClientSiteId = r.ClientSiteId 
 where  r.EstStartDate >= DATEADD(year,-1,getdate())
 
 
END
GO
/****** Object:  StoredProcedure [dbo].[EAppDBOpportunities]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppDBOpportunities] 
	 @LanguageId Int,
	 @UserId Int
AS
BEGIN
 
	select  r.CountryId,r.SectorId,r.SegmentId,r.IndustryId,r.CostCentreId,r.PlantAreaId,r.ClientSiteid,r.LeverageDate, 
  r.AssetType,r.BManufacturerId, r.OpportunityCount, r.BearingCount,r.CountryName,r.SectorName,r.SegmentName,r.IndustryName,
  r.CostCentreName,r.ClientSiteName,r.PlantAreaName,r.BManufacturerName,r.OpportunityName,r.OpportunityCode 
    from [dbo].[RptOpportunities] r  join (select ClientSiteId from dbo.udtfClientAccess(@UserId)) a on a.ClientSiteId = r.ClientSiteId 
 where r.LeverageDate  >= DATEADD(year,-1,getdate()) 
END
GO
/****** Object:  StoredProcedure [dbo].[EAppDBUserAuditHistory]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppDBUserAuditHistory]
	@LanguageId int 
AS
BEGIN
 	select  h.AuditLogHeaderId,d.AuditLogDetailId, d.CreatedOn as ActivityTime,
	h.userId,(Select UserName from users where userid = h.userid) UserName,
	h.HostIP,h.SessionId,h.Active
	,h.CountryId as HCountryId
	,h.CostCentreId as HCostCentreId  
	,h.ClientSiteId as HClientSiteId
	,d.CountryId, dbo.GetNameTranslated(d.CountryId,@LanguageId,'CountryName') CountryName,
	d.CostCentreId, dbo.GetNameTranslated(d.CostCentreId,@LanguageId,'CostCentreName') CostCentreName,
	d.ClientSiteId, dbo.GetNameTranslated(d.ClientSiteId,@LanguageId,'ClientSiteName') ClientSiteName,
	d.CurrentPage,d.Activity
	From AuditLogHeader h join AuditLogDetail d on h.AuditLogHeaderId = d.AuditLogHeaderId
	where  h.createdon >DATEADD(DAY,-60,getdate()) 
END
GO
/****** Object:  StoredProcedure [dbo].[EAppDBWorkNotification]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppDBWorkNotification] 
	 @LanguageId Int,
	 @UserId Int
AS
BEGIN
	select  w.CountryId, w.CostCentreId, w.SectorId, w.segmentId, w.IndustryId , w.ClientSiteId , w.PlantAreaId, 
	w.CountryName , w.CostCentreName ,w.SectorName ,w.SegmentName ,w.IndustryName, w.ClientSiteName,w.PlantAreaName ,w.WorkNotificationDate ,
	w.TotalJobs ,	w.TotalWN ,w.OpenWN ,w.CancelledWN ,w.ClosedWN ,w.TotalAssets ,w.TotalFailureReported ,
	w.TT,w.TF,w.FT,w.FF,w.AnalystId,(select username from users where userid = w.AnalystId)AnalystName
	From RptWorkNotification w join (select ClientSiteId from dbo.udtfClientAccess(@UserId)) a on a.ClientSiteId = w.ClientSiteId 
	where w.WorkNotificationDate  >= DATEADD(year,-1,getdate())
END
GO
/****** Object:  StoredProcedure [dbo].[EAppECJob]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppECJob] 
	 @JobId Bigint 
	,@StatusId Int 
	,@Result varchar(1) OUTPUT
	,@ResultText nvarchar(2500) OUTPUT
	,@NStatusId int OUTPUT
AS
BEGIN
 BEGIN TRANSACTION
	BEGIN TRY  
 
		Declare @EnteredCount int, @NewCount int ,  @JobComments  nvarchar(1500), @JobSUStatusId int, @OldStatusId int
		
		Select @Result = 'S', @ResultText = 'Job Submit Prerequest Check Success' , @NStatusId = @StatusId
  		
		Select @OldStatusId = isnull(StatusId,0), @JobSUStatusId = dbo.GetStatusId(1,'JobProcessStatus','SU')
		from Jobs where JobId = @JobId

		if @OldStatusId <>  @StatusId and @StatusId = @JobSUStatusId
		Begin
 
			Select @EnteredCount = Sum(case when dbo.GetLookupTranslated( StatusId,1,'LookupCode') ='IP' then 1 else 0 end) 
			, @NewCount = Sum(case when dbo.GetLookupTranslated( StatusId,1,'LookupCode') ='NS' then 1 else 0 end) 
			from  JobEquipment 
			where JobId = @JobId and dbo.GetLookupTranslated( StatusId,1,'LookupCode') in ('NS','IP')
			--Group by StatusId 

			if isnull(@EnteredCount,0) > 0
				Select  @Result = 'F', @ResultText = concat('All (',@EnteredCount,') Equipments are In Progress Status, do Submit manually and try')
			Else if isnull(@NewCount,0) > 0  
				Select  @Result = 'W', @ResultText = concat('All (',@NewCount,') Equipments are Not started in Status will be marked as Service not required.',char(10),'Do you want to continue ?')
		End

		if isnull(@Result,'N') <> 'S'
			Set  @NStatusId = @OldStatusId
 
	 	COMMIT TRANSACTION
 
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH

END
GO
/****** Object:  StoredProcedure [dbo].[EAppECJobEquipment]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppECJobEquipment] 
	 @JobEquipmentId Bigint 
	,@StatusId Int 
	,@UserId int
	,@IsWarningAccepted int
	,@Result varchar(1) OUTPUT
	,@ResultText nvarchar(2500) OUTPUT
	,@NStatusId int OUTPUT
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
 
		Declare @ValidationFailCount int,@ValidationSuccessCount int, @NewCount int , @EquipConditionId int,  @EquipComments  nvarchar(1500), @JobEquipStatusId int, @OldStatusId int
		
		Select @Result = 'S', @ResultText = 'Submit Prerequest Check Success' , @NStatusId = @StatusId
  		
		Select @OldStatusId = isnull(StatusId,0), @JobEquipStatusId = dbo.GetStatusId(1,'JobProcessStatus','SU')
		,@EquipConditionId = isnull(ConditionId,0), @EquipComments = isnull(Comment,'') 
		from JobEquipment where JobEquipmentId = @JobEquipmentId
 
		if @OldStatusId <>  @StatusId and @StatusId = @JobEquipStatusId
		Begin
			if ( Isnull(@EquipConditionId,0) <> 0 and len(isnull(@EquipComments,'')) >= 1 )
			Begin
	 
				Select @ValidationFailCount = Sum(case when isnull(DataValidationStatus,0) = 2 then 1 else 0 end)
				, @ValidationSuccessCount =  Sum(case when isnull(DataValidationStatus,0) = 1 then 1 else 0 end)  
				, @NewCount =  Sum(case when isnull(DataValidationStatus,0) = 0 then 1 else 0 end) 
				from  JobEquipUnitAnalysis 
				where JobEquipmentId = @JobEquipmentId 
				Group by StatusId 

				if isnull(@ValidationFailCount,0) > 0
					Select  @Result = 'F', @ResultText = concat('Submit Prerequest Check Failed.',char(10),'All (',@ValidationFailCount,') Assets are Failed in Data Validation, do clear it and try again')
				Else if isnull(@ValidationSuccessCount,0) = 0 
					Select  @Result = 'F', @ResultText = concat('Submit Prerequest Check Failed.',char(10),'All (',@NewCount,') Assets are in Not Started status, Submit is not possible.',char(10),'Please contact Administrator')
				Else if isnull(@NewCount,0) > 0  and isnull(@ValidationSuccessCount,0) > 0 
					Select  @Result = 'W', @ResultText = concat('Submit Prerequest Check.',char(10),'All (',@NewCount,') Assets in Not Started status will be marked as Service Not Required.',char(10),'Do you want to continue ?')
			 
			End
			Else
			Begin
				Select @Result = 'F', @ResultText = 'Condition code and comments are mandatory' 
			End
		End

		if isnull(@Result,'N') <> 'S'
			Set  @NStatusId = @OldStatusId
 
		COMMIT TRANSACTION
 
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppECJobEquipUnitAnalysis]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppECJobEquipUnitAnalysis] 
	 @UnitAnalysisId Bigint 
	,@StatusId Int 
	,@UserId int
	,@Result varchar(1) OUTPUT
	,@ResultText nvarchar(2500) OUTPUT
	,@NStatusId int OUTPUT
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
 
		Declare  @OldJEUStatus int, @NewJEUStatus int , @JobEquipJEUECStatus int,@JEUComments nvarchar(2500),@JEUConditionId int 
		,@JEUConfidentFactorId int , @JEUFailureProbFactorid int ,@JEUPriorityId int , @JEURecommendation nvarchar(1500), @SymStatus varchar(1)
		,@SymptomIndicatedFault int ,   @SymptomSymptoms  nvarchar(1500)
		 
		Select @Result = 'S', @ResultText = 'Success' , @NStatusId = @StatusId
  		
		Select @OldJEUStatus = isnull(StatusId,0), @NewJEUStatus = isnull(@StatusId,0), @JobEquipJEUECStatus = dbo.GetStatusId(1,'JobProcessStatus','SU')
		,@JEUConditionId = isnull(ConditionId,0), @JEUComments = isnull(Comment,'')
		,@JEUConfidentFactorId = isnull(ConfidentFactorId,0), @JEUFailureProbFactorid = isnull(FailureProbFactorid,0)
		,@JEUPriorityId = isnull(PriorityId,0), @JEURecommendation = isnull(Recommendation,'')
		from JobEquipUnitAnalysis where UnitAnalysisId = @UnitAnalysisId
		
			if ( Isnull(@JEUConditionId,0) <> 0 and len(isnull(@JEUComments,'')) >= 1 )
			Begin
				Select @Result = 'S', @ResultText = 'Submit Prerequest Check Success' 
				if cast(isnull(dbo.GetLookupTranslated(@JEUConditionId,1,'LookupCode'),0) as int) > 1 
				Begin
					if @JEUConfidentFactorId  = 0
						Select @Result = 'E', @ResultText = concat(@ResultText,char(10),'Confident Factor Missing')
					if @JEUFailureProbFactorid  = 0
						Select @Result = 'E', @ResultText = concat(@ResultText,char(10),'Failure Probabilty Factor Missing')
					if @JEUPriorityId  = 0
						Select @Result = 'E', @ResultText = concat(@ResultText,char(10),' Priority Missing')
					if @JEURecommendation  =''
						Select @Result = 'E', @ResultText = concat(@ResultText,char(10),'Recommendation is Missing')
							
					Set @SymStatus = 'N'
					DECLARE CGetSymptom CURSOR READ_ONLY
					For
					Select isnull(IndicatedFaultId,0) ,isnull(Symptoms,'') from JobEquipUnitSymptoms where UnitAnalysisId = @UnitAnalysisId
					OPEN CGetSymptom
					FETCH NEXT FROM CGetSymptom INTO @SymptomIndicatedFault, @SymptomSymptoms
					WHILE @@FETCH_STATUS = 0
						BEGIN
							if ((@SymptomIndicatedFault  = 0 and @SymptomSymptoms <> '') or (@SymptomIndicatedFault  <> 0 and @SymptomSymptoms = '') )
								Select @Result = 'E', @ResultText = concat(@ResultText,char(10),'Invalid Symptom Data')
									
							if (@SymptomIndicatedFault <> 0 and @SymptomSymptoms <> '') 
								Set @SymStatus = 'S'
									
						FETCH NEXT FROM CGetSymptom INTO
						@SymptomIndicatedFault, @SymptomSymptoms
						END
					CLOSE CGetSymptom
					DEALLOCATE CGetSymptom
					if @SymStatus = 'N'
						Select  @Result = 'E', @ResultText = concat(@ResultText,char(10),'Symptom Data Missing')
				End
			End
			Else
			Begin
				Select @Result = 'E', @ResultText = 'Condition code and comments are mandatory' 
			End


		if isnull(@Result,'N') <> 'S'
			Set  @NStatusId = @OldJEUStatus
 
		COMMIT TRANSACTION
 
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppExportOpportunityFile]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE   PROCEDURE [dbo].[EAppExportOpportunityFile]  
	@LeverageExportId Bigint, 
	@LanguageId Int 
AS
BEGIN
	Select 
     '' as '<Opportunity ROW ID>', '' as '<Start Date>',	
	Isnull(dbo.GetLookupTranslated(ls.OpportunityTypeId ,@LanguageId,'LookupValue'),'')  as '<Opportunity Name>', 
	case when Isnull(ls.Descriptions,'') ='' then Concat('Emaint-JobId:',j.JobId,' Equip.Id:',e.EquipmentId,' Oppertunity by ',(select UserName from Users where userid = ls.CreatedBy) ) else ls.Descriptions end  as '<Description>',	
	c.SiebelId as '<Account Row ID>',	Isnull(dbo.GetNameTranslated(c.ClientSiteId ,@LanguageId,'ClientSiteName'),'') as '<Account>',	c.InternalRefId as '<Cust #>',	
	'SKF Sales Process' as '<Sales Method>',	'01 - Discover Lead' as '<Sales Stage>',	'Sales Excellence Process' as '<Process>',	
	'Existing Product & Services' as '<Solution Type>',	'' as '<Offer>',	'' as '<Sales Team - Primary USERID>',	'' as '<Revenue Class>',	CONVERT(varchar,  DATEADD(DD,60,ls.Createdon), 103) as '<Due/Close Date>',	
	'SKF Internl' as '<Source Type>',	'REP Centre ' as '<Source Value>',	'' as '<Lead Quality>',	'' as '<Note>', 	'' as '<URL>',	'' as '<Reason/Won Lost>',	
	'' as '<Next  Step>',	'' as '<Won/lost Details>',	'' as '<Contact Row ID>',	'' as '<Contact Last Name>',	'' as '<Contact First Name>',	
	'' as '<Contact Mid Name>',	'' as '<Sub-Platform>',	'' as '<Sub-Product Line>',	'' as '<Product>',	'' as '<Revenue>',	'' as '<Win Prob %>',	
	'' as '<Revenue End>'  
	from LeverageService ls 
	join JobEquipment e on e.JobEquipmentId = ls.JobEquipmentId
	Join Jobs j on j.JobId = e.JobId 
	join ClientSite c on c.ClientSiteId = j.ClientSiteId
	where ls.LeverageExportId = @LeverageExportId 
	Order by ls.LeverageDate, ls.JobEquipmentId    

End
GO
/****** Object:  StoredProcedure [dbo].[EAppGetAssignToList]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

CREATE   PROCEDURE [dbo].[EAppGetAssignToList]  
	@Type varchar(30),
	@LanguageId Int, 
	@UserId Int,
	@ClientSiteId Int 
AS
BEGIN
Declare @RoleId int, @CountryId int, @CostCentreId int
select @CountryId = CountryId, @CostCentreId = CostCentreId from clientsite where clientsiteid = @ClientSiteId 

Select @RoleId = Roleid from Roles where  RoleName =case when @Type = 'DataCollector' then 'WF_DataCollector' when @Type = 'Analyst' then 'WF_Analyst' when @Type = 'Reviewer' then 'WF_Reviewer' end

;With UsrGrp as
(
Select urg.UserId  from RoleGroupRoleRelation rgr join UserRoleGroupRelation urg on urg.RoleGroupId = rgr.RoleGroupId
 and rgr.Active= 'Y' and urg.Active = 'Y'
Where rgr.roleid = @RoleId
)
select ur.UserId, u.EmailId from  UserClientSiteRelation ur join usrgrp on ur.UserId = UsrGrp.UserId
join users u on u.UserId = ur.UserId
where ur.ClientSiteId = @ClientSiteId /*and ur.UserId <> @UserId */ and ur.Active = 'Y'
union
select ur.UserId, u.EmailId from  UserCountryRelation ur join usrgrp on ur.UserId = UsrGrp.UserId
join users u on u.UserId = ur.UserId
where ur.CountryId = @CountryId /*and ur.UserId <> @UserId */ and ur.Active = 'Y'
union
select ur.UserId, u.EmailId from  UserCostCentreRelation ur join usrgrp on ur.UserId = UsrGrp.UserId
join users u on u.UserId = ur.UserId
where ur.CostCentreId = @CostcentreId /*and ur.UserId <> @UserId */ and ur.Active = 'Y'

End
GO
/****** Object:  StoredProcedure [dbo].[EAppGetClientConditionCodeDetail]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   Procedure [dbo].[EAppGetClientConditionCodeDetail]
@ClientSiteId int, @LanguageId Int  
as
begin
 
	select l.LookupCode as ConditionCode,l.ListOrder, ct.ConditionName, ct.Descriptions
	from ConditionCodeClientMapping c  join ConditionCodeClientTranslated ct on ct.CMappingId = c.CMappingId  and c.ClientSiteId =@ClientSiteId
	join lookups l on l.LookupId = c.ConditionId
	where ( ct.LanguageId = @LanguageId or (  ct.LanguageId  = c.CreatedLanguageId 
	and not exists (select 'x' from ConditionCodeClientTranslated where CMappingId = c.CMappingId and languageid = @Languageid)))
	order by l.ListOrder 
 
 
end
GO
/****** Object:  StoredProcedure [dbo].[EAppGetFailureReportDetail]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppGetFailureReportDetail] 
	@EquipmentId int
AS
BEGIN 
	Select EquipmentId,
	(select 0 as FailureReportHeaderId, 'DR' as UnitType,d.DriveUnitId as UnitId,d.IdentificationName, d.AssetId,d.MeanRepairManHours, isnull(d.MeanRepairManHours,0) MTTR,isnull(d.DownTimeCostPerHour,0)MTBF, '' Descriptions, null as FailureModeId,  null as  FailureCauseId , null as DActualRepairCost, null as DActualOutageTime, 'Y' as Active
    from EquipmentDriveUnit  d join Taxonomy t on t.TaxonomyId = d.AssetId
	where d.EquipmentId = e.EquipmentId and d.Active = 'Y'
	order by d.ListOrder
	FOR JSON AUTO , INCLUDE_NULL_VALUES
	) DriveUnitList,
    (select 0 as FailureReportHeaderId, 'IN' as UnitType,d.IntermediateUnitId as UnitId,d.IdentificationName, d.AssetId,d.MeanRepairManHours,isnull(d.MeanRepairManHours,0) MTTR,isnull(d.DownTimeCostPerHour,0)MTBF,'' Descriptions, null as FailureModeId, null as  FailureCauseId , null as DActualRepairCost, null as DActualOutageTime, 'Y' as Active
	from EquipmentIntermediateUnit  d join Taxonomy t on t.TaxonomyId = d.AssetId
	where d.EquipmentId = e.EquipmentId and d.Active = 'Y'
	order by d.ListOrder
	FOR JSON AUTO , INCLUDE_NULL_VALUES
	) IntermediateUnitList ,   
    (select 0 as FailureReportHeaderId, 'DN' as UnitType,d.DrivenUnitId as UnitId,d.IdentificationName, d.AssetId,d.MeanRepairManHours,isnull(d.MeanRepairManHours,0) MTTR,isnull(d.DownTimeCostPerHour,0)MTBF,'' Descriptions, null as FailureModeId, null as  FailureCauseId , null as DActualRepairCost, null as DActualOutageTime, 'Y' as Active
	from EquipmentDrivenUnit  d join Taxonomy t on t.TaxonomyId = d.AssetId
	where d.EquipmentId = e.EquipmentId and d.Active = 'Y'
	order by d.ListOrder
	FOR JSON AUTO , INCLUDE_NULL_VALUES
	) DrivenUnitList    
	from  Equipment e 
	where e.EquipmentId = @EquipmentId 
END 
GO
/****** Object:  StoredProcedure [dbo].[EAppGetJobScheduleReport]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppGetJobScheduleReport]
	 @ClientSiteId Bigint 
	,@StatusId Int 
AS
BEGIN
 BEGIN TRANSACTION
	BEGIN TRY  

	declare @TotalCount nvarchar(150);

	Select @TotalCount = Count(*) from Jobs where ClientSiteId = @ClientSiteId

	Select *, dbo.GetNameTranslated(StatusId,1,'LookupValue') as JobStatus, @TotalCount as TotalCount
	, 'http://ec2-18-138-91-203.ap-southeast-1.compute.amazonaws.com:8080/doc/equipment/EQ20233520190425002638625.JPG' as ImgUrl
	from Jobs j where j.ClientSiteId = @ClientSiteId -- and j.EstStartDate between @EstStartDate and @EstEndDate

	COMMIT TRANSACTION
 
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH

END
GO
/****** Object:  StoredProcedure [dbo].[EAppGetLastSession]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppGetLastSession] 
	 @UserId INT
	
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
		Select LastSessionClient as ClientSiteId from Users where UserId = @UserId;

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppGetNotification]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppGetNotification]
	@Type varchar(30),
	@ClientSiteId int,
	@LanguageId int,
	@Id Bigint,
	@UserId Int  
AS
BEGIN

Declare @List Table([Location] nvarchar(250), StartDate datetime, EndDate datetime, [Subject] nvarchar(250),Body nvarchar(2500))

If @Type = 'Notify_DataCollector'
Begin
	insert into @List
	select Isnull(dbo.GetNameTranslated(j.ClientSiteId, @LanguageId, 'ClientSiteName'), '')
	, j.EstStartDate, j.EstEndDate
	,Concat('READY FOR DATA COLLECTION: ','For Client - ',Isnull(dbo.GetNameTranslated(j.ClientSiteId, @LanguageId, 'ClientSiteName'), ''),', Job Id - ',j.JobId, ', Job Name - ', j.JobName)
	,'Hey Data Collector, you have been notified that the subjected job details is Ready for Data Collection.'
	from Jobs j where JobId = @Id;
	
	select (select (select distinct je.DataCollectorId, Concat(u.LastName,' ',u.FirstName) as [Name], Isnull(u.emailid,'') as EmailId
			from JobEquipment je join Users u on u.userid = je.DataCollectorId where je.JobId = @Id
 	FOR JSON AUTO, INCLUDE_NULL_VALUES
	) ToEmailList,
	[Location],StartDate,EndDate,[Subject],Body
	From @List
FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER) NotifyDataCollector
End

If @Type = 'Notify_Analyst'
Begin
	insert into @List
	select Isnull(dbo.GetNameTranslated(j.ClientSiteId, @LanguageId, 'ClientSiteName'), '')
	, j.EstStartDate, j.EstEndDate
	,Concat('DATA COLLECTION DONE: ','For Client - ',Isnull(dbo.GetNameTranslated(j.ClientSiteId, @LanguageId, 'ClientSiteName'), ''),', Job Id - ',j.JobId, ', Job Name - ', j.JobName)
	,'Hey Analyst, you have been notified that the data collection has been completed for the subjected Job Details, Further you can Create Report for the Job.'
	from Jobs j where JobId = @Id;
	
	select (select (select distinct je.AnalystId, Concat(u.LastName,' ',u.FirstName) as [Name], Isnull(u.emailid,'') as EmailId
			from JobEquipment je join Users u on u.userid = je.AnalystId where je.JobId = @Id
			and je.DataCollectionDone = 1
 	FOR JSON AUTO, INCLUDE_NULL_VALUES
	) ToEmailList,
	[Location],StartDate,EndDate,[Subject],Body
	From @List
FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER) NotifyAnalyst
End

If @Type = 'Notify_Reviewer'
Begin
	insert into @List
	select Isnull(dbo.GetNameTranslated(j.ClientSiteId, @LanguageId, 'ClientSiteName'), '')
	, j.EstStartDate, j.EstEndDate
	,Concat('REPORT SENT FOR REVIEW: ','For Client - ',Isnull(dbo.GetNameTranslated(j.ClientSiteId, @LanguageId, 'ClientSiteName'), ''),', Job Id - ',j.JobId, ', Job Name - ', j.JobName)
	,'Hey Reviewer, you have been notified that the subjected Job has been sent for Reviewal, Please verfify and Complete the Job.'
	from Jobs j where JobId = @Id;
	
	select (select (select distinct je.AnalystId, Concat(u.LastName,' ',u.FirstName) as [Name], Isnull(u.emailid,'') as EmailId
			from JobEquipment je join Users u on u.userid = je.ReviewerId where je.JobId = @Id
			and je.DataCollectionDone = 1
 	FOR JSON AUTO, INCLUDE_NULL_VALUES
	) ToEmailList,
	[Location],StartDate,EndDate,[Subject],Body
	From @List
FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER) NotifyReviewer
End

If @Type = 'Notify_Planner' -- Now it will notify to Reviewer Role get input from SKF Team.
Begin
	insert into @List
	select Isnull(dbo.GetNameTranslated(j.ClientSiteId, @LanguageId, 'ClientSiteName'), '')
	, j.EstStartDate, j.EstEndDate
	,Concat('JOB COMPLETED: ','For Client - ',Isnull(dbo.GetNameTranslated(j.ClientSiteId, @LanguageId, 'ClientSiteName'), ''),', Job Id - ',j.JobId, ', Job Name - ', j.JobName)
	,'Hey Man, Subjected Job has been successfully Completed.'
	from Jobs j where JobId = @Id;
	
	select (select (select distinct je.AnalystId, Concat(u.LastName,' ',u.FirstName) as [Name], Isnull(u.emailid,'') as EmailId
			from JobEquipment je join Users u on u.userid = je.ReviewerId where je.JobId = @Id
			and je.DataCollectionDone = 1
 	FOR JSON AUTO, INCLUDE_NULL_VALUES
	) ToEmailList,
	[Location],StartDate,EndDate,[Subject],Body
	From @List
FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER) NotifyPlanner
End

End
 
GO
/****** Object:  StoredProcedure [dbo].[EAppGetProgramPrivilegeAccess]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   PROCEDURE [dbo].[EAppGetProgramPrivilegeAccess]  
	@ProgramId Int, 
	@LanguageId int
AS
BEGIN
 
DROP TABLE IF EXISTS #TmpPrivilege 
DROP TABLE IF EXISTS #TmpProgram

select @ProgramId as ProgramId into #TmpProgram
 
select distinct case when (isnull(ppr.PrivilegeId,0)=0 or (isnull(ppr.PrivilegeId,0)<>0 and isnull(ppr.Active,'N') = 'N')) then 'Available' else 'Associated' end 'PrivilegeStatus',
case when (isnull(ppr.PrivilegeId,0)=0 or (isnull(ppr.PrivilegeId,0)<>0 and isnull(ppr.Active,'N') = 'N')) then ps.PrivilegeID else ppr.PrivilegeId end 'PrivilegeId' 
Into #TmpPrivilege
from ProgramPrivilegeRelation ppr right join Privileges ps on ps.PrivilegeID = ppr.PrivilegeId   and ppr.ProgramId = @ProgramId
select ( select ProgramId,
	( select distinct b.Privilegeid,dbo.GetNameTranslated(b.Privilegeid,@LanguageId,'PrivilegeName') as PrivilegeName, 'N'Active from #TmpPrivilege b  
	where b.PrivilegeStatus = 'Available'
	FOR JSON AUTO 
	) Available,
	(select distinct b.Privilegeid,dbo.GetNameTranslated(b.PrivilegeId,@LanguageId,'PrivilegeName') as PrivilegeName, 'Y'Active from #TmpPrivilege b 
	where b.PrivilegeStatus   = 'Associated' 
	FOR JSON AUTO 
	) Associated  
from #TmpProgram For JSON AUTO ) as  RrogramPrivilegeRelation
   

END
GO
/****** Object:  StoredProcedure [dbo].[EAppGetRoleGroupRoleAccess]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppGetRoleGroupRoleAccess]  
	@RoleGroupId Int, 
	@LanguageId int
AS
BEGIN
 
DROP TABLE IF EXISTS #TmpRole 
DROP TABLE IF EXISTS #TmpRoleGroup

select @RoleGroupId as RoleGroupId into #TmpRoleGroup
 
select distinct case when (isnull(rg.RoleId,0)=0 or (isnull(rg.RoleId,0)<>0 and isnull(rg.Active,'N') = 'N')) then 'Available' else 'Associated' end 'RoleStatus',
case when (isnull(rg.RoleId,0)=0 or (isnull(rg.RoleId,0)<>0 and isnull(rg.Active,'N') = 'N')) then rs.RoleId else rg.RoleId end 'RoleId' 
Into #TmpRole
from Roles rs left join RoleGroupRoleRelation rg on rs.roleid = rg.roleid   and rolegroupid = @RoleGroupId 
where rs.Active = 'Y'

select ( select RoleGroupId,
	( select distinct b.RoleId,dbo.GetNameTranslated(b.RoleId,@LanguageId,'RoleName') as RoleName, 'N'Active from #TmpRole b 
	where b.RoleStatus = 'Available' 
	FOR JSON AUTO 
	) Available,
	(select distinct b.RoleId,dbo.GetNameTranslated(b.RoleId,@LanguageId,'RoleName') as RoleName, 'Y'Active from #TmpRole b
	where b.RoleStatus   = 'Associated' 
	FOR JSON AUTO 
	) Associated  
from #TmpRoleGroup For JSON AUTO ) as  RoleGroupRoleRelation
   

END
GO
/****** Object:  StoredProcedure [dbo].[EAppGetRolePrgPrivilegeAccess]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppGetRolePrgPrivilegeAccess]  
	@RoleId Int, 
	@LanguageId int
AS
BEGIN
 
DROP TABLE IF EXISTS #TmpRole 
DROP TABLE IF EXISTS #TmpRoleProgram

select @RoleId as RoleId into #TmpRoleProgram
 
select distinct IsNull(rpp.Active,'N')Active, rpp.RoleId, rpp.HideProgram,
case when (isnull(rpp.ProgramId,0)=0 or (isnull(rpp.ProgramId,0)<>0 and isnull(rpp.Active,'N') = 'N')) then 'Available' else 'Associated' end 'ProgramStatus',
case when (isnull(rpp.ProgramId,0)=0 or (isnull(rpp.ProgramId,0)<>0 and isnull(rpp.Active,'N') = 'N')) then pr.ProgramId else rpp.ProgramId end 'ProgramId' 
Into #TmpRole
from RolePrgPrivilegeRelation rpp right join Programs pr on rpp.ProgramId = pr.ProgramId  and rpp.RoleId  = @RoleId
where pr.Active = 'Y'

select ( select RoleId,
	( select distinct b.ProgramId,dbo.GetNameTranslated(b.ProgramId,@LanguageId,'ProgramName') as ProgramName, 'N'Active, 'N'HideProgram,
		(select p.PrivilegeId,dbo.GetNameTranslated(p.PrivilegeId,@LanguageId,'PrivilegeName') as PrivilegeName, 'N' Active
			from ProgramPrivilegeRelation p where p.ProgramId =  b.ProgramId and p.active = 'Y'
			FOR JSON AUTO 
		) Privileges	
	from #TmpRole b 
	where b.ProgramStatus = 'Available'	
	and not exists (Select 'x' from #TmpRole ba where ba.ProgramId = b.ProgramId and ba.RoleId = b.Roleid and ba.RoleId = @RoleId and  ba.Active = 'Y' )
	order by dbo.GetNameTranslated(b.ProgramId,@LanguageId,'ProgramName')
	FOR JSON AUTO 
	) Available,
	(select distinct c.ProgramId,dbo.GetNameTranslated(c.ProgramId,@LanguageId,'ProgramName') as ProgramName, 'Y'Active , c.HideProgram,
		( select r.PrivilegeId,dbo.GetNameTranslated(r.PrivilegeId,@LanguageId,'PrivilegeName') as PrivilegeName,
		case when (select rpr.Active from RolePrgPrivilegeRelation rpr where rpr.roleid = @RoleId and rpr.programid = r.programid and rpr.privilegeid = r.privilegeid) is null  then 'N' 
		when (select rpr.Active from RolePrgPrivilegeRelation rpr where rpr.roleid = @RoleId and rpr.programid = r.programid and rpr.privilegeid = r.privilegeid) = 'N' then 'N' 
		else 'Y' end  as Active
			from ProgramPrivilegeRelation r where r.ProgramId = c.ProgramId and r.active = 'Y'
			FOR JSON AUTO 
		) Privileges	
	from #TmpRole c 
	where c.ProgramStatus   = 'Associated' 	
	order by dbo.GetNameTranslated(c.ProgramId,@LanguageId,'ProgramName')
	FOR JSON AUTO 
	) Associated  
from #TmpRoleProgram For JSON AUTO ) as  RolePrgPrivilageRelation
   

END
GO
/****** Object:  StoredProcedure [dbo].[EAppGetSiteUserAccess]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   PROCEDURE [dbo].[EAppGetSiteUserAccess]  
	@LanguageId Int, 
	@ClientSiteId Int
AS
BEGIN

Declare @Countryid int, @CostCentreid int, @ClientId int, @EquipCount int
select @ClientId = ClientId, @CountryId = CountryId, @CostCentreId = CostcentreId from ClientSite where ClientSiteId = @ClientSiteId 
	
 

	DROP TABLE IF EXISTS #UserAccess
	Create Table #UserAccess(UserId int, LanguageId int )
	 
	INSERT into #UserAccess (UserId, LanguageId) 
	SELECT uccr.UserId, @LanguageId from UserCostCentreRelation uccr 
	join CostCentre cc on cc.CostCentreId = uccr.CostCentreId 
	where uccr.CostCentreId = @CostCentreId and uccr.Active = 'Y' 
	Union
	SELECT ucr.UserId, @LanguageId 
	from CostCentre cc Join UserCountryRelation ucr on ucr.countryid = cc.CountryId and ucr.active = 'Y'
	where cc.CountryId = @CountryId and cc.CostCentreId = @CostCentreId and   cc.Active = 'Y' 
 	Union
	SELECT ucr.UserId, @LanguageId
	from  UserClientRelation ucr  
	where ucr.ClientId = @ClientId and   ucr.Active = 'Y' 
	Union
	SELECT ucr.UserId, @LanguageId
	from  UserClientSiteRelation ucr  
	where ucr.ClientSiteId = @ClientSiteId and   ucr.Active = 'Y' 
  
 	;With UsrGrp as
	(
	Select urg.UserId , 	
	case when r.RoleName = 'WF_Analyst' then 'Analyst' 
						when r.RoleName = 'WF_Reviewer' then 'Reviewer' 
						when r.RoleName = 'WF_DataCollector' then 'DataCollector' 
						when r.RoleName = 'WF_Planner' then 'Planner' 
						when r.RoleName = 'Admin' then 'Admin' 
						else  'Others' end RoleGroupName
	from RoleGroupRoleRelation rgr join UserRoleGroupRelation urg 
	on urg.RoleGroupId = rgr.RoleGroupId and rgr.Active= 'Y' and urg.Active = 'Y'
	join #UserAccess ur on ur.UserId = urg.UserId  
	join roles r on r.RoleId = rgr.RoleId  and r.Active = 'Y' 
	Group by r.RoleName,urg.userId
	),AvblUsers as
    (
	Select urg.UserId , Replace(r.rolename,'WF_','')RoleName
	from RoleGroupRoleRelation rgr join UserRoleGroupRelation urg 
	on urg.RoleGroupId = rgr.RoleGroupId and rgr.Active= 'Y' and urg.Active = 'Y'
	join roles r on r.RoleId = rgr.RoleId  and r.Active = 'Y' 
	Group by r.RoleName,urg.userId
	)
	Select (
	select distinct ur.UserId,
	(select username from users where userid = ur.userid)as UserName, 'N' as Active from AvblUsers ur where ur.RoleName = 'Analyst'
	and ur.UserId not in (select userid from UsrGrp g where g.UserId = ur.UserId and Replace(g.RoleGroupName,'WF_','') = 'Analyst')
 	FOR JSON AUTO ) Analyst,
		(select distinct ur.UserId,(select username from users where userid = ur.userid)as UserName, 'N' as Active from AvblUsers ur where ur.RoleName = 'Planner'
		and ur.UserId not in (select userid from UsrGrp g where g.UserId = ur.UserId and Replace(g.RoleGroupName,'WF_','') = 'Planner')
 	FOR JSON AUTO ) Planner,
		(select distinct ur.UserId,(select username from users where userid = ur.userid)as UserName, 'N' as Active from AvblUsers ur where ur.RoleName = 'DataCollector'
		and ur.UserId not in (select userid from UsrGrp g where g.UserId = ur.UserId and Replace(g.RoleGroupName,'WF_','') = 'DataCollector')
 	FOR JSON AUTO ) DataCollector,
		(select distinct ur.UserId,(select username from users where userid = ur.userid)as UserName, 'N' as Active from AvblUsers ur where ur.RoleName = 'Reviewer'
		and ur.UserId not in (select userid from UsrGrp g where g.UserId = ur.UserId and Replace(g.RoleGroupName,'WF_','') = 'Reviewer')
 	FOR JSON AUTO ) Reviewer,
	(select distinct replace(ur.RoleGroupName,'WF_','')as RoleGroupName, u.UserId, u.UserName,u.FirstName,u.LastName 
	from usrgrp ur 
	join users u on u.UserId = ur.UserId 
	join #UserAccess ura on ura.UserId = u.UserId  
	order by RoleGroupName, u.UserName
	FOR JSON AUTO )AssignedUsers
	

	 
End
GO
/****** Object:  StoredProcedure [dbo].[EAppGetUnitSymptomsTemplate]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

CREATE   PROCEDURE [dbo].[EAppGetUnitSymptomsTemplate]
	 @UnitType varchar(3),
	 @ServiceType varchar(3),
	 @LanguageId int
AS
BEGIN
	Declare @SymtomName varchar(30) 
	select  @SymtomName = case when @ServiceType = 'OA' then 'JobSymptomTypeOA' when (@UnitType = 'DR' and @ServiceType = 'VA') then 'JobSymptomType' when (@UnitType = 'DN' and @ServiceType = 'VA') then 'JobSymptomType' when (@UnitType = 'IN' and @ServiceType = 'VA') then 'JobSymptomTypeShaft' End ;
 
 	DECLARE @SymptomsLookup TABLE (
	[SymptomTypeId] int,
	[FrequencyId] int,
	[SListOrder] int,
	[FListOrder] int 
	);

	If (@ServiceType = 'VA')
	Begin
	Insert into @SymptomsLookup(FrequencyId,FListOrder,SymptomTypeId,SListOrder)
	select a.lookupid as 'FrequencyId',a.ListOrder ,b.lookupid  as 'SymptomTypeId',b.ListOrder from lookups a cross join lookups b where a.lname = 'JobFrequency' and b.lname = @SymtomName
	End
	Else if (@ServiceType = 'OA')
	Begin
	Insert into @SymptomsLookup(FrequencyId,FListOrder,SymptomTypeId,SListOrder)
	select a.lookupid as 'FrequencyId',a.ListOrder ,b.lookupid  as 'SymptomTypeId',b.ListOrder from lookups a cross join lookups b where a.lname = 'JobFrequencyOA' and b.lname = @SymtomName
	End

 	Select 
	(select 0 as UnitSymptomsId ,0 as UnitAnalysisId ,
	isnull(js.SymptomTypeId,0) as SymptomTypeId,
	isnull(dbo.GetLookupTranslated(js.SymptomTypeId, @LanguageId,'LookupValue'),'') as SymptomType,
	isnull(js.FrequencyId,0) as FrequencyId,
	isnull(dbo.GetLookupTranslated(js.FrequencyId, @LanguageId,'LookupValue'),'')as Frequency,
	0 as FailureModeId,
	0 as IndicatedFaultId,
	'' as Symptoms,'N' as Active
	from @SymptomsLookup js 
	order by js.SListOrder,js.FListOrder						  
	FOR JSON AUTO 
	) JobUnitSymptomsListJson  

END
 
GO
/****** Object:  StoredProcedure [dbo].[EAppGetUserClientSiteAccess]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppGetUserClientSiteAccess] @LanguageId INT
	,@Type VARCHAR(50)
	,@UserId INT
	,@CountryId INT
	,@CostCentreId INT
AS
BEGIN

	IF @Type = 'Country'
	BEGIN
		DROP TABLE IF EXISTS #CountryAccess 

		CREATE TABLE #CountryAccess (
			CountryId INT 
			);
		Insert into #CountryAccess (CountryId )
		SELECT a.CountryId 
		FROM UserCountryRelation a
		WHERE a.UserId = @UserId and a.Active = 'Y'
		
		Insert into #CountryAccess (CountryId )
		SELECT c.CountryId
		FROM UserCostCentreRelation a join CostCentre c on c.CostCentreId = a.CostCentreId
		WHERE a.UserId = @UserId and a.Active = 'Y'	
		
		
		SELECT a.CountryId
		,Isnull(dbo.GetNameTranslated(a.CountryId, @LanguageId, 'CountryName'), '') AS CountryName
		From #CountryAccess a 
		Group by a.CountryId
	
	END
	ELSE IF @Type = 'CostCentre'
	BEGIN

		DROP TABLE IF EXISTS #CostCentreAccess 

		CREATE TABLE #CostCentreAccess (
			CostCentreId INT 
			);
 		
		Insert into #CostCentreAccess (CostCentreId )
		SELECT a.CostCentreId
		FROM UserCostCentreRelation a 
		WHERE a.UserId = @UserId and a.Active = 'Y'	 
	
		Insert into #CostCentreAccess (CostCentreId )
		SELECT c.CostCentreId 
		FROM UserCountryRelation a join CostCentre c on c.CountryId =a.CountryId 
		WHERE a.UserId = @UserId and a.Active = 'Y'
				
 
		SELECT c.CountryId
			,Isnull(dbo.GetNameTranslated(c.CountryId, @LanguageId, 'CountryName'), '') AS CountryName
			,a.CostCentreId
			,IsNull(dbo.GetNameTranslated(a.CostCentreId, @LanguageId, 'CostCentreName'), '') AS CostCentreName
		FROM #CostCentreAccess a join CostCentre c on c.CostCentreId = a.CostCentreId and c.CountryId = @CountryId
		GROUP BY c.CountryId, a.CostCentreId
	
	END
	ELSE
	BEGIN
		DROP TABLE IF EXISTS #ClientSiteAccess
		DROP TABLE IF EXISTS #UserClientSiteAccess

		CREATE TABLE #ClientSiteAccess (
			CountryId INT
			,CostCentreId INT
			,ClientId INT
			,ClientSiteId INT
			)

		INSERT INTO #ClientSiteAccess (
			CountryId
			,CostCentreId
			,ClientId
			,ClientSiteId
			)
		SELECT cs.CountryId
			,cs.CostCentreId
			,cs.ClientId
			,cs.ClientSiteId
		FROM ClientSite cs
		JOIN UserCountryRelation ucr ON ucr.CountryId = cs.CountryId
		WHERE ucr.UserId = @UserId
			AND ucr.Active = 'Y'

		INSERT INTO #ClientSiteAccess (
			CountryId
			,CostCentreId
			,ClientId
			,ClientSiteId
			)
		SELECT cs.CountryId
			,cs.CostCentreId
			,cs.ClientId
			,cs.ClientSiteId
		FROM ClientSite cs
		JOIN UserCostCentreRelation uccr ON uccr.CostCentreId = cs.CostCentreId
		WHERE uccr.UserId = @UserId
			AND uccr.Active = 'Y'

		INSERT INTO #ClientSiteAccess (
			CountryId
			,CostCentreId
			,ClientId
			,ClientSiteId
			)
		SELECT cs.CountryId
			,cs.CostCentreId
			,cs.ClientId
			,cs.ClientSiteId
		FROM ClientSite cs
		JOIN UserClientRelation ucr ON ucr.ClientId = cs.ClientId
		WHERE ucr.UserId = @UserId
			AND ucr.Active = 'Y'

		INSERT INTO #ClientSiteAccess (
			CountryId
			,CostCentreId
			,ClientId
			,ClientSiteId
			)
		SELECT cs.CountryId
			,cs.CostCentreId
			,cs.ClientId
			,cs.ClientSiteId
		FROM ClientSite cs
		JOIN UserClientSiteRelation ucsr ON ucsr.ClientSiteId = cs.ClientSiteId
		WHERE ucsr.UserId = @UserId
			AND ucsr.Active = 'Y'

		SELECT ucsa.Countryid
			,ucsa.CostCentreId
			,ucsa.ClientId
			,ucsa.ClientSiteId
		INTO #UserClientSiteAccess
		FROM #ClientSiteAccess ucsa
		GROUP BY ucsa.Countryid
			,ucsa.CostCentreId
			,ucsa.ClientId
			,ucsa.ClientSiteId
	
		SELECT @UserId AS UserId
			,a.CountryId
			,Isnull(dbo.GetNameTranslated(a.CountryId, @LanguageId, 'CountryName'), '') AS CountryName
			,a.CostCentreId
			,IsNull(dbo.GetNameTranslated(a.CostCentreId, @LanguageId, 'CostCentreName'), '') AS CostCentreName
			,a.ClientId
			,IsNull(dbo.GetNameTranslated(a.ClientId, @LanguageId, 'ClientName'), '') AS ClientName
			,a.ClientSiteId
			,Isnull(dbo.GetNameTranslated(a.ClientSiteId, @LanguageId, 'ClientSiteName'), '') AS ClientSiteName
			,cs.logo
		FROM #UserClientSiteAccess a
		JOIN ClientSite cs ON cs.ClientSiteId = a.ClientSiteId
		WHERE (
				a.CountryId = @CountryId
				OR @Countryid = 0
				)
			AND (
				a.CostCentreId = @CostCentreId
				OR @CostCentreId = 0
				)
	END
END
GO
/****** Object:  StoredProcedure [dbo].[EAppGetUserJobStatusColour]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 
CREATE   procedure [dbo].[EAppGetUserJobStatusColour](@Jobid BigInt)
as  
Begin
Declare @TLoad  Table (DC int,DCStatus varchar(15), AL int, ALStatus varchar(15), RV int, RVStatus varchar(15)) 
 
Declare @DataCollector int,@Analyst int ,@Reviewer int,@DupCheck int, @NST int, @ST int ,@TCT int, 
@DCStatusColour varchar(15),@ALStatusColour varchar(15),@RVStatusColour varchar(15),@NAId int

DECLARE UserCur  CURSOR FOR  
select distinct DataCollectorId, AnalystId, ReviewerId  from JobEquipment where JobId = @JobId and active = 'Y'
OPEN UserCur  
FETCH NEXT FROM UserCur  into @DataCollector,@Analyst,@Reviewer  
WHILE @@FETCH_STATUS = 0  
	BEGIN  
	Select  @DupCheck = 0 , @DCStatusColour = '', @ALStatusColour = '', @RVStatusColour = ''
	select @DupCheck = DC from @TLoad where DC = @DataCollector group by DC
	if isnull(@DupCheck,0) > 0
		Set @DataCollector = 0

	set @DupCheck = 0
	select @DupCheck = AL from @TLoad where AL = @Analyst group by AL
	if isnull(@DupCheck,0) > 0
		Set @Analyst = 0

	set @DupCheck = 0
	select @DupCheck = RV from @TLoad where RV = @Reviewer group by RV
	if isnull(@DupCheck,0) > 0
		Set @Reviewer = 0
	
	if @DataCollector > 0 
	Begin
		select @NST = 0 , @ST = 0
		Select @NST = sum(Case when isnull(DataCollectionDone,0) = 0 then 1 else 0 end), @TCT = count(*) ,
			   @ST = sum(Case when isnull(DataCollectionDone,0) = 1 then 1 else 0 end)
		from JobEquipment where JobId = @JobId and DataCollectorId = @DataCollector and active = 'Y'
	
	select @DCStatusColour = case 
			when isnull(@TCT,0) = isnull(@NST,0) then dbo.GetLookupTranslated(dbo.GetStatusId(1,'ReportStatusLegend','NS')  ,1,'LookupValue')
			when isnull(@TCT,0) = isnull(@ST,0) then dbo.GetLookupTranslated(dbo.GetStatusId(1,'ReportStatusLegend','C')  ,1,'LookupValue')
			when isnull(@TCT,0) > isnull(@NST,0)  then dbo.GetLookupTranslated(dbo.GetStatusId(1,'ReportStatusLegend','IP')  ,1,'LookupValue')
			when isnull(@TCT,0) > isnull(@ST,0)  then dbo.GetLookupTranslated(dbo.GetStatusId(1,'ReportStatusLegend','IP')  ,1,'LookupValue')
		   End
	End  
	if @Analyst > 0 
	Begin
		set @ALStatusColour = ''
 		select @ALStatusColour = dbo.GetAnalystJobStatusColour(@JobId,@Analyst)
	End 
	if @Reviewer > 0 
	Begin
		select @NAId = dbo.GetStatusId(1,'JobProcessStatus','NA')
		select @NST = 0 , @ST = 0
		Select @NST = sum(Case when isnull(ReviewDone,0) = 0 then 1 else 0 end), @TCT = count(*) ,
			   @ST = sum(Case when isnull(ReviewDone,0) = 1 then 1 else 0 end)
		from JobEquipment where JobId = @JobId and ReviewerId = @Reviewer  and StatusId <>  @NAId and active = 'Y'
	 
	select @RVStatusColour = case 
			when isnull(@TCT,0) = isnull(@NST,0) then dbo.GetLookupTranslated(dbo.GetStatusId(1,'ReportStatusLegend','NS')  ,1,'LookupValue')
			when isnull(@TCT,0) = isnull(@ST,0) then dbo.GetLookupTranslated(dbo.GetStatusId(1,'ReportStatusLegend','C')  ,1,'LookupValue')
			when isnull(@TCT,0) > isnull(@NST,0)  then dbo.GetLookupTranslated(dbo.GetStatusId(1,'ReportStatusLegend','IP')  ,1,'LookupValue')
			when isnull(@TCT,0) > isnull(@ST,0)  then dbo.GetLookupTranslated(dbo.GetStatusId(1,'ReportStatusLegend','IP')  ,1,'LookupValue')
		   End
	End  	
	if @Datacollector > 0 or @Analyst >0 or @Reviewer > 0 
	Begin
		select @DataCollector = case when @DataCollector = 0 then null else @DataCollector end,  
			   @Analyst = Case	when @Analyst = 0 then null else @Analyst  end,
			   @Reviewer = Case	when @Reviewer = 0 then null else @Reviewer  end 

		Insert into @TLoad(DC,DCStatus,AL,ALStatus,RV,RVStatus)values(@DataCollector,@DCStatusColour, @Analyst,@ALStatusColour, @Reviewer, @RVStatusColour)
	End
   FETCH NEXT FROM UserCur  into @DataCollector,@Analyst,@Reviewer
   END;  
CLOSE UserCur 
DEALLOCATE UserCur  

 select (select concat(LastName,' ',FirstName) from users where userid =  DC) as DataCollector, DCStatus ,
 (select concat(LastName,' ',FirstName) from users where userid =  AL) as Analyst, ALStatus, 
  (select concat(LastName,' ',FirstName) from users where userid =  RV) as Reviewer, RVStatus,
  (select ReportSent from jobs where jobid = @JobId) as  ReportSent
   from @TLoad

End
GO
/****** Object:  StoredProcedure [dbo].[EAppGetUserMenu]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppGetUserMenu]  
	@LanguageId Int,
	@UserId int
AS
BEGIN

DROP TABLE IF EXISTS #ProgramAccess 

select distinct prp.ProgramId ,'Y' Internal, prp.HideProgram
into #ProgramAccess
from UserRoleGroupRelation ur   join RoleGroupRoleRelation rgr on (rgr.RoleGroupId = ur.RoleGroupId  and ur.UserId = @Userid and ur.active = 'Y' and rgr.active = 'Y' )
join RolePrgPrivilegeRelation prp on (prp.roleid = rgr.RoleId   and prp.Active = 'Y' )

select (
select Case when isnull(l1.GroupCode,'') = '' then 'False' else 'True' end hasChild,  
	(select  Isnull(dbo.GetNameTranslated(l2.MenuGroupId,@LanguageId,'LookupValue'),'')MenuName,Isnull(dbo.GetLookupTranslated(l2.MenuGroupId,@LanguageId,'LookupOrder'),99)MenuOrder,'' ControllerName,''ActionName,''IconName,''CssClassName,''LinkUrl,
		 (select Isnull(dbo.GetNameTranslated(l3.ProgramId,@LanguageId,'ProgramMenuName'),'')MenuName,Isnull(ControllerName,'')ControllerName,Isnull(ActionName,'')ActionName,Isnull(IconName,'')IconName,Isnull(CssClassName,'')CssClassName,Isnull(LinkUrl,'')LinkUrl
		from programs l3 where l3.MenuGroupId = l2.MenuGroupId and l3.ProgramId in (select pa.Programid from #ProgramAccess pa where not exists(select 'x' from programs ps where ps.programid = pa.programid and ps.internal = 'Y' or pa.HideProgram = 'Y') )
		order by l3.MenuOrder
		FOR JSON AUTO) as Childs 
	from programs l2 where l2.SubGroupCode = l1.GroupCode and isnull(l2.MenuGroupId,0) <> 0 and l2.ProgramId in (select Programid from #ProgramAccess)
	group by l2.MenuGroupId
	Order by MenuOrder
	FOR JSON AUTO) as Childs,
Isnull(dbo.GetNameTranslated(l1.ProgramId,@LanguageId,'ProgramMenuName'),'')MenuName,Isnull(l1.ControllerName,'')ControllerName,Isnull(l1.ActionName,'')ActionName,Isnull(l1.IconName,'')IconName,Isnull(l1.CssClassName,'')CssClassName,Isnull(l1.LinkUrl,'')LinkUrl
From programs l1  WHERE   l1.ProgramId in (select pb.Programid pb from #ProgramAccess pb where not exists(select 'x' from programs ps where ps.programid = pb.programid and ps.internal = 'Y'  or pb.HideProgram = 'Y')) and ((isnull(GroupCode,'') <> '' or (isnull(GroupCode,'') ='' and isnull(SubGroupCode,'') ='' )))
order by l1.MenuOrder
FOR JSON AUTO
) as Menus  

END
  
GO
/****** Object:  StoredProcedure [dbo].[EAppGetUserRoleGroupAccess]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppGetUserRoleGroupAccess]  
	@UserId Int,
	@LanguageId int
AS
BEGIN
 
DROP TABLE IF EXISTS #TmpRole 
DROP TABLE IF EXISTS #TmpUser

select @UserId as UserId into #TmpUser
 
select distinct case when (isnull(ur.RoleGroupId,0)=0 or (isnull(ur.RoleGroupId,0)<>0 and isnull(ur.Active,'N') = 'N')) then 'Available' else 'Associated' end 'RoleStatus',
case when (isnull(ur.RoleGroupId,0)=0 or (isnull(ur.RoleGroupId,0)<>0 and isnull(ur.Active,'N') = 'N')) then rg.RoleGroupId else ur.RoleGroupId end 'RoleGroupId'
Into #TmpRole
from UserRoleGroupRelation ur right join Rolegroup rg on  ur.rolegroupid = rg.rolegroupid and ur.userid = @UserId -- and ur.active = 'Y' 
where rg.active = 'Y'

select ( select Userid,
	( select distinct b.RoleGroupId,dbo.GetNameTranslated(b.RoleGroupId,@LanguageId,'RoleGroupName') as RoleGroupName, 'N'Active from #TmpRole b
	where b.RoleStatus = 'Available'
	FOR JSON AUTO 
	) Available,
	(select distinct b.RoleGroupId,dbo.GetNameTranslated(b.RoleGroupId,@LanguageId,'RoleGroupName') as RoleGroupName, 'Y'Active from #TmpRole b
	where b.RoleStatus   = 'Associated' 
	FOR JSON AUTO 
	) Associated  
from #TmpUser For JSON AUTO ) as  RoleGroupRelation
   

END
GO
/****** Object:  StoredProcedure [dbo].[EAppGetUserSiteAccess]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppGetUserSiteAccess]  
	@LanguageId Int, 
	@UserId Int,
	@LoginUserid Int 
AS
BEGIN
 
	DROP TABLE IF EXISTS #UserAccess
	Create Table #UserAccess(UserId int, LanguageId int )

	DROP TABLE IF EXISTS #CostCentre
	CREATE TABLE #CostCentre(CountryId int, CostCentreId int)
	
	DROP TABLE IF EXISTS #ClientSites
	CREATE TABLE #ClientSites(CountryId int, CostCentreId int, ClientId int, ClientSiteId int)

	INSERT into #CostCentre (Countryid, CostCentreId) 
	SELECT cc.Countryid, uccr.CostCentreId from UserCostCentreRelation uccr join CostCentre cc on cc.CostCentreId = uccr.CostCentreId where uccr.UserId =  @LoginUserid and uccr.Active = 'Y' 
	Union
	SELECT CountryId, CostCentreId  from CostCentre cc where cc.CountryId in (select CountryId from UserCountryRelation ucr where ucr.UserId = @LoginUserid and ucr.Active = 'Y') and   cc.Active = 'Y' 

	INSERT into #ClientSites (Countryid, CostCentreId, ClientId, ClientSiteId) 
	SELECT Countryid, CostCentreId, ClientId, ClientSiteId from ClientSite cs  where countryid in (select CountryId from UserCountryRelation ucr where ucr.UserId = @LoginUserid and ucr.Active = 'Y') 
	Union
	SELECT Countryid, CostCentreId, ClientId, ClientSiteId from ClientSite cs  where CostCentreId in (select CostCentreId from UserCostCentreRelation uccr where uccr.UserId = @LoginUserid and uccr.Active = 'Y') 
	Union
	SELECT Countryid, CostCentreId, ClientId, ClientSiteId from ClientSite cs  where ClientId in (select ClientId from UserClientRelation ucr where ucr.UserId = @LoginUserid and ucr.Active = 'Y') 
	Union
	SELECT Countryid, CostCentreId, ClientId, ClientSiteId from ClientSite cs  where ClientSiteId in (select ClientSiteId from UserClientSiteRelation ucsr where ucsr.UserId = @LoginUserid and ucsr.Active = 'Y') 



	insert into #UserAccess (UserId, LanguageId ) 
	select @UserId, @Languageid 
	  
	Select (
	select Userid, LanguageId, 
	(select IsNull(ucr.CountryId,c.CountryId) CountryId ,Isnull(dbo.GetNameTranslated(IsNull(ucr.CountryId,c.CountryId),@LanguageId,'CountryName'),'') as CountryName,IsNull(ucr.active,'N') Active 
	from UserCountryRelation ucr Right Join (select CountryId,Active from UserCountryRelation where UserId = @LoginUserid  and Active = 'Y' )   c on c.CountryId = ucr.CountryId and ucr.UserId = @UserId and ucr.Active = 'Y'
 	FOR JSON AUTO ) CountryRelations,
	(
	select cc.CountryId,Isnull(dbo.GetNameTranslated( cc.CountryId ,@LanguageId,'CountryName'),'') as CountryName, IsNull(uccr.CostCentreId,cc.CostCentreId) CostCentreId ,Isnull(dbo.GetNameTranslated(IsNull(uccr.CostCentreId,cc.CostCentreId),@LanguageId,'CostCentreName'),'') as CostCentreName,IsNull(uccr.active,'N') Active 
	from UserCostCentreRelation uccr Right Join (Select CountryId, CostCentreId from #CostCentre) cc on cc.CostCentreId = uccr.CostCentreId and uccr.UserId = @UserId 
	FOR JSON AUTO  ) CostCentreRelations,
	(
	select  IsNull(ucr.ClientId,c.ClientId) ClientId ,Isnull(dbo.GetNameTranslated(IsNull(ucr.ClientId,c.ClientId),@LanguageId,'ClientName'),'') as ClientName,IsNull(ucr.active,'N') Active 
	from UserClientRelation ucr Right Join (select ClientId,Active from UserClientRelation where UserId = @LoginUserid and Active = 'Y' )  c on c.ClientId = ucr.ClientId and ucr.UserId = @UserId 
	FOR JSON AUTO  ) ClientRelations,
	(
	select 
	cs.CountryId,Isnull(dbo.GetNameTranslated(cs.CountryId,@LanguageId,'CountryName'),'') as CountryName,
	cs.CostCentreId,Isnull(dbo.GetNameTranslated(cs.CostCentreId,@LanguageId,'CostCentreName'),'') as CostCentreName,
	cs.ClientId,Isnull(dbo.GetNameTranslated(cs.ClientId,@LanguageId,'ClientName'),'') as ClientName, 
	IsNull(ucsr.ClientSiteId,cs.ClientSiteId) ClientSiteId ,Isnull(dbo.GetNameTranslated(IsNull(ucsr.ClientSiteId,cs.ClientSiteId),@LanguageId,'ClientSiteName'),'') as ClientSiteName,
	IsNull(ucsr.active,'N') Active 
	from UserClientSiteRelation ucsr Right Join (Select Countryid, CostCentreId, ClientId, ClientSiteId from #ClientSites) cs on cs.ClientSiteId = ucsr.ClientSiteId and ucsr.UserId = @UserId
	FOR JSON AUTO  ) ClientSiteRelations
	from #UserAccess
	FOR JSON AUTO ) UserAccess

End



GO
/****** Object:  StoredProcedure [dbo].[EAppGetUserWidgets]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppGetUserWidgets]  
	@LanguageId Int,
	@UserId int
AS
BEGIN

DROP TABLE IF EXISTS #ProgramAccess 

select distinct prp.ProgramId
into #ProgramAccess
from UserRoleGroupRelation ur   join RoleGroupRoleRelation rgr on (rgr.RoleGroupId = ur.RoleGroupId  and ur.UserId = @Userid and ur.active = 'Y' and rgr.active = 'Y' )
join RolePrgPrivilegeRelation prp on (prp.roleid = rgr.RoleId   and prp.Active = 'Y' )
 
select ProgramId as WidgetId, ProgramCode WidgetCode, Isnull(dbo.GetNameTranslated(p.ProgramId,@LanguageId,'ProgramMenuName'),'')WidgetName,
	   Isnull(WidgetLogo,'')WidgetLogo,Height,Width,Isnull(u.Param1,'')Param1,Isnull(u.Param2,'')Param2,Isnull(u.Param3,'')Param3,Isnull(u.Param4,'')Param4,Isnull(u.Param5,'')Param5,
	   Isnull(u.Active,'N') Active
		from UserDashboard u right join programs p  on ( p.ProgramId = u.WidgetId and u.UserId = @UserId )
		where   ProgramType = 'WGT' and p.ProgramId in (select pa.Programid from #ProgramAccess pa where not exists(select 'x' from programs ps where ps.programid = pa.programid and ps.internal = 'Y') )
		order by p.MenuOrder

END
GO
/****** Object:  StoredProcedure [dbo].[EAppListAccessableClient]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

create   PROCEDURE [dbo].[EAppListAccessableClient]
	@UserId Int,
	@LanguageId Int,
	@ClientStatus int
AS
BEGIN


--[EAppGetUserClientSiteAccess]@LanguageId,'',@UserId,0,0

	select c.ClientId,ct.ClientName, lk.LookupId as ClientStatus,dbo.GetNameTranslated(c.ClientStatus,@LanguageId,'LookupValue') as ClientStatusName, 
	ct.LanguageId,c.CreatedLanguageId  
	from Client c join lookups lk on lk.LookupId = c.ClientStatus 
	right join ClientTranslated ct on ct.ClientId = c.ClientId 
	where (c.ClientStatus =  @ClientStatus or @ClientStatus = 0 )  and( ct.LanguageId = @LanguageId or (  ct.LanguageId  = c.CreatedLanguageId 
	and not exists (select 'x' from ClientTranslated where ClientId = c.ClientId and languageid = @Languageid)))
 

END
GO
/****** Object:  StoredProcedure [dbo].[EAppListApplicationConfiguration]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppListApplicationConfiguration]   
	@Status varchar(5),
	@AppConfigName varchar(200)
AS
BEGIN

	select l.AppConfigId,l.AppConfigCode,l.AppConfigName,l.AppConfigValue,l.Descriptions, l.Active 
	from ApplicationConfiguration l  
	where (l.Active =  @Status or @Status = 'ALL') and (l.AppConfigName = @AppConfigName or isnull(@AppConfigName,'') = '')  

END
GO
/****** Object:  StoredProcedure [dbo].[EAppListArea]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppListArea]  
	@ClientSiteId Int,
	@LanguageId int  
AS
BEGIN
 
	select s.PlantAreaId,dbo.GetNameTranslated(s.PlantAreaId,@LanguageId,'PlantAreaName') as PlantAreaName, 
	  s.AreaId,dbo.GetNameTranslated(s.AreaId,@LanguageId,'AreaName') as AreaName,
	  dbo.GetNameTranslated(s.AreaId,@LanguageId,'AreaDescriptions') as Descriptions, 
	  s.Active
	from Area s join PlantArea p on p.PlantAreaId = s.PlantAreaId and p.ClientSiteId = @ClientSiteId
	
 

END
GO
/****** Object:  StoredProcedure [dbo].[EAppListAreaTranslated]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppListAreaTranslated]  
	@AreaId Int
AS
BEGIN

	select @AreaId AreaId, s.PlantAreaId, st.AreaName,st.Descriptions,  l.LanguageId, l.CountryCode as LanguageCountryCode,l.LName LanguageName, s.Active
	from AreaTranslated st right join Languages l on st.LanguageId =l.LanguageId and st.AreaId = @AreaId
	join Area s on s.Areaid = @Areaid
 
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListAssetCategory]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppListAssetCategory]
	@LanguageId Int,
	@Status varchar(5) 
AS
BEGIN
 
	select a.AssetCategoryId,a.AssetCategoryCode,att.AssetCategoryName,att.Descriptions,
	 a.Active,att.LanguageId,a.CreatedLanguageId  
	from AssetCategory a right join AssetCategoryTranslated att on att.AssetCategoryId = a.AssetCategoryId
	where (a.Active =  @Status or @Status = 'ALL')  and( att.LanguageId = @LanguageId or (  att.LanguageId  = a.CreatedLanguageId 
	and not exists (select 'x' from AssetCategoryTranslated where AssetCategoryId = a.AssetCategoryId and languageid = @Languageid)))
 

END

GO
/****** Object:  StoredProcedure [dbo].[EAppListAssetCategoryClassRelation]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 -- [AssetCategoryClassRelation] 
CREATE   PROCEDURE [dbo].[EAppListAssetCategoryClassRelation]  
	@LanguageId Int,
	@AssetCategoryId int
AS
BEGIN
  

SELECT @AssetCategoryId AssetCategoryId,  Isnull(a.AssetClassId,i.AssetClassId) AssetClassId,Isnull(dbo.GetNameTranslated(i.AssetClassId,@LanguageId,'AssetClassName'),'') as AssetClassName, case when Isnull(a.Active,'N') = 'N' then 'N' else a.Active end Active 
FROM AssetCategoryClassRelation a right join AssetClass i on i.AssetClassId = a.AssetClassId and a.AssetCategoryId = @AssetCategoryId 
 

END

GO
/****** Object:  StoredProcedure [dbo].[EAppListAssetCategoryTranslated]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppListAssetCategoryTranslated]  
	@AssetCategoryId Int
AS
BEGIN

	select @AssetCategoryId AssetCategoryId, a.AssetCategoryCode, att.AssetCategoryName,att.Descriptions,  l.LanguageId, l.CountryCode as LanguageCountryCode,l.LName LanguageName, a.Active
	from AssetCategoryTranslated att right join Languages l on att.LanguageId =l.LanguageId and att.AssetCategoryId = @AssetCategoryId
	join AssetCategory a on a.AssetCategoryid = @AssetCategoryid
 
END

GO
/****** Object:  StoredProcedure [dbo].[EAppListAssetClass]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 
CREATE   PROCEDURE [dbo].[EAppListAssetClass]
	@LanguageId Int,
	@Status varchar(5) 
AS
BEGIN
 
	select a.AssetClassId,a.AssetClassCode,att.AssetClassName,att.Descriptions,
	 a.Active,att.LanguageId,a.CreatedLanguageId  
	from AssetClass a right join AssetClassTranslated att on att.AssetClassId = a.AssetClassId
	where (a.Active =  @Status or @Status = 'ALL')  and( att.LanguageId = @LanguageId or (  att.LanguageId  = a.CreatedLanguageId 
	and not exists (select 'x' from AssetClassTranslated where AssetClassId = a.AssetClassId and languageid = @Languageid)))
 

END
GO
/****** Object:  StoredProcedure [dbo].[EAppListAssetClassIndustryRelation]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppListAssetClassIndustryRelation]  
	@LanguageId Int,
	@AssetClassId int
AS
BEGIN
  

SELECT @AssetClassId AssetClassId,  Isnull(a.IndustryId,i.IndustryId) IndustryId
,Isnull(dbo.GetNameTranslated(i.IndustryId,@LanguageId,'IndustryName'),'') as IndustryName
,Isnull(dbo.GetNameTranslated(i.SegmentId,@LanguageId,'SegmentName'),'') as SegmentName
,case when Isnull(a.Active,'N') = 'N' then 'N' else a.Active end Active 
FROM AssetClassIndustryRelation a right join Industry i on i.IndustryId = a.IndustryId and a.AssetClassId  = @AssetClassId 
 

END

GO
/****** Object:  StoredProcedure [dbo].[EAppListAssetClassTranslated]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE   PROCEDURE [dbo].[EAppListAssetClassTranslated]  
	@AssetClassId Int
AS
BEGIN

	select @AssetClassId AssetClassId, a.AssetClassCode, att.AssetClassName,att.Descriptions,  l.LanguageId, l.CountryCode as LanguageCountryCode,l.LName LanguageName, a.Active
	from AssetClassTranslated att right join Languages l on att.LanguageId =l.LanguageId and att.AssetClassId = @AssetClassId
	join AssetClass a on a.AssetClassid = @AssetClassid
 
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListAssetSequence]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppListAssetSequence]
	@LanguageId Int,
	@Status varchar(5) 
AS
BEGIN
 
	select a.AssetSequenceId,a.AssetSequenceCode,att.AssetSequenceName,att.Descriptions,
	 a.Active,att.LanguageId,a.CreatedLanguageId , AssetTypeId, Isnull(dbo.GetNameTranslated(a.AssetTypeId,@LanguageId,'AssetTypeCode'),'') as AssetTypeCode,
	  Isnull(dbo.GetNameTranslated(a.AssetTypeId,@LanguageId,'AssetTypeName'),'') as AssetTypeName  
	from AssetSequence a right join AssetSequenceTranslated att on att.AssetSequenceId = a.AssetSequenceId
	where (a.Active =  @Status or @Status = 'ALL')  and( att.LanguageId = @LanguageId or (  att.LanguageId  = a.CreatedLanguageId 
	and not exists (select 'x' from AssetSequenceTranslated where AssetSequenceId = a.AssetSequenceId and languageid = @Languageid)))
 

END
GO
/****** Object:  StoredProcedure [dbo].[EAppListAssetSequenceTranslated]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppListAssetSequenceTranslated]  
	@AssetSequenceId Int
AS
BEGIN

	select @AssetSequenceId AssetSequenceId, a.AssetSequenceCode, a.AssetTypeId, att.AssetSequenceName,att.Descriptions,  l.LanguageId, l.CountryCode as LanguageCountryCode,l.LName LanguageName, a.Active
	from AssetSequenceTranslated att right join Languages l on att.LanguageId =l.LanguageId and att.AssetSequenceId = @AssetSequenceId
	join AssetSequence a on a.AssetSequenceid = @AssetSequenceid
 
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListAssetType]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppListAssetType]
	@LanguageId Int,
	@Status varchar(5) 
AS
BEGIN
 
	select a.AssetTypeId,a.AssetTypeCode,att.AssetTypeName,att.Descriptions,
	 a.Active,att.LanguageId,a.CreatedLanguageId  
	from AssetType a right join AssetTypeTranslated att on att.AssetTypeId = a.AssetTypeId
	where (a.Active =  @Status or @Status = 'ALL')  and( att.LanguageId = @LanguageId or (  att.LanguageId  = a.CreatedLanguageId 
	and not exists (select 'x' from AssetTypeTranslated where AssetTypeId = a.AssetTypeId and languageid = @Languageid)))
 

END
GO
/****** Object:  StoredProcedure [dbo].[EAppListAssetTypeClassRelation]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppListAssetTypeClassRelation]  
	@LanguageId Int,
	@AssetTypeId int
AS
BEGIN
  

SELECT @AssetTypeId AssetTypeId,  Isnull(a.AssetClassId,i.AssetClassId) AssetClassId,Isnull(dbo.GetNameTranslated(i.AssetClassId,@LanguageId,'AssetClassName'),'') as AssetClassName, case when Isnull(a.Active,'N') = 'N' then 'N' else a.Active end Active 
FROM AssetTypeClassRelation a right join AssetClass i on i.AssetClassId = a.AssetClassId and a.AssetTypeId = @AssetTypeId 
 

END
GO
/****** Object:  StoredProcedure [dbo].[EAppListAssetTypeTranslated]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   PROCEDURE [dbo].[EAppListAssetTypeTranslated]  
	@AssetTypeId Int
AS
BEGIN

	select @AssetTypeId AssetTypeId, a.AssetTypeCode, att.AssetTypeName,att.Descriptions,  l.LanguageId, l.CountryCode as LanguageCountryCode,l.LName LanguageName, a.Active
	from AssetTypeTranslated att right join Languages l on att.LanguageId =l.LanguageId and att.AssetTypeId = @AssetTypeId
	join AssetType a on a.AssetTypeid = @AssetTypeid
 
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListBearings]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppListBearings]
	@LanguageId Int,
	@Status varchar(5) 
AS
BEGIN
 
	select b.BearingId,b.BearingCode,bt.BearingName,CONCAT(b.BearingCode,'-',bt.BearingName) as BearingCodeName,bt.Descriptions,
	 b.Active,bt.LanguageId,b.CreatedLanguageId , b.ManufacturerId ,dbo.GetNameTranslated(b.ManufacturerId,@LanguageId,'ManufacturerName') as ManufacturerName
	from Bearings b right join BearingTranslated bt on bt.BearingId = b.BearingId join Manufacturer m on m.ManufacturerId =  b.ManufacturerId
	where (b.Active =  @Status or @Status = 'ALL')  and( bt.LanguageId = @LanguageId or (  bt.LanguageId  = b.CreatedLanguageId 
	and not exists (select 'x' from BearingTranslated where BearingId = b.BearingId and languageid = @Languageid)))
 
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListBearingTranslated]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppListBearingTranslated]  
	@BearingId Int
AS
BEGIN

	select @BearingId BearingId, b.BearingCode,b.ManufacturerId, bt.BearingName,bt.Descriptions,l.LanguageId, l.CountryCode as LanguageCountryCode,l.LName LanguageName, b.Active
	from BearingTranslated bt right join Languages l on bt.LanguageId =l.LanguageId and bt.BearingId = @BearingId
	join Bearings b on b.Bearingid = @Bearingid
 
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListClient]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  

CREATE   PROCEDURE [dbo].[EAppListClient]  
	@LanguageId Int,
	@ClientStatus int
AS
BEGIN

	select c.ClientId,ct.ClientName, lk.LookupId as ClientStatus,dbo.GetNameTranslated(c.ClientStatus,@LanguageId,'LookupValue') as ClientStatusName, 
	ct.LanguageId,c.CreatedLanguageId  
	from Client c join lookups lk on lk.LookupId = c.ClientStatus 
	right join ClientTranslated ct on ct.ClientId = c.ClientId 
	where (c.ClientStatus =  @ClientStatus or @ClientStatus = 0 )  and( ct.LanguageId = @LanguageId or (  ct.LanguageId  = c.CreatedLanguageId 
	and not exists (select 'x' from ClientTranslated where ClientId = c.ClientId and languageid = @Languageid)))
 

END
GO
/****** Object:  StoredProcedure [dbo].[EAppListClientAttachments]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppListClientAttachments]
	@ClientSiteId int,
	@Status varchar(5) 
AS
BEGIN
		select cda.[ClientDocAttachId], cda.[ClientSiteId],cda.FileDescription, cda.FileName, cda.LogicalName, cda.PhysicalPath, cda.Active 
		from [ClientDocAttachment] cda
		where (cda.Active =  @Status or @Status = 'ALL') and cda.ClientSiteId = @ClientSiteId
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListClientSite]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppListClientSite] @LanguageId INT
	,@ClientSiteStatus INT
	,@UserId INT
AS
BEGIN

	DROP TABLE

	IF EXISTS #SiteAccess
		CREATE TABLE #SiteAccess (
			UserId INT
			,CountryId INT
			,CountryName VARCHAR(100)
			,CostCentreid INT
			,CostCentreName VARCHAR(100)
			,Clientid INT
			,ClientName VARCHAR(100)
			,ClientSiteid INT
			,ClientSiteName VARCHAR(100),
			Logo VARCHAR(250)
			)

	INSERT INTO #SiteAccess (
		UserId
		,Countryid
		,CountryName
		,CostCentreid
		,CostCentreName
		,Clientid
		,ClientName
		,ClientSiteid
		,ClientSiteName
		,Logo
		)
	EXEC [dbo].[EAppGetUserClientSiteAccess] @LanguageId
		,'ClientSite'
		,@UserId
		,0
		,0

	SELECT c.ClientSiteId
		,c.InternalRefId
		,ct.SiteName
		,c.CountryId
		,c.CostCentreId
		,c.IndustryId
		,c.ClientId
		,dbo.GetNameTranslated(c.CountryId, @LanguageId, 'CountryName') AS CountryName
		,dbo.GetNameTranslated(c.CostCentreId, @LanguageId, 'CostCentreName') AS CostCentreName
		,dbo.GetNameTranslated(c.IndustryId, @LanguageId, 'IndustryName') AS IndustryName
		,dbo.GetNameTranslated(c.ClientId, @LanguageId, 'ClientName') AS ClientName
		,lk.LookupId AS ClientSiteStatus
		,dbo.GetNameTranslated(c.ClientSiteStatus, @LanguageId, 'LookupValue') AS ClientSiteStatusName
		,ct.LanguageId
		,c.CreatedLanguageId
		,ct.Address1
		,ct.Address2
		,ct.City
		,c.Phone
		,c.POBox
		,c.Zip
		,ct.StateName
		,c.Email
		,c.Logo
		,c.SiebelId
		,case when (select  count(*) from equipment e join plantarea p on p.PlantAreaId = e.PlantAreaId and p.clientsiteid = c.ClientSiteId )
		= 0 then 'Y' else 'N' end NotifyDataCollector
	FROM ClientSite c
	JOIN lookups lk ON lk.LookupId = c.ClientSiteStatus
	RIGHT JOIN ClientSiteTranslated ct ON ct.ClientSiteId = c.ClientSiteId
	WHERE (
			c.ClientSiteStatus = @ClientSiteStatus
			OR @ClientSiteStatus = 0
			)
		AND (
			ct.LanguageId = @LanguageId
			OR (
				ct.LanguageId = c.CreatedLanguageId
				AND NOT EXISTS (
					SELECT 'x'
					FROM ClientSiteTranslated
					WHERE ClientSiteId = c.ClientSiteId
						AND languageid = @Languageid
					)
				)
			)
		AND c.ClientSiteId IN (
			SELECT ClientSiteId
			FROM #SiteAccess
			) 
			order by c.ClientSiteId desc 
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListClientSiteConfiguration]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppListClientSiteConfiguration]
	@ClientSiteId int,
	@LanguageId int 
AS
BEGIN
 
select c.ClientSiteConfigId,@ClientSiteId as ClientSiteId,l.LookupId as ConfigId,l.LookupCode as ConfigCode,l.LookupName as ConfigName, c.ClientSiteConfigValue
from ClientSiteConfiguration c 
right join (select lookupid,LookupCode, dbo.GetNameTranslated(lookupid,@LanguageId,'LookupValue')LookupName,ListOrder from lookups where Lname ='ClientSiteConfig')  l on c.ConfigId = l.LookupId
and ClientSiteId = @ClientSiteId
order by l.listOrder
 

END
GO
/****** Object:  StoredProcedure [dbo].[EAppListClientSiteTaxonomy]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppListClientSiteTaxonomy]
	@LanguageId Int,
	@ClientSiteId Int
AS
BEGIN
	Declare @IndustryId int , @DownTimeCost decimal(20,5)
	select  @IndustryId = i.IndustryId, @DownTimeCost = i.DownTimeCostPerHour from Clientsite c join Industry i on i.IndustryId = c.IndustryId where c.ClientSiteId = @ClientSiteId
	 
	select @IndustryId as IndustryId,t.TaxonomyId,t.TaxonomyCode,t.AssetClassTypeCode,t.AssetCategoryId,t.AssetSequenceId,t.AssetClassId,
	@DownTimeCost DownTimeCostPerHour,
	dbo.GetNameTranslated(@IndustryId,@LanguageId,'IndustryName') as IndustryName, 
	dbo.GetNameTranslated(t.AssetCategoryId, @LanguageId,'AssetCategoryCName') as AssetCategoryName, 
	dbo.GetNameTranslated(t.AssetClassId, @LanguageId,'AssetClassCName') as AssetClassName, 
	dbo.GetNameTranslated(t.AssetTypeId, @LanguageId,'AssetTypeCName') as AssetTypeName, 
	dbo.GetNameTranslated(t.AssetSequenceId, @LanguageId,'AssetSequenceCName') as AssetSequenceName,
	t.MTTR, t.MTBF 
	from Taxonomy t 
	where t.IndustryId =  @IndustryId and TaxonomyType = 'A' and t.Active = 'Y' 
	order by t.AssetCategoryId,t.AssetClassId,t.AssetTypeId,t.AssetSequenceId
END
  
GO
/****** Object:  StoredProcedure [dbo].[EAppListClientSiteTranslated]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppListClientSiteTranslated]  
	@ClientSiteId Int
AS
BEGIN

	select @ClientSiteId ClientSiteId,ct.SiteName,ct.Address1,ct.Address2,ct.City,ct.StateName,c.Phone,c.Zip,c.POBox,c.InternalRefId,c.ClientId,c.IndustryId,c.CountryId,c.CostCentreId,
	l.LanguageId, l.CountryCode as LanguageCountryCode,l.LName LanguageName, c.ClientSiteStatus
	from ClientSiteTranslated ct right join Languages l on ct.LanguageId =l.LanguageId and ct.ClientSiteId = @ClientSiteId
	Join ClientSite c on c.ClientSiteId = @ClientSiteId
 
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListClientTranslated]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create   PROCEDURE [dbo].[EAppListClientTranslated]  
	@ClientId Int
AS
BEGIN
	select @ClientId ClientId,ct.ClientName,  l.LanguageId, l.CountryCode as LanguageCountryCode,l.LName LanguageName, c.ClientStatus
	from ClientTranslated ct right join Languages l on ct.LanguageId =l.LanguageId and ct.ClientId = @ClientId
	Join Client c on c.ClientId = @ClientId
 
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListConditionCodeClientMapping]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppListConditionCodeClientMapping]  
	@LanguageId Int,
	@ClientSiteId int
AS
BEGIN
 
	DROP TABLE IF EXISTS #TLookups
	DROP TABLE IF EXISTS #TCCodeMapping

	select l.LookupId,l.LookupCode,l.LName,lt.LValue,lt.Descriptions, l.Active,lt.LanguageId,l.CreatedLanguageId  
	Into #TLookups
	from Lookups l right join LookupTranslated lt on lt.LookupId = l.LookupId
	where l.LName = 'ConditionCodeMap' and ( lt.LanguageId = @LanguageId or (  lt.LanguageId  = l.CreatedLanguageId 
	and not exists (select 'x' from LookupTranslated where LookupId = l.LookupId and languageid = @Languageid)))
    
	select c.CMappingId,c.ClientSiteId,c.ConditionId, lk.LookupCode as ConditionCode,ct.ConditionName,ct.Descriptions, ct.LanguageId,c.CreatedLanguageId,c.Active
	Into #TCCodeMapping
	from ConditionCodeClientMapping c join lookups lk on lk.LookupId = c.ConditionId  
	right join ConditionCodeClientTranslated ct on ct.CMappingId = c.CMappingId
	where  c.ClientSiteId =  @ClientSiteId and( ct.LanguageId = @LanguageId or (  ct.LanguageId  = c.CreatedLanguageId 
	and not exists (select 'x' from ConditionCodeClientTranslated where clientSiteId = @ClientSiteId and ConditionId = c.ConditionId and languageid = @Languageid)))
  
	select @ClientSiteId as 'ClientSiteId',lk.Lookupid as ConditionId, lk.LookupCode as SKFConditionCode,lk.LValue as 'SKFConditionname' ,c.CMappingId, isnull(c.ConditionName,lk.LValue) as 'ClientsConditionName',isnull(c.Descriptions,lk.Descriptions) as Descriptions
	,isnull(c.Active,'Y')  as Active
	from #TCCodeMapping c right join #TLookups lk on lk.LookupId = c.ConditionId  

END
 
GO
/****** Object:  StoredProcedure [dbo].[EAppListConditionCodeClientMappingTranslated]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppListConditionCodeClientMappingTranslated]  
	@CMappingId Int
AS
BEGIN
	select @CMappingId as CMappingId, ct.ConditionName as ClientsConditionName,ct.Descriptions,  l.LanguageId, l.CountryCode as LanguageCountryCode,l.LName LanguageName  
	from ConditionCodeClientTranslated ct right join Languages l on ct.LanguageId =l.LanguageId and ct.CMappingId = @CMappingId 
 
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListCostCentre]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppListCostCentre]  
	@CountryId Int,
	@LanguageId Int,
	@Status varchar(5) 
AS
BEGIN
	
   if @CountryId = 0
	set @CountryId = null

	select c.CostCentreId,c.CountryId,dbo.GetNameTranslated(c.CountryId,@LanguageId,'CountryName') as CountryName,ct.CostCentreName,ct.Descriptions, c.Active,ct.LanguageId,c.CostCentreCode,c.CreatedLanguageId  
	from CostCentre c right join CostCentreTranslated ct on ct.CostCentreId = c.CostCentreId 
	where   c.countryId = isnull(@CountryId,c.countryId)  and( ct.LanguageId = @LanguageId or (  ct.LanguageId  = c.CreatedLanguageId 
	and not exists (select 'x' from CostCentreTranslated where CostCentreId = c.CostCentreId and languageid = @Languageid)))
 

END
GO
/****** Object:  StoredProcedure [dbo].[EAppListCostCentreTranslated]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppListCostCentreTranslated]  
	@CostCentreId Int
AS
BEGIN

	select @CostCentreId CostCentreId, ct.CostCentreName,c.CountryId,l.LanguageId, l.CountryCode as LanguageCountrycode,l.LName LanguageName , c.Active, c.CostCentreCode
	from CostCentreTranslated ct right join Languages l on ct.LanguageId =l.LanguageId and ct.CostCentreId = @CostCentreId 
	Join CostCentre c on c.CostCentreId = @CostCentreId
 
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListCountry]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppListCountry]  
	@LanguageId Int,
	@Status varchar(5) 
AS
BEGIN

	select c.CountryId,c.CountryCode,ct.CountryName, c.Active,ct.LanguageId,c.CreatedLanguageId  
	from country c right join CountryTranslated ct on ct.CountryId = c.CountryId
	where (c.Active =  @Status or @Status = 'ALL')  and( ct.LanguageId = @LanguageId or (  ct.LanguageId  = c.CreatedLanguageId 
	and not exists (select 'x' from CountryTranslated where countryid = c.countryid and languageid = @Languageid)))
 

END
GO
/****** Object:  StoredProcedure [dbo].[EAppListCountryTranslated]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppListCountryTranslated]  
	@CountryId Int
AS
BEGIN

	select @CountryId CountryId,c.CountryCode, ct.CountryName,  l.LanguageId, l.CountryCode as LanguageCountryCode,l.LName LanguageName, c.Active
	from CountryTranslated ct right join Languages l on ct.LanguageId =l.LanguageId and ct.CountryId = @CountryId
	Join Country c on c.CountryId = @CountryId
 
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListEquipment]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppListEquipment]
	@ClientSiteId int,
	@EquipmentId int,
	@LanguageId int, 
	@Action varchar(75), -- Attachment | Services
	@Status varchar(5) 
AS
BEGIN
 	If ( isnull(@EquipmentId, 0) = 0)
	Begin
		select e.EquipmentId, e.PlantAreaId, dbo.GetNameTranslated(e.PlantAreaId,@LanguageId,'PlantAreaName') PlantAreaName, 
		dbo.GetNameTranslated(e.AreaId,@LanguageId,'AreaName')AreaName,
		dbo.GetNameTranslated(e.SystemId,@LanguageId,'SystemName') SystemName,
		e.EquipmentCode, e.EquipmentName, e.Descriptions,
		e.OrientationId, dbo.GetNameTranslated(e.OrientationId,@LanguageId,'LookupValue') OrientationName, 
		e.MountingId, dbo.GetNameTranslated(e.MountingId,@LanguageId,'LookupValue') MountingName,
		e.StandByEquipId, dbo.GetNameTranslated(e.StandByEquipId,@LanguageId,'EquipmentName') StandByEquipName, 
		e.ListOrder, case when @Action ='List' then 'N' else e.Active end as Active,
		e.AreaId,dbo.GetNameTranslated(e.AreaId,@LanguageId,'AreaName') AreaName,
		e.SystemId,dbo.GetNameTranslated(e.SystemId,@LanguageId,'SystemName') SystemName
		 from Equipment e join PlantArea p on p.PlantAreaId= e.PlantAreaId and p.ClientSiteId = @ClientSiteId
		 where (e.Active =  @Status or @Status = 'ALL')
		 order by listorder
    End
	 
	else If (isnull(@EquipmentId, 0)  > 0 and @Action = 'Attachment')
	Begin
		select ea.EquipmentAttachId, ea.EquipmentId, ea.FileName, ea.LogicalName, ea.PhysicalPath, ea.Active from EquipmentAttachments ea
		where (ea.Active =  @Status or @Status = 'ALL') and ea.EquipmentId = @EquipmentId
    End
 

END
GO
/****** Object:  StoredProcedure [dbo].[EAppListEquipmentConditionReport]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

CREATE   PROCEDURE [dbo].[EAppListEquipmentConditionReport]
	@ClientSiteId int, 
	@ReportFromDate Date,
	@ReportToDate Date,
	@ConditionCodeId Int,  
	@LanguageId int 
AS
BEGIN
   set @ConditionCodeId = case when @ConditionCodeId = 0 then null else @ConditionCodeId end
	Declare @JobStatusId int
	Set @JobStatusId = dbo.GetStatusId(1,'JobProcessStatus','C')
	;With JECTE
	as
	(
		Select j.JobId, j.JobName, j.JobNumber,je.JobEquipmentId,je.EquipmentId, je.DataCollectionDate, je.ReportDate,
		case when (dbo.GetLookupTranslated(je.ServiceId,1,'LookupCode') = 'VA') then 'Y' else 'N' end as VA,
		case when (dbo.GetLookupTranslated(je.ServiceId,1,'LookupCode') = 'OA') then 'Y' else 'N' end as OA,
		case when (select count(UnitAnalysisId) from JobEquipUnitAnalysis ua where ua.JobEquipmentId = je.JobEquipmentId and ua.IsWorkNotification = 'Y') > 0 then 'Y' else 'N' end as WN
	    from  JobEquipment je Join Jobs j on je.JobId = j.JobId 
		where j.ClientSiteId = @ClientSiteId and je.ReportDate between @ReportFromDate  and isnull(@ReportToDate,getdate())
		and( je.ConditionId = @ConditionCodeId or @ConditionCodeId is null) 
	)
	Select e.PlantAreaId, dbo.GetNameTranslated(e.PlantAreaId,@LanguageId,'PlantAreaName') as PlantAreaName,je.JobEquipmentId,e.EquipmentId, e.EquipmentName ,je.JobId, je.JobName, je.JobNumber,
	je.DataCollectionDate, je.ReportDate, je.VA,je.OA,je.WN  
	from  JECTE je Join Equipment e on e.EquipmentId = je.EquipmentId  
	order by je.ReportDate desc, je.JobNumber desc 
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListEquipmentDrivenUnit]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppListEquipmentDrivenUnit]
	@EquipmentId int,
	@DrivenUnitId int,
	@LanguageId int, 
	@Action varchar(75), -- Attachment | Services
	@Status varchar(5) 
AS
BEGIN
	Declare @YTCBearingId int 
	select @YTCBearingId = BearingId from Bearings where BearingCode = 'YTC'
	If (isnull(@EquipmentId, 0) > 0 and ISNULL(@Action, '') = '')
	Begin
		select e.EquipmentId,e.DrivenUnitId,
		(select Count(*) from DrivenBearing db where db.DrivenUnitId = e.DrivenUnitId and db.BearingId <> @YTCBearingId and db.Place = 'DE' and db.Active = 'Y') as DESelectedCount,
		(select Count(*) from DrivenBearing db where db.DrivenUnitId = e.DrivenUnitId and db.BearingId <> @YTCBearingId and db.Place = 'NDE' and db.Active = 'Y')  as NDESelectedCount,
		dbo.GetNameTranslated(e.EquipmentId,null,'EquipmentName') EquipmentName,
		e.AssetId,
		dbo.GetNameTranslated(e.AssetId,null,'TaxonomyAssetCode') AssetCode,
		e.IdentificationName,e.ListOrder,
		e.ManufacturerId,
		dbo.GetNameTranslated(e.ManufacturerId,null,'ManufacturerName') ManufacturerName,
		e.MaxRPM,e.Capacity,e.Model,e.Lubrication,e.SerialNumber,e.RatedFlowGPM,e.PumpEfficiency,e.RatedSuctionPressure,e.Efficiency,e.RatedDischargePressure,e.CostPerUnit,e.BearingDriveEndId,e.BearingNonDriveEndId
		,e.ImpellerVanes,e.ImpellerVanesKW,e.Stages,e.NumberOfPistons,e.PumpType,e.MeanRepairManHours,e.DownTimeCostPerHour,e.CostToRepair,e.MeanFailureRate
		,e.Active,e.ManufactureYear,e.FirstInstallationDate,e.OperationModeId	
		from EquipmentDrivenUnit e
		where  e.EquipmentId = @EquipmentId
    End

	else If (isnull(@DrivenUnitId, 0) > 0 and @Action = 'Attachment')
	Begin
		select da.DrivenAttachId, da.DrivenUnitId, da.FileName, da.LogicalName, da.PhysicalPath, da.Active from DrivenAttachments da
		where  da.DrivenUnitId = @DrivenUnitId  and da.Active = @Status
    End

	else If (@Action = 'Services')
	Begin
		select isnull(d.DrivenServiceId,0)as UnitServiceId,@DrivenUnitId as DrivenUnitId,isnull(d.ReportId,l.LookupId)as ServiceId,l.LookupName as ServiceName,isnull(d.Active,'N')as Active 
		from DrivenServices d 
		right join (select lookupid,dbo.GetNameTranslated(lookupid,@LanguageId,'LookupValue')LookupName,ListOrder from lookups where Lname ='ReportType')  l on d.ReportId = l.LookupId
		and d.DrivenUnitId = @DrivenUnitId
		order by l.listOrder
    End
 	else If (@Action = 'DEBearings')
	Begin
		select b.BearingId, b.ManufacturerId,b.BearingCode as Designation, dbo.GetNameTranslated(b.BearingId,@LanguageId,'BearingName') as BearingName,
		dbo.GetNameTranslated(b.ManufacturerId,@LanguageId,'ManufacturerName') as ManufacturerName,
		isnull(d.Active,'N')as Active 
		from DrivenBearing d 
		right join Bearings b on d.BearingId = b.BearingId and b.active = 'Y'
		and d.DrivenUnitId = @DrivenUnitId and d.Place = 'DE' 
    End  
	else If (@Action = 'NDEBearings')
	Begin
		select b.BearingId, b.ManufacturerId,b.BearingCode as Designation,dbo.GetNameTranslated(b.BearingId,@LanguageId,'BearingName') as BearingName,
		dbo.GetNameTranslated(b.ManufacturerId,@LanguageId,'ManufacturerName') as ManufacturerName,
		isnull(d.Active,'N')as Active 
		from DrivenBearing d 
		right join Bearings b on d.BearingId = b.BearingId and b.active = 'Y'
		and d.DrivenUnitId = @DrivenUnitId and d.Place = 'NDE' 
    End 

END
GO
/****** Object:  StoredProcedure [dbo].[EAppListEquipmentDriveUnit]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppListEquipmentDriveUnit]
	@EquipmentId int,
	@DriveUnitId int,
	@LanguageId int, 
	@Action varchar(75), -- Attachment | Services
	@Status varchar(5) 
AS
BEGIN
 	Declare @YTCBearingId int 
	If (isnull(@EquipmentId, 0) > 0 and ISNULL(@Action, '') = '')
	Begin
		select @YTCBearingId = BearingId from Bearings where BearingCode = 'YTC'

		select e.EquipmentId,e.DriveUnitId,
		(select Count(*) from DriveBearing db where db.DriveUnitId = e.DriveUnitId and db.BearingId <> @YTCBearingId and db.Place = 'DE' and db.Active = 'Y') as DESelectedCount,
		(select Count(*) from DriveBearing db where db.DriveUnitId = e.DriveUnitId and db.BearingId <> @YTCBearingId and db.Place = 'NDE' and db.Active = 'Y') as NDESelectedCount,
		dbo.GetNameTranslated(e.EquipmentId,null,'EquipmentName') EquipmentName,
		e.AssetId,
		dbo.GetNameTranslated(e.AssetId,null,'TaxonomyAssetCode') AssetCode,
		e.IdentificationName,e.ListOrder,
		e.ManufacturerId,
		dbo.GetNameTranslated(e.ManufacturerId,null,'ManufacturerName') ManufacturerName,
		e.RPM,e.Frame,e.Voltage,e.PowerFactor,e.UnitRate,e.Model,e.HP,e.Type,e.MotorFanBlades,e.SerialNumber,e.RotorBars,e.Poles,e.Slots,e.BearingDriveEndId,
		e.BearingNonDriveEndId,e.PulleyDiaDrive,e.PulleyDiaDriven,e.BeltLength,
		e.CouplingId,
		dbo.GetNameTranslated(e.CouplingId,null,'LookupValue') CouplingName,
		e.MeanRepairManHours,e.DownTimeCostPerHour,e.CostToRepair,e.MeanFailureRate,e.Active,e.ManufactureYear,e.FirstInstallationDate,e.OperationModeId	
		from EquipmentDriveUnit e
		where e.EquipmentId = @EquipmentId
    End

	else If (isnull(@DriveUnitId, 0) > 0 and @Action = 'Attachment')
	Begin
		select da.DriveAttachId, da.DriveUnitId, da.FileName, da.LogicalName, da.PhysicalPath, da.Active from DriveAttachments da
		where  da.DriveUnitId = @DriveUnitId and da.Active = @Status
    End

	else If (@Action = 'Services')
	Begin
		select isnull(d.DriveServiceId,0)as UnitServiceId,@DriveUnitId as DriveUnitId,isnull(d.ReportId,l.LookupId)as ServiceId,l.LookupName as ServiceName,isnull(d.Active,'N')as Active 
		from DriveServices d 
		right join (select lookupid,dbo.GetNameTranslated(lookupid,@LanguageId,'LookupValue')LookupName,ListOrder from lookups where Lname ='ReportType')  l on d.ReportId = l.LookupId
		and d.DriveUnitId = @DriveUnitId
		order by l.listOrder
    End
	else If (@Action = 'DEBearings')
	Begin
		select b.BearingId, b.ManufacturerId,b.BearingCode as Designation,dbo.GetNameTranslated(b.BearingId,@LanguageId,'BearingName') as BearingName,
		dbo.GetNameTranslated(b.ManufacturerId,@LanguageId,'ManufacturerName') as ManufacturerName,
		isnull(d.Active,'N')as Active 
		from DriveBearing d 
		right join Bearings b on d.BearingId = b.BearingId and b.active = 'Y'
		and d.DriveUnitId = @DriveUnitId and d.Place = 'DE' 
    End 
	else If (@Action = 'NDEBearings')
	Begin
		select b.BearingId, b.ManufacturerId,b.BearingCode as Designation,dbo.GetNameTranslated(b.BearingId,@LanguageId,'BearingName') as BearingName,
		dbo.GetNameTranslated(b.ManufacturerId,@LanguageId,'ManufacturerName') as ManufacturerName,
		isnull(d.Active,'N')as Active 
		from DriveBearing d 
		right join Bearings b on d.BearingId = b.BearingId and b.active = 'Y'
		and d.DriveUnitId = @DriveUnitId and d.Place = 'NDE' 
    End 
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListEquipmentIntermediateUnit]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppListEquipmentIntermediateUnit]
	@EquipmentId int,
	@IntermediateUnitId int,
	@LanguageId int, 
	@Action varchar(75), -- Attachment | Services
	@Status varchar(5) 
AS
BEGIN
 	Declare @YTCBearingId int 
	If (isnull(@EquipmentId, 0) > 0  and ISNULL(@Action, '') = '')
	Begin
		select @YTCBearingId = BearingId from Bearings where BearingCode = 'YTC'

	   select e.EquipmentId,e.IntermediateUnitId,
	   (select Count(*) from IntermediateBearing ib where ib.IntermediateUnitId = e.IntermediateUnitId and ib.BearingId <> @YTCBearingId and ib.Place = 'DE' and ib.Active = 'Y') as DESelectedCount,
		(select Count(*) from IntermediateBearing ib where ib.IntermediateUnitId = e.IntermediateUnitId and ib.BearingId <> @YTCBearingId and ib.Place = 'NDE' and ib.Active = 'Y') as NDESelectedCount,
		dbo.GetNameTranslated(e.EquipmentId,null,'EquipmentName') EquipmentName,
		e.AssetId,
		dbo.GetNameTranslated(e.AssetId,null,'TaxonomyAssetCode') AssetCode,
		e.IdentificationName,e.ListOrder,
		e.ManufacturerId,
		dbo.GetNameTranslated(e.ManufacturerId,null,'ManufacturerName') ManufacturerName
		,e.Ratio,e.Size,e.BeltLength,e.PulleyDiaDrive,e.PulleyDiaDriven,e.RatedRPMInput,e.RatedRPMOutput,e.PinionInputGearTeeth,e.PinionOutputGearTeeth
		,e.IdlerInputGearTeeth,e.IdlerOutputGearTeeth,e.BullGearTeeth,e.Model,e.Serial,e.BearingInputId,e.BearingOutputId,e.MeanRepairManHours
		,e.DownTimeCostPerHour,e.CostToRepair,e.MeanFailureRate,e.Active,e.ManufactureYear,e.FirstInstallationDate,e.OperationModeId		
	 from EquipmentIntermediateUnit e
	where  e.EquipmentId = @EquipmentId
    End
	else If (isnull(@IntermediateUnitId, 0) > 0 and @Action = 'Attachment')
	Begin
		select ia.IntermediateAttachId, ia.IntermediateUnitId, ia.FileName, ia.LogicalName, ia.PhysicalPath, ia.Active from IntermediateAttachments ia
		where  ia.IntermediateUnitId = @IntermediateUnitId  and ia.Active = @Status
    End
	else If (@Action = 'Services')
	Begin
		select isnull(i.IntermediateServiceId,0)as UnitServiceId,@IntermediateUnitId as IntermediateUnitId,isnull(i.ReportId,l.LookupId)as ServiceId,l.LookupName as ServiceName,isnull(i.Active,'N')as Active from IntermediateServices i 
		right join (select lookupid,dbo.GetNameTranslated(lookupid,@LanguageId,'LookupValue')LookupName,ListOrder from lookups where Lname ='ReportType')  l on i.ReportId = l.LookupId
		and i.IntermediateUnitId = @IntermediateUnitId
		order by l.listOrder
    End
 	else If (@Action = 'DEBearings')
	Begin
		select b.BearingId, b.ManufacturerId,b.BearingCode as Designation,dbo.GetNameTranslated(b.BearingId,@LanguageId,'BearingName') as BearingName,
		dbo.GetNameTranslated(b.ManufacturerId,@LanguageId,'ManufacturerName') as ManufacturerName,
		isnull(d.Active,'N')as Active 
		from IntermediateBearing d 
		right join Bearings b on d.BearingId = b.BearingId and b.active = 'Y'
		and d.IntermediateUnitId = @IntermediateUnitId and d.Place = 'DE' 
    End 
	else If (@Action = 'NDEBearings')
	Begin
		select b.BearingId, b.ManufacturerId,b.BearingCode as Designation,dbo.GetNameTranslated(b.BearingId,@LanguageId,'BearingName') as BearingName,
		dbo.GetNameTranslated(b.ManufacturerId,@LanguageId,'ManufacturerName') as ManufacturerName,
		isnull(d.Active,'N')as Active 
		from IntermediateBearing d 
		right join Bearings b on d.BearingId = b.BearingId and b.active = 'Y'
		and d.IntermediateUnitId = @IntermediateUnitId and d.Place = 'NDE' 
    End 
END
 
  
GO
/****** Object:  StoredProcedure [dbo].[EAppListFailureCause]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 
CREATE   PROCEDURE [dbo].[EAppListFailureCause]
	@LanguageId Int,
	@Status varchar(5) 
AS
BEGIN
 
	select   a.FailureCauseId,a.FailureCauseCode,att.FailureCauseName,att.Descriptions,
	 a.Active,att.LanguageId,a.CreatedLanguageId  
	from FailureCause a right join FailureCauseTranslated att on att.FailureCauseId = a.FailureCauseId  
	where (a.Active =  @Status or @Status = 'ALL')  and( att.LanguageId = @LanguageId or (  att.LanguageId  = a.CreatedLanguageId 
	and not exists (select 'x' from FailureCauseTranslated where FailureCauseId = a.FailureCauseId and languageid = @Languageid)))
 

END
GO
/****** Object:  StoredProcedure [dbo].[EAppListFailureCauseModeRelation]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppListFailureCauseModeRelation]  
	@LanguageId Int,
	@FailureCauseId int
AS
BEGIN
  

SELECT @FailureCauseId FailureCauseId,  Isnull(c.FailureModeId,f.FailureModeId) FailureModeId,Isnull(dbo.GetNameTranslated(f.FailureModeId,@LanguageId,'FailureModeName'),'') as FailureModeName, case when Isnull(c.Active,'N') = 'N' then 'N' else f.Active end Active 
FROM FailureCauseModeRelation c right join FailureMode f on f.FailureModeId = c.FailureModeId and c.FailureCauseId = @FailureCauseId 
order by FailureModeName 

END
GO
/****** Object:  StoredProcedure [dbo].[EAppListFailureCauseTranslated]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppListFailureCauseTranslated]  
	@FailureCauseId Int
AS
BEGIN

	select @FailureCauseId FailureCauseId, a.FailureCauseCode, att.FailureCauseName,att.Descriptions,  l.LanguageId, l.CountryCode as LanguageCountryCode,l.LName LanguageName, a.Active
	from FailureCauseTranslated att right join Languages l on att.LanguageId =l.LanguageId and att.FailureCauseId = @FailureCauseId
	join FailureCause a on a.FailureCauseid = @FailureCauseid
 
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListFailureMode]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 
CREATE   PROCEDURE [dbo].[EAppListFailureMode]
	@LanguageId Int, 
	@Status varchar(5) 
AS
BEGIN
 
	select  a.FailureModeId,a.FailureModeCode,att.FailureModeName,att.Descriptions,
	 a.Active,att.LanguageId,a.CreatedLanguageId  
	from FailureMode a right join FailureModeTranslated att on att.FailureModeId = a.FailureModeId  
	where   (a.Active =  @Status or @Status = 'ALL')  and( att.LanguageId = @LanguageId or (  att.LanguageId  = a.CreatedLanguageId 
	and not exists (select 'x' from FailureModeTranslated where FailureModeId = a.FailureModeId and languageid = @Languageid)))
 

END
GO
/****** Object:  StoredProcedure [dbo].[EAppListFailureModeAssetClassRelation]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppListFailureModeAssetClassRelation]  
	@LanguageId Int,
	@FailureModeId int
AS
BEGIN
  

SELECT @FailureModeId FailureModeId,  Isnull(f.AssetClassId,a.AssetClassId) AssetClassId,Isnull(dbo.GetNameTranslated(a.AssetClassId,@LanguageId,'AssetClassName'),'') as AssetClassName, case when Isnull(f.Active,'N') = 'N' then 'N' else f.Active end Active 
FROM FailureModeAssetClassRelation f right join AssetClass a on a.AssetClassId = f.AssetClassId and f.FailureModeId = @FailureModeId 
Order by AssetClassName

END
GO
/****** Object:  StoredProcedure [dbo].[EAppListFailureModeTranslated]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 


CREATE   PROCEDURE [dbo].[EAppListFailureModeTranslated]  
	@FailureModeId Int
AS
BEGIN

	select @FailureModeId FailureModeId, a.FailureModeCode, att.FailureModeName,att.Descriptions,  l.LanguageId, l.CountryCode as LanguageCountryCode,l.LName LanguageName, a.Active
	from FailureModeTranslated att right join Languages l on att.LanguageId =l.LanguageId and att.FailureModeId = @FailureModeId
	join FailureMode a on a.FailureModeid = @FailureModeid
 
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListFailureReport]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppListFailureReport]
	@ReportType varchar(10), 
	@ClientSiteId int,
	@FailureReportHeaderId Bigint,	 
	@LanguageId int,  
	@ReportFromDate Date,
	@ReportToDate Date
AS
BEGIN
	if @FailureReportHeaderId = 0 
	Set @FailureReportHeaderId = null
	 
	--Select h.FailureReportHeaderId,h.ReportType, h.EquipmentId ,h.ReportDate  ,h.ActualRepairCost ,h.ActualOutageTime ,h.BreakDownCost ,h.BreakDownHrs ,h.Active ,
	--(select d.FailureReportHeaderId,FailureReportDetailId,UnitType,UnitId,dbo.GetNameTranslated(d.UnitId,@LanguageId,'DRUnitName') as IdentificationName, FailureModeId,FailureCauseId,d.MTTR,d.MTBF, isnull(d.Descriptions,'')Descriptions, ActualRepairCost as DActualRepairCost,ActualOutageTime as DActualOutageTime, isnull(Active,'N') as Active 
	--COMMETNS BY SSK ON 02-04-2019 ****Added the FailureModeName and FailureCauseName in the json list*******
	Select h.FailureReportHeaderId,h.ReportType, h.EquipmentId,dbo.GetNameTranslated(h.EquipmentId,@LanguageId,'EquipmentName') as EquipmentName,h.ReportDate  ,h.ActualRepairCost ,h.ActualOutageTime ,h.BreakDownCost ,h.BreakDownHrs ,h.Active ,h.DownTimeCost,h.TrueSavingsCost,h.TrueSavingsHrs,h.ActualRepairCost, (select Username from users where userid = h.CreatedBy) as CreatedBy,
	(select d.FailureReportHeaderId,FailureReportDetailId,UnitType,UnitId,dbo.GetNameTranslated(d.UnitId,@LanguageId,'DRUnitName') as IdentificationName,dbo.GetNameTranslated(d.UnitId,@LanguageId,'DRUnitAssetId') as AssetId, FailureModeId,dbo.GetNameTranslated(d.FailureModeId,@LanguageId,'FailureModeName') as FailureModeName,FailureCauseId,dbo.GetNameTranslated(d.FailureCauseId,@LanguageId,'FailureCauseName') as FailureCauseName,d.MTTR,d.MTBF, isnull(d.Descriptions,'')Descriptions, ActualRepairCost as DActualRepairCost,ActualOutageTime as DActualOutageTime, isnull(Active,'N') as Active 
	from FailureReportDetail  d where d.FailureReportHeaderId = h.FailureReportHeaderId and d.UnitType = 'DR'
	order by d.FailureReportDetailId
	FOR JSON AUTO , INCLUDE_NULL_VALUES
	) DriveUnitList  ,
	--COMMETNS BY SSK ON 02-04-2019 ****Added the FailureModeName and FailureCauseName in the json list*******
	--(select d.FailureReportHeaderId,FailureReportDetailId,UnitType,UnitId,dbo.GetNameTranslated(d.UnitId,@LanguageId,'INUnitName') as IdentificationName,FailureModeId,FailureCauseId,d.MTTR,d.MTBF, isnull(d.Descriptions,'')Descriptions,  ActualRepairCost as DActualRepairCost,ActualOutageTime as DActualOutageTime, isnull(Active,'N') as Active 
	(select d.FailureReportHeaderId,FailureReportDetailId,UnitType,UnitId,dbo.GetNameTranslated(d.UnitId,@LanguageId,'INUnitName') as IdentificationName,dbo.GetNameTranslated(d.UnitId,@LanguageId,'INUnitAssetId') as AssetId,FailureModeId,dbo.GetNameTranslated(d.FailureModeId,@LanguageId,'FailureModeName') as FailureModeName,FailureCauseId,dbo.GetNameTranslated(d.FailureCauseId,@LanguageId,'FailureCauseName') as FailureCauseName,d.MTTR,d.MTBF, isnull(d.Descriptions,'')Descriptions,  ActualRepairCost as DActualRepairCost,ActualOutageTime as DActualOutageTime, isnull(Active,'N') as Active 
	from FailureReportDetail  d where d.FailureReportHeaderId = h.FailureReportHeaderId and d.UnitType = 'IN'
	order by d.FailureReportDetailId
	FOR JSON AUTO , INCLUDE_NULL_VALUES
	) IntermediateUnitList ,
	--COMMETNS BY SSK ON 02-04-2019 ****Added the FailureModeName and FailureCauseName in the json list*******
    --select d.FailureReportHeaderId,FailureReportDetailId,UnitType,UnitId,dbo.GetNameTranslated(d.UnitId,@LanguageId,'DNUnitName') as IdentificationName,FailureModeId,FailureCauseId,d.MTTR,d.MTBF, isnull(d.Descriptions,'')Descriptions,  ActualRepairCost as DActualRepairCost,ActualOutageTime as DActualOutageTime, isnull(Active,'N') as Active 
    (select d.FailureReportHeaderId,FailureReportDetailId,UnitType,UnitId,dbo.GetNameTranslated(d.UnitId,@LanguageId,'DNUnitName') as IdentificationName,dbo.GetNameTranslated(d.UnitId,@LanguageId,'DNUnitAssetId') as AssetId,FailureModeId,dbo.GetNameTranslated(d.FailureModeId,@LanguageId,'FailureModeName') as FailureModeName,FailureCauseId,dbo.GetNameTranslated(d.FailureCauseId,@LanguageId,'FailureCauseName') as FailureCauseName,d.MTTR,d.MTBF, isnull(d.Descriptions,'')Descriptions,  ActualRepairCost as DActualRepairCost,ActualOutageTime as DActualOutageTime, isnull(Active,'N') as Active 
	from FailureReportDetail  d where d.FailureReportHeaderId = h.FailureReportHeaderId and d.UnitType = 'DN'
	order by d.FailureReportDetailId
	FOR JSON AUTO , INCLUDE_NULL_VALUES
	) DrivenUnitList 
	from  FailureReportHeader h  where h.FailureReportHeaderId = isnull(FailureReportHeaderId,@FailureReportHeaderId) and h.ClientSiteId = @ClientSiteId 
	and h.ReportDate between @ReportFromDate and isnull(@ReportToDate,getdate()) and h.ReportType = @ReportType

END
GO
/****** Object:  StoredProcedure [dbo].[EAppListFailureReportAttachment]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppListFailureReportAttachment]
	@FailureReportHeaderId int,
	@Status varchar(5) 
AS
BEGIN
		select fa.FailureReportAttachId, fa.FailureReportHeaderId, fa.FileName, fa.LogicalName, fa.PhysicalPath, fa.Active 
		from FailureReportAttachment fa
		where   fa.FailureReportHeaderId = @FailureReportHeaderId and (fa.Active =  @Status or @Status = 'ALL') 
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListIndustry]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppListIndustry]  
	@LanguageId Int,
	@SectorId Int,
	@SegmentId Int,
	@Status varchar(5) 
AS
BEGIN
 
	select s.SectorId,i.IndustryId,i.DownTimeCostPerHour,dbo.GetNameTranslated(s.SectorId,@LanguageId,'SectorName') as SectorName,  
	i.SegmentId,dbo.GetNameTranslated(i.SegmentId,@LanguageId,'SegmentName') as SegmentName,
	i.IndustryCode,it.IndustryName,it.Descriptions, i.Active,it.LanguageId,i.CreatedLanguageId  
	from Industry I right join IndustryTranslated it on it.IndustryId = i.IndustryId 
	join Segment s on s.SegmentId = i.SegmentId
	where (s.SectorId =  @SectorId or @SectorId = 0) and (s.SegmentId =  @SegmentId or @SegmentId = 0) 
	and (i.Active =  @Status or @Status = 'ALL')  and ( it.LanguageId = @LanguageId or (  it.LanguageId  = i.CreatedLanguageId 
	and not exists (select 'x' from IndustryTranslated where IndustryId = i.IndustryId and languageid = @Languageid)))
 

END
GO
/****** Object:  StoredProcedure [dbo].[EAppListIndustryTranslated]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppListIndustryTranslated]  
	@IndustryId Int
AS
BEGIN

	select @IndustryId IndustryId, i.SegmentId, i.IndustryCode, it.IndustryName,it.Descriptions,  l.LanguageId, l.CountryCode as LanguageCountryCode,l.LName LanguageName, i.Active 
	from IndustryTranslated it right join Languages l on it.LanguageId =l.LanguageId and it.IndustryId = @industryId
	join Industry i on i.IndustryId = @IndustryId
 
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListJobComment]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppListJobComment]
	@JobId Bigint,
	@LanguageId Int
AS
BEGIN
 
 Select j.StatusId,isnull(dbo.GetNameTranslated(j.StatusId,@LanguageId,'LookupValue'),'') StatusName, j.Comments,
 (select u.UserName from Users u where u.UserId = j.CreatedBy) CreatedBy, j.Createdon
 from  JobComments j where j.JobId = @JobId and j.Active = 'Y' order by j.Createdon 
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListJobDiagnosis]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[EAppListJobDiagnosis]
	@ClientSiteId int,
	@UserId int,
	@JobId Bigint,
	@ScheduleSetupId Bigint,
	@LanguageId int,  
	@StatusId int,
	@FromDate Date,
	@ToDate Date,
	@JobNumber varchar(50)
AS  
BEGIN  
	Declare @VAId int, @OAId int
	Select @VAId = dbo.GetStatusId(1,'ReportType','VA'),  @OAId = dbo.GetStatusId(1,'ReportType','OA')
	Select j.JobId, j.JobName, j.JobNumber, j.EstStartDate, j.EstEndDate, j.ActStartDate, j.ActEndDate,j.AnalystId,(select UserName from Users where UserId = j.AnalystId) AnalystName, j.ScheduleSetupId, j.ClientSiteId, j.StatusId, 
	isnull(dbo.GetNameTranslated(j.StatusId,@LanguageId,'LookupValue'),'') StatusName,
	isnull(dbo.GetNameTranslated(j.StatusId,@LanguageId,'LookupCode'),'') StatusCode,
	j.ReviewerId,
	dbo.GetLookupTranslated(dbo.GetStatusId(@LanguageId,'ReportStatusLegend',dbo.GetLookupTranslated(j.StatusId,@LanguageId,'LookupCode')),@LanguageId,'LookupValue')  StatusColour,
	j.DataCollectionDate, j.ReportDate, isnull(dbo.CheckJobStatus(j.StatusId),0) as IsEditable,@VAId as VAServiceId, @OAId as OAServiceId,
	dbo.GetJobStatusColour(j.JobId,@VAId,j.EstStartDate,@LanguageId,@UserId) as VAStatusColour, 
	dbo.GetJobStatusColour(j.JobId,@OAId,j.EstStartDate,@LanguageId,@UserId) as OAStatusColour,
	dbo.GetJobEquipCount(j.JobId,@VAId,@LanguageId,@UserId)as VACount,
	dbo.GetJobEquipCount(j.JobId,@OAId,@LanguageId,@UserId)as OACount,
	dbo.GetJobProcessPct(j.JobId,null,@LanguageId,@UserId)as StatusPercent,	
	dbo.GetJobToolTip(j.JobId,@VAId,@LanguageId,@UserId)as VAToolTip,
	dbo.GetJobToolTip(j.JobId,@OAId,@LanguageId,@UserId)as OAToolTip,
	DataCollectionMode,
	cast(case when isnull(j.DataCollectionMode,0) = 1 then 1
	when  isnull(DataCollectionMode,0) = 0 
	then 
	case when j.DataCollectorId = @UserId then
		case when (select case when Count(JobEquipmentId) = 0 then 999.999 when Count(JobEquipmentId) - sum(isnull(DataCollectionDone,0)) = 0 then 1 else 0 end  
		from JobEquipment where jobid = j.jobid and  DataCollectorId = @UserId and active = 'Y')  = 0 then 0 else 1 end
	when j.AnalystId = @UserId then
		case when (select case when Count(JobEquipmentId) = 0 then 999.999 when Count(JobEquipmentId) - sum(isnull(DataCollectionDone,0)) = 0 then 1 else 0 end  
		from JobEquipment where jobid = j.jobid and  AnalystId = @UserId and active = 'Y')  = 0 then 0 else 1 end
	when j.ReviewerId = @UserId then
		case when (select case when Count(JobEquipmentId) = 0 then 999.999 when Count(JobEquipmentId) - sum(isnull(DataCollectionDone,0)) = 0 then 1 else 0 end  
		from JobEquipment where jobid = j.jobid and  ReviewerId = @UserId and active = 'Y')  = 0 then 0 else 1 end
 	end 
	end as int) DataCollectionDone,
	ReportSent,
 	case 
	when  isnull(DataCollectionMode,0) = 1  and isnull(j.AnalystId,0) = 0 and isnull(j.ReviewerId,0) = 0 then 'Not Started'
	when  isnull(DataCollectionMode,0) = 1  and isnull(j.AnalystId,0) > 0 and isnull(j.ReviewerId,0) > 0 then 'Done'
	when  isnull(DataCollectionMode,0) = 1 and ( isnull(j.AnalystId,0) > 0 or isnull(j.ReviewerId,0) > 0) then 'In Progress'
	when  (isnull(DataCollectionMode,0) = 0  and isnull(j.DataCollectorId,0) > 0) and isnull(j.AnalystId,0) > 0 and isnull(j.ReviewerId,0) > 0 then 'Done'
	when  (isnull(DataCollectionMode,0) = 0  and isnull(j.DataCollectorId,0) = 0) and isnull(j.AnalystId,0) = 0 and isnull(j.ReviewerId,0) = 0 then 'Not Started'
	when  (isnull(DataCollectionMode,0) = 0  and isnull(j.DataCollectorId,0) > 0) or isnull(j.AnalystId,0) > 0 or isnull(j.ReviewerId,0) > 0 then 'In Progress'
	end Assignment,
	(select isnull(js.JobServiceId,0) as JobServiceId,isnull(js.JobId,@JobId) JobId, isnull(js.ServiceId,l.LookupId)as ServiceId, isnull(l.LookupCode,l.LookupCode)as ServiceCode, Isnull(l.LookupName,l.LookupName) as ServiceName,isnull(js.Active,'N')as Active
	from JobServices js	
	right join (select lookupid,LookupCode,dbo.GetNameTranslated(lookupid,@LanguageId,'LookupValue')LookupName,ListOrder from lookups where Lname ='ReportType')  l on js.ServiceId = l.LookupId
	and  js.JobId = j.JobId 
	FOR JSON AUTO 
	) JobServices,
	dbo.GetDCUpdateCheck(j.JobId,@UserId) as IsDCDoneAllowed,
	dbo.GetRSUpdateCheck(j.JobId,@UserId) as IsReportSentAllowed
 from  Jobs j  where  j.EstStartDate between @FromDate and isnull(@ToDate,getdate()+90) 
 and j.ClientSiteId = @ClientSiteId and j.JobNumber = isnull(@JobNumber,j.JobNumber)  
  and exists (select 'x' from JobEquipment where JobId = j.JobId and (DataCollectorId =  @UserId or AnalystId = @UserId or ReviewerId = @UserId))
  order by j.EstStartDate desc, j.JobNumber desc  
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListJobEquipment]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppListJobEquipment]
	@JobId Bigint, 
	@ServiceId int,
	@LanguageId int,  
	@StatusId int,
	@UserId int
AS
BEGIN
 Declare @IsOil int 

 if @ServiceId = 0
	set @ServiceId = null;

 Select @IsOil = dbo.[GetStatusId](@LanguageId,'ReportType' , 'OA')

 Select je.JobEquipmentId, je.JobId, j.JobName, j.JobNumber, je.EquipmentId,''as EquipmentCode,
 dbo.GetNameTranslated(je.EquipmentId,@LanguageId,'EquipmentName')as EquipmentName, 
 je.ActStartDate, je.ActEndDate, je.StatusId
 ,dbo.GetLookupTranslated(dbo.GetStatusId(@LanguageId,'ReportStatusLegend',dbo.GetLookupTranslated(je.StatusId,@LanguageId,'LookupCode')),@LanguageId,'LookupValue')  StatusColour
 , isnull(dbo.GetLookupTranslated(je.StatusId,@LanguageId,'LookupValue'),'') StatusName
 , isnull(dbo.GetLookupTranslated(je.StatusId,@LanguageId,'LookupCode'),'') StatusCode, isnull(dbo.CheckJobStatus(je.StatusId),0) as IsEditable, 
 case when isnull((select Count(ua.UnitAnalysisId) from JobEquipUnitAnalysis ua where ua.JobEquipmentId = je.JobEquipmentId and ua.IsWorkNotification = 'Y' ),0) >0 then 'Y' else 'N' end as  IsWorkNotification, 
 case when isnull((select Count(ua.UnitAnalysisId) from JobEquipUnitAnalysis ua where ua.JobEquipmentId = je.JobEquipmentId and ua.ServiceId = @IsOil),0) >0 then 'Y' else 'N' end as 'IsOilProperties',
 e.PlantAreaId, dbo.GetNameTranslated(e.PlantAreaId,@LanguageId,'PlantAreaName') as PlantAreaName,
 je.ConditionId,je.Comment as EquipmentComment, je.DataCollectionDate, je.ReportDate, je.ServiceId, isnull(dbo.GetLookupTranslated(je.ServiceId,@LanguageId,'LookupValue'),'') ServiceName,
 je.DataCollectionDone, dbo.[JobEquipUnitUnselected](je.JobEquipmentId) as AssetToReport
 from  JobEquipment je  join Jobs j on j.JobId = je.JobId and je.ServiceId = isnull(@ServiceId,je.ServiceId)
 join Equipment e on e.EquipmentId = je.EquipmentId   
 where je.JobId = @JobId and  je.Active = 'Y' and (je.DataCollectorId = @UserId or je.AnalystId = @UserId or je.ReviewerId = @UserId)
 order by  dbo.GetLookupTranslated(je.ServiceId,@LanguageId,'LookupOrder') , e.PlantAreaId,e.ListOrder 
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListJobEquipmentAssignUser]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppListJobEquipmentAssignUser]  
	@JobId Bigint, 
	@LanguageId int 
AS
BEGIN
    select je.JobEquipmentId, 
	dbo.GetNameTranslated(e.PlantAreaId,@LanguageId,'PlantAreaName') as PlantName, 
	dbo.GetNameTranslated(e.AreaId,@LanguageId,'AreaName') as AreaName, 
	dbo.GetNameTranslated(e.SystemId,@LanguageId,'SystemName') as SystemName, 
	isnull(e.EquipmentName,'') as EquipmentName, 
	je.ServiceId, dbo.GetNameTranslated(je.serviceId,@LanguageId,'LookupValue') as ServiceName,
	je.DataCollectorId, (select Username from users where userid = je.DataCollectorId) as DataCollectorName, 
	je.AnalystId, (select Username from users where userid = je.AnalystId) as AnalystName ,
	je.ReviewerId, (select Username from users where userid = je.ReviewerId) as ReviewerName 
	from JobEquipment je join Equipment e on e.EquipmentId = je.EquipmentId	and je.JobId = @JobId 
	order by e.ListOrder 

END
GO
/****** Object:  StoredProcedure [dbo].[EAppListJobEquipmentComment]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppListJobEquipmentComment] 
	@JobEquipmentId Bigint,
	@LanguageId Int
AS
BEGIN
 
 Select j.StatusId,isnull(dbo.GetNameTranslated(j.StatusId,@LanguageId,'LookupValue'),'') StatusName, j.Comments,
 (select u.UserName from Users u where u.UserId = j.CreatedBy) CreatedBy , j.Createdon
 from  JobEquipmentComments j where j.JobEquipmentId = @JobEquipmentId and j.Active = 'Y' order by Createdon 

END
GO
/****** Object:  StoredProcedure [dbo].[EAppListJobEquipmentDetail]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppListJobEquipmentDetail] 
	@ClientSiteId int,
	@JobId Bigint, 
	@LanguageId int 
AS
BEGIN
	Declare @VAId int, @OAId int
	--Select @VAId = dbo.GetStatusId(1,'ReportType','VA'),  @OAId = dbo.GetStatusId(1,'ReportType','OA')
 	
	select (select isnull(je.JobEquipmentId ,0) as JobEquipmentId,isnull(e.PlantAreaId,'') as PlantAreaId, 
	 isnull(dbo.GetNameTranslated(e.PlantAreaId,@LanguageId,'PlantAreaName'),'') as PlantAreaName, 
	isnull(e.EquipmentId,'') as EquipmentId , isnull(e.EquipmentName,'') as EquipmentName,
	 isnull(je.StatusId ,'') as StatusId , isnull(dbo.GetNameTranslated(je.StatusId,@LanguageId,'LookupValue'),'')StatusName,
	isnull(je.Active,'N') as Active
	from JobEquipment je right join vEquipment e on e.EquipmentId = je.EquipmentId	and  e.ClientSiteId = @ClientSiteId  
	and je.JobId = @JobId 
	order by e.ListOrder
	FOR JSON AUTO 
	) JobEquipments  

END
GO
/****** Object:  StoredProcedure [dbo].[EAppListJobEquipmentOilProperties]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppListJobEquipmentOilProperties] 
	 @JobEquipmentId Bigint  
	,@LanguageId int 
AS
BEGIN
 	select j.JobEquipOilPropertiesId, j.JobEquipmentId,
	j.OilLevel, j.SeverityId,dbo.GetNameTranslated(j.SeverityId,@LanguageId,'LookupValue') as Severity,
	j.OilPropertiesId, dbo.GetNameTranslated(j.OilPropertiesId,@LanguageId,'LookupValue') as OilProperties,
	j.OAVibChangePercentageId, dbo.GetNameTranslated(j.OilPropertiesId,@LanguageId,'LookupValue') as OAVibChangePercentage, Active
	from JobEquipmentOilProperties j  where j.JobEquipmentId = @JobEquipmentId and Active = 'Y'
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListJobEquipmentSelected]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppListJobEquipmentSelected] 
	@ClientSiteId int,
	@JobId Bigint, 
	@LanguageId int 
AS
BEGIN
	DROP TABLE IF EXISTS #TEquipment

	Create Table #TEquipment(PlantAreaId int, AreaId Int, SystemId int,PlantAreaName nvarchar(250),AreaName nvarchar(250),systemName nvarchar(250),EquipmentId int, EquipmentName nvarchar(250),ListOrder int);
	
	Insert into #TEquipment(PlantAreaId,PlantAreaName,AreaId,AreaName,SystemId,SystemName,EquipmentId,EquipmentName,ListOrder)
	select e.PlantAreaId,pt.PlantAreaName, e.AreaId, dbo.GetNameTranslated(e.AreaId,@LanguageId,'AreaName')AreaName,
	e.SystemId, dbo.GetNameTranslated(e.SystemId,@LanguageId,'SystemName')SystemName,
	e.EquipmentId, e.EquipmentName, e.ListOrder
	FROM dbo.Equipment AS e JOIN dbo.PlantArea AS P ON P.PlantAreaId = e.PlantAreaId and p.ClientSiteId = @ClientSiteId
	join PlantAreaTranslated pt on pt.PlantAreaId = p.PlantAreaId and pt.languageId = case when isnull(@LanguageId,0) = 0 then p.CreatedLanguageId else @LanguageId end
  
	select (select isnull(e.PlantAreaId,'') as PlantAreaId, e.PlantAreaName, e.PlantAreaId,e.AreaId,e.AreaName,e.SystemId,e.SystemName, 
	isnull(e.EquipmentId,'') as EquipmentId , isnull(e.EquipmentName,'') as EquipmentName,
	isnull(je.Active,'N') as Active
	from (select distinct EquipmentId, Active from JobEquipment where jobid = @JobId) je right join #TEquipment e on e.EquipmentId = je.EquipmentId 
	order by e.ListOrder
	FOR JSON AUTO, INCLUDE_NULL_VALUES
	) JobEquipments  

END
GO
/****** Object:  StoredProcedure [dbo].[EAppListJobEquipmentUnitAnalysisComment]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppListJobEquipmentUnitAnalysisComment] 
	@UnitAnalysisId Bigint,
	@LanguageId Int
AS
BEGIN
 
 Select j.StatusId,isnull(dbo.GetNameTranslated(j.StatusId,@LanguageId,'LookupValue'),'') StatusName, j.Comments,
 (select u.UserName from Users u where u.UserId = j.CreatedBy)CreatedBy,Createdon
 from  JobEquipmentUnitAnalysisComments j where UnitAnalysisId = @UnitAnalysisId and j.Active = 'Y' order by Createdon 
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListJobEquipUnitAnalysis]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppListJobEquipUnitAnalysis] 
	@JobEquipmentId Bigint, 
	@LanguageId int,
	@StatusId int
AS
BEGIN
 
 Declare @JobId Bigint, @EquipmentId Int, @NewStatus int,@DataCollectionDone int
 select  @JobId = JobId, @EquipmentId = EquipmentId, @NewStatus = dbo.GetStatusId(1,'JobProcessStatus','NS'),
 @DataCollectionDone = DataCollectionDone
 from JobEquipment where JobEquipmentId = @JobEquipmentId
 
	select UnitAnalysisId, JobEquipmentId,@JobId as JobId,@EquipmentId as EquipmentId,
	isnull(dbo.GetNameTranslated(@EquipmentId,@LanguageId,'EquipmentName'),'') as EquipmentName,
	UnitType,UnitId, 
		Case when UnitType = 'DR' then (select AssetId from EquipmentDriveUnit where DriveUnitId = UnitId) 
		 when UnitType = 'IN' then (select AssetId from EquipmentIntermediateUnit where IntermediateUnitId = UnitId)
		 when UnitType = 'DN' then (select AssetId from EquipmentDrivenUnit where DrivenUnitId = UnitId) 
		 end AssetId, 
		Case when UnitType = 'DR' then (select IdentificationName from EquipmentDriveUnit where DriveUnitId = UnitId) 
		 when UnitType = 'IN' then (select IdentificationName from EquipmentIntermediateUnit where IntermediateUnitId = UnitId)
		 when UnitType = 'DN' then (select IdentificationName from EquipmentDrivenUnit where DrivenUnitId = UnitId) 
		 end  AssetName, ServiceId,
	isnull(dbo.GetLookupTranslated(ServiceId,@LanguageId,'LookupValue'),'') as ServiceName, 
	isnull(dbo.CheckJobStatus(isnull(ua.StatusId,@NewStatus)),0) as IsEditable,
	Case when IsWorkNotification = 'N' then 'No' when IsWorkNotification = 'Y' then 'Yes' end IsWorkNotification  , StatusId , 
	Case when UnitType = 'DR' then 1 when UnitType = 'IN' then 2 when unitType = 'DN' then 3 end UnitOrder,
	Case when UnitType = 'DR' then (select listorder from EquipmentDriveUnit where DriveUnitId = UnitId) 
		 when UnitType = 'IN' then (select listorder from EquipmentIntermediateUnit where IntermediateUnitId = UnitId)
		 when UnitType = 'DN' then (select listorder from EquipmentDrivenUnit where DrivenUnitId = UnitId) 
		 end ListOrder,
	Case when DatavalidationStatus = 0 then dbo.GetLookupTranslated(dbo.GetStatusId(@LanguageId,'ReportStatusLegend',
	'NS'),@LanguageId,'LookupValue')
	when DatavalidationStatus = 1 then dbo.GetLookupTranslated(dbo.GetStatusId(@LanguageId,'ReportStatusLegend',
	'C'),@LanguageId,'LookupValue')
	when DatavalidationStatus = 2 then dbo.GetLookupTranslated(dbo.GetStatusId(@LanguageId,'ReportStatusLegend',
	'OD'),@LanguageId,'LookupValue')
	when DatavalidationStatus = 9 then dbo.GetLookupTranslated(dbo.GetStatusId(@LanguageId,'ReportStatusLegend',
	'NA'),@LanguageId,'LookupValue')
	end StatusColour,	 
	DatavalidationText,	
	Case when DatavalidationStatus = 2 then 'QC Failed' 
		 when DataValidationStatus = 1 then 'QC Success'
		 when DataValidationStatus = 0 then 'Not Started' 
		 when DataValidationStatus = 9 then 'Not Required'
	end DataValidationStatus, @DataCollectionDone as DataCollectionDone
	from JobEquipUnitAnalysis ua where ua.JobEquipmentId = @JobEquipmentId
    order by UnitOrder,ListOrder
END 
 
 
GO
/****** Object:  StoredProcedure [dbo].[EAppListJobEquipUnitUnselected]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppListJobEquipUnitUnselected] 
	@JobEquipmentId Bigint, 
	@LanguageId int 
AS
BEGIN
   
;With DRCTE as
(
Select  Je.JobEquipmentId,Je.JobId,je.EquipmentId,e.PlantAreaId,e.AreaId,e.SystemId, je.AssetListOrder,
isnull(dbo.GetLookupTranslated(je.ServiceId,@LanguageId,'LookupOrder'),0)as ListOrder
,je.DriveUnitId as UnitId, 1 as UnitOrder, 'DR' as UnitType, je.AssetId,je.AssetName,Je.ServiceId
from vEquipDriveAnalysis je	
Join Equipment e on e.EquipmentId = je.EquipmentId
where je.JobEquipmentId = @JobEquipmentId
and not exists (select 'x' from JobEquipUnitAnalysis ua where ua.JobEquipmentId = je.JobEquipmentId and ua.UnitType = 'DR' and ua.UnitId = je.DriveUnitId and ua.ServiceId = je.ServiceId ) 
), INCTE as
(
	Select Je.JobEquipmentId,Je.JobId,je.EquipmentId,e.PlantAreaId,e.AreaId,e.SystemId, je.AssetListOrder,
	isnull(dbo.GetLookupTranslated(je.ServiceId,@LanguageId,'LookupOrder'),0)as ListOrder
	,je.IntermediateUnitId as UnitId,  2 as UnitOrder, 'IN' as UnitType, je.AssetId,je.AssetName,Je.ServiceId  
	from vEquipIntermediateAnalysis je	
	Join Equipment e on e.EquipmentId = je.EquipmentId	
	where je.JobEquipmentId = @JobEquipmentId
	and not exists (select 'x' from JobEquipUnitAnalysis ua where ua.JobEquipmentId = je.JobEquipmentId and ua.UnitType = 'IN' and ua.UnitId = je.IntermediateUnitId and ua.ServiceId = je.ServiceId ) 

), DNCTE as
(  Select Je.JobEquipmentId,Je.JobId,je.EquipmentId,e.PlantAreaId,e.AreaId,e.SystemId, je.AssetListOrder,
	isnull(dbo.GetLookupTranslated(je.ServiceId,@LanguageId,'LookupOrder'),0)as ListOrder
	,je.DrivenUnitId as UnitId,  3 as UnitOrder, 'DN' UnitType, je.AssetId,je.AssetName,Je.ServiceId  
	from vEquipDrivenAnalysis je
	Join Equipment e on e.EquipmentId = je.EquipmentId
	where je.JobEquipmentId = @JobEquipmentId
	and not exists (select 'x' from JobEquipUnitAnalysis ua where ua.JobEquipmentId = je.JobEquipmentId and ua.UnitType = 'DN' and ua.UnitId = je.DrivenUnitId and ua.ServiceId = je.ServiceId ) 
 ) 

	select JobEquipmentId,EquipmentId,
	isnull(dbo.GetNameTranslated(PlantAreaId,@LanguageId,'PlantAreaName'),'') as PlantName,
	isnull(dbo.GetNameTranslated(AreaId,@LanguageId,'AreaName'),'') as AreaName,
	isnull(dbo.GetNameTranslated(SystemId,@LanguageId,'System'),'') as [System],
	AssetName,	ListOrder,UnitType,UnitId, UnitOrder 
 	from DRCTE 
	union all
	select JobEquipmentId,EquipmentId,
	isnull(dbo.GetNameTranslated(PlantAreaId,@LanguageId,'PlantAreaName'),'') as PlantName,
	isnull(dbo.GetNameTranslated(AreaId,@LanguageId,'AreaName'),'') as AreaName,
	isnull(dbo.GetNameTranslated(SystemId,@LanguageId,'System'),'') as [System],
	AssetName,	ListOrder,UnitType,UnitId, UnitOrder 
	from INCTE
	union all
	select JobEquipmentId,EquipmentId,
	isnull(dbo.GetNameTranslated(PlantAreaId,@LanguageId,'PlantAreaName'),'') as PlantName,
	isnull(dbo.GetNameTranslated(AreaId,@LanguageId,'AreaName'),'') as AreaName,
	isnull(dbo.GetNameTranslated(SystemId,@LanguageId,'System'),'') as [System],
	AssetName,	ListOrder,UnitType,UnitId, UnitOrder 
	from DNCTE
    order by UnitOrder,ListOrder
END 
 
GO
/****** Object:  StoredProcedure [dbo].[EAppListJobs]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppListJobs]
	@ClientSiteId int,
	@JobId Bigint,
	@ScheduleSetupId Bigint,
	@LanguageId int,  
	@StatusId int,
	@FromDate date,
	@ToDate date,
	@JobNumber varchar(50)
AS
BEGIN
	Declare @VAId int, @OAId int
	Select @VAId = dbo.GetStatusId(1,'ReportType','VA'),  @OAId = dbo.GetStatusId(1,'ReportType','OA')
 
	Select j.JobId, j.JobName, j.JobNumber, j.EstStartDate, j.EstEndDate,j.DataCollectorId, j.AnalystId,j.ReviewerId, 
	j.ScheduleSetupId, j.ClientSiteId, j.StatusId, dbo.GetLookupTranslated(j.StatusId,@LanguageId,'LookupCode') StatusCode,
	isnull(dbo.GetLookupTranslated(j.StatusId,@LanguageId,'LookupValue'),'') StatusName,
	dbo.GetLookupTranslated(dbo.GetStatusId(@LanguageId,'ReportStatusLegend',
	dbo.GetLookupTranslated(j.StatusId,@LanguageId,'LookupCode')),@LanguageId,'LookupValue')  StatusColour,
	j.DataCollectionDate, j.ReportDate,@VAId as VAServiceId, @OAId as OAServiceId,
	dbo.GetJobStatusColour(j.JobId,@VAId,j.EstStartDate,@LanguageId,null) as VAStatusColour, 
	dbo.GetJobStatusColour(j.JobId,@OAId,j.EstStartDate,@LanguageId,null) as OAStatusColour, 
	dbo.GetJobEquipCount(j.JobId,@VAId,@LanguageId,null)as VACount,
	dbo.GetJobEquipCount(j.JobId,@OAId,@LanguageId,null)as OACount,
	dbo.GetJobProcessPct(j.JobId,null,@LanguageId,null) as StatusPercent,
	isnull(dbo.GetJobToolTip(j.JobId,@VAId,@LanguageId,null),'')as VAToolTip,
	isnull(dbo.GetJobToolTip(j.JobId,@OAId,@LanguageId,null),'') as OAToolTip,
	DataCollectionMode,cast(case when isnull(j.DataCollectionMode,0) = 1 then 1
	when  isnull(DataCollectionMode,0) = 0 then case when isnull(DataCollectionDone,'N') = 'Y' then 1 else 0 end
	end as int) DataCollectionDone,ReportSent,
 	case 
	when  isnull(DataCollectionMode,0) = 1  and isnull(j.AnalystId,0) = 0 and isnull(j.ReviewerId,0) = 0 then 'Not Started'
	when  isnull(DataCollectionMode,0) = 1  and isnull(j.AnalystId,0) > 0 and isnull(j.ReviewerId,0) > 0 then 'Done'
	when  isnull(DataCollectionMode,0) = 1 and ( isnull(j.AnalystId,0) > 0 or isnull(j.ReviewerId,0) > 0) then 'In Progress'
	when  (isnull(DataCollectionMode,0) = 0  and isnull(j.DataCollectorId,0) > 0) and isnull(j.AnalystId,0) > 0 and isnull(j.ReviewerId,0) > 0 then 'Done'
	when  (isnull(DataCollectionMode,0) = 0  and isnull(j.DataCollectorId,0) = 0) and isnull(j.AnalystId,0) = 0 and isnull(j.ReviewerId,0) = 0 then 'Not Started'
	when  (isnull(DataCollectionMode,0) = 0  and isnull(j.DataCollectorId,0) > 0) or isnull(j.AnalystId,0) > 0 or isnull(j.ReviewerId,0) > 0 then 'In Progress'
	end Assignment,
	(select isnull(js.JobServiceId,0) as JobServiceId,isnull(js.JobId,@JobId) JobId, isnull(js.ServiceId,l.LookupId)as ServiceId, isnull(l.LookupCode,l.LookupCode)as ServiceCode, Isnull(l.LookupName,l.LookupName) as ServiceName,isnull(js.Active,'N')as Active
	from JobServices js	
	right join (select lookupid,LookupCode,dbo.GetNameTranslated(lookupid,@LanguageId,'LookupValue')LookupName,ListOrder from lookups where Lname ='ReportType')  l on js.ServiceId = l.LookupId
	and  js.JobId = j.JobId 
	order by l.ListOrder
	FOR JSON AUTO 
	) JobServices
	from  Jobs j  	
	where j.ClientSiteId = @ClientSiteId 
	and (j.ScheduleSetupId = @ScheduleSetupId or @ScheduleSetupId = 0) and (J.StatusId =  @StatusId or @StatusId = 0) 
	and j.EstStartDate between @FromDate and isnull(@ToDate,getdate()+90) 
	and j.JobNumber = isnull(@JobNumber,j.JobNumber)
	order by j.EstStartDate desc, j.JobNumber desc  
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListJobSummaryReport]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppListJobSummaryReport]
	@ClientSiteId int, 
	@ReportFromDate Date,
	@ReportToDate Date,  
	@LanguageId int 
AS
BEGIN
	Declare @JobStatusId int
 	Set @JobStatusId = dbo.GetStatusId(1,'JobProcessStatus','C')
	;With JECTE
	as
	(
		Select j.JobId,j.ClientSiteId, j.JobName, j.JobNumber, j.EstStartDate 
 	    from  Jobs j   
		where j.ClientSiteId = @ClientSiteId and j.EstStartDate > @ReportFromDate  and j.StatusId = @JobStatusId
	)
	Select   je.JobId, je.ClientSiteId, je.JobName, je.JobNumber,
	 je.EstStartDate 
	from  JECTE je  
	order by EstStartDate desc , je.JobNumber desc
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListJobUnitAnalysis]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppListJobUnitAnalysis]
	 @UnitAnalysisId Bigint
	 ,@UnitType Varchar(3) 
	 ,@ServiceType varchar(3)
	,@LanguageId int 
AS
BEGIN
	Declare @SymtomName varchar(30),@FrequencyName varchar(30)

	select @FrequencyName =case when @ServiceType = 'OA' then 'JobFrequencyOA' else 'JobFrequency' End ,
	 @SymtomName = case when @ServiceType = 'OA' then 'JobSymptomTypeOA' when (@UnitType = 'DR' and @ServiceType = 'VA') then 'JobSymptomType' when (@UnitType = 'DN' and @ServiceType = 'VA') then 'JobSymptomType' when (@UnitType = 'IN' and @ServiceType = 'VA') then 'JobSymptomTypeShaft' End ;
 
 	DECLARE @SymptomsLookup TABLE (
	[SymptomTypeId] int,
	[FrequencyId] int,
	[SListOrder] int,
	[FListOrder] int 
	);
	
 
	Insert into @SymptomsLookup(FrequencyId,FListOrder,SymptomTypeId,SListOrder)
	select a.lookupid as 'FrequencyId',a.ListOrder ,b.lookupid  as 'SymptomTypeId',b.ListOrder 
	from lookups a cross join lookups b where a.lname = @FrequencyName and b.lname = @SymtomName

 	Select u.UnitAnalysisId,u.JobEquipmentId,u.ServiceId,u.UnitType,u.UnitId, u.ConditionId,u.ConfidentFactorId,u.FailureProbFactorId,u.PriorityId,u.IsWorkNotification,u.NoOfDays,u.Recommendation,u.Comment,u.StatusId,
	(select isnull(js.UnitSymptomsId ,0) as UnitSymptomsId,isnull(js.UnitAnalysisId ,0) as UnitAnalysisId,
	isnull(js.SymptomTypeId,sl.SymptomTypeId) as SymptomTypeId,  
	dbo.GetLookupTranslated(js.SymptomTypeId, @LanguageId,'LookupValue')as SymptomType,
	isnull(js.FrequencyId,sl.FrequencyId) as FrequencyId,   
	dbo.GetLookupTranslated(js.FrequencyId, @LanguageId,'LookupValue')as Frequency,
	js.FailureModeId as FailureModeId,js.IndicatedFaultId as IndicatedFaultId,  
	js.Symptoms as Symptoms,isnull(js.Active,'N') as Active
	from JobEquipUnitSymptoms js Right Join @SymptomsLookup sl on (sl.SymptomTypeId = js.SymptomTypeId and sl.FrequencyId = js.FrequencyId)   
	and js.UnitAnalysisId = u.UnitAnalysisId		
	order by sl.SListOrder,sl.FListOrder				  
	FOR JSON AUTO , INCLUDE_NULL_VALUES
	) JobUnitSymptomsListJson,
	(select isnull(ja.UnitAmplitudeId ,0) as UnitAmplitudeId, ja.UnitAnalysisId   as UnitAnalysisId,
	ja.OAVibration  as OAVibration,
	ja.OAGELevelPkPk  as OAGELevelPkPk, ja.OASensorDirection as OASensorDirection,
	ja.OASensorLocation  as OASensorLocation, ja.OAVibChangePercentage  as OAVibChangePercentage,
	isnull(ja.Active,'N') as Active
	from JobEquipUnitAmplitude ja where ja.UnitAnalysisId = u.UnitAnalysisId 
	FOR JSON AUTO  , INCLUDE_NULL_VALUES
	) JobUnitAmplitudeListJson
	from JobEquipUnitAnalysis u  where u.UnitAnalysisId = @UnitAnalysisId
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListJobUnitAnalysisAttachments]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppListJobUnitAnalysisAttachments]
	@UnitAnalysisId int,
	@Status varchar(5) 
AS
BEGIN
		select uaa.UnitAnalysisAttachId, uaa.UnitAnalysisId, uaa.FileName, uaa.LogicalName, uaa.PhysicalPath, uaa.Active from JobEquipUnitAnalysisAttachments uaa
		where (uaa.Active =  @Status or @Status = 'ALL') and uaa.UnitAnalysisId = @UnitAnalysisId
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListLeverageService]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppListLeverageService]  
	@JobEquipmentId Bigint, 
	@LanguageId Int 
AS
BEGIN
 
	select Isnull(ls.LeverageServiceId,0)as LeverageServiceId ,isnull(ls.JobEquipmentId,@JobEquipmentId)as JobEquipmentId,isnull(ls.OpportunityTypeId,ot.lookupId) as OpportunityTypeId,
	Isnull(dbo.GetLookupTranslated( isnull(ls.OpportunityTypeId,ot.lookupId) ,@LanguageId,'LookupValue'),'') as OpportunityType, 
	isnull(ls.Descriptions,'') as Descriptions,IsNull(ls.active,'N') Active  
	from LeverageService ls Right Join (Select lookupId,ListOrder from Lookups where LName = 'OpportunityType') ot on ot.LookupId = ls.OpportunityTypeid 
	and ls.JobEquipmentId = @JobEquipmentId
    order by ListOrder  
	    
End
GO
/****** Object:  StoredProcedure [dbo].[EAppListLeverageServiceFiles]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

create   PROCEDURE [dbo].[EAppListLeverageServiceFiles]  
	@FileFromDate date,
	@FileToDate date, 
	@LanguageId Int
AS
BEGIN 

	Select le.LeverageExportId, le.FileDate, le.[FileName], le.FilePath
	From LeverageExport  le 
	where FileDate between @FileFromDate and @FileToDate 
	 
End
GO
/****** Object:  StoredProcedure [dbo].[EAppListLeverageServiceGeneration]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppListLeverageServiceGeneration]  
	@LeverageFromDate date,
	@LeverageToDate date,
	@CountryId Int, 
	@LanguageId Int
AS
BEGIN 
	Declare @JobStatusId int
	 

	;With LSCTE
	AS
	(
	Select Isnull(ls.LeverageServiceId,0)as LeverageServiceId ,  ls.OpportunityTypeId, ls.JobEquipmentId,
	Isnull(dbo.GetLookupTranslated( ls.OpportunityTypeId,@LanguageId,'LookupValue'),'') as OpportunityType, 
	Isnull(ls.Descriptions,'') as Descriptions,IsNull(ls.active,'N') Active, ls.LeverageExportId,
	(Select [FileName] from LeverageExport le where le.LeverageExportId = ls.LeverageExportId) as 'FileName'
	from LeverageService ls 
	where ls.LeverageDate between @LeverageFromDate and isnull(@LeverageToDate,getdate()) 
	)
	Select  ls.LeverageServiceId ,j.ClientSiteId,Isnull(dbo.GetNameTranslated(j.ClientSiteId,@LanguageId,'ClientSiteName'),'') as ClientName, ep.PlantAreaId,Isnull(dbo.GetNameTranslated(ep.PlantAreaId,@LanguageId,'PlantAreaName'),'') as PlantArea, 
	ls.JobEquipmentId,ep.EquipmentName, j.JobNumber,j.JobName, ls.OpportunityTypeId,
	ls.OpportunityType, ls.Descriptions,ls.LeverageExportId, ls.[FileName], ls.Active
	--,Isnull(dbo.GetLookupTranslated( j.StatusId,@LanguageId,'LookupCode'),'') as JobStatusCode
	From LSCTE ls join JobEquipment e on e.JobEquipmentId = ls.JobEquipmentId and ls.LeverageExportId is null
	join Equipment ep on ep.EquipmentId = e.EquipmentId
	Join PlantArea p on p.PlantAreaId = ep.PlantAreaId
	join ClientSite c on c.ClientSiteId = p.ClientSiteId and (c.CountryId = @CountryId or @CountryId = 0)
	Join Jobs j on j.JobId = e.JobId --and j.StatusId  = @JobStatusId  
 	    
End
GO
/****** Object:  StoredProcedure [dbo].[EAppListLookups]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppListLookups]  
	@LanguageId Int,
	@Status varchar(5),
	@LName varchar(200)
AS
BEGIN

	select l.LookupId,l.LookupCode,l.LName,lt.LValue,lt.Descriptions, l.Active,lt.LanguageId,l.CreatedLanguageId, l.ListOrder  
	from Lookups l right join LookupTranslated lt on lt.LookupId = l.LookupId
	where (l.Active =  @Status or @Status = 'ALL') and (l.LName = @LName or isnull(@LName,'') = '') and( lt.LanguageId = @LanguageId or (  lt.LanguageId  = l.CreatedLanguageId 
	and not exists (select 'x' from LookupTranslated where LookupId = l.LookupId and languageid = @Languageid)))
    order by l.ListOrder asc

END
GO
/****** Object:  StoredProcedure [dbo].[EAppListLookupsByName]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppListLookupsByName] 
	@LanguageId Int,
	@Status varchar(5),
	@LName varchar(200)
AS
BEGIN
	select l.LookupId,l.LookupCode,l.LName,lt.LValue,lt.Descriptions, l.Active,lt.LanguageId,l.CreatedLanguageId, l.ListOrder  
	from Lookups l right join LookupTranslated lt on lt.LookupId = l.LookupId
	where (l.Active =  @Status or @Status = 'ALL') and (l.LName = @LName or isnull(@LName,'') = '') and( lt.LanguageId = @LanguageId or (  lt.LanguageId  = l.CreatedLanguageId 
	and not exists (select 'x' from LookupTranslated where LookupId = l.LookupId and languageid = @Languageid)))
	order by ListOrder asc

END
GO
/****** Object:  StoredProcedure [dbo].[EAppListLookupTranslated]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

CREATE   PROCEDURE [dbo].[EAppListLookupTranslated]  
	@LookupId Int
AS
BEGIN

	select @LookupId LookupId, ls.LName LookupName, ls.LookupCode,lt.LValue, lt.Descriptions,  l.LanguageId, l.CountryCode as LanguageCountryCode,l.LName LanguageName, ls.Active 
	from LookupTranslated lt right join Languages l on lt.LanguageId =l.LanguageId and lt.LookupId = @LookupId
	join lookups ls on ls.LookupId = @LookupId
 
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListManufacturer]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppListManufacturer]
	@LanguageId Int,
	@Status varchar(5) 
AS
BEGIN
 
	select m.ManufacturerId,m.ManufacturerCode,mt.ManufacturerName,mt.Descriptions,
	 m.Active,mt.LanguageId,m.BearingMFT,m.DriveMFT,m.IntermediateMFT,m.DrivenMFT,m.CreatedLanguageId  
	from Manufacturer m right join ManufacturerTranslated mt on mt.ManufacturerId = m.ManufacturerId
	where (m.Active =  @Status or @Status = 'ALL')  and( mt.LanguageId = @LanguageId or (  mt.LanguageId  = m.CreatedLanguageId 
	and not exists (select 'x' from ManufacturerTranslated where ManufacturerId = m.ManufacturerId and languageid = @Languageid)))
 
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListManufacturerTranslated]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppListManufacturerTranslated]  
	@ManufacturerId Int
AS
BEGIN

	select @ManufacturerId ManufacturerId, m.ManufacturerCode,m.ManufacturerId, mt.ManufacturerName,mt.Descriptions,l.LanguageId, l.CountryCode as LanguageCountryCode,l.LName LanguageName, m.Active
	from ManufacturerTranslated mt right join Languages l on mt.LanguageId =l.LanguageId and mt.ManufacturerId = @ManufacturerId
	join Manufacturer m on m.Manufacturerid = @Manufacturerid
 
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListOtherReportsAttachments]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppListOtherReportsAttachments]
	@ClientSiteId int,
	@Status varchar(5) 
AS
BEGIN
		select ora.[OtherReportsAttachId], ora.[ClientSiteId], ora.PlantAreaId, ora.ReportDate, ora.FileDescription, ora.FileName, ora.LogicalName, ora.PhysicalPath, ora.Active 
		from [OtherReportsAttachment] ora
		where (ora.Active =  @Status or @Status = 'ALL') and ora.ClientSiteId = @ClientSiteId
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListPlantArea]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppListPlantArea]
	@LanguageId Int,
	@ClientSiteId Int,
	@Status varchar(5)
AS
BEGIN
 
	select a.PlantAreaId,a.PlantAreaCode,a.ClientSiteId,att.PlantAreaName,att.Descriptions,
	 a.Active,att.LanguageId,a.CreatedLanguageId  
	from PlantArea a right join PlantAreaTranslated att on att.PlantAreaId = a.PlantAreaId and  att.LanguageId = @LanguageId  
	where a.ClientSiteId = @ClientSiteId and (a.Active =  @Status or @Status = 'ALL')  
	
 	
	/*select a.PlantAreaId,a.PlantAreaCode,a.ClientSiteId,att.PlantAreaName,att.Descriptions,
	 a.Active,att.LanguageId,a.CreatedLanguageId  
	from PlantArea a right join PlantAreaTranslated att on att.PlantAreaId = a.PlantAreaId
	where a.ClientSiteId = @ClientSiteId and (a.Active =  @Status or @Status = 'ALL')  and ( att.LanguageId = @LanguageId or (  att.LanguageId  = a.CreatedLanguageId 
	and not exists (select 'x' from PlantAreaTranslated where PlantAreaId = a.PlantAreaId and languageid = @Languageid)))
  */

END
GO
/****** Object:  StoredProcedure [dbo].[EAppListPlantAreaTranslated]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppListPlantAreaTranslated]  
	@PlantAreaId Int
AS
BEGIN

	select @PlantAreaId PlantAreaId, a.PlantAreaCode, a.ClientSiteId, att.PlantAreaName,att.Descriptions,  l.LanguageId, l.CountryCode as LanguageCountryCode,l.LName LanguageName, a.Active
	from PlantAreaTranslated att right join Languages l on att.LanguageId =l.LanguageId and att.PlantAreaId = @PlantAreaid
	join PlantArea a on a.PlantAreaId = @PlantAreaId
 
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListPrivileges]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
create   PROCEDURE [dbo].[EAppListPrivileges]   
	@Status varchar(5) 
AS
BEGIN
 
	select p.PrivilegeID,p.PrivilegeCode,p.PrivilegeName,p.Active 
	from Privileges p 
	where (p.Active =  @Status or @Status = 'ALL')  
 

END
GO
/****** Object:  StoredProcedure [dbo].[EAppListPrograms]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppListPrograms]  
	@LanguageId Int,
	@Status varchar(5) 
AS
BEGIN
 
	select p.ProgramId,p.Active,p.Internal,p.ProgramCode, pt.ProgramName,pt.Descriptions,pt.MenuName, p.ControllerName,p.MenuOrder,p.ActionName,p.LinkUrl,
	p.IconName,p.CssClassName,p.GroupCode,P.SubgroupCode,pt.LanguageId,p.CreatedLanguageId,
	p.MenuGroupid, dbo.GetNameTranslated(p.MenuGroupid,@LanguageId,'LookupValue') as MenuGroupName
	from Programs p right join ProgramTranslated pt on pt.ProgramId = p.ProgramId
	where (p.Active =  @Status or @Status = 'ALL')  and( pt.LanguageId = @LanguageId or (  pt.LanguageId  = p.CreatedLanguageId 
	and not exists (select 'x' from ProgramTranslated where ProgramId = pt.ProgramId and languageid = @Languageid)))
 

END
GO
/****** Object:  StoredProcedure [dbo].[EAppListProgramTranslated]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppListProgramTranslated]  
	@ProgramId Int
AS
BEGIN

	select @ProgramId ProgramId,p.programcode, pt.ProgramName,pt.MenuName,  pt.Descriptions,  l.LanguageId, 
	l.CountryCode as LanguageCountryCode,l.LName LanguageName, p.Active ,p.MenuGroupId, p.Internal
	from ProgramTranslated pt right join Languages l on pt.LanguageId =l.LanguageId and pt.ProgramId = @ProgramId
	join Programs p on p.programId = @ProgramId
 
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListRoleGroup]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 
CREATE   PROCEDURE [dbo].[EAppListRoleGroup]  
	@LanguageId Int,
	@Status varchar(5) 
AS
BEGIN

	select rg.RoleGroupId,rgt.RoleGroupName,rgt.Descriptions, rg.Active,rgt.LanguageId,rg.CreatedLanguageId  
	from RoleGroup rg right join RoleGroupTranslated rgt on rgt.RoleGroupId = rg.RoleGroupId
	where (rg.Active =  @Status or @Status = 'ALL')  and( rgt.LanguageId = @LanguageId or (  rgt.LanguageId  = rg.CreatedLanguageId 
	and not exists (select 'x' from RoleGroupTranslated where RoleGroupId = rg.RoleGroupId and languageid = @Languageid)))
 

END
GO
/****** Object:  StoredProcedure [dbo].[EAppListRoleGroupTranslated]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 
CREATE   PROCEDURE [dbo].[EAppListRoleGroupTranslated]  
	@RoleGroupId Int
AS
BEGIN

	select @RoleGroupId RoleGroupId, rgt.RoleGroupName,  rgt.Descriptions,  l.LanguageId, l.CountryCode as LanguageCountryCode,l.LName LanguageName, rg.Active 
	from RoleGroupTranslated rgt right join Languages l on rgt.LanguageId =l.LanguageId and rgt.RoleGroupId = @RoleGroupId
	join RoleGroup rg on rg.RoleGroupId = @RoleGroupId
 
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListRoles]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 
CREATE   PROCEDURE [dbo].[EAppListRoles]   
	@Status varchar(5) 
AS
BEGIN
 
	select r.RoleId,r.RoleName,r.Descriptions,r.Active,r.internal 
	from roles r 
	where (r.Active =  @Status or @Status = 'ALL')  
 

END
GO
/****** Object:  StoredProcedure [dbo].[EAppListScheduleEquipment]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EAppListScheduleEquipment]
	@ClientSiteId int,
	@ScheduleSetupId Bigint,
	@LanguageId int 
AS
BEGIN
	DROP TABLE IF EXISTS #TEquipment

	Create Table #TEquipment(PlantAreaId int, PlantAreaName nvarchar(250),EquipmentId int, EquipmentName nvarchar(250),ListOrder int);
	
	Insert into #TEquipment(PlantAreaId,PlantAreaName,EquipmentId,EquipmentName,ListOrder)
	select e.PlantAreaId,pt.PlantAreaName,
	e.EquipmentId, e.EquipmentName, e.ListOrder
	FROM dbo.Equipment AS e JOIN dbo.PlantArea AS P ON P.PlantAreaId = e.PlantAreaId and p.ClientSiteId = @ClientSiteId
	join PlantAreaTranslated pt on pt.PlantAreaId = p.PlantAreaId and pt.languageId = @LanguageId
 
	 Select s.ScheduleSetupId, s.ScheduleEquipmentId, e.PlantAreaId ,e.PlantAreaName,
	 e.EquipmentId, e.EquipmentName,isnull(s.Active,'N') as Active
	 from  #TEquipment e left join ScheduleEquipments s on s.EquipmentId = e.EquipmentId and s.ScheduleSetupId = @ScheduleSetupId
	 Order By PlantAreaId, e.ListOrder  

END
GO
/****** Object:  StoredProcedure [dbo].[EAppListScheduleSetup]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppListScheduleSetup]
	@ClientSiteId int,
	@ScheduleSetupId Bigint,
	@LanguageId int,  
	@StatusId int
AS
BEGIN
 
	Select s.ScheduleSetupId,s.ScheduleName,s.StartDate,s.EndDate,s.IntervalDays,s.StatusId,dbo.GetLookupTranslated(s.StatusId, @LanguageId, 'LookupCode') StatusCode, dbo.GetLookupTranslated(s.StatusId, @LanguageId, 'LookupValue') StatusName,s.EstJobDays,
	(select isnull(ss.ScheduleServiceId,0) as ScheduleServiceId,isnull(ss.ScheduleSetupId,@ScheduleSetupId) ScheduleSetupId, isnull(ss.ServiceId,l.LookupId)as ServiceId,Isnull(l.LookupName,l.LookupName) as ServiceName,isnull(ss.Active,'N')as Active
	from ScheduleServices ss	
	right join (select lookupid,dbo.GetLookupTranslated(lookupid,@LanguageId,'LookupValue')LookupName,ListOrder from lookups where Lname ='ReportType')  l on ss.ServiceId = l.LookupId
	and  ss.ScheduleSetupId = s.ScheduleSetupId 
	order by l.ListOrder
	FOR JSON AUTO 
	) ScheduleServices
	from ScheduleSetup s where s.ClientSiteId = @ClientSiteId and (s.StatusId =  @StatusId or @StatusId = 0 )
	and (s.ScheduleSetupId = @ScheduleSetupId or @ScheduleSetupId = 0)
	order by ScheduleSetupId desc
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListScheduleSetupEquipment]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppListScheduleSetupEquipment]
	@ClientSiteId int,
	@ScheduleSetupId Bigint,
	@LanguageId int 
AS
BEGIN
	DROP TABLE IF EXISTS #TEquipment

	Create Table #TEquipment(PlantAreaId int, AreaId Int, SystemId int,PlantAreaName nvarchar(250),AreaName nvarchar(250),systemName nvarchar(250),EquipmentId int, EquipmentName nvarchar(250),ListOrder int);
	
	Insert into #TEquipment(PlantAreaId,PlantAreaName,AreaId,AreaName,SystemId,SystemName,EquipmentId,EquipmentName,ListOrder)
	select e.PlantAreaId,pt.PlantAreaName, e.AreaId, dbo.GetNameTranslated(e.AreaId,@LanguageId,'AreaName')AreaName,
	e.SystemId, dbo.GetNameTranslated(e.SystemId,@LanguageId,'SystemName')SystemName,
	e.EquipmentId, e.EquipmentName, e.ListOrder
	FROM dbo.Equipment AS e JOIN dbo.PlantArea AS P ON P.PlantAreaId = e.PlantAreaId and p.ClientSiteId = @ClientSiteId
	join PlantAreaTranslated pt on pt.PlantAreaId = p.PlantAreaId and pt.languageId = case when isnull(@LanguageId,0) = 0 then p.CreatedLanguageId else @LanguageId end
 	 
	select (select isnull(se.ScheduleEquipmentId,'') as ScheduleEquipmentId,isnull(e.PlantAreaId,'') as PlantAreaId, 
	e.AreaId,e.AreaName,e.PlantAreaName, e.SystemId, e.SystemName,
	isnull(e.EquipmentId,'') as EquipmentId , isnull(e.EquipmentName,'') as EquipmentName,
	isnull(se.Active,'N') as Active
	from ScheduleEquipments se right join #TEquipment e on e.EquipmentId = se.EquipmentId  
	and  se.ScheduleSetupId = @ScheduleSetupId
	order by e.ListOrder
	FOR JSON AUTO, INCLUDE_NULL_VALUES
	) ScheduleEquipments 
 

END
GO
/****** Object:  StoredProcedure [dbo].[EAppListSector]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
create   PROCEDURE [dbo].[EAppListSector]  
	@LanguageId Int,
	@Status varchar(5) 
AS
BEGIN

	select s.SectorId,s.SectorCode,st.SectorName,st.Descriptions, s.Active,st.LanguageId,s.CreatedLanguageId  
	from Sector s right join SectorTranslated st on st.SectorId = s.SectorId
	where (s.Active =  @Status or @Status = 'ALL')  and( st.LanguageId = @LanguageId or (  st.LanguageId  = s.CreatedLanguageId 
	and not exists (select 'x' from SectorTranslated where SectorId = s.SectorId and languageid = @Languageid)))
 

END
GO
/****** Object:  StoredProcedure [dbo].[EAppListSectorTranslated]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppListSectorTranslated]  
	@SectorId Int
AS
BEGIN

	select @SectorId SectorId, st.SectorName, s.SectorCode, st.Descriptions,  l.LanguageId, l.CountryCode as LanguageCountryCode,l.LName LanguageName, s.Active 
	from SectorTranslated st right join Languages l on st.LanguageId =l.LanguageId and st.SectorId = @SectorId
	join Sector s on s.SectorId = @SectorId
 
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListSegment]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppListSegment]  
	@LanguageId Int,
	@SectorId Int,
	@Status varchar(5) 
AS
BEGIN
 
	select dbo.GetNameTranslated(s.SectorId,@LanguageId,'SectorName') as SectorName, s.SectorId,  s.SegmentId,s.SegmentCode,st.SegmentName,st.Descriptions, s.Active,st.LanguageId,s.CreatedLanguageId  
	from Segment s right join SegmentTranslated st on st.SegmentId = s.SegmentId 
	where (s.sectorid = @SectorId or @SectorId = 0) and  (s.Active =  @Status or @Status = 'ALL')  and( st.LanguageId = @LanguageId or (  st.LanguageId  = s.CreatedLanguageId 
	and not exists (select 'x' from SegmentTranslated where SegmentId = s.SegmentId and languageid = @Languageid)))
 

END
GO
/****** Object:  StoredProcedure [dbo].[EAppListSegmentTranslated]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppListSegmentTranslated]  
	@SegmentId Int
AS
BEGIN

	select @SegmentId SegmentId, s.SegmentCode, s.SectorId, st.SegmentName,st.Descriptions,  l.LanguageId, l.CountryCode as LanguageCountryCode,l.LName LanguageName, s.Active
	from SegmentTranslated st right join Languages l on st.LanguageId =l.LanguageId and st.SegmentId = @SegmentId
	join segment s on s.segmentid = @Segmentid
 
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListSystem]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppListSystem]  
	@ClientSiteId Int,
	@LanguageId int 
AS
BEGIN
 
	select s.PlantAreaId,dbo.GetNameTranslated(s.PlantAreaId,@LanguageId,'PlantAreaName') PlantAreaName, 
	dbo.GetNameTranslated(s.AreaId,@LanguageId,'AreaName') as AreaName, s.AreaId,  
	s.SystemId,dbo.GetNameTranslated(s.SystemId,@LanguageId,'SystemName') as  SystemName,
	dbo.GetNameTranslated(s.SystemId,@LanguageId,'SystemDescriptions') as  Descriptions, s.Active
	from [System] s join PlantArea p on p.PlantAreaId= s.PlantAreaId and p.ClientSiteId = @ClientSiteId

END
 
GO
/****** Object:  StoredProcedure [dbo].[EAppListSystemTranslated]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppListSystemTranslated]  
	@SystemId Int
AS
BEGIN

	select @SystemId SystemId, s.AreaId, st.SystemName,st.Descriptions,  l.LanguageId, l.CountryCode as LanguageCountryCode,l.LName LanguageName, s.Active
	from SystemTranslated st right join Languages l on st.LanguageId =l.LanguageId and st.SystemId = @SystemId
	join System s on s.Systemid = @Systemid
 
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListTaxonomy]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppListTaxonomy]
	@LanguageId Int,
	@SectorId Int,
	@SegmentId Int,
	@IndustryId int,
	@AssetCategoryId int,
	@AssetClassId int,
	@AssetTypeId int,
	@AssetSequenceId int, 
	@FailureModeId Int,
	@Status varchar(5) 
AS
BEGIN
	
	select t.TaxonomyId,t.TaxonomyCode,t.SectorId,t.SegmentId, t.IndustryId,t.AssetTypeId,isnull(t.FailureModeId,0) as FailureModeId,isnull(t.FailureCauseId,0) as FailureCauseId,t.AssetCategoryId,t.AssetSequenceId,t.AssetClassId,
	dbo.GetSectorNameTranslated(t.SectorId, @LanguageId,'Name') as SectorName, 
	dbo.GetSegmentNameTranslated(t.SegmentId, @LanguageId,'Name') as SegmentName, 
	dbo.GetNameTranslated(t.IndustryId, @LanguageId,'IndustryName') as IndustryName, 
	dbo.GetNameTranslated(t.AssetCategoryId, @LanguageId,'AssetCategoryCName') as AssetCategoryName, 
    dbo.GetNameTranslated(t.AssetClassId, @LanguageId,'AssetClassCName') as AssetClassName, 
	dbo.GetNameTranslated(t.AssetTypeId, @LanguageId,'AssetTypeCName') as AssetTypeName, 
	dbo.GetNameTranslated(t.AssetSequenceId, @LanguageId,'AssetSequenceCName') as AssetSequenceName, 
	dbo.GetNameTranslated(t.FailureModeId, @LanguageId,'FailureModeName') as FailureModeName, 
	dbo.GetNameTranslated(t.FailureCauseId, @LanguageId,'FailureCauseName') as FailureCauseName,  
	t.Active, t.MTTR,t.MTTROld, t.MTBF,t.MTBFOld, t.AssetClassTypeCode
	from Taxonomy t 
	where t.SectorId =  @SectorId
	and (t.SegmentId =  @SegmentId  or @SegmentId = 0)
	and (t.AssetTypeId =  @AssetTypeId or @AssetTypeId = 0) 
	and (t.FailureModeId =  @FailureModeId or @FailureModeId = 0) 
	and (t.IndustryId =  @IndustryId or @IndustryId = 0) 	
	and (t.AssetCategoryid =  @AssetCategoryid or @AssetCategoryid = 0) 
	and (t.AssetClassId =  @AssetClassId or @AssetClassId = 0) 
	and (t.AssetSequenceId =  @AssetSequenceId or @AssetSequenceId = 0)
   
END
  
GO
/****** Object:  StoredProcedure [dbo].[EAppListTechUpgrade]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppListTechUpgrade]  
	@LanguageId Int,
	@ClientSiteId int,
	@Status varchar(5) 
AS
BEGIN
 
 Select tu.TechUpgradeId,  dbo.GetNameTranslated(e.PlantAreaId,@LanguageId,'PlantAreaName') as PlantAreaName,tu.EquipmentId,''as EquipmentCode,dbo.GetNameTranslated(tu.EquipmentId,@LanguageId,'EquipmentName')as EquipmentName,tu.ReportDate,tu.RecommendationDate, tu.Recommendation, tu.Saving,  tu.FileName, tu.LogicalName, tu.PhysicalPath, tu.Active 
 from  TechUpgrade tu  join Equipment e on e.EquipmentId = tu.EquipmentId
 where (tu.Active =  @Status or @Status = 'ALL') and tu.ClientSiteId = @ClientSiteId	

	END
GO
/****** Object:  StoredProcedure [dbo].[EAppListUserDashboard]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppListUserDashboard]
	@LanguageId Int ,
	@UserId Int
AS
BEGIN
 

DROP TABLE IF EXISTS #ProgramAccess 

select distinct prp.ProgramId ,'Y' Internal
into #ProgramAccess
from UserRoleGroupRelation ur   join RoleGroupRoleRelation rgr on (rgr.RoleGroupId = ur.RoleGroupId  and ur.UserId = @Userid and ur.active = 'Y' and rgr.active = 'Y' )
join RolePrgPrivilegeRelation prp on (prp.roleid = rgr.RoleId   and prp.Active = 'Y' )
 
select u.UserDashboardId, ProgramId as WidgetId, ProgramCode WidgetCode, Isnull(dbo.GetNameTranslated(p.ProgramId,@LanguageId,'ProgramMenuName'),'')WidgetName,
u.UserId,u.XAxis sizeX,u.YAxis sizeY,u.WRow as [row],u.WColumn as col,u.DataViewPrefId, Isnull(dbo.GetNameTranslated(u.DataViewPrefId,@LanguageId,'LookupValue'),'') as DataViewPref,
	   Isnull(WidgetLogo,'')WidgetLogo,Height,Width,Isnull(u.Param1,'')Param1,Isnull(u.Param2,'')Param2,Isnull(u.Param3,'')Param3,Isnull(u.Param4,'')Param4,Isnull(u.Param5,'')Param5,
	   Isnull(u.Active,'N')Active
		from programs p join UserDashboard u on u.WidgetId = p.ProgramId and u.Userid = @Userid and u.Active = 'Y' and    p.ProgramId in (select pa.Programid from #ProgramAccess pa where not exists(select 'x' from programs ps where ps.programid = pa.programid and ps.internal = 'Y') )
		where p.ProgramType = 'WGT'
		order by p.MenuOrder 

END
GO
/****** Object:  StoredProcedure [dbo].[EAppListUsers]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppListUsers]
	@Languageid int,   
	@UserTypeId int,
	@UserStatusId int
AS
BEGIN
	
	Select u.UserId, u.UserName,u.FirstName,u.MiddleName,u.LastName,u.EmailId,u.Mobile,u.Phone,u.UserTypeId,u.UserStatusId,
	dbo.GetNameTranslated(u.UserTypeId,@LanguageId,'LookupValue') as UserTypeName, 
	dbo.GetNameTranslated(u.UserStatusId,@LanguageId,'LookupValue') as UserStatusName
	from Users u join Lookups lk on lk.LookupId = u.UserTypeId
	join Lookups lku on lku.LookupId = u.UserStatusId
	where (u.UserStatusId =  @UserStatusId or @UserStatusId = 0) and (u.UserTypeId=  @UserTypeId or @UserTypeId = 0)  
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListWidgets]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppListWidgets]  
	@Status varchar(5),
	@WidgetName nvarchar(150),
	@Category nvarchar(150)
AS
BEGIN

select WidgetId,WidgetName,WidgetCode,WidgetLogo,WidgetCategory,
WidgetSubCategory,Height,Width,Param1,Param2,
Param3,Param4,Param5,Active from Widgets where (Active =  @Status or @Status = 'ALL')

END
GO
/****** Object:  StoredProcedure [dbo].[EAppListWNEquipmentOpportunity]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppListWNEquipmentOpportunity] 
	 @WNJobEquipmentId Bigint 
	,@LanguageId int 
AS
BEGIN
 	select WNO.WNOpportunityId,WNO.WNEquipmentId,ActualOutageHours,ActualRepairCost,EquipmentId,
    WNO.FailureModeId,[dbo].[GetNameTranslated](WNO.FailureModeId,@LanguageId,'FailureModeName'),WNO.FailureCauseId,[dbo].[GetNameTranslated](WNO.FailureCauseId,@LanguageId,'FailureCauseName'),Active, dbo.GetNameTranslated(WNO.EquipmentId,1,'EquipmentName') AS EquipmentName
	from [dbo].[WorkNotificationOpportunity] WNO where WNO.WNEquipmentId = @WNJobEquipmentId
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListWorkNotification]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppListWorkNotification]
	@ClientSiteId int,
	@LanguageId int,  
	@FromDate date,
	@ToDate date
	AS
BEGIN
	
	Select J.JobNumber,WN.JobId,WN.WorkNotificationNumber,WN.WNEquipmentId,
	dbo.GetNameTranslated(e.PlantAreaId,1,'PlantAreaName') AS PlantAreaName, 
	WN.EquipmentName,dbo.GetConditionCodeTranslated(WN.ConditionId,@ClientSiteId,1,'ConditionName') AS ConditionName, 
	WN.ClientSiteId, WN.StatusId, dbo.GetLookupTranslated(WN.StatusId,@LanguageId,'LookupCode') StatusCode,
	isnull(dbo.GetLookupTranslated(WN.StatusId,@LanguageId,'LookupValue'),'') StatusName,
	WN.DataCollectionDate,WN.WNCompletionDate, 
	isnull(WN.Active,'N')as Active
	from [WorkNotificationEquipment] WN  JOIN Jobs J ON WN.JobId=J.JobId join Equipment e
	on e.EquipmentId = wn.EquipmentId 
	where WN.ClientSiteId = @ClientSiteId 
	order by WN.WorkNotificationNumber  
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListWorkNotificationAttachments]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppListWorkNotificationAttachments]
	@WNEquipmentId int,
	@Status varchar(5) 
AS
BEGIN
		SELECT WNA.WNAttachmentId, WNA.WNEquipmentId, WNA.FileName, WNA.LogicalName, WNA.PhysicalPath, WNA.Active FROM WorkNotificationAttachment WNA
		where (WNA.Active =  @Status or @Status = 'ALL') and WNA.WNEquipmentId = @WNEquipmentId
END
GO
/****** Object:  StoredProcedure [dbo].[EAppListWorkNotificationUnit]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppListWorkNotificationUnit]
	@ClientSiteId int,
	@WNEquipmentId bigint,
	@LanguageId int 
	AS
BEGIN 
	Select wn.WNEquipmentId,wn.EquipmentName, Concat(wn.worknotificationNumber,'-',wu.WNUnitAnalysisId) WorkNotificationNumber, wu.WNUnitAnalysisId, wu.UnitType, wu.AssetName, wu.MeanRepairManHours, wu.DownTimeCostPerHour, wu.CostToRepair,
	wu.ActualOutageHours, wu.ActualRepairCost, 
	wu.StatusId, dbo.GetLookupTranslated(wu.StatusId,@LanguageId,'LookupCode') StatusCode,
	dbo.GetLookupTranslated(wu.StatusId,@LanguageId,'LookupValue') StatusName,
	dbo.GetConditionCodeTranslated(wu.ConditionId,@ClientSiteId,@LanguageId,'ConditionName') AS ConditionName,
	dbo.GetLookupTranslated(wu.ConfidentFactorId,@LanguageId,'LookupValue') ConfidentFactor,
	dbo.GetLookupTranslated(wu.FailureProbFactorId,@LanguageId,'LookupValue') FailureProbFactor,
	dbo.GetLookupTranslated(wu.PriorityId,@LanguageId,'LookupValue') Priority,
	wu.IndicatedFault, wu.Recommendation, wu.Comment
    from  WorkNotificationEquipment wn join WorkNotificationUnits wu  on wn.WNEquipmentId = wu.WNEquipmentId
	where wn.WNEquipmentId = @WNEquipmentId 
	order by wu.WNUnitAnalysisId
END
GO
/****** Object:  StoredProcedure [dbo].[EAppLoadJobEquipStatusListItem]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

create   PROCEDURE [dbo].[EAppLoadJobEquipStatusListItem] 
	@UserId Int,
	@JobEquipmentId Int,
	@LanguageId Int 
AS
BEGIN 
 
 Declare @CurrentStatusId int

 Select @CurrentStatusId = StatusId from JobEquipment where JobEquipmentId = @JobEquipmentId


select wd.AvailableStatusId as StatusId,Isnull(dbo.GetNameTranslated(wd.AvailableStatusId,@LanguageId,'LookupCode'),'') as StatusCode, Isnull(dbo.GetNameTranslated(wd.AvailableStatusId,@LanguageId,'LookupValue'),'') as StatusName 
from RoleGroupRoleRelation rgr join UserRoleGroupRelation ur  on (rgr.RoleGroupId = ur.RoleGroupId  and ur.UserId = @UserId and ur.active = 'Y' and rgr.active = 'Y' )
join RoleWorkFlowRelation rwr on (rwr.roleid = rgr.RoleId   and rwr.Active = 'Y' )
join WorkFlowDetail wd on wd.WorkFlowId = rwr.WorkFlowId and wd.CurrentStatusId = @CurrentStatusId
Group by wd.AvailableStatusId

END
GO
/****** Object:  StoredProcedure [dbo].[EAppLoadJobStatusListItem]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppLoadJobStatusListItem]  
	@Type varchar(50),
	@UserId Int,
	@CurrentStatusId Int,
	@LanguageId Int 
AS
BEGIN 
 
select wd.AvailableStatusId as StatusId,Isnull(dbo.GetNameTranslated(wd.AvailableStatusId,@LanguageId,'LookupCode'),'') as StatusCode, Isnull(dbo.GetNameTranslated(wd.AvailableStatusId,@LanguageId,'LookupValue'),'') as StatusName 
from RoleGroupRoleRelation rgr join UserRoleGroupRelation ur  on (rgr.RoleGroupId = ur.RoleGroupId  and ur.UserId = @UserId and ur.active = 'Y' and rgr.active = 'Y' )
join RoleWorkFlowRelation rwr on (rwr.roleid = rgr.RoleId   and rwr.Active = 'Y' )
join WorkFlowDetail wd on wd.WorkFlowId = rwr.WorkFlowId and wd.CurrentStatusId = @CurrentStatusId
Group by wd.AvailableStatusId

END
GO
/****** Object:  StoredProcedure [dbo].[EAppLoadListItem]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EAppLoadListItem]  
	@Type Varchar(100),
	@LanguageId Int,
	@SourceId int,
	@SourceId1 int
AS
BEGIN 
	If @Type = 'Segment'
	Begin
		SELECT  s.SegmentId,s.SegmentCode,Isnull(dbo.GetNameTranslated(s.SegmentId,@LanguageId,'SegmentName'),'') as SegmentName  
	    FROM Segment s  where s.SectorId = @SourceId and s.Active = 'Y'
		order by SegmentName
    End
	If @Type = 'PlantArea'
	Begin
		SELECT  p.PlantAreaId,p.PlantAreaCode,Isnull(dbo.GetNameTranslated(p.PlantAreaId,@LanguageId,'PlantAreaName'),'') as PlantName  
	    FROM PlantArea p  where p.ClientSiteId = @SourceId and P.Active = 'Y'
		order by PlantName
    End
	If @Type = 'Industry'
	Begin
		SELECT  i.IndustryId,i.IndustryCode,Isnull(dbo.GetNameTranslated(i.IndustryId,@LanguageId,'IndustryName'),'') as IndustryName  
	    FROM Industry i  where i.SegmentId = @SourceId and i.Active = 'Y'
		order by IndustryName
    End
	else If @Type = 'AssetClassAssetType'
	Begin
		SELECT  a.AssetTypeId, Isnull(dbo.GetNameTranslated(a.AssetTypeId,@LanguageId,'AssetTypeCode'),'') as AssetTypeCode, Isnull(dbo.GetNameTranslated(a.AssetTypeId,@LanguageId,'AssetTypeName'),'') as AssetTypeName  
	    FROM AssetTypeClassRelation a  where a.AssetClassId = @SourceId and a.Active = 'Y'
		Group by a.AssetTypeId
    End
	else If @Type = 'IndustryCategoryAssetClass'
	Begin
		SELECT  a.AssetClassId,Isnull(dbo.GetNameTranslated(a.AssetClassId,@LanguageId,'AssetClassCode'),'') as AssetClassCode,Isnull(dbo.GetNameTranslated(a.AssetClassId,@LanguageId,'AssetClassName'),'') as AssetClassName  
	    FROM AssetClassIndustryRelation a  where a.IndustryId = @SourceId and a.Active = 'Y'
		and exists (select 'x' from AssetCategoryClassRelation b where b.AssetClassId = a.AssetClassId and b.AssetCategoryid = @SourceId1 and b.Active = 'Y')
		Group by a.AssetClassId
    End
	else if @Type = 'AssetTypeAssetSequence'
	Begin
		SELECT  a.AssetSequenceId,Isnull(dbo.GetNameTranslated(a.AssetSequenceId,@LanguageId,'AssetSequenceCode'),'') as AssetSequenceCode,Isnull(dbo.GetNameTranslated(a.AssetSequenceId,@LanguageId,'AssetSequenceName'),'') as AssetSequenceName  
	    FROM AssetSequence a  where a.AssetTypeId = @SourceId and a.Active = 'Y' 
		Group by a.AssetSequenceId
    End
	else If @Type = 'FailureMode'
	Begin
		select FailureModeId, Isnull(dbo.GetNameTranslated(a.FailureModeId,@LanguageId,'FailureModeCode'),'') as FailureModeCode, Isnull(dbo.GetNameTranslated(a.FailureModeId,@LanguageId,'FailureModeName'),'') as FailureModeName
		from FailureModeAssetClassRelation a where a.AssetClassId = @SourceId and Active = 'Y' ORDER BY FailureModeName ASC
    End
	else If @Type = 'FailureModeByAsset' -- Used in Report and other Stuffs where taxonomy deals.
	Begin
		Declare @AssetClassId int
		select @AssetClassId = AssetClassId  from Taxonomy where TaxonomyId  = @SourceId 
		select FailureModeId,  Isnull(dbo.GetNameTranslated(a.FailureModeId,@LanguageId,'FailureModeCode'),'') as FailureModeCode, Isnull(dbo.GetNameTranslated(a.FailureModeId,@LanguageId,'FailureModeName'),'') as FailureModeName
		from FailureModeAssetClassRelation a where a.AssetClassId = @AssetClassId and Active = 'Y' ORDER BY FailureModeName ASC
    End
	else If @Type = 'FailureCause'
	Begin
     	select f.FailureCauseId,Isnull(dbo.GetNameTranslated(f.FailureCauseId,@LanguageId,'FailureCauseCode'),'') as FailureCauseCode , Isnull(dbo.GetNameTranslated(f.FailureCauseId,@LanguageId,'FailureCauseName'),'') as FailureCauseName 
		from FailureCauseModeRelation f where f.FailureModeId = @SourceId and Active = 'Y' ORDER BY FailureCauseName ASC
    End
		
	If @Type = 'Area'
	Begin
		SELECT  i.AreaId,Isnull(dbo.GetNameTranslated(i.AreaId,@LanguageId,'AreaName'),'') as AreaName  
	    FROM Area i  where i.PlantAreaId = @SourceId and i.Active = 'Y'
		order by AreaId
    End
	else If @Type = 'System'
	Begin
		SELECT  s.SystemId,Isnull(dbo.GetNameTranslated(s.SystemId,@LanguageId,'SystemName'),'') as SystemName  
	    FROM [System] s  where s.AreaId = @SourceId and s.Active = 'Y'
		order by SystemId
    End
	else If @Type = 'UserCountryAccess'
	Begin
		SELECT  c.CountryId,Isnull(dbo.GetNameTranslated(c.CountryId,@LanguageId,'CountryName'),'') as CountryName  
	    FROM UserCountryRelation c  where c.UserId = @SourceId and c.Active = 'Y'
		order by CountryId
    End
	 else If @Type = 'BearingMFT'
	Begin
		SELECT  m.ManufacturerId,Isnull(dbo.GetNameTranslated(m.ManufacturerId,@LanguageId,'ManufacturerName'),'') as ManufacturerName 
	    FROM Manufacturer m  where m.Active = 'Y' and m.BearingMFT = 'Y'
		order by ManufacturerName
    End
	 else If @Type = 'DriveMFT'
	Begin
		SELECT  m.ManufacturerId,Isnull(dbo.GetNameTranslated(m.ManufacturerId,@LanguageId,'ManufacturerName'),'') as ManufacturerName 
	    FROM Manufacturer m  where m.Active = 'Y' and m.DriveMFT = 'Y'
		order by ManufacturerName
    End
	 else If @Type = 'IntermediateMFT'
	Begin
		SELECT  m.ManufacturerId,Isnull(dbo.GetNameTranslated(m.ManufacturerId,@LanguageId,'ManufacturerName'),'') as ManufacturerName 
	    FROM Manufacturer m  where m.Active = 'Y' and m.IntermediateMFT = 'Y'
		order by ManufacturerName
    End
	 else If @Type = 'DrivenMFT'
	Begin
		SELECT  m.ManufacturerId,Isnull(dbo.GetNameTranslated(m.ManufacturerId,@LanguageId,'ManufacturerName'),'') as ManufacturerName 
	    FROM Manufacturer m  where m.Active = 'Y' and m.DrivenMFT = 'Y'
		order by ManufacturerName
    End
END
GO
/****** Object:  StoredProcedure [dbo].[EAppLoadWNListItem]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppLoadWNListItem]  
	@Type Varchar(100),
	@LanguageId Int,
	@SourceId int,
	@ClientSiteId int
AS
BEGIN 
	If @Type = 'Equipment'
	Begin
		SELECT  DISTINCT  E.EquipmentName,E.EquipmentId FROM Equipment E join PlantArea p on p.PlantAreaId= E.PlantAreaId and p.ClientSiteId =@ClientSiteId 
	End
	else If @Type = 'FailureMode'
	Begin
		select distinct  FailureModeId, Isnull(dbo.GetNameTranslated(a.FailureModeId,@LanguageId,'FailureModeCode'),'') as FailureModeCode, Isnull(dbo.GetNameTranslated(a.FailureModeId,@LanguageId,'FailureModeName'),'') as FailureModeName
		from FailureModeAssetClassRelation a WHERE Active = 'Y'
    End
	else If @Type = 'FailureCause'
	Begin
     	select distinct  f.FailureCauseId,Isnull(dbo.GetNameTranslated(f.FailureCauseId,@LanguageId,'FailureCauseCode'),'') as FailureCauseCode , Isnull(dbo.GetNameTranslated(f.FailureCauseId,@LanguageId,'FailureCauseName'),'') as FailureCauseName 
		from FailureCauseModeRelation f where f.FailureModeId = @SourceId and Active = 'Y'
    End			
END
GO
/****** Object:  StoredProcedure [dbo].[EAppMasterAutoComplete]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppMasterAutoComplete]  
	@LanguageId Int,
	@SearchCriteria nvarchar(150),
	@AutoCompleteName nvarchar(150)
AS
BEGIN

if @AutoCompleteName = 'Country'

Begin
set @SearchCriteria = concat(N'','%',@SearchCriteria,'%')
print @SearchCriteria;
	select c.CountryId,c.CountryCode,ct.CountryName 
	from country c right join CountryTranslated ct on ct.CountryId = c.CountryId
	where  ( ct.LanguageId = @LanguageId or (  ct.LanguageId  = c.CreatedLanguageId 
	and not exists (select 'x' from CountryTranslated where countryid = c.countryid and languageid = @LanguageId)))
	and ct.CountryName like (@SearchCriteria)
end

END
GO
/****** Object:  StoredProcedure [dbo].[EAppMasterImport]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 
CREATE   PROCEDURE [dbo].[EAppMasterImport]   
	@Json nvarchar(max)
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
	DECLARE @TempValidationStatus varchar(1), @ErrorTextTemp varchar(1000), @ErrorText varchar(1000),@LanguageId int, @LoaderId Int, @UserId int, @SectorId Int,@SegmentId Int,@IndustryId Int,@AssetTypeId Int,@FailureModeId Int,@FailureCauseId	Int
	Declare @PType Varchar(50),@PAction Varchar(50), @SectorCode varchar(50),@SegmentCode varchar(50),@IndustryCode varchar(50),@AssetTypeCode varchar(50),@FailureModeCode varchar(50),@FailureCauseCode varchar(50)
	Declare @SectorName Varchar(150), @SectorDescriptions varchar(250),@SegmentName Varchar(150), @SegmentDescriptions varchar(250),
	@IndustryName Varchar(150), @IndustryDescriptions varchar(250), @AssetTypeName Varchar(150), @AssetTypeDescriptions varchar(250),
	@FailureModeName Varchar(150), @FailureModeDescriptions varchar(250),@FailureCauseName Varchar(150), @FailureCauseDescriptions varchar(250),
	@MTTROld decimal(10,2) , @MTBFOld decimal(10,2), @TaxonomyId int,@MTTR  decimal(10,2) , @MTBF decimal(10,2),
	@AssetCategoryId Int,@AssetCategoryCode varchar(50),@AssetCategoryName Varchar(150),@AssetCategoryDescriptions varchar(250),
	@AssetClassId Int,@AssetClassCode varchar(50),@AssetClassName Varchar(150),@AssetClassDescriptions varchar(250),
	@AssetSequenceId Int,@AssetSequenceCode varchar(50),@AssetSequenceName Varchar(150),@AssetSequenceDescriptions varchar(250),
	@AssetTypeClassCode Varchar(50),@TaxonomyType varchar(1), @SectorIdNew int
	DROP TABLE IF EXISTS #LoadJson

	CREATE TABLE #LoadJson
	(
	  LoaderId int not null identity(1,1),
	  UserId int,
	  LanguageId int,
	  PType Varchar(50),
	  PAction Varchar(100),
	  ReferenceNo int,
	  SectorId int,
      SectorCode varchar(50),
      SectorName varchar(150),
	  SectorDescriptions varchar(250),
	  SegmentId Int,
      SegmentCode varchar(50),
	  SegmentName varchar(150),
	  SegmentDescriptions varchar(250),
	  IndustryId int,
      IndustryCode varchar(50),
      IndustryName varchar(150),
	  IndustryDescriptions varchar(250),
	  AssetTypeId int,
      AssetTypeCode varchar(50),
      AssetTypeName varchar(150),
	  AssetTypeDescriptions varchar(250),
	  AssetCategoryId int,
      AssetCategoryCode varchar(50),
      AssetCategoryName varchar(150),
	  AssetCategoryDescriptions varchar(250),
	  AssetClassId int,
      AssetClassCode varchar(50),
      AssetClassName varchar(150),
	  AssetClassDescriptions varchar(250),
	  AssetSequenceId int,
      AssetSequenceCode varchar(50),
      AssetSequenceName varchar(150),
	  AssetSequenceDescriptions varchar(250),
	  FailureModeId int,
      FailureModeCode varchar(50),
      FailureModeName varchar(150),
	  FailureModeDescriptions varchar(250),
	  FailureCauseId int,
      FailureCauseCode varchar(50),
      FailureCauseName varchar(150),
	  FailureCauseDescriptions varchar(250),
	  MTTROld decimal(10,2),
	  MTBFOld decimal(10,2),
	  MTTR decimal(10,2),
	  MTBF decimal(10,2),
	  ValidationResult varchar(1000),
	  ValidationStatus Varchar(1)
	) 

Insert into #LoadJson (UserId,PType,PAction,LanguageId,ReferenceNo,SectorCode, SectorName,SectorDescriptions, SegmentCode, SegmentName,SegmentDescriptions, IndustryCode, 
IndustryName,IndustryDescriptions, AssetTypeCode, AssetTypeName,AssetTypeDescriptions, AssetCategoryCode, AssetCategoryName, AssetCategoryDescriptions, 
AssetClassCode, AssetClassName, AssetClassDescriptions, AssetSequenceCode, AssetSequenceName, AssetSequenceDescriptions,
 FailureModeCode, FailureModeName,FailureModeDescriptions, FailureCauseCode, 
FailureCauseName,FailureCauseDescriptions,MTTROld,MTBFOld,MTTR,MTBF)
SELECT
    JSON_Value (c.value, '$.UserId') as UserId, 
    JSON_Value (c.value, '$.PType') as PType, 
	JSON_Value (c.value, '$.PAction') as PAction, 
	JSON_Value (c.value, '$.LanguageId') as LanguageId, 
	JSON_Value (p.value, '$.ReferenceNo') as ReferenceNo, 
    JSON_Value (p.value, '$.SectorCode') as SectorCode, 
    JSON_Value (p.value, '$.SectorName') as SectorName,
	JSON_Value (p.value, '$.SectorDescriptions') as SectorDescriptions,
    JSON_Value (p.value, '$.SegmentCode') as SegmentCode,
    JSON_Value (p.value, '$.SegmentName') as SegmentName,
	JSON_Value (p.value, '$.SegmentDescriptions') as SegmentDescriptions,
    JSON_Value (p.value, '$.IndustryCode') as IndustryCode,
    JSON_Value (p.value, '$.IndustryName') as IndustryName,
	JSON_Value (p.value, '$.IndustryDescriptions') as IndustryDescriptions,
    JSON_Value (p.value, '$.AssetTypeCode') as AssetTypeCode,
    JSON_Value (p.value, '$.AssetTypeName') as AssetTypeName,
	JSON_Value (p.value, '$.AssetTypeDescriptions') as AssetTypeDescriptions,
	JSON_Value (p.value, '$.AssetCategoryCode') as AssetCategoryCode,
    JSON_Value (p.value, '$.AssetCategoryName') as AssetCategoryName,
	JSON_Value (p.value, '$.AssetCategoryDescriptions') as AssetCategoryDescriptions,
	JSON_Value (p.value, '$.AssetClassCode') as AssetClassCode,
    JSON_Value (p.value, '$.AssetClassName') as AssetClassName,
	JSON_Value (p.value, '$.AssetClassDescriptions') as AssetClassDescriptions,
	JSON_Value (p.value, '$.AssetSequenceCode') as AssetSequenceCode,
    JSON_Value (p.value, '$.AssetSequenceName') as AssetSequenceName,
	JSON_Value (p.value, '$.AssetSequenceDescriptions') as AssetSequenceDescriptions,
    JSON_Value (p.value, '$.FailureModeCode') as FailureModeCode,
    JSON_Value (p.value, '$.FailureModeName') as FailureModeName,
	JSON_Value (p.value, '$.FailureModeDescriptions') as FailureModeDescriptions,
    JSON_Value (p.value, '$.FailureCauseCode') as FailureCauseCode,
    JSON_Value (p.value, '$.FailureCauseName') as FailureCauseName,
	JSON_Value (p.value, '$.FailureCauseDescriptions') as FailureCauseDescriptions,
	JSON_Value (p.value, '$.MTTROld') as MTTROld,
	JSON_Value (p.value, '$.MTBFOld') as MTBFOld,
	JSON_Value (p.value, '$.MTTR') as MTTR,
	JSON_Value (p.value, '$.MTBF') as MTBF	 
FROM OPENJSON (@json, '$.Header') as c
CROSS APPLY OPENJSON (c.value, '$.Detail') as p
 
  
DECLARE GetIdCur CURSOR READ_ONLY
    FOR
    SELECT LoaderId,UserId,LanguageId,PType,PAction, SectorCode ,SectorName,SectorDescriptions,SegmentCode,SegmentName,SegmentDescriptions,IndustryCode,IndustryName,IndustryDescriptions
	,AssetTypeCode,AssetTypeName,AssetTypeDescriptions, AssetCategoryCode, AssetCategoryName, AssetCategoryDescriptions, AssetClassCode, AssetClassName, AssetClassDescriptions, AssetSequenceCode, AssetSequenceName, AssetSequenceDescriptions, 
	FailureModeCode,FailureModeName,FailureModeDescriptions,FailureCauseCode,FailureCauseName,FailureCauseDescriptions,
	MTTROld,MTBFOld,MTTR,MTBF
	from #LoadJson  

    OPEN GetIdCur
    FETCH NEXT FROM GetIdCur INTO
    @LoaderId,@UserId,@LanguageId,@PType,@PAction,@SectorCode, @SectorName,@SectorDescriptions,@SegmentCode, @SegmentName,@SegmentDescriptions,
	@IndustryCode, @IndustryName,@IndustryDescriptions,@AssetTypeCode, @AssetTypeName,@AssetTypeDescriptions,@AssetCategoryCode, @AssetCategoryName,
	@AssetCategoryDescriptions, @AssetClassCode, @AssetClassName, @AssetClassDescriptions, @AssetSequenceCode, @AssetSequenceName, @AssetSequenceDescriptions,
	@FailureModeCode, @FailureModeName,@FailureModeDescriptions,
	@FailureCauseCode, @FailureCauseName,@FailureCauseDescriptions,@MTTROld,@MTBFOld,@MTTR,@MTBF
    WHILE @@FETCH_STATUS = 0
    BEGIN
	if isnull(@PType,'') = 'Sector'
	Begin  
	if isnull(@SectorCode,'') <> ''
	begin 
		Select @SectorId = SectorId from Sector where SectorCode = @SectorCode;
		if isnull(@SectorId,0) = 0
		Begin --OK
	 
			exec dbo.[EAppSaveSector] 0,@LanguageId,@SectorCode,@SectorName ,@SectorDescriptions,'Y',@UserId 
			set @TempValidationStatus = 'L' 
			set @ErrorTextTemp = Concat(@ErrorTextTemp,char(10), 'Sector Created')  
	 
 		End---Ok  
		else if isnull(@SectorId,0) > 0
			begin
 				set @TempValidationStatus = 'E' 
				set @ErrorTextTemp =  'Sector Code already exists' 
			end
 	End	
	else if isnull(@SectorCode,'') = ''
	begin
		set @TempValidationStatus = 'E' 
		set @ErrorTextTemp =  'Invalid Sector Code' 
	end
End
	if isnull(@PType,'') = 'Segment'
	Begin  
	if isnull(@SectorCode,'') <> ''
	begin 
		Select @SectorId = SectorId from Sector where SectorCode = @SectorCode;
		if isnull(@SectorId,0) = 0
		Begin --OK
 			set @TempValidationStatus = 'E' 
			set @ErrorTextTemp =  'Sector does not exist' 	 
 	 
 		End---Ok  
		else if isnull(@SectorId,0) > 0
		begin
			if isnull(@SegmentCode,'') = ''
			begin
				set @TempValidationStatus = 'E' 
				set @ErrorTextTemp =  'Invalid Segment Code' 
			end
			Else if isnull(@SegmentCode,'') <> ''
			Begin
				Select @SegmentId = SegmentId from Segment where SectorId = @Sectorid and SegmentCode = @SegmentCode;
				if isnull(@SegmentId,0) = 0
				Begin --OK
					exec dbo.[EAppSaveSegment]0,@SectorId,@LanguageId,@SegmentCode,@SegmentName ,@SegmentDescriptions,'Y',@UserId 
					set @TempValidationStatus = 'L' 
					set @ErrorTextTemp =  'Segment Created' 
				End
				if isnull(@SegmentId,0)>0
				Begin
					set @TempValidationStatus = 'E' 
					set @ErrorTextTemp =  'Segment Already Exists' 
				End
			End
		end
 	End	
	else if isnull(@SectorCode,'') = ''
	begin
		set @TempValidationStatus = 'E' 
		set @ErrorTextTemp =  'Invalid Sector Code' 
	end
End
	if isnull(@PType,'') = 'AssetCategory'
	Begin  
	if isnull(@AssetCategoryCode,'') <> ''
	begin 
		Select @AssetCategoryId = AssetCategoryId from AssetCategory where AssetCategoryCode = @AssetCategoryCode;
		if isnull(@AssetCategoryId,0) = 0
		Begin --OK
	 
			exec dbo.[EAppSaveAssetCategory] 0,@LanguageId,@AssetCategoryCode,@AssetCategoryName ,@AssetCategoryDescriptions,'Y',@UserId 
			set @TempValidationStatus = 'L' 
			set @ErrorTextTemp = Concat(@ErrorTextTemp,char(10), 'Asset Category Created')  
	 
 		End---Ok  
		else if isnull(@AssetCategoryId,0) > 0
			begin
 				set @TempValidationStatus = 'E' 
				set @ErrorTextTemp =  'AssetCategory already exists' 
			end
 	End	
	else if isnull(@AssetCategoryCode,'') = ''
	begin
		set @TempValidationStatus = 'E' 
		set @ErrorTextTemp =  'Invalid AssetCategory Code' 
	end
End
	if isnull(@PType,'') = 'AssetClass'
	Begin  
	if isnull(@AssetClassCode,'') <> ''
	begin 
		Select @AssetClassId = AssetClassId from AssetClass where AssetClassCode = @AssetClassCode;
		if isnull(@AssetClassId,0) = 0
		Begin --OK
	 
			exec dbo.[EAppSaveAssetClass] 0,@LanguageId,@AssetClassCode,@AssetClassName ,@AssetClassDescriptions,'Y',@UserId 
			set @TempValidationStatus = 'L' 
			set @ErrorTextTemp = Concat(@ErrorTextTemp,char(10), 'Asset Class Created')  
	 
 		End---Ok  
		else if isnull(@AssetClassId,0) > 0
			begin
 				set @TempValidationStatus = 'E' 
				set @ErrorTextTemp =  'Asset Class Code already exists' 
			end
 	End	
	else if isnull(@AssetClassCode,'') = ''
	begin
		set @TempValidationStatus = 'E' 
		set @ErrorTextTemp =  'Invalid Asset Class Code' 
	end
End
	if isnull(@PType,'') = 'AssetType'
	Begin  
	if isnull(@AssetTypeCode,'') <> ''
	begin 
		Select @AssetTypeId = AssetTypeId from AssetType where AssetTypeCode = @AssetTypeCode;
		if isnull(@AssetTypeId,0) = 0
		Begin --OK
	 
			exec dbo.[EAppSaveAssetType] 0,@LanguageId,@AssetTypeCode,@AssetTypeName ,@AssetTypeDescriptions,'Y',@UserId 
			set @TempValidationStatus = 'L' 
			set @ErrorTextTemp = Concat(@ErrorTextTemp,char(10), 'Asset Type Created')  
	 
 		End---Ok  
		else if isnull(@AssetTypeId,0) > 0
			begin
 				set @TempValidationStatus = 'E' 
				set @ErrorTextTemp =  'Asset Class Type already exists' 
			end
 	End	
	else if isnull(@AssetTypeCode,'') = ''
	begin
		set @TempValidationStatus = 'E' 
		set @ErrorTextTemp =  'Invalid Asset Type Code' 
	end
End
	if isnull(@PType,'') = 'AssetSequence'
	Begin  
	if isnull(@AssetTypeCode,'') <> ''
	begin 
		Select @AssetTypeId = AssetTypeId from AssetType where AssetTypeCode = @AssetTypeCode;
		if isnull(@AssetTypeId,0) = 0
		Begin --OK
 			set @TempValidationStatus = 'E' 
			set @ErrorTextTemp =  'AssetType does not exist' 	 
 	 
 		End---Ok  
		else if isnull(@AssetTypeId,0) > 0
		begin
			if isnull(@AssetSequenceCode,'') = ''
			begin
				set @TempValidationStatus = 'E' 
				set @ErrorTextTemp =  'Invalid Asset Sequence Code' 
			end
			Else if isnull(@AssetSequenceCode,'') <> ''
			Begin
				Select @AssetSequenceId = AssetSequenceId  from AssetSequence  where AssetTypeId = @AssetTypeId and @AssetSequenceCode = @AssetSequenceCode;
				if isnull(@AssetSequenceId,0) = 0
				Begin --OK
					exec dbo.[EAppSaveAssetSequence]0,@LanguageId,@AssetTypeId,@AssetSequenceCode,@AssetSequenceName ,@AssetSequenceDescriptions,'Y',@UserId 
					set @TempValidationStatus = 'L' 
					set @ErrorTextTemp = Concat(@ErrorTextTemp,char(10), 'AssetSequence Created')  
				End
				Else if isnull(@AssetSequenceId,0) > 0
				Begin --OK
					set @TempValidationStatus = 'E' 
					set @ErrorTextTemp =  'Asset Sequence Already Exists' 
				End
			End
		end
 	End	
	else if isnull(@AssetTypeCode,'') = ''
	begin
		set @TempValidationStatus = 'E' 
		set @ErrorTextTemp =  'Invalid  Asset Type Code' 
	end
End
	if isnull(@PType,'') = 'FailureMode'
	Begin  
	if isnull(@FailureModeCode,'') <> ''
	begin 
		Select @FailureModeId = FailureModeId from FailureMode where FailureModeCode = @FailureModeCode;
		if isnull(@FailureModeId,0) = 0
		Begin --OK
	 
			exec dbo.[EAppSaveFailureMode] 0,@LanguageId,@FailureModeCode,@FailureModeName,@FailureModeDescriptions,'Y',@UserId 
			set @TempValidationStatus = 'L' 
			set @ErrorTextTemp = Concat(@ErrorTextTemp,char(10), 'Failure Mode Created')  
	 
 		End---Ok  
		else if isnull(@FailureModeId,'') > 0
			begin
 				set @TempValidationStatus = 'E' 
				set @ErrorTextTemp =  'Failure mode already exists' 
			end
 	End	
	else if isnull(@FailureModeCode,'') = ''
	begin
		set @TempValidationStatus = 'E' 
		set @ErrorTextTemp =  'Invalid Failure mode Code' 
	end
End
	if isnull(@PType,'') = 'FailureCause'
	Begin  
	if isnull(@FailureCauseCode,'') <> ''
	begin 
		Select @FailureCauseId = FailureCauseId from FailureCause where FailureCauseCode = @FailureCauseCode;
		if isnull(@FailureCauseId,0) = 0
		Begin --OK
	 
			exec dbo.[EAppSaveFailureCause] 0,@LanguageId,@FailureCauseCode,@FailureCauseName,@FailureCauseDescriptions,'Y',@UserId 
			set @TempValidationStatus = 'L' 
			set @ErrorTextTemp = Concat(@ErrorTextTemp,char(10), 'Failure Cause Created')  
	 
 		End---Ok  
		else if isnull(@FailureCauseId,'') > 0
			begin
 				set @TempValidationStatus = 'E' 
				set @ErrorTextTemp =  'Failure Cause already exists' 
			end
 	End	
	else if isnull(@FailureCauseCode,'') = ''
	begin
		set @TempValidationStatus = 'E' 
		set @ErrorTextTemp =  'Invalid Failure Cause Code' 
	end
End  
	if isnull(@PType,'') = 'AssetClassFailureModeRelation'
	Begin  
	if isnull(@FailureModeCode,'') <> '' and isnull(@AssetClassCode,'') <> ''
	begin 
		Select @FailureModeId = FailureModeId from FailureMode where FailureModeCode = @FailureModeCode;
		if isnull(@FailureModeId,0) = 0
		Begin 
			set @TempValidationStatus = 'E' 
			set @ErrorTextTemp = Concat(@ErrorTextTemp,char(10), 'Invalid Failure Mode')  
 		End   
		Select @AssetClassId = AssetClassId from AssetClass where AssetClassCode = @AssetClassCode;
		if isnull(@AssetClassId,0) = 0
		Begin 
			set @TempValidationStatus = 'E' 
			set @ErrorTextTemp = Concat(@ErrorTextTemp,char(10), 'Invalid Asset Class')  
 		End   
		
		if isnull(@FailureModeId,'') > 0 and isnull(@AssetClassId,'') > 0
		begin
			exec dbo.[EAppSaveFailureModeAssetClassRelation] @FailureModeId,@AssetClassId,'Y',@UserId 
			set @TempValidationStatus = 'L' 
			set @ErrorTextTemp = Concat(@ErrorTextTemp,char(10), 'Failure Mode Asset Class relation created')  
 		end
 	End	
	else if isnull(@FailureModeCode,'') = '' or isnull(@AssetClassCode,'') = ''
	begin
		set @TempValidationStatus = 'E' 
		set @ErrorTextTemp =  'Failure mode and Asset Class Code are mandatory' 
	end
End
	if isnull(@PType,'') = 'Industry'
	Begin
	if isnull(@IndustryCode,'') <> ''  
	begin 
		Select @SegmentId = SegmentId, @IndustryId = IndustryId from Industry where Industrycode = @IndustryCode;
		if isnull(@IndustryId,0) = 0
		Begin --OK
			if isnull(@SectorCode,'') <> ''
			Begin
				Select @SectorId  = Sectorid from Sector where SectorCode = @SectorCode
				if isnull(@SectorId,0) = 0 
				Begin
 					set @TempValidationStatus = 'E' 
					set @ErrorTextTemp =  'Sector missing' 
				End
 
			End
			else if isnull(@SectorCode,'')=''
			Begin
 				set @TempValidationStatus = 'E' 
				set @ErrorTextTemp =  'Invalid Sector Code' 
			End 

			if isnull(@SegmentCode,'') = ''
			begin
 				set @TempValidationStatus = 'E' 
				set @ErrorTextTemp =  'Invalid Segment Code' 
			end
			else if isnull(@SegmentCode,'') <> ''
			begin --OK1
				Select @SectorId = SectorId,@SegmentId = SectorId from Segment where  SectorId = @SectorId and SegmentCode = @SegmentCode;
  				if isnull(@SegmentId,0) = 0
				Begin--OK2
 							set @TempValidationStatus = 'E' 
							set @ErrorTextTemp =  'Segment missing' 

				End--OK2
				if isnull(@SegmentId,0) > 0
				Begin--OK3 
					if isnull(@SectorId,0)> 0 and isnull(@SegmentId,0) > 0 
					Begin -- OK4
  						set @TempValidationStatus = 'V' 
						set @TaxonomyType = 'A'
						set @ErrorTextTemp =Concat(@ErrorTextTemp,char(10), 'Industry - Ready To Load')    

						If isnull(@TempValidationStatus,'N') = 'V' 
						Begin -- OK5
							select  @SegmentId = SegmentId from Segment where SectorId = @SectorId and SegmentCode = @SegmentCode 
							Select @IndustryId = IndustryId from Industry where Industrycode = @IndustryCode;
							if isnull(@IndustryId,0) = 0
							Begin
								if isnull(@IndustryName,'') <> ''
								Begin
 									exec dbo.[EAppSaveIndustry] 0,@SegmentId,@LanguageId,@IndustryCode,@IndustryName,@IndustryDescriptions,'Y',@UserId
									set @TempValidationStatus = 'L' 
									set @ErrorTextTemp = Concat(@ErrorTextTemp,char(10), 'Industry Loaded Successfully')  
								End
								else if isnull(@IndustryName,'') = ''
								Begin
								 	set @TempValidationStatus = 'E' 
									set @ErrorTextTemp =  'Industry Name Missing' 
								End
							end
							if isnull(@IndustryId,0) > 0
							Begin
								set @TempValidationStatus = 'E' 
								set @ErrorTextTemp =  Concat(@ErrorTextTemp,char(10), 'Industry Already Exists')  
							End
						End  -- OK5

					End -- OK4
				
				End -- OK3
			End	--OK1						
 		End---Ok  
		else if isnull(@IndustryId,0) > 0
			begin
 				set @TempValidationStatus = 'E' 
				set @ErrorTextTemp =  'Industry Already Exists' 
			end
 	End	
	else if isnull(@IndustryCode,'') = ''
	begin
		set @TempValidationStatus = 'E' 
		set @ErrorTextTemp =  'Invalid Industry Code' 
	end
End 
  	if isnull(@PType,'') = 'Taxonomy'
	Begin
	if isnull(@IndustryCode,'') <> ''
	begin 
		Select  @SegmentId = SegmentId, @IndustryId = IndustryId from Industry where Industrycode = @IndustryCode;
 
		if isnull(@IndustryId,0) > 0
		Begin
			Select @SectorId = SectorId from Segment where SegmentId = @SegmentId;
			if isnull(@AssetCategoryCode,'') = '' or isnull(@AssetCategoryName,'') = ''
			begin
 				set @TempValidationStatus = 'E' 
				set @ErrorTextTemp =  'Invalid Asset Type Code / Name' 
			end
			else if isnull(@AssetCategoryCode,'') <> '' and isnull(@AssetCategoryName,'') <> ''
			begin 
				Select @AssetCategoryId = AssetCategoryId from AssetCategory where AssetCategoryCode = @AssetCategoryCode;
  				if isnull(@AssetCategoryId,0) = 0
				Begin
					exec dbo.[EAppSaveAssetCategory] 0,@LanguageId,@AssetCategoryCode,@AssetCategoryName,@AssetCategoryDescriptions,'Y',@UserId
					Select @AssetCategoryId = AssetCategoryId from AssetCategory where AssetCategoryCode = @AssetCategoryCode;  
					set @TempValidationStatus = 'I' 
					set @ErrorTextTemp = Concat(@ErrorTextTemp,char(10), 'Asset Category Created')  
				End
				if isnull(@AssetCategoryId,0) > 0
				Begin
					if isnull(@AssetClassCode,'') = '' or isnull(@AssetClassName,'') = ''
					begin
 						set @TempValidationStatus = 'E' 
						set @ErrorTextTemp =  'Invalid Asset Class Code / Name' 
					end
					else if isnull(@AssetClassCode,'') <> '' and isnull(@AssetClassName,'') <> ''
					begin 
						Select @AssetClassId = AssetClassId from AssetClass where AssetClassCode = @AssetClassCode;
  						if isnull(@AssetClassId,0) = 0
						Begin
							exec dbo.[EAppSaveAssetClass] 0,@LanguageId,@AssetClassCode,@AssetClassName,@AssetClassDescriptions,'Y',@UserId
							Select @AssetClassId = AssetClassId from AssetClass where AssetClassCode = @AssetClassCode;  
							exec dbo.[EAppSaveAssetCategoryClassRelation] @AssetClassId,@AssetCategoryId,'Y',@UserId
							exec dbo.[EAppSaveAssetClassIndustryRelation]  @AssetClassId,@IndustryId,'Y',@UserId
							set @TempValidationStatus = 'I' 
							set @ErrorTextTemp = Concat(@ErrorTextTemp,char(10), 'Asset Class Created')  
						End
						if isnull(@AssetClassId,0) > 0
						Begin
							if isnull(@AssetTypeCode,'') = '' or isnull(@AssetTypeName,'') = ''
							begin
	 								set @TempValidationStatus = 'E' 
								set @ErrorTextTemp =  'Invalid Asset Type Code / Name' 
							end
							else if isnull(@AssetTypeCode,'') <> '' and isnull(@AssetTypeName,'') <> ''
							begin 
								Select @AssetTypeId = AssetTypeId from AssetType where AssetTypeCode = @AssetTypeCode;
  								if isnull(@AssetTypeId,0) = 0
								Begin
									exec dbo.[EAppSaveAssetType] 0,@LanguageId,@AssetTypeCode,@AssetTypeName,@AssetTypeDescriptions,'Y',@UserId
									Select @AssetTypeId = AssetTypeId from AssetType where AssetTypeCode = @AssetTypeCode; 
									exec dbo.[EAppSaveAssetTypeClassRelation] @AssetClassId,@AssetTypeId, 'Y',@UserId 
									set @TempValidationStatus = 'I' 
									set @ErrorTextTemp = Concat(@ErrorTextTemp,char(10), 'Asset Type Created')  
								End
								if isnull(@AssetTypeId,0) > 0
								Begin
									if isnull(@AssetSequenceCode,'') = '' or isnull(@AssetSequenceName,'') = ''
									begin
 										set @TempValidationStatus = 'E' 
										set @ErrorTextTemp =  'Invalid Asset Sequence Code / Name' 
									end
									else if isnull(@AssetSequenceCode,'') <> '' and isnull(@AssetSequenceName,'') <> ''
									begin 
										Select @AssetSequenceId = AssetSequenceId from AssetSequence where AssetTypeId = @AssetTypeId and AssetSequenceCode = @AssetSequenceCode;
  										if isnull(@AssetSequenceId,0) = 0
										Begin
											exec dbo.[EAppSaveAssetSequence] 0,@LanguageId,@AssetTypeId,@AssetSequenceCode,@AssetSequenceName,@AssetSequenceDescriptions,'Y',@UserId
											Select @AssetSequenceId = AssetSequenceId from AssetSequence where AssetTypeId = @AssetTypeId and AssetSequenceCode = @AssetSequenceCode;  
											set @TempValidationStatus = 'I' 
											set @ErrorTextTemp = Concat(@ErrorTextTemp,char(10), 'Asset Sequence Created')  
										End
										if isnull(@AssetSequenceId,0) > 0
										Begin
  											set @TempValidationStatus = 'V' 
											set @TaxonomyType = 'A'
											set @ErrorTextTemp =Concat(@ErrorTextTemp,char(10), 'Asset - Ready To Load')    

											if isnull(@FailureModeCode,'') <> ''
											begin 
												Select @FailureModeId = FailureModeId from FailureMode where FailureModeCode = @FailureModeCode;
 												if isnull(@FailureModeId,0) > 0  
												Begin
													set @TaxonomyType = 'T'
  													set @TempValidationStatus = 'V' 
													set @ErrorTextTemp = Concat(@ErrorTextTemp,char(10), 'FailureModeCode - Ready To Load')
												End
												else if isnull(@FailureModeId,0) = 0
												Begin
  													set @TempValidationStatus = 'E' 
													set @ErrorTextTemp =  Concat(@ErrorTextTemp,char(10), 'Failure Mode - Does Not Exists') 
												End
											end   
											if isnull(@FailureCauseCode,'') <> ''
											begin 
												Select @FailureCauseId = FailureCauseId from FailureCause where FailureCauseCode = @FailureCauseCode;
 												if isnull(@FailureCauseId,0) > 0  
												Begin
  													set @TempValidationStatus = 'V' 
													set @TaxonomyType = 'T'
													set @ErrorTextTemp =  Concat(@ErrorTextTemp,char(10), 'Failure Cause - Ready To Load')  
												End
 												else if isnull(@FailureCauseId,0) = 0
												Begin
  													set @TempValidationStatus = 'E' 
													set @ErrorTextTemp =  Concat(@ErrorTextTemp,char(10), 'Failure Cause - Does Not Exists')  
												End
											end   
											If isnull(@TempValidationStatus,'N') = 'V' 
											Begin
												select @TaxonomyId = TaxonomyId ,  @MTTROld = isnull(MTTROld,0), @MTBFOld = isnull(MTBFOld,0) from Taxonomy where Sectorid = @SectorId and SegmentId = @SegmentId and IndustryId = @IndustryId
												 and AssetCategoryid = @AssetCategoryId AND AssetClassId = @AssetClassId and AssetTypeid = @AssetTypeId and AssetSequenceId = @AssetSequenceId 
												 and (FailureModeId = @FailureModeId or isnull(@FailureModeId,0) =0) and (FailureCauseId = @FailureCauseId or isnull(@FailureCauseId,0) =0)  ;
												if isnull(@TaxonomyId,0) = 0
												Begin
													set @AssetTypeClassCode = Concat(@AssetClassCode,@AssetTypeCode,@AssetSequenceCode)
													exec dbo.[EAppSaveTaxonomy] 0,'',@SectorId,@SegmentId,@IndustryId,@AssetTypeId,@FailureModeId,@FailureCauseid,@MTTR,@MTTROld,@MTBF,@MTBFOld ,'Y',@UserId,@AssetCategoryId,@AssetClassId,@AssetSequenceId,@AssetTypeClassCode,@TaxonomyType 
													set @TempValidationStatus = 'L' 
													set @ErrorTextTemp = Concat(@ErrorTextTemp,char(10), 'Taxonomy Load - Loaded Successfully')  
												end
												if isnull(@TaxonomyId,0) > 0
												Begin
													set @TempValidationStatus = 'E' 
													set @ErrorTextTemp =  Concat(@ErrorTextTemp,char(10), 'Taxonomy - Taxonomy Already Exists')  
												End
											End



										End							
								

									end  



								End							
								

							end  


						End							
								

					end   


				End							
								

			end   
	
		End
		else if isnull(@IndustryId,0)  = 0
		begin
 			set @TempValidationStatus = 'E' 
			set @ErrorTextTemp =  'Industry Does Not Exits' 
		end
		end   
	else if isnull(@IndustryCode,'') = ''
	begin
	set @TempValidationStatus = 'E' 
	set @ErrorTextTemp =  'Invalid Industry Code' 
	end

	End	

			Update #LoadJson set validationStatus = @TempValidationStatus, ValidationResult = @ErrorTextTemp 
			where LoaderId = @LoaderId
			
			select  @ErrorTextTemp = '' , @TempValidationStatus = 'N',@SectorId = null,@SectorDescriptions='',@SectorName='',@SectorCode= '',
			@SegmentId = null, @SegmentDescriptions='',@SegmentName='',@SegmentCode= '',@IndustryId = null, @IndustryDescriptions='',@IndustryName='',@IndustryCode= ''
			,@AssetTypeId = null, @AssetTypeDescriptions='',@AssetTypeName='',@AssetTypeCode= '',@FailureModeId = null, @FailureModeDescriptions='',@FailureModeName='',@FailureModeCode= ''
			,@AssetCategoryId = null, @AssetCategoryDescriptions='',@AssetCategoryName='',@AssetCategoryCode= ''
			,@AssetClassId = null, @AssetClassDescriptions='',@AssetClassName='',@AssetClassCode= ''
			,@AssetSequenceId = null, @AssetSequenceDescriptions='',@AssetSequenceName='',@AssetSequenceCode= ''
			,@FailureCauseId = null, @FailureCauseDescriptions='',@FailureCauseName='',@FailureCauseCode= '',@MTTROld = null ,@MTBFOld = null,@MTTR =null,@MTBF=null,
			@TaxonomyId = null
		    
			FETCH NEXT FROM GetIdCur INTO
            @LoaderId,@UserId,@LanguageId,@PType,@PAction,@SectorCode ,@SectorName,@SectorDescriptions,@SegmentCode, @SegmentName,@SegmentDescriptions,
			@IndustryCode, @IndustryName,@IndustryDescriptions,@AssetTypeCode, @AssetTypeName,@AssetTypeDescriptions, @AssetCategoryCode, @AssetCategoryName,@AssetCategoryDescriptions,
			@AssetClassCode, @AssetClassName,@AssetClassDescriptions, @AssetSequenceCode, @AssetSequenceName,@AssetSequenceDescriptions,@FailureModeCode, @FailureModeName,@FailureModeDescriptions,
			@FailureCauseCode, @FailureCauseName,@FailureCauseDescriptions,@MTTROld,@MTBFOld,@MTTR,@MTBF

    END 
    CLOSE GetIdCur
    DEALLOCATE GetIdCur
	
	if isnull(@PType,'') = 'Sector' 
	Begin 
		Select (Select ReferenceNo,SectorCode, SectorName,SectorDescriptions,validationStatus, ValidationResult
		from #LoadJson FOR JSON AUTO ) as MasterImport
	End
	if isnull(@PType,'') = 'Segment' 
	Begin 
		Select (Select ReferenceNo,SectorCode, SectorName,SegmentCode, SegmentName,SegmentDescriptions,validationStatus, ValidationResult
		from #LoadJson FOR JSON AUTO ) as MasterImport
	End
	if isnull(@PType,'') = 'Industry' 
	Begin 
		Select (Select ReferenceNo,SectorCode, SectorName,SegmentCode, SegmentName,IndustryCode,IndustryName,IndustryDescriptions,validationStatus, ValidationResult
		from #LoadJson FOR JSON AUTO ) as MasterImport
	End
	if isnull(@PType,'') = 'AssetType' 
	Begin 
		Select (Select ReferenceNo,AssetTypeCode, AssetTypeName,AssetTypeDescriptions,validationStatus, ValidationResult
		from #LoadJson FOR JSON AUTO ) as MasterImport
	End
	if isnull(@PType,'') = 'AssetCategory' 
	Begin 
		Select (Select ReferenceNo,AssetCategoryCode, AssetCategoryName,AssetCategoryDescriptions,validationStatus, ValidationResult
		from #LoadJson FOR JSON AUTO ) as MasterImport
	End
	if isnull(@PType,'') = 'AssetClass' 
	Begin 
		Select (Select ReferenceNo,AssetClassCode, AssetClassName,AssetClassDescriptions,validationStatus, ValidationResult
		from #LoadJson FOR JSON AUTO ) as MasterImport
	End
	if isnull(@PType,'') = 'AssetSequence' 
	Begin 
		Select (Select ReferenceNo,AssetSequenceCode, AssetSequenceName,AssetSequenceDescriptions,validationStatus, ValidationResult
		from #LoadJson FOR JSON AUTO ) as MasterImport
	End
	if isnull(@PType,'') = 'FailureMode' 
	Begin 
		Select (Select ReferenceNo,FailureModeCode, FailureModeName,FailureModeDescriptions,validationStatus, ValidationResult
		from #LoadJson FOR JSON AUTO ) as MasterImport
	End
	if isnull(@PType,'') = 'FailureCause' 
	Begin 
		Select (Select ReferenceNo,FailureCauseCode, FailureCauseName,FailureCauseDescriptions,validationStatus, ValidationResult
		from #LoadJson FOR JSON AUTO ) as MasterImport
	End
	if isnull(@PType,'') = 'Taxonomy' 
	Begin 
		Select (Select ReferenceNo,IndustryCode,IndustryName, FailureCauseCode,AssetTypeCode, AssetTypeName,FailureModeCode, FailureModeName,FailureCauseCode, FailureCauseName,FailureCauseDescriptions,validationStatus, ValidationResult
		from #LoadJson FOR JSON AUTO ) as MasterImport
	End

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppRptAssetConditionHistory]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppRptAssetConditionHistory] 
	@UnitType Varchar(3),
	@UnitId bigint, 
	@ServiceId int,
	@JobEquipmentId bigint,
	@ClientSiteId int,
	@LanguageId int 
AS
BEGIN
	Declare @DataCollectionDate date
	 select @DataCollectionDate =  j.DataCollectionDate  	From  jobEquipment j  
	 where j.JobEquipmentId = @JobEquipmentId 

	Select Top 5 j.DataCollectionDate ReportDate,je.serviceid, je.ConditionId,
	cast(dbo.GetLookupTranslated(je.ConditionId, @LanguageId,'LookupCode' ) as int ) as ConditionCode,
	dbo.[GetConditionCodeTranslated](je.ConditionId,@ClientSiteId,@LanguageId,'ConditionName' ) as ConditionName
	From JobEquipUnitAnalysis je join jobEquipment j on j.JobEquipmentId = Je.JobEquipmentId and isnull(je.ConditionId,0) <> 0
	where  je.unittype =@UnitType and je.unitid = @UnitId and je.ServiceId = @ServiceId 
	and j.DataCollectionDate <= @DataCollectionDate 
	order by j.DataCollectionDate desc
 
END
GO
/****** Object:  StoredProcedure [dbo].[EAppRptAssetfeederAttachments]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppRptAssetfeederAttachments]  
	@UnitAnalysisId bigint 
AS
BEGIN  
    
	Select  
	jua.UnitAnalysisAttachId, jua.UnitAnalysisId, jua.PhysicalPath
	From  JobEquipUnitAnalysisAttachments jua where  jua.UnitAnalysisId = @UnitAnalysisId and jua.Active = 'Y'
END 
GO
/****** Object:  StoredProcedure [dbo].[EAppRptBriefSummary]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppRptBriefSummary]  
	@JobId bigint, 
	@LanguageId int 
AS
BEGIN  
set @LanguageId = isnull(@LanguageId,1)
  ;With JECTE as (
 	Select j.JobId, j.StatusId as JobStatusId, j.Jobnumber,j.AnalystId,j.ReviewerId,js.ServiceId,  e.PlantAreaId,p.ClientSiteId, je.JobEquipmentId,e.EquipmentId, e.EquipmentName, je.ConditionId,
	je.DataCollectionDate, je.ReportDate, j.CreatedBy, e.ListOrder as EListOrder, je.Comment,DATEDIFF(Day,j.EstStartDate,j.EstEndDate) as NoOfDays
	from  JobEquipment je Join Equipment e on e.EquipmentId = je.EquipmentId 
	join PlantArea p on p.PlantAreaId = e.PlantAreaId
	join Jobs j on j.JobId = je.JobId
	join JobServices js on js.JobId = j.JobId and js.Active = 'Y'
	Where j.JobId = @JobId 
	)
	Select 
	je.JobId,
	dbo.GetLookupTranslated(je.ServiceId ,@LanguageId,'LookupValue' ) as ServiceName,
	cast(dbo.GetLookupTranslated(je.ServiceId ,@LanguageId,'Lookuporder') as int) as SListOrder,
	je.PlantAreaId,je.ClientSiteId, (select cs.Logo from ClientSite cs where cs.ClientSiteId = je.ClientSiteId) as ClientLogo,
	dbo.GetNameTranslated(je.ClientSiteId,@LanguageId,'ClientSiteName') as ClientName,
	dbo.GetNameTranslated(je.PlantAreaId,@LanguageId,'PlantAreaName') as PlantAreaName,
	je.JobEquipmentId,je.EquipmentId, je.EquipmentName, 
	(Select concat(u.FirstName,' ',u.LastName) from users u where userid = je.AnalystId ) as ReportBy , 
	case when je.JobStatusId = dbo.GetStatusId(1,'JobProcessStatus','C') then (Select concat(a.FirstName,' ',a.LastName) from users a where userid = je.ReviewerId ) else '' end  ReviewerName,
	je.DataCollectionDate, je.ReportDate,je.EListOrder,
	cast(dbo.GetLookupTranslated(je.ConditionId,@LanguageId,'LookupCode' ) as int) as EConditionCode,
    dbo.[GetConditionCodeTranslated](je.ConditionId,je.ClientSiteId,@LanguageId,'ConditionName' ) as EConditionName,
	cast(dbo.GetLookupTranslated(ju.ConditionId,@LanguageId,'LookupCode' ) as int) as AConditionCode,
    dbo.[GetConditionCodeTranslated](ju.ConditionId,je.ClientSiteId,@LanguageId,'ConditionName' ) as AConditionName,
	case when ju.UnitType = 'DR' then (select edu.IdentificationName from EquipmentDriveUnit edu where edu.DriveUnitId = ju.UnitId)
	when ju.UnitType = 'DN' then (select edu.IdentificationName from EquipmentDrivenUnit edu where edu.DrivenUnitId = ju.UnitId)
	when ju.UnitType = 'IN' then (select eiu.IdentificationName from EquipmentIntermediateUnit eiu where eiu.IntermediateUnitId = ju.UnitId)
	end as AssetName,
	case when ju.UnitType = 'DR' then (select edu.ListOrder from EquipmentDriveUnit edu where edu.DriveUnitId = ju.UnitId)
	when ju.UnitType = 'DN' then (select edu.ListOrder from EquipmentDrivenUnit edu where edu.DrivenUnitId = ju.UnitId)
	when ju.UnitType = 'IN' then (select eiu.ListOrder from EquipmentIntermediateUnit eiu where eiu.IntermediateUnitId = ju.UnitId)
	end as AListOrder,
	case when ju.UnitType = 'DR' then 1
	when ju.UnitType = 'DN' then 3
	when ju.UnitType = 'IN' then 2
	end UnitOrder,  je.Comment,
	ju.UnitAnalysisId,
	(select STUFF(REPLACE((SELECT distinct '#!' +  LTRIM(RTRIM(dbo.GetNameTranslated(FailureModeid,@LanguageId,'FailureModeName'))) AS 'data()' FROM JobEquipUnitSymptoms
	WHERE  UnitAnalysisId = ju.UnitAnalysisId 
	FOR XML PATH('')),' #!',', '), 1, 2, '') ) as FailureMode,
	(select STUFF(REPLACE((SELECT distinct '#!' +  LTRIM(RTRIM(dbo.GetNameTranslated(indicatedFaultid,@LanguageId,'FailureCauseName'))) AS 'data()' FROM JobEquipUnitSymptoms
	WHERE  UnitAnalysisId = ju.UnitAnalysisId 
	FOR XML PATH('')),' #!',', '), 1, 2, '') ) as FailureCase,
	ju.UnitType, ju.UnitType as 'UnitTypeDesc', ju.UnitId, ju.ServiceId,ju.Comment as AssetComment,ju.Recommendation, 
	dbo.GetLookupTranslated(ju.ConfidentFactorId,1,'LookupValue') as ConfidenceLevel,
	dbo.GetLookupTranslated(ju.FailureProbFactorId,1,'LookupValue') as FailureProbability,
	dbo.GetLookupTranslated(ju.PriorityId,1,'LookupValue') as Prioirty, ju.IsWorkNotification ,
 	case when ju.IsWorkNotification = 'Y' then wr.WorkNotificationNumber else '' end AWorkNotificationNumber,
    wr.WorkNotificationNumber EWorkNotificationNumber,
    wr.ACostToRepair, wr.ECostToRepair,
	(select OAVibration from dbo.[udtfgetUnitAmplitude] (ju.UnitAnalysisId)) OAVibration, 
	(select OAGELevelPkPk from dbo.[udtfgetUnitAmplitude] (ju.UnitAnalysisId)) OAGELevelPkPk,
	JE.NoOfDays
	From JECTE je join users u on u.UserId = je.CreatedBy 
	Join JobEquipUnitAnalysis ju on ju.JobEquipmentId = je.JobEquipmentId and ju.ServiceId = je.ServiceId 
  	left join (select wu.UnitId,wu.UnitType, we.JobId,we.EquipmentId, we.WorkNotificationNumber,we.CostToRepair as ECostToRepair, wu.CostToRepair ACostToRepair 
	from WorkNotificationEquipment we join WorkNotificationUnits wu on we.wnEquipmentId = wu.WNEquipmentId) wr
	on wr.JobId = je.JobId and wr.EquipmentId = je.EquipmentId   and wr.UnitId = ju.UnitId and ju.unitType = wr.unitType
	
 END 
GO
/****** Object:  StoredProcedure [dbo].[EAppRptClientConditionCodeList]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppRptClientConditionCodeList] 
	@LanguageId Int,
	@ClientSiteId int
AS
BEGIN
 select ConditionId , dbo.GetLookupTranslated( ConditionId,@LanguageId,'LookupCode')CoditionCode
 ,dbo.GetConditionCodeTranslated( ConditionId,@ClientSiteId,@LanguageId,'ConditionName')ConditionName
 ,dbo.GetConditionCodeTranslated( ConditionId,@ClientSiteId,@LanguageId,'ConditionDescription')ConditionDescription
 From ConditionCodeClientMapping where clientsiteId = @ClientSiteId
 END
GO
/****** Object:  StoredProcedure [dbo].[EAppRptEquipmentConditionHistory]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppRptEquipmentConditionHistory]
	@EquipmentId bigint,
	@JobEquipmentId Bigint,
	@ClientSiteId int,
	@ServiceId int,
	@LanguageId int 
AS
BEGIN
	 Declare @ReportDate date
	 select @ReportDate =  j.DataCollectionDate  	From  jobEquipment j  
	 where j.JobEquipmentId = @JobEquipmentId 	
	
	Select Top 5 je.DataCollectionDate as RConditionDate, je.ConditionId as RConditionId,
	cast(dbo.GetLookupTranslated(je.ConditionId, @LanguageId,'LookupCode' ) as int ) as RConditionCode,
	dbo.[GetConditionCodeTranslated](je.ConditionId,@ClientSiteId,@LanguageId,'ConditionName' ) as RConditionName
	From JobEquipment je 
	where je.EquipmentId = @EquipmentId and je.ServiceId = @ServiceId and je.DataCollectionDate <= @ReportDate and isnull(je.ConditionId,0) <> 0
	order by DataCollectionDate desc 

END
GO
/****** Object:  StoredProcedure [dbo].[EAppRptEquipmentConditionMonitoring]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppRptEquipmentConditionMonitoring]
	@JobEquipmentId bigint, 
	@LanguageId int 
AS
BEGIN
  ;With JECTE as (
 	Select j.Jobnumber,j.ReviewerId, e.PlantAreaId,p.ClientSiteId, je.JobEquipmentId,e.EquipmentId, 
	e.EquipmentName, 
	je.ConditionId,	je.DataCollectionDate, je.ReportDate, je.CreatedBy ,je.Comment, 
	Je.ServiceId,e.AreaId,e.SystemId
	from  JobEquipment je Join Equipment e on e.EquipmentId = je.EquipmentId 
	join PlantArea p on p.PlantAreaId = e.PlantAreaId
	join Jobs j on j.JobId = je.JobId
	Where JobEquipmentId = @JobEquipmentId 
	)
	Select 
	je.PlantAreaId,je.ClientSiteId,
	je.ServiceId,
	dbo.GetLookupTranslated(je.ServiceId,@LanguageId,'LookupValue' ) ServiceName,
	 dbo.GetNameTranslated(je.PlantAreaId,@LanguageId,'PlantAreaName') as PlantAreaName,
	 dbo.GetNameTranslated(je.AreaId,@LanguageId,'AreaName') as AreaName,
	 dbo.GetNameTranslated(je.SystemId,@LanguageId,'SystemName') as SystemName,
	je.JobEquipmentId,je.EquipmentId, je.EquipmentName, concat(u.FirstName,' ',u.LastName) as ReportBy , 
	u.EmailId, (Select concat(a.FirstName,' ',a.LastName) from users a where userid = je.ReviewerId ) as ReviewerName,
	je.DataCollectionDate, je.ReportDate, cast(dbo.GetLookupTranslated(je.ConditionId,@LanguageId,'LookupCode' ) as int) as ConditionCode,
	 dbo.[GetConditionCodeTranslated](je.ConditionId,je.ClientSiteId,@LanguageId,'ConditionName' ) as ConditionName,
	je.Comment
	From JECTE je join users u on u.UserId = je.CreatedBy

END
GO
/****** Object:  StoredProcedure [dbo].[EAppRptEquipmentConditionMonitoringAssetDetail]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
create   PROCEDURE [dbo].[EAppRptEquipmentConditionMonitoringAssetDetail]
	@ClientSiteId int,
	@UnitType varchar(4),
	@UnitId bigint, 
	@LanguageId int 
AS
BEGIN
Declare @LunitType varchar(5) = '';
select @LUnitType = case when @UnitType = 'Drive' then 'DR' 
			when @UnitType = 'Driven'  then 'DN' 
			when @UnitType = 'Intermediate' then 'IN' end  

select case when u.UnitType = 'DR' then 'Drive' 
			when u.UnitType = 'DN'  then 'Driven' 
			when u.UnitType = 'IN' then 'Intermediate' end  UnitType,
			dbo.[GetConditionCodeTranslated](u.ConditionId,@ClientSiteId,@LanguageId,'ConditionName' ) as ConditionName,
			cast(dbo.GetLookupTranslated(u.ConditionId, @LanguageId,'LookupCode') as int ) as ConditionCode,
			dbo.GetLookupTranslated(u.ConfidentFactorId, @LanguageId,'LookupValue') as ConfidentFactor,
			dbo.GetLookupTranslated(u.FailureProbFactorId, @LanguageId,'LookupValue') as FailureProbFactor,
			dbo.GetLookupTranslated(u.PriorityId, @LanguageId,'LookupValue') as Prioirty ,
			'' as NoOfDays,
		    (select STUFF(REPLACE((SELECT distinct '#!' +  LTRIM(RTRIM(dbo.GetNameTranslated(FailuremodeId,@LanguageId,'FailureCauseName'))) AS 'data()' 
			FROM JobEquipUnitSymptoms
			WHERE  UnitAnalysisId = u.UnitAnalysisId
			FOR XML PATH('')),' #!',', '), 1, 2, '') ) as FailureMode,
		    (select STUFF(REPLACE((SELECT distinct '#!' +  LTRIM(RTRIM(dbo.GetNameTranslated(IndicatedFaultId,@LanguageId,'FailureCauseName'))) AS 'data()' 
		    FROM JobEquipUnitSymptoms
			WHERE  UnitAnalysisId = u.UnitAnalysisId
			FOR XML PATH('')),' #!',', '), 1, 2, '') ) as FailureCause, 
			u.Comment,u.Recommendation  
			from  JobEquipUnitAnalysis u  
			where u.UnitType = @UnitType and @UnitId = @UnitId 
END 
GO
/****** Object:  StoredProcedure [dbo].[EAppRptEquipmentConditionMonitoringAssets]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppRptEquipmentConditionMonitoringAssets]
	@ClientSiteId int,
	@JobEquipmentId bigint, 
	@LanguageId int 
AS
BEGIN

select case when u.UnitType = 'DR' then 'Drive' 
			when u.UnitType = 'DN'  then 'Driven' 
			when u.UnitType = 'IN' then 'Intermediate' end  UnitType,
			case when u.UnitType = 'DR' then 1 
			when u.UnitType = 'DN'  then 3 
			when u.UnitType = 'IN' then 2 end  UnitOrder,
			dbo.[GetConditionCodeTranslated](u.ConditionId,@ClientSiteId,@LanguageId,'ConditionName' ) as ConditionName,
			cast(dbo.GetLookupTranslated(u.ConditionId, @LanguageId,'LookupCode') as int ) as ConditionCode,
			dbo.GetLookupTranslated(u.ConfidentFactorId, @LanguageId,'LookupValue') as ConfidentFactor,
			dbo.GetLookupTranslated(u.FailureProbFactorId, @LanguageId,'LookupValue') as FailureProbFactor,
			dbo.GetLookupTranslated(u.PriorityId, @LanguageId,'LookupValue') as Prioirty ,
			DATEDIFF(Day,j.EstStartDate,j.EstEndDate) as NoOfDays,
			u.Comment,u.Recommendation,
			(select STUFF(REPLACE((SELECT distinct '#!' +  LTRIM(RTRIM(dbo.GetNameTranslated(FailureModeId,1,'FailureModeName'))) AS 'data()' 
	        FROM JobEquipUnitSymptoms
			WHERE  UnitAnalysisId = u.UnitAnalysisId
			FOR XML PATH('')),' #!',', '), 1, 2, '') ) as FailureMode,
			(select STUFF(REPLACE((SELECT distinct '#!' +  LTRIM(RTRIM(dbo.GetNameTranslated(IndicatedFaultId,1,'FailureCauseName'))) AS 'data()' FROM JobEquipUnitSymptoms
			WHERE  UnitAnalysisId = u.UnitAnalysisId
			FOR XML PATH('')),' #!',', '), 1, 2, '') ) as FailureCause,
			case when u.UnitType = 'DR' then (select edu.IdentificationName from EquipmentDriveUnit edu where edu.DriveUnitId = u.UnitId)
			when u.UnitType = 'DN' then (select edu.IdentificationName from EquipmentDrivenUnit edu where edu.DrivenUnitId = u.UnitId)
			when u.UnitType = 'IN' then (select eiu.IdentificationName from EquipmentIntermediateUnit eiu where eiu.IntermediateUnitId = u.UnitId)
			end as AssetId,
			case when u.UnitType = 'DR' then (select edu.IdentificationName from EquipmentDriveUnit edu where edu.DriveUnitId = u.UnitId)
			when u.UnitType = 'DN' then (select edu.IdentificationName from EquipmentDrivenUnit edu where edu.DrivenUnitId = u.UnitId)
			when u.UnitType = 'IN' then (select eiu.IdentificationName from EquipmentIntermediateUnit eiu where eiu.IntermediateUnitId = u.UnitId)
			end as AssetOrder, u.UnitAnalysisId, @ClientSiteId as ClientSiteId
			from  JobEquipment je join JobEquipUnitAnalysis u on je.JobEquipmentId = u.JobEquipmentId
			join jobs j on j.JobId = je.JobId
			where je.JobEquipmentId = @JobEquipmentId 
			order by UnitOrder,AssetOrder
END
GO
/****** Object:  StoredProcedure [dbo].[EAppRptJobEquipConditionChart]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppRptJobEquipConditionChart]
	@JobId bigint,  
	@LanguageId int 
AS
BEGIN  
 
	Declare @TotalCount decimal(5,2)
	select @TotalCount = count(*) from JobEquipment je where je.JobId = @JobId and je.Active = 'Y'
	select c.ConditionId, 
	concat(Cast(dbo.GetLookupTranslated(c.ConditionId,1,'LookupCode' ) as int),':',dbo.[GetConditionCodeTranslated](c.ConditionId,j.ClientSiteId,1,'ConditionName' ),
	' (',case when isnull(count(je.JobEquipmentId),0) = 0 then 0 else cast(isnull(count(je.JobEquipmentId),1) * 100/isnull(@TotalCount,1)   as decimal(10,0)) end,'%)' )as ECondition,count(je.JobEquipmentId)JCount,
	dbo.[GetConditionCodeTranslated](c.ConditionId,j.ClientSiteId,1,'ConditionName' )CondtitionName,
	case when isnull(count(je.JobEquipmentId),0) = 0 then 0 else cast( isnull(count(je.JobEquipmentId),1) * 100/isnull(@TotalCount,1) as decimal(10,0)) end as CondtionPct
 	from ConditionCodeClientMapping c join jobs j on j.ClientSiteId = c.ClientSiteId and j.jobid = @JobId
	left join JobEquipment je on je.JobId = j.jobid and c.ConditionId = je.ConditionId
	Group by j.clientsiteid,c.ConditionId, je.ConditionId 
	order by c.conditionid
END 
GO
/****** Object:  StoredProcedure [dbo].[EAppRptJobEquipConditionSummary]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppRptJobEquipConditionSummary]
	@JobId bigint,  
	@LanguageId int 
AS
BEGIN  
  Declare @TotalCount decimal(5,2)
   select @TotalCount = count(*) from JobEquipment je where je.JobId = @JobId and je.Active = 'Y'
  ;With JECTE as ( 
 	Select  je.ConditionId, p.ClientSiteId
	from  JobEquipment je Join Equipment e on e.EquipmentId = je.EquipmentId and je.ConditionId is not null
	join PlantArea p on p.PlantAreaId= e.PlantAreaId
	join Jobs j on j.JobId = je.JobId 
	Where j.JobId = @JobId 
	)
	Select  
	Cast(dbo.GetLookupTranslated(je.ConditionId,@LanguageId,'LookupCode' ) as int) as EConditionCode,
    dbo.[GetConditionCodeTranslated](je.ConditionId,je.ClientSiteId,@LanguageId,'ConditionName' ) as EConditionName,
	Count(ConditionId) ConditionCount ,@TotalCount as TotalEquipment,
	case when isnull(Count(ConditionId),0) = 0 then 0 else (isnull(Count(ConditionId),1) * 100/isnull(@TotalCount,1) )end as CondtionPct
	From JECTE je    
	Group by ClientSiteId,ConditionId
END
GO
/****** Object:  StoredProcedure [dbo].[EAppRptJobEquipmentConditionList]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppRptJobEquipmentConditionList]
	@ClientSiteId int, 
	@ReportFromDate Date,
	@ReportToDate Date,
	@ConditionCodeId nvarchar(100), 
	@LanguageId int 
AS
BEGIN  
  	DECLARE @ConditionCodeArray TABLE(ConditionCodeId int)   
	DECLARE @XML xml = N'<r><![CDATA[' + REPLACE(@ConditionCodeId, ',', ']]></r><r><![CDATA[') + ']]></r>'

	INSERT INTO @ConditionCodeArray (ConditionCodeId)
	SELECT RTRIM(LTRIM(T.c.value('.', 'NVARCHAR(128)')))
	FROM @xml.nodes('//r') T(c);
	

	Declare @JobStatusId int, @VA int, @OA int
	Set @JobStatusId = dbo.GetStatusId(1,'JobProcessStatus','C')
	Set @VA = dbo.GetStatusId(1,'ReportType','VA')
	Set @OA = dbo.GetStatusId(1,'ReportType','OA')
	Select j.JobId, j.JobName, j.JobNumber,je.JobEquipmentId,je.EquipmentId,e.EquipmentName, je.DataCollectionDate, je.ReportDate,
	e.PlantAreaId, dbo.GetNameTranslated(e.PlantAreaId,@LanguageId,'PlantAreaName') as PlantAreaName,
	case when (je.ServiceId = @VA) then 'Y' else 'N' end as VA,
	case when (je.ServiceId = @OA) then 'Y' else 'N' end as OA,
	case when (select count(UnitAnalysisId) from JobEquipUnitAnalysis ua where ua.JobEquipmentId = je.JobEquipmentId and ua.IsWorkNotification = 'Y') > 0 then 'Y' else 'N' end as WN
	from  JobEquipment je Join Jobs j on je.JobId = j.JobId --and je.ConditionId in (Select ConditionCodeId from @ConditionCodeArray)  
	Join Equipment e on e.EquipmentId = je.EquipmentId 
	 where j.ClientSiteId =  @ClientSiteId --and/*  J.StatusId =  @JobStatusId and */j.ReportDate between @ReportFromDate and isnull(@ReportToDate,getdate())

END
GO
/****** Object:  StoredProcedure [dbo].[EAppRptPerformance]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppRptPerformance] 
@ReportType varchar(25),
@ClientSiteId int,
@PlantAreaId int,
@LanguageId int,
@FromDate date,
@ToDate date
AS
BEGIN
	Declare @JsonOutReport nvarchar(max)
 if @ReportType = 'JobStatus'
 Begin
	Declare @New int, @Completed int , @InProgress int, @ServiceNotRequired int, @Dispute int, @DisputeResolved int , @EntryCompletd int, @WaitingForReview int,
	@LookupId int, @LookupCode varchar(5)

	
	if @PlantAreaId = 0 
		Set @PlantAreaId = null

	Declare GetStatusCur Cursor Read_Only
	For
	Select Lookupid, LookupCode From Lookups where Lname = 'JobProcessStatus'
	Open GetStatusCur
	FETCH NEXT FROM GetStatusCur into @LookupId, @LookupCode
	WHILE @@FETCH_STATUS = 0
	BEGIN  
	if  @LookupCode = 'NS' 
	 Set @New =  @LookupId
	if  @LookupCode = 'C' 
	 Set @Completed =  @LookupId
	if  @LookupCode = 'IP' 
	 Set @InProgress =  @LookupId
	if  @LookupCode = 'NA' 
	 Set @ServiceNotRequired =  @LookupId
	if  @LookupCode = 'D' 
	 Set @Dispute =  @LookupId
	if  @LookupCode = 'SU' 
	 Set @WaitingForReview =  @LookupId  

	FETCH NEXT FROM GetStatusCur into @LookupId, @LookupCode
	END
	Close GetStatusCur
	Deallocate GetStatusCur 
	;with JCTE as
	(  
		SELECT j.JobId,j.JobNumber,J.EstStartDate,J.ReportDate,j.StatusId
		FROM Jobs j 
		WHERE j.ClientSiteId = @ClientSiteId and j.EstStartDate between @FromDate and isnull(@ToDate,getdate())
	) 
		Select @JsonOutReport = (
		Select  min(format(j.EstStartDate,'yyyyMM'))JobOrder,format(j.EstStartDate,'MMM-yy')JobMonth,
		 sum(case when J.StatusId = @New then 1 else 0 end) as Scheduled
		,sum(case when J.StatusId = @Completed then 1 else 0 end) as Completed
		,sum(case when J.StatusId = @InProgress then 1 else 0 end) as InProgress
		,sum(case when J.StatusId = @ServiceNotRequired then 1 else 0 end) as ServiceNotRequired
		,sum(case when J.StatusId = @Dispute then 1 else 0 end) as Dispute
		,sum(case when J.StatusId = @WaitingForReview then 1 else 0 end) as WaitingForReview
		FROM JobEquipment je Join JCTE j on j.JobId = je.JobId
		join Equipment e on je.EquipmentId = e.EquipmentId and e.PlantAreaId = isnull(@PlantAreaId,e.PlantAreaId)
		Group By format(j.EstStartDate,'MMM-yy') 
		Order by JobOrder
		FOR JSON AUTO, INCLUDE_NULL_VALUES)  
		
	End
 If @ReportType = 'EquipmentCondition'
 Begin
	Select @JsonOutReport = (
	select 	dbo.[GetConditionCodeTranslated](je.ConditionId,@ClientSiteId,@LanguageId,'ConditionName' ) as ConditionName,
	Count(*) as ConditionCount, dbo.[GetLookupTranslated](je.ConditionId,@LanguageId,'LookupOrder' ) as LookupOrder 
	from JobEquipment je join Equipment e on je.EquipmentId = e.EquipmentId 
	and e.PlantAreaId = isnull(@PlantAreaId,e.PlantAreaId)
	where je.ReportDate between @FromDate and isnull(@ToDate,getdate()) and je.ConditionId is not null
	Group By je.ConditionId 
	Order by LookupOrder
	FOR JSON AUTO, INCLUDE_NULL_VALUES)  
 End
 Select @JsonOutReport	as JsonOutReport
 End
GO
/****** Object:  StoredProcedure [dbo].[EAppRptSummaryReportMachineConditionPct]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppRptSummaryReportMachineConditionPct]
	@JobId Bigint, 
	@ServiceId int,
	@PlantAreaId int,
	@LanguageId int 
AS
BEGIN  

;With JECTE as
(
select je.JobEquipmentId, e.PlantAreaId, p.ClientSiteId, je.ConditionId , je.EquipmentId
from jobequipment je join Equipment e on e.equipmentid = je.equipmentid 
join PlantArea p on p.PlantAreaId= e.PlantAreaId
where je.jobid = @JobId and je.ServiceId = @ServiceId and je.Active = 'Y' and e.PlantAreaId = @PlantAreaId 
), JECount as
(
 select Count(*)as TotalMachineCount from JECTE
 )
Select  je.PlantAreaId,dbo.GetNameTranslated(je.PlantAreaId,@LanguageId,'PlantAreaName') as PlantAreaName,
je.ConditionId,dbo.GetLookupTranslated(je.ConditionId,@LanguageId,'LookupCode')ConditionCode,dbo.GetConditionCodeTranslated(je.ConditionId,je.ClientSiteId,@LanguageId,'ConditionName')ConditionName, count(*) MachineCount, 
min(jc.TotalMachineCount)as TotalMachineCount , ( count(*) * 100/min(jc.TotalMachineCount) ) CountPct
from JECTE je cross join JECount jc
Group by  Clientsiteid,plantareaid, conditionid 

END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveAppConfiguration]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   PROCEDURE [dbo].[EAppSaveAppConfiguration] @AppConfigId INT 
	,@AppConfigCode  VARCHAR(50) 
	,@AppConfigName VARCHAR(150) 
	,@AppConfigValue VARCHAR(150)
	,@Descriptions VARCHAR(250)
	,@Active VARCHAR(1)
	,@UserId INT 
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
		MERGE [dbo].[ApplicationConfiguration] AS [target]
		USING (
			SELECT @AppConfigId
			) AS source(AppConfigId)
			ON ([target].[AppConfigId] = [source].[AppConfigId])
		WHEN MATCHED
			THEN
				UPDATE
				SET AppConfigCode = @AppConfigCode
					,AppConfigName = @AppConfigName
					,AppConfigValue = @AppConfigValue
					,Descriptions = @Descriptions
					,Active = @Active
					,CreatedBy = @UserId 
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					AppConfigCode
					,AppConfigName
					,AppConfigValue
					,Descriptions
					,Active
					,CreatedBy 
					)
				VALUES (
					@AppConfigCode
					,@AppConfigName
					,@AppConfigValue
					,@Descriptions
					,@Active
					,@UserId
					);

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveArea]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppSaveArea] @AreaId INT
	,@PlantAreaId INT
	,@LanguageId INT
	,@AreaName NVARCHAR(150)
	,@Descriptions NVARCHAR(150)
	,@Active VARCHAR(1)
	,@UserId INT
	,@ReturnKey int
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
		DECLARE @Created TABLE (
			[AreaId] INT
			,PRIMARY KEY ([AreaId])
			);

		MERGE [dbo].[Area] AS [target]
		USING (
			SELECT @AreaId
				,@LanguageId
				,@UserId
			) AS source(AreaId, LanguageId, Userid)
			ON ([target].[AreaId] = [source].[AreaId])
		WHEN MATCHED
			THEN
				UPDATE
				SET PlantAreaId = @PlantAreaId
					,Active = @Active
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					PlantAreaId
					,AreaLanguageId
					,Active
					,CreatedBy
					)
				VALUES (
					@PlantAreaId
					,@LanguageId
					,@Active
					,@UserId
					)
		OUTPUT INSERTED.[AreaId]
		INTO @Created;

		SELECT @AreaId = (
				SELECT AreaId
				FROM @Created
				)

		MERGE [dbo].[AreaTranslated] AS [target]
		USING (
			SELECT @AreaId
				,@LanguageId
				,@AreaName
				,@Descriptions
				,@UserId
			) AS source(AreaId, LanguageId, AreaName, Descriptions, Userid)
			ON ([target].[AreaId] = [source].[AreaId])
				AND [TARGET].LanguageId = @LanguageId
		WHEN MATCHED
			THEN
				UPDATE
				SET AreaName = @AreaName
					,Descriptions = @Descriptions
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					AreaId
					,LanguageId
					,Areaname
					,Descriptions
					,CreatedBy
					)
				VALUES (
					@AreaId
					,@LanguageId
					,@AreaName
					,@Descriptions
					,@UserId
					);

		COMMIT TRANSACTION
		if isnull(@ReturnKey,0) = 1 
		Begin
			SELECT AreaId as AreaId FROM @Created;
		End
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveAssetCategory]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppSaveAssetCategory] @AssetCategoryId INT
	,@LanguageId INT
	,@AssetCategoryCode VARCHAR(5)
	,@AssetCategoryName NVARCHAR(150)
	,@Descriptions NVARCHAR(150)
	,@Active VARCHAR(1)
	,@UserId INT
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
		DECLARE @Created TABLE (
			[AssetCategoryId] INT
			,PRIMARY KEY ([AssetCategoryId])
			);

		MERGE [dbo].[AssetCategory] AS [target]
		USING (
			SELECT @AssetCategoryId
			) AS source(AssetCategoryId)
			ON ([target].[AssetCategoryId] = [source].[AssetCategoryId])
		WHEN MATCHED
			THEN
				UPDATE
				SET AssetCategoryCode = @AssetCategoryCode
					,Active = @Active
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					AssetCategoryCode
					,CreatedLanguageId
					,Active
					,CreatedBy
					)
				VALUES (
					@AssetCategoryCode
					,@Languageid
					,@Active
					,@UserId
					)
				OUTPUT INSERTED.[AssetCategoryId]
				INTO @Created;

		SELECT @AssetCategoryId = (
				SELECT AssetCategoryId
				FROM @Created
				)

		MERGE [dbo].[AssetCategoryTranslated] AS [target]
		USING (
			SELECT @AssetCategoryId
				,@LanguageId
			) AS source(AssetCategoryId, LanguageId)
			ON ([target].[AssetCategoryId] = [source].[AssetCategoryId])
				AND [TARGET].LanguageId = @LanguageId
		WHEN MATCHED
			THEN
				UPDATE
				SET AssetCategoryName = @AssetCategoryName
					,Descriptions = @Descriptions
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					AssetCategoryId
					,LanguageId
					,AssetCategoryname
					,Descriptions
					,CreatedBy
					)
				VALUES (
					@AssetCategoryId
					,@Languageid
					,@AssetCategoryName
					,@Descriptions
					,@UserId
					);

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveAssetCategoryClassRelation]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- [AssetCategoryClassRelation] 
 -- [AssetTypeClassRelation]
CREATE   PROCEDURE [dbo].[EAppSaveAssetCategoryClassRelation] @AssetClassId INT
	,@AssetCategoryId INT
	,@Active VARCHAR(1)
	,@UserId INT
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
		MERGE [dbo].[AssetCategoryClassRelation] AS [target]
		USING (
			SELECT @AssetClassId
				,@AssetCategoryId
			) AS source(AssetClassId, AssetCategoryId)
			ON ([target].[AssetClassId] = [source].[AssetClassId])
				AND ([target].[AssetCategoryId] = [source].[AssetCategoryId])
		WHEN MATCHED
			THEN
				UPDATE
				SET Active = @Active
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					AssetClassId
					,AssetCategoryId
					,Active
					,CreatedBy
					)
				VALUES (
					@AssetClassId
					,@AssetCategoryId
					,@Active
					,@UserId
					);

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveAssetClass]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppSaveAssetClass] @AssetClassId INT
	,@LanguageId INT
	,@AssetClassCode VARCHAR(5)
	,@AssetClassName NVARCHAR(150)
	,@Descriptions NVARCHAR(150)
	,@Active VARCHAR(1)
	,@UserId INT
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
		DECLARE @Created TABLE (
			[AssetClassId] INT
			,PRIMARY KEY ([AssetClassId])
			);

		MERGE [dbo].[AssetClass] AS [target]
		USING (
			SELECT @AssetClassId
			) AS source(AssetClassId)
			ON ([target].[AssetClassId] = [source].[AssetClassId])
		WHEN MATCHED
			THEN
				UPDATE
				SET AssetClassCode = @AssetClassCode
					,Active = @Active
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					AssetClassCode
					,CreatedLanguageId
					,Active
					,CreatedBy
					)
				VALUES (
					@AssetClassCode
					,@Languageid
					,@Active
					,@UserId
					)
				OUTPUT INSERTED.[AssetClassId]
				INTO @Created;

		SELECT @AssetClassId = (
				SELECT AssetClassId
				FROM @Created
				)

		MERGE [dbo].[AssetClassTranslated] AS [target]
		USING (
			SELECT @AssetClassId
				,@LanguageId
			) AS source(AssetClassId, LanguageId)
			ON ([target].[AssetClassId] = [source].[AssetClassId])
				AND [TARGET].LanguageId = @LanguageId
		WHEN MATCHED
			THEN
				UPDATE
				SET AssetClassName = @AssetClassName
					,Descriptions = @Descriptions
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					AssetClassId
					,LanguageId
					,AssetClassname
					,Descriptions
					,CreatedBy
					)
				VALUES (
					@AssetClassId
					,@Languageid
					,@AssetClassName
					,@Descriptions
					,@UserId
					);

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveAssetClassIndustryRelation]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 -- [AssetClassIndustryRelation]
 -- [AssetCategoryClassRelation] 
 -- [AssetTypeClassRelation]
CREATE   PROCEDURE [dbo].[EAppSaveAssetClassIndustryRelation] @AssetClassId INT
	,@IndustryId INT
	,@Active VARCHAR(1)
	,@UserId INT
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
		MERGE [dbo].[AssetClassIndustryRelation] AS [target]
		USING (
			SELECT @AssetClassId
				,@IndustryId
			) AS source(AssetClassId, IndustryId)
			ON ([target].[AssetClassId] = [source].[AssetClassId])
				AND ([target].[IndustryId] = [source].[IndustryId])
		WHEN MATCHED
			THEN
				UPDATE
				SET Active = @Active
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					AssetClassId
					,IndustryId
					,Active
					,CreatedBy
					)
				VALUES (
					@AssetClassId
					,@IndustryId
					,@Active
					,@UserId
					);

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveAssetSequence]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppSaveAssetSequence] @AssetSequenceId INT
	,@LanguageId INT
	,@AssetTypeId Int
	,@AssetSequenceCode VARCHAR(5)
	,@AssetSequenceName NVARCHAR(150)
	,@Descriptions NVARCHAR(150)
	,@Active VARCHAR(1)
	,@UserId INT
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
		DECLARE @Created TABLE (
			[AssetSequenceId] INT
			,PRIMARY KEY ([AssetSequenceId])
			);

		MERGE [dbo].[AssetSequence] AS [target]
		USING (
			SELECT @AssetSequenceId, @AssetTypeId
			) AS source(AssetSequenceId, AssetTypeId)
			ON ([target].[AssetSequenceId] = [source].[AssetSequenceId])
			and ([target].[AssetTypeId] = [source].[AssetTypeId])
		WHEN MATCHED
			THEN
				UPDATE
				SET AssetSequenceCode = @AssetSequenceCode
					,Active = @Active
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					AssetSequenceCode
					,AssetTypeId
					,CreatedLanguageId
					,Active
					,CreatedBy
					)
				VALUES (
					@AssetSequenceCode
					,@AssetTypeId
					,@Languageid
					,@Active
					,@UserId
					)
				OUTPUT INSERTED.[AssetSequenceId]
				INTO @Created;

		SELECT @AssetSequenceId = (
				SELECT AssetSequenceId
				FROM @Created
				)

		MERGE [dbo].[AssetSequenceTranslated] AS [target]
		USING (
			SELECT @AssetSequenceId
				,@LanguageId
			) AS source(AssetSequenceId, LanguageId)
			ON ([target].[AssetSequenceId] = [source].[AssetSequenceId])
				AND [TARGET].LanguageId = @LanguageId
		WHEN MATCHED
			THEN
				UPDATE
				SET AssetSequenceName = @AssetSequenceName
					,Descriptions = @Descriptions
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					AssetSequenceId
					,LanguageId
					,AssetSequencename
					,Descriptions
					,CreatedBy
					)
				VALUES (
					@AssetSequenceId
					,@Languageid
					,@AssetSequenceName
					,@Descriptions
					,@UserId
					);

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveAssetType]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppSaveAssetType] @AssetTypeId INT
	,@LanguageId INT
	,@AssetTypeCode VARCHAR(5)
	,@AssetTypeName NVARCHAR(150)
	,@Descriptions NVARCHAR(150)
	,@Active VARCHAR(1)
	,@UserId INT
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
		DECLARE @Created TABLE (
			[AssetTypeId] INT
			,PRIMARY KEY ([AssetTypeId])
			);

		MERGE [dbo].[AssetType] AS [target]
		USING (
			SELECT @AssetTypeId
			) AS source(AssetTypeId)
			ON ([target].[AssetTypeId] = [source].[AssetTypeId])
		WHEN MATCHED
			THEN
				UPDATE
				SET AssetTypeCode = @AssetTypeCode
					,Active = @Active
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					AssetTypeCode
					,CreatedLanguageId
					,Active
					,CreatedBy
					)
				VALUES (
					@AssetTypeCode
					,@Languageid
					,@Active
					,@UserId
					)
				OUTPUT INSERTED.[AssetTypeId]
				INTO @Created;

		SELECT @AssetTypeId = (
				SELECT AssetTypeId
				FROM @Created
				)

		MERGE [dbo].[AssetTypeTranslated] AS [target]
		USING (
			SELECT @AssetTypeId
				,@LanguageId
			) AS source(AssetTypeId, LanguageId)
			ON ([target].[AssetTypeId] = [source].[AssetTypeId])
				AND [TARGET].LanguageId = @LanguageId
		WHEN MATCHED
			THEN
				UPDATE
				SET AssetTypeName = @AssetTypeName
					,Descriptions = @Descriptions
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					AssetTypeId
					,LanguageId
					,AssetTypename
					,Descriptions
					,CreatedBy
					)
				VALUES (
					@AssetTypeId
					,@Languageid
					,@AssetTypeName
					,@Descriptions
					,@UserId
					);

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveAssetTypeClassRelation]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- [AssetTypeClassRelation]
CREATE   PROCEDURE [dbo].[EAppSaveAssetTypeClassRelation] @AssetClassId INT
	,@AssetTypeId INT
	,@Active VARCHAR(1)
	,@UserId INT
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
		MERGE [dbo].[AssetTypeClassRelation] AS [target]
		USING (
			SELECT @AssetClassId
				,@AssetTypeId
			) AS source(AssetClassId, AssetTypeId)
			ON ([target].[AssetClassId] = [source].[AssetClassId])
				AND ([target].[AssetTypeId] = [source].[AssetTypeId])
		WHEN MATCHED
			THEN
				UPDATE
				SET Active = @Active
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					AssetClassId
					,AssetTypeId
					,Active
					,CreatedBy
					)
				VALUES (
					@AssetClassId
					,@AssetTypeId
					,@Active
					,@UserId
					);

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveAssignUser]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppSaveAssignUser]
	 @Type Varchar(30)
	,@Id Bigint  
	,@DataCollectionMode int
	,@DataCollectorId int
	,@AnalystId int 
	,@ReviewerId int
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
	Declare @JobId bigint
		Select @DataCollectorId = case when @DataCollectorId = 0 then null else @DataCollectorId End ,
		@AnalystId = case when @AnalystId = 0 then null else @AnalystId End ,
		@ReviewerId = case when @ReviewerId = 0 then null else @ReviewerId End
		
		If @Type = 'Job'
		Begin
			MERGE [dbo].[Jobs] AS [target] 
			USING (
				SELECT @Id 
				) AS source(JobId)
				ON ([target].[JobId] = [source].[JobId])
			WHEN MATCHED
				THEN 
					UPDATE 
					SET   
					 DataCollectorId = isnull(@DataCollectorId,DataCollectorId)
					 ,DataCollectionMode = isnull(@DataCollectionMode,DataCollectionMode)
					 ,AnalystId = isnull(@AnalystId,AnalystId)
					 ,ReviewerId = isnull(@ReviewerId,ReviewerId)
					 ,DataCollectionDone = case when isnull(@DataCollectionMode,0) = 1 then 'Y' else DataCollectionDone end
					 ;
			Update JobEquipment set DatacollectionDone = case when isnull(@DataCollectionMode,0) = 1 then 1 else DataCollectionDone end,
			DataCollectorId = case when isnull(@DataCollectionMode,0) = 1 then null else DataCollectorId end	where jobid = @Id 
			Update JobEquipment set AnalystId = @AnalystId where jobid = @Id and AnalystId  is null
			Update JobEquipment set DataCollectorId = @DataCollectorId where jobid = @Id and DataCollectorId  is null 
			Update JobEquipment set ReviewerId = @ReviewerId where jobid = @Id and ReviewerId  is null 
		End
		Else If @Type = 'Equipment'
		Begin
			MERGE [dbo].[JobEquipment] AS [target] 
			USING (
				SELECT @Id 
				) AS source(JobEquipmentId)
				ON ([target].[JobEquipmentId] = [source].[JobEquipmentId])
			WHEN MATCHED
				THEN 
					UPDATE 
					SET     
					 DataCollectorId = isnull(@DataCollectorId,DataCollectorId)
					 ,AnalystId = isnull(@AnalystId,AnalystId)
					 ,ReviewerId = isnull(@ReviewerId,ReviewerId)
					 ;
				select @JobId = JobId from JobEquipment where JobEquipmentId =@Id;
				if isnull(@JobId,0) > 0
				Begin
					update jobs set DataCollectorId = isnull(DataCollectorId,@DataCollectorId),
								AnalystId = isnull(AnalystId,@AnalystId),
								ReviewerId = isnull(ReviewerId, @ReviewerId),
								DataCollectionMode = isnull(@DataCollectionMode,DataCollectionMode)
					where JobId = @JobId	
					select * From JobEquipment
				End

		End

	
	COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveAuditLog]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EAppSaveAuditLog]  
	 @HostIP Varchar(50)
	,@SessionId varchar(300)  
	,@IsForceLogOut varchar(1)  
	,@CurrentPage nvarchar(250)
	,@Activity nvarchar(250) 
	,@UserId int 
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
	Declare @Active varchar(1), @AuditLogHeaderId Bigint  ,@CountryId Int, @CostCentreId  Int, @ClientSiteId int
	
	   select  @Active = case when isnull(@CurrentPage,'N') = 'Logout' then 'N' else 'Y' end
	 
		MERGE [dbo].[AuditLogHeader] AS [target]
		USING (
			SELECT 
			 @HostIP 
			,@SessionId 
			,@UserId 
			) AS source(HostIP ,SessionId ,UserId )
			ON ([target].[UserId] = [source].[UserId]
			and [target].[SessionId] = [source].[SessionId]
			and [target].[HostIP] = [source].[HostIP]
			)
		WHEN MATCHED
			THEN
				UPDATE
				SET  Active = @Active 
				,IsForceLogOut = @IsForceLogOut
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
				  HostIP 
				, SessionId 
				, UserId 
				, Active
				, IsForceLogOut
					)
				VALUES (
				 @HostIP 
				,@SessionId 
				,@UserId 
				,@Active
				,isnull(@IsForceLogOut,'N')
					);
  
			Select @AuditLogHeaderId = AuditLogHeaderId, @ClientSiteId = ClientSiteId  from AuditLogHeader
			where [UserId] = @UserId 
			and  [SessionId] = @SessionId 
			and  [HostIP] = @HostIP 
	if isnull(@ClientSiteId,0) = 0 
	Begin
		Select @ClientSiteId = LastSessionClient from users where userid = @UserId
		Select @CountryId = CountryId , @CostCentreId = CostCentreId From ClientSite Where ClientSiteId = @ClientSiteId
		update AuditLogHeader set CountryId = @CountryId, CostCentreId = @CostCentreId, ClientSiteId = @ClientSiteId where AuditLogHeaderId = @AuditLogHeaderId
	End  
	if isnull(@CountryId,0)=0 
	Begin
		Select @CountryId = CountryId , @CostCentreId = CostCentreId From ClientSite Where ClientSiteId = @ClientSiteId
	End

	if isnull(@AuditLogHeaderId,0)>0
	Begin
				INSERT into AuditLogDetail (
					AuditLogHeaderId
					,UserId
					,ClientSiteId
					,CurrentPage
					,Activity 
					,CountryId
					,CostCentreId 
					)
				VALUES (
					@AuditLogHeaderId
					,@UserId
					,@ClientSiteId
					,@CurrentPage
					,@Activity 
					,@CountryId
					,@CostCentreId 
					);
	End
		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveBearings]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppSaveBearings] @BearingId INT
	,@LanguageId INT
	,@ManufacturerId INT
	,@BearingCode VARCHAR(50)
	,@BearingName NVARCHAR(150)
	,@Descriptions NVARCHAR(150)
	,@Active VARCHAR(1)
	,@UserId INT
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
		DECLARE @Created TABLE (
			[BearingId] INT
			,PRIMARY KEY ([BearingId])
			);

		MERGE [dbo].[Bearings] AS [target]
		USING (
			SELECT @BearingId 
			) AS source(BearingId)
			ON ([target].[BearingId] = [source].[BearingId])
		WHEN MATCHED
			THEN
				UPDATE
				SET BearingCode = @BearingCode, ManufacturerId = @ManufacturerId
					,Active = @Active
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					BearingCode
					,ManufacturerId
					,CreatedLanguageId
					,Active
					,CreatedBy
					)
				VALUES (
					@BearingCode
					,@ManufacturerId
					,@Languageid
					,@Active
					,@UserId
					)
				OUTPUT INSERTED.[BearingId]
				INTO @Created;

		SELECT @BearingId = (
				SELECT BearingId
				FROM @Created
				)

		MERGE [dbo].[BearingTranslated] AS [target]
		USING (
			SELECT @BearingId
				,@LanguageId
			) AS source(BearingId, LanguageId)
			ON ([target].[BearingId] = [source].[BearingId])
				AND [TARGET].LanguageId = @LanguageId
		WHEN MATCHED
			THEN
				UPDATE
				SET BearingName = @BearingName
					,Descriptions = @Descriptions
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					BearingId
					,LanguageId
					,BearingName
					,Descriptions
					,CreatedBy
					)
				VALUES (
					@BearingId
					,@Languageid
					,@BearingName
					,@Descriptions
					,@UserId
					);

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveClient]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppSaveClient] @ClientId INT
	,@LanguageId INT
	,@ClientName NVARCHAR(150)
	,@ClientStatus INT
	,@UserId INT
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY 
	if @ClientStatus = 0 
		set @ClientStatus = dbo.GetStatusId(@LanguageId,'ClientStatus','A') 
		DECLARE @Created TABLE (
			[ClientId] INT
			,PRIMARY KEY ([ClientId])
			);

		MERGE [dbo].[Client] AS [target]
		USING (
			SELECT @ClientId
				,@LanguageId
				,@UserId
			) AS source(ClientId, LanguageId, Userid)
			ON ([target].[ClientId] = [source].[ClientId])
		WHEN MATCHED
			THEN
				UPDATE
				SET ClientStatus = @ClientStatus
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					ClientStatus
					,CreatedLanguageId
					,CreatedBy
					)
				VALUES (
					 @ClientStatus 
					,@Languageid
					,@UserId
					)
				OUTPUT INSERTED.[ClientId]
				INTO @Created;

		SELECT @ClientId = ClientId
		FROM @Created;

		MERGE [dbo].[ClientTranslated] AS [target]
		USING (
			SELECT @ClientId
				,@LanguageId
				,@ClientName
				,@UserId
			) AS source(ClientId, LanguageId, ClientName, Userid)
			ON ([target].[ClientId] = [source].[ClientId])
				AND [TARGET].LanguageId = @LanguageId
		WHEN MATCHED
			THEN
				UPDATE
				SET ClientName = @ClientName
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					ClientId
					,ClientName
					,LanguageId
					,CreatedBy
					)
				VALUES (
					@ClientId
					,@ClientName
					,@Languageid
					,@UserId
					);

		COMMIT TRANSACTION

		SELECT ClientId as ClientId FROM @Created;
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveClientDocAttachments]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
Create   PROCEDURE [dbo].[EAppSaveClientDocAttachments] 
	 @ClientDocAttachId INT
	,@ClientSiteId int 
	,@FileName nVarchar(150)
	,@FileDescription nVarchar(250)
	,@LogicalName VARCHAR(500)
	,@PhysicalPath VARCHAR(500)
	,@Active VARCHAR(1)
	,@UserId INT
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
 
	MERGE [dbo].[ClientDocAttachment] AS [target]
		USING (
			SELECT @ClientDocAttachId 
			) AS source(ClientDocAttachId)
			ON ([target].[ClientDocAttachId] = [source].[ClientDocAttachId])
		WHEN MATCHED
			THEN
				UPDATE
				SET Active = @Active
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
				 ClientSiteId
				,FileName
				,FileDescription
				,LogicalName
				,PhysicalPath
				,Active
				,CreatedBy
					)
				VALUES (
				 @ClientSiteId
				,@FileName
				,@FileDescription
				,@LogicalName
				,@PhysicalPath
				,@Active
				,@UserId);
	 

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveClientSite]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppSaveClientSite] @ClientSiteId INT
	,@ClientId INT
	,@InternalRefId NVARCHAR(150)
	,@IndustryId INT
	,@CountryId INT
	,@CostCentreId INT
	,@LanguageId INT
	,@SiteName NVARCHAR(150)
	,@Address1 NVARCHAR(50)
	,@Address2 NVARCHAR(50)
	,@CIty NVARCHAR(50)
	,@Statename NVARCHAR(40)
	,@POBox NVARCHAR(40)
	,@Zip NVARCHAR(30)
	,@Phone NVARCHAR(30)
	,@ClientSiteStatus INT
	,@UserId INT
	,@Email NVARCHAR(150)
	,@Logo VARCHAR(250)
	,@SiebelId VARCHAR(75)
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY

		if  @ClientSiteStatus = 0 
		set @ClientSiteStatus = dbo.GetStatusId(@LanguageId,'ClientSiteStatus','A') 

		DECLARE @Created TABLE (
			[ClientSiteId] INT
			,PRIMARY KEY ([ClientSiteId])
			);

		MERGE [dbo].[ClientSite] AS [target]
		USING (
			SELECT @ClientSiteId
			) AS source(ClientSiteId)
			ON ([target].[ClientSiteId] = [source].[ClientSiteId])
		WHEN MATCHED
			THEN
				UPDATE
				SET ClientId = @ClientId
					,CountryId = @CountryId
					,CostCentreid = @CostCentreId
					,IndustryId = @Industryid
					,ClientSiteStatus = @ClientSiteStatus
					,InternalRefId = @InternalRefId
					,POBox = @POBox
					,Zip = @Zip
					,Phone = @Phone
					,Email = @Email
					,Logo = @Logo
					,SiebelId = @SiebelId
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					ClientSiteStatus
					,ClientId
					,CountryId
					,CostCentreId
					,IndustryId
					,InternalRefId
					,POBox
					,Zip
					,Phone
					,Email
					,Logo
					,SiebelId
					,CreatedLanguageId
					,CreatedBy
					)
				VALUES (
					@ClientSiteStatus
					,@ClientId
					,@CountryId
					,@CostCentreId
					,@IndustryId
					,@InternalRefId
					,@POBox
					,@Zip
					,@Phone
					,@Email
					,@Logo
					,@SiebelId
					,@Languageid
					,@UserId
					)
		OUTPUT INSERTED.[ClientSiteId]
		INTO @Created;

		SELECT @ClientSiteId = ClientSiteId
		FROM @Created;

		MERGE [dbo].[ClientSiteTranslated] AS [target]
		USING (
			SELECT @ClientSiteid
				,@LanguageId
			) AS source(ClientSiteid, LanguageId)
			ON ([target].[ClientSiteId] = [source].[ClientSiteId])
				AND [TARGET].LanguageId = @LanguageId
		WHEN MATCHED
			THEN
				UPDATE
				SET SiteName = @SiteName
					,Address1 = @Address1
					,Address2 = @Address2
					,City = @City
					,Statename = @StateName
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					ClientSiteId
					,SiteName
					,Address1
					,Address2
					,CIty
					,Statename
					,LanguageId
					,CreatedBy
					)
				VALUES (
					@ClientSiteId
					,@SiteName
					,@Address1
					,@Address2
					,@CIty
					,@Statename
					,@Languageid
					,@UserId
					);

		COMMIT TRANSACTION
		SELECT ClientSiteId FROM @Created;
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveClientSiteConfiguration]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppSaveClientSiteConfiguration] @ClientSiteConfigId INT 
	,@ClientSiteId  INT 
	,@ConfigId Int 
	,@ClientSiteConfigValue VARCHAR(150)  
	,@UserId INT 
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
		MERGE [dbo].[ClientSiteConfiguration] AS [target]
		USING (
			SELECT @ClientSiteConfigId
			) AS source(ClientSiteConfigId)
			ON ([target].[ClientSiteConfigId] = [source].[ClientSiteConfigId])
		WHEN MATCHED
			THEN
				UPDATE
				SET ClientSiteConfigValue = @ClientSiteConfigValue 
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					 ClientSiteId
					,ConfigId 
					,ClientSiteConfigValue 
					,CreatedBy 
					)
				VALUES (
					 @ClientSiteId
					,@ConfigId 
					,@ClientSiteConfigValue 
					,@UserId 
					);

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveClientUserAccess]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppSaveClientUserAccess] 
	@LoginUserId INT 
	,@UserId INT
	,@ClientSiteId INT
	,@Active VARCHAR(1)
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY 
	 
			MERGE [dbo].[UserClientSiteRelation] AS [target]
			USING (
				SELECT @ClientSiteId
					,@UserId
				) AS source(ClientSiteId, Userid)
				ON (
						[target].[ClientSiteId] = [source].[ClientSiteId]
						AND [target].[UserId] = [source].[UserId]
						)
			WHEN MATCHED
				THEN
					UPDATE
					SET Active = @Active
			WHEN NOT MATCHED BY TARGET
				THEN
					INSERT (
						UserId
						,ClientSiteId
						,Active
						,CreatedBy
						)
					VALUES (
						@UserId
						,@ClientSiteId
						,@Active
						,@LoginUserId
						);
 
		

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveCloneIdentifier]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppSaveCloneIdentifier] @Type varchar(30), @TId INT
	,@LanguageId INT
	,@TName nvarchar(250) 
	as
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
	if @Type = 'PL' 
	Begin
		MERGE [dbo].[PlantAreaTranslated] AS [target]
		USING (
			SELECT @TId
				,@LanguageId
			) AS source(TId, LanguageId)
			ON ([target].[PlantAreaTId] = [source].[TId])
				AND [TARGET].LanguageId = @LanguageId
		WHEN MATCHED
			THEN
				UPDATE
				SET PlantAreaName = @TName 
	 ;
	 End
	if @Type = 'EQ' 
	Begin
		MERGE [dbo].[Equipment] AS [target]
		USING (
			SELECT @TId 
			) AS source(TId)
			ON ([target].[EquipmentId] = [source].[TId]) 
		WHEN MATCHED
			THEN
				UPDATE
				SET EquipmentName = @TName 
	 ;
	 End
	if @Type = 'DR' 
	Begin
		MERGE [dbo].[EquipmentDriveUnit] AS [target]
		USING (
			SELECT @TId 
			) AS source(TId)
			ON ([target].[DriveUnitId] = [source].[TId]) 
		WHEN MATCHED
			THEN
				UPDATE
				SET IdentificationName = @TName 
	 ;
	 End
	if @Type = 'DN' 
	Begin
		MERGE [dbo].[EquipmentDrivenUnit] AS [target]
		USING (
			SELECT @TId 
			) AS source(TId)
			ON ([target].[DrivenUnitId] = [source].[TId]) 
		WHEN MATCHED
			THEN
				UPDATE
				SET IdentificationName = @TName 
	 ;
	 End
	if @Type = 'IN' 
	Begin
		MERGE [dbo].[EquipmentIntermediateUnit] AS [target]
		USING (
			SELECT @TId 
			) AS source(TId)
			ON ([target].[IntermediateUnitId] = [source].[TId]) 
		WHEN MATCHED
			THEN
				UPDATE
				SET IdentificationName = @TName 
	 ;
	 End


		COMMIT TRANSACTION
	 
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveConditionCodeClientMapping]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppSaveConditionCodeClientMapping] @CMappingId INT
	,@ClientSiteId INT
	,@ConditionId INT
	,@LanguageId INT
	,@ConditionName NVARCHAR(150)
	,@Descriptions NVARCHAR(250)
	,@UserId INT
	,@Active Varchar(1)
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
		DECLARE @Created TABLE (
			[CMappingId] INT
			,PRIMARY KEY ([CMappingId])
			);

		MERGE [dbo].[ConditionCodeClientMapping] AS [target]
		USING (
			SELECT @ClientSiteId
				,@ConditionId
			) AS source(ClientSiteId, ConditionId)
			ON [target].[ClientSiteId] = [source].[ClientSiteId]
				AND [target].[ConditionId] = [source].[ConditionId]
			WHEN MATCHED
			THEN
				UPDATE
				SET Active = @Active
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					ClientSiteId
					,ConditionId
					,CreatedLanguageId
					,CreatedBy
					)
				VALUES (
					@ClientSiteId
					,@ConditionId
					,@LanguageId
					,@UserId
					)
				OUTPUT INSERTED.[CMappingId]
				INTO @Created;

		SELECT @CMappingId = [CMappingId]
		FROM @Created;

		MERGE [dbo].ConditionCodeClientTranslated AS [target]
		USING (
			SELECT @CMappingId
				,@LanguageId
			) AS source(CMappingId, LanguageId)
			ON ([target].[CMappingId] = [source].[CMappingId])
				AND [TARGET].LanguageId = @LanguageId
		WHEN MATCHED
			THEN
				UPDATE
				SET ConditionName = @ConditionName
					,Descriptions = @Descriptions
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					CMappingId
					,LanguageId
					,ConditionName
					,Descriptions
					,CreatedBy
					)
				VALUES (
					@CMappingId
					,@Languageid
					,@ConditionName
					,@Descriptions
					,@UserId
					);

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveCostCentre]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppSaveCostCentre] @CountryId INT
	,@CostCentreId INT
	,@LanguageId INT
	,@CostCentreName NVARCHAR(150)
	,@CostCentreCode NVARCHAR(30)
	,@Descriptions NVARCHAR(150)
	,@Active VARCHAR(1)
	,@UserId INT
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
		DECLARE @Created TABLE (
			[CostCentreId] INT
			,PRIMARY KEY ([CostCentreId])
			);

		MERGE [dbo].[CostCentre] AS [target]
		USING (
			SELECT @CostCentreId
				,@LanguageId
				,@CostCentreCode
				,@Active
				,@UserId
			) AS source(CostcentreId, LanguageId, CostCentreCode, Active, Userid)
			ON ([target].[CostCentreId] = [source].[CostCentreId])
		WHEN MATCHED
			THEN
				UPDATE
				SET Active = @Active,
				   CountryId = @CountryId,
					CostCentreCode = @CostCentreCode
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					CountryId
					,CreatedLanguageId
					,CreatedBy
					,CostCentreCode
					)
				VALUES (
					@CountryId
					,@Languageid
					,@UserId
					,@CostCentreCode
					)
				OUTPUT INSERTED.[CostCentreId]
				INTO @Created;

		SELECT @CostCentreId = (
				SELECT CostCentreId
				FROM @Created
				)

		MERGE [dbo].[CostCentreTranslated] AS [target]
		USING (
			SELECT @CostCentreId
				,@LanguageId
				,@CostCentreName
				,@Descriptions
				,@Active
				,@UserId
			) AS source(CostcentreId, LanguageId, CostCentreName, Descriptions, Active, Userid)
			ON ([target].[CostCentreId] = [source].[CostCentreId])
				AND [TARGET].LanguageId = @LanguageId
		WHEN MATCHED
			THEN
				UPDATE
				SET CostCentreName = @CostCentreName
					,Descriptions = @Descriptions
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					CostCentreId
					,LanguageId
					,CostCentrename
					,Descriptions
					,CreatedBy
					)
				VALUES (
					@CostCentreId
					,@Languageid
					,@CostCentreName
					,@Descriptions
					,@UserId
					);

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveCountry]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppSaveCountry] @CountryId INT
	,@LanguageId INT
	,@CountryCode VARCHAR(5)
	,@CountryName NVARCHAR(150)
	,@Active VARCHAR(1)
	,@UserId INT
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
		DECLARE @Created TABLE (
			[CountryId] INT
			,PRIMARY KEY ([CountryId])
			);

		MERGE [dbo].[Country] AS [target]
		USING (
			SELECT @CountryId
				,@LanguageId
				,@UserId
			) AS source(CountryId, LanguageId, Userid)
			ON ([target].[CountryId] = [source].[CountryId])
		WHEN MATCHED
			THEN
				UPDATE
				SET Active = @Active
					,CountryCode = @CountryCode
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					CountryCode
					,CreatedLanguageId
					,CreatedBy
					)
				VALUES (
					@CountryCode
					,@Languageid
					,@UserId
					)
				OUTPUT INSERTED.[CountryId]
				INTO @Created;

		SELECT @CountryId = CountryId
		FROM @Created;

		MERGE [dbo].[CountryTranslated] AS [target]
		USING (
			SELECT @CountryId
				,@LanguageId
				,@CountryName
				,@UserId
			) AS source(CountryId, LanguageId, CountryName, Userid)
			ON ([target].[CountryId] = [source].[CountryId])
				AND [TARGET].LanguageId = @LanguageId
		WHEN MATCHED
			THEN
				UPDATE
				SET CountryName = @CountryName
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					CountryId
					,LanguageId
					,Countryname
					,CreatedBy
					)
				VALUES (
					@CountryId
					,@Languageid
					,@CountryName
					,@UserId
					);

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveEquipment]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppSaveEquipment] 
	 @EquipmentId INT
	,@PlantAreaId INT	  
	,@AreaId INT
	,@SystemId INT	
	,@EquipmentCode VARCHAR(5)
	,@EquipmentName NVARCHAR(150)
	,@Descriptions NVARCHAR(250)
	,@ListOrder INT 
	,@OrientationId INT 
	,@MountingId INT 
	,@StandByEquipId INT 
	,@Active VARCHAR(1)
	,@UserId INT
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
 
 		MERGE [dbo].[Equipment] AS [target]
		USING (
			SELECT @EquipmentId 
			) AS source(EquipmentId)
			ON ([target].[EquipmentId] = [source].[EquipmentId])
		WHEN MATCHED
			THEN
 
				UPDATE
				SET PlantAreaId = @PlantAreaId	 
				,AreaId=@AreaId
				,SystemId=@SystemId
				,EquipmentCode = @EquipmentCode
				,EquipmentName = @EquipmentName
				,Descriptions = @Descriptions
				,ListOrder = @ListOrder
				,OrientationId = @OrientationId
				,MountingId = @MountingId
				,StandByEquipId = @StandByEquipId
				,Active = @Active
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
				 PlantAreaId
				 ,AreaId
				 ,SystemId
				,EquipmentCode
				,EquipmentName
				,Descriptions
				,ListOrder
				,OrientationId
				,MountingId
				,StandByEquipId
				,Active
				,CreatedBy
					)
				VALUES (
				 @PlantAreaId
				 ,@AreaId
				 ,@SystemId
				,@EquipmentCode
				,@EquipmentName
				,@Descriptions
				,@ListOrder
				,@OrientationId
				,@MountingId
				,@StandByEquipId
				,@Active
				,@UserId
					)
				;
 

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveEquipmentAttachments]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppSaveEquipmentAttachments] 
	 @Type VARCHAR(250)
	,@TypeId INT
	,@AttachId INT
	,@FileName VARCHAR(500)
	,@LogicalName VARCHAR(500)
	,@PhysicalPath VARCHAR(500)
	,@Active VARCHAR(1)
	,@UserId INT
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY

	IF (@Type = 'Equipment')
	BEGIN
	MERGE [dbo].[EquipmentAttachments] AS [target]
		USING (
			SELECT @AttachId 
			) AS source(EquipmentAttachId)
			ON ([target].[EquipmentAttachId] = [source].[EquipmentAttachId])
		WHEN MATCHED
			THEN
				UPDATE
				SET Active = @Active
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
				 EquipmentId
				,FileName
				,LogicalName
				,PhysicalPath
				,Active
				,CreatedBy
					)
				VALUES (
				 @TypeId
				,@FileName
				,@LogicalName
				,@PhysicalPath
				,@Active
				,@UserId);
	END

	ELSE IF (@Type = 'Drive')
	BEGIN
		MERGE [dbo].[DriveAttachments] AS [target]
		USING (
			SELECT @AttachId 
			) AS source(DriveAttachId)
			ON ([target].[DriveAttachId] = [source].[DriveAttachId])
		WHEN MATCHED
			THEN
				UPDATE
				SET Active = @Active
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
				 DriveUnitId
				,FileName
				,LogicalName
				,PhysicalPath
				,Active
				,CreatedBy
					)
				VALUES (
				 @TypeId
				,@FileName
				,@LogicalName
				,@PhysicalPath
				,@Active
				,@UserId);
	END

	ELSE IF (@Type = 'Intermediate')
	BEGIN
		MERGE [dbo].[IntermediateAttachments] AS [target]
		USING (
			SELECT @AttachId 
			) AS source(IntermediateAttachId)
			ON ([target].[IntermediateAttachId] = [source].[IntermediateAttachId])
		WHEN MATCHED
			THEN
				UPDATE
				SET Active = @Active
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
				 IntermediateUnitId
				,FileName
				,LogicalName
				,PhysicalPath
				,Active
				,CreatedBy
					)
				VALUES (
				 @TypeId
				,@FileName
				,@LogicalName
				,@PhysicalPath
				,@Active
				,@UserId);
	END

	ELSE IF (@Type = 'Driven')
	BEGIN
		MERGE [dbo].[DrivenAttachments] AS [target]
		USING (
			SELECT @AttachId 
			) AS source(DrivenAttachId)
			ON ([target].[DrivenAttachId] = [source].[DrivenAttachId])
		WHEN MATCHED
			THEN
				UPDATE
				SET Active = @Active
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
				 DrivenUnitId
				,FileName
				,LogicalName
				,PhysicalPath
				,Active
				,CreatedBy
					)
				VALUES (
				 @TypeId
				,@FileName
				,@LogicalName
				,@PhysicalPath
				,@Active
				,@UserId);
	END

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveEquipmentDrivenUnit]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 CREATE   PROCEDURE [dbo].[EAppSaveEquipmentDrivenUnit] 
	@DrivenUnitId int 
	,@EquipmentId int 
	,@AssetId int  
	,@IdentificationName nvarchar(150) 
	,@ListOrder int 
	,@ManufacturerId int 
	,@MaxRPM nvarchar(100) 
	,@Capacity nvarchar(100) 
	,@Model nvarchar(100) 
	,@Lubrication nvarchar(100) 
	,@SerialNumber nvarchar(100) 
	,@RatedFlowGPM nvarchar(100) 
	,@PumpEfficiency nvarchar(100) 
	,@RatedSuctionPressure nvarchar(100) 
	,@Efficiency nvarchar(100) 
	,@RatedDischargePressure nvarchar(100) 
	,@CostPerUnit nvarchar(100)  
	,@ImpellerVanes nvarchar(100) 
	,@ImpellerVanesKW nvarchar(100) 
	,@Stages nvarchar(100)  
	,@NumberOfPistons nvarchar(100) 
	,@PumpType nvarchar(100) 
	,@MeanRepairManHours decimal(15, 4) 
	,@DownTimeCostPerHour decimal(15, 4) 
	,@CostToRepair decimal(15, 4) 
	,@MeanFailureRate decimal(15, 4) 
	,@ReportServicesJson nvarchar(max)
	,@DEBearingJson nvarchar(max)
	,@NDEBearingJson nvarchar(max)
	,@Active VARCHAR(1)
	,@UserId INT
	,@ManufactureYear int
	,@FirstInstallationDate date
	,@OperationModeId int
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
  		DECLARE @Created TABLE (
			[DrivenUnitId] INT
			,PRIMARY KEY ([DrivenUnitId])
			);

 		MERGE [dbo].[EquipmentDrivenUnit] AS [target]
		USING (
			SELECT @DrivenUnitId 
			) AS source(DrivenUnitId)
			ON ([target].[DrivenUnitId] = [source].[DrivenUnitId])
		WHEN MATCHED
			THEN
 
				UPDATE
				SET AssetId = @AssetId,
				IdentificationName = @IdentificationName,
				ListOrder = @ListOrder
				,ManufacturerId = @ManufacturerId
				,MaxRPM = @MaxRPM
				,Capacity = @Capacity
				,Model = @Model
				,Lubrication = @Lubrication
				,SerialNumber = @SerialNumber
				,RatedFlowGPM = @RatedFlowGPM
				,PumpEfficiency = @PumpEfficiency
				,RatedSuctionPressure = @RatedSuctionPressure
				,Efficiency  = @Efficiency
				,RatedDischargePressure = @RatedDischargePressure
				,CostPerUnit = @CostPerUnit 
				,ImpellerVanes = @ImpellerVanes
				,ImpellerVanesKW = @ImpellerVanesKW
				,Stages = @Stages
				,NumberOfPistons = @NumberOfPistons
				,PumpType = @PumpType
				,MeanRepairManHours = @MeanRepairManHours
				,DownTimeCostPerHour = @DownTimeCostPerHour
				,CostToRepair = @CostToRepair
				,MeanFailureRate  = @MeanFailureRate
				,Active = @Active
				,ManufactureYear = @ManufactureYear
				,FirstInstallationDate = @FirstInstallationDate
				,OperationModeId = @OperationModeId
					WHEN NOT MATCHED BY TARGET
			THEN
				INSERT ( 
				 EquipmentId
				,AssetId 
				,IdentificationName
				,ListOrder
				,ManufacturerId
				,MaxRPM
				,Capacity
				,Model
				,Lubrication
				,SerialNumber
				,RatedFlowGPM 
				,PumpEfficiency 
				,RatedSuctionPressure
				,Efficiency
				,RatedDischargePressure
				,CostPerUnit  
				,ImpellerVanes 
				,ImpellerVanesKW  
				,Stages 
				,NumberOfPistons  
				,PumpType  
				,MeanRepairManHours 
				,DownTimeCostPerHour 
				,CostToRepair 
				,MeanFailureRate 
				,Active 
				,CreatedBy
				,ManufactureYear
				,FirstInstallationDate
				,OperationModeId
					)
				VALUES ( 
				@EquipmentId
				,@AssetId 
				,@IdentificationName
				,@ListOrder
				,@ManufacturerId
				,@MaxRPM
				,@Capacity
				,@Model
				,@Lubrication
				,@SerialNumber
				,@RatedFlowGPM 
				,@PumpEfficiency 
				,@RatedSuctionPressure
				,@Efficiency
				,@RatedDischargePressure
				,@CostPerUnit  
				,@ImpellerVanes 
				,@ImpellerVanesKW  
				,@Stages 
				,@NumberOfPistons  
				,@PumpType  
				,@MeanRepairManHours 
				,@DownTimeCostPerHour 
				,@CostToRepair 
				,@MeanFailureRate 
				,@Active  
				,@UserId
				,@ManufactureYear
				,@FirstInstallationDate
				,@OperationModeId
					) OUTPUT INSERTED.DrivenUnitId
				INTO @Created ;
			    
				SELECT @DrivenUnitId = [DrivenUnitId]
				FROM @Created; 
 ---- Process Start Report Service------
	DECLARE @DrivenServiceId int, @ReportId int, @JActive varchar(1) 
	
	DROP TABLE IF EXISTS #LoadJson

	CREATE TABLE #LoadJson
	(
	  LoaderId int not null identity(1,1),
	  DrivenServiceId int, 
	  ReportId int,
	  Active varchar(1) 
	) 

Insert into #LoadJson (DrivenServiceId,ReportId,Active)
SELECT
    JSON_Value (c.value, '$.UnitServiceId') as DrivenServiceId, 
	JSON_Value (c.value, '$.ServiceId') as ReportId, 
	JSON_Value (c.value, '$.Active') as Active  
FROM OPENJSON ( @ReportServicesJson ) as c 
 
  
DECLARE GetIdCur CURSOR READ_ONLY
    FOR
    SELECT DrivenServiceId,ReportId,Active
	from #LoadJson  

    OPEN GetIdCur
    FETCH NEXT FROM GetIdCur INTO
    @DrivenServiceId, @ReportId, @JActive
    WHILE @@FETCH_STATUS = 0
		BEGIN
		 	MERGE [dbo].[DrivenServices] AS [target]
			USING (
				SELECT @DrivenUnitId,@ReportId 
				) AS source(DrivenUnitId,ReportId)
				ON ([target].[DrivenUnitId] = [source].[DrivenUnitId] and [target].[ReportId] = [source].[ReportId])
			WHEN MATCHED
				THEN 
					UPDATE
					SET Active = @JActive
			WHEN NOT MATCHED BY TARGET
					THEN
						INSERT (  
						 DrivenUnitId
						,ReportId
						,Active
						,CreatedBy
							)
						VALUES ( 
						 @DrivenUnitId
						,@ReportId  
						,@JActive
						,@UserId
							)
						;
		FETCH NEXT FROM GetIdCur INTO	@DrivenServiceId,@ReportId,@JActive
		END
    CLOSE GetIdCur
    DEALLOCATE GetIdCur
 ---- Process End Report Service------

  ---- Process Start Bearing Drive End------
	DECLARE @BearingId int, @DEActive varchar(1),@DEManufacturerId int ,@DEPlace varchar(3)
	
	DROP TABLE IF EXISTS #LoadDEBearingJson

	CREATE TABLE #LoadDEBearingJson
	(
	  LoaderId int not null identity(1,1),
	  Place varchar(3), 
	  BearingId int,
	  ManufacturerId Int,
	  Active Varchar(1) 
	) 

Insert into #LoadDEBearingJson (BearingId,ManufacturerId,Active,Place)
SELECT
    JSON_Value (c.value, '$.BearingId') as BearingId,
	JSON_Value (c.value, '$.ManufacturerId') as ManufacturerId,   
	JSON_Value (c.value, '$.Active') as Active,
	'DE' as Place  
FROM OPENJSON ( @DEBearingJson ) as c 
 
DECLARE GetBeringDECur CURSOR READ_ONLY
    FOR
    SELECT BearingId,ManufacturerId,Active,Place
	from #LoadDEBearingJson  

    OPEN GetBeringDECur
    FETCH NEXT FROM GetBeringDECur INTO
    @BearingId,@DEManufacturerId,@DEActive,@DEPlace
    WHILE @@FETCH_STATUS = 0
		BEGIN
		 	MERGE [dbo].[DrivenBearing] AS [target]
			USING (
				SELECT @DrivenUnitId, @BearingId, @DEPlace  
				) AS source(DrivenUnitId,BearingId,Place)
				ON ([target].[DrivenUnitId] = [source].[DrivenUnitId] 
				and [target].[Place] = [source].[Place]
				and [target].[BearingId] = [source].[BearingId])				
			WHEN MATCHED
				THEN 
					UPDATE
					SET Active = @DEActive
			WHEN NOT MATCHED BY TARGET
					THEN
						INSERT (  
						 DrivenUnitId
						,BearingId
						,ManufacturerId
						,Place
						,Active
						,CreatedBy
							)
						VALUES ( 
						 @DrivenUnitId
						,@BearingId 
						,@DEManufacturerId
						,@DEPlace 
						,@DEActive
						,@UserId
							)
						;
		FETCH NEXT FROM GetBeringDECur INTO   @BearingId,@DEManufacturerId,@DEActive,@DEPlace
		END
    CLOSE GetBeringDECur
    DEALLOCATE GetBeringDECur
 ---- Process End Bearing Drive End------
  ---- Process Start Bearing Non Drive End------
	DECLARE @NDEActive varchar(1) ,@NDEPlace varchar(3) , @NDEManufacturerID int
	
	DROP TABLE IF EXISTS #LoadNDEBearingJson

	CREATE TABLE #LoadNDEBearingJson
	(
	  LoaderId int not null identity(1,1),
	  Place varchar(3), 
	  BearingId int,
	  ManufacturerId int,
	  Active Varchar(1) 
	) 
 
Insert into #LoadNDEBearingJson (BearingId,ManufacturerId,Active,Place)
SELECT
    JSON_Value (c.value, '$.BearingId') as BearingId,
	JSON_Value (c.value, '$.ManufacturerId') as ManufacturerId,  
	JSON_Value (c.value, '$.Active') as Active,
	'NDE' as Place  
FROM OPENJSON ( @NDEBearingJson ) as c 
 
DECLARE GetBeringNDECur CURSOR READ_ONLY
    FOR
    SELECT BearingId,ManufacturerId,Active,Place
	from #LoadNDEBearingJson  

    OPEN GetBeringNDECur
    FETCH NEXT FROM GetBeringNDECur INTO
    @BearingId,@NDEManufacturerID,@NDEActive,@NDEPlace
    WHILE @@FETCH_STATUS = 0
		BEGIN
		 	MERGE [dbo].[DrivenBearing] AS [target]
			USING (
				SELECT @DrivenUnitId, @BearingId,@NDEPlace  
				) AS source(DrivenUnitId,BearingId,Place)
				ON ([target].[DrivenUnitId] = [source].[DrivenUnitId] 
				and [target].[Place] = [source].[Place]
				and [target].[BearingId] = [source].[BearingId])				
			WHEN MATCHED
				THEN 
					UPDATE
					SET Active = @NDEActive
			WHEN NOT MATCHED BY TARGET
					THEN
						INSERT (  
						 DrivenUnitId
						,BearingId
						,ManufacturerId
						,Place
						,Active
						,CreatedBy
							)
						VALUES ( 
						 @DrivenUnitId
						,@BearingId 
						,@NDEManufacturerID
						,@NDEPlace 
						,@NDEActive
						,@UserId
							)
						;
		FETCH NEXT FROM GetBeringNDECur INTO   @BearingId,@NDEManufacturerID,@NDEActive,@NDEPlace
		END
    CLOSE GetBeringNDECur
    DEALLOCATE GetBeringNDECur
 ---- Process End Bearing Non Drive End------ 
		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveEquipmentDriveUnit]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppSaveEquipmentDriveUnit] 
	@DriveUnitId int
	,@EquipmentId int
	,@AssetId int 
	,@IdentificationName nvarchar(150)
	,@ListOrder int
	,@ManufacturerId int
	,@RPM nvarchar(100)
	,@Frame nvarchar(100)
	,@Voltage nvarchar(100)
	,@PowerFactor nvarchar(100)
	,@UnitRate nvarchar(100)
	,@Model nvarchar(100)
	,@HP nvarchar(100)
	,@Type nvarchar(100)
	,@MotorFanBlades nvarchar(100)
	,@SerialNumber nvarchar(100)
	,@RotorBars nvarchar(100)
	,@Poles nvarchar(100)
	,@Slots nvarchar(100) 
	,@PulleyDiaDrive nvarchar(100)
	,@PulleyDiaDriven nvarchar(100)
	,@BeltLength nvarchar(100)
	,@CouplingId int
	,@MeanRepairManHours decimal(15, 4)
	,@DownTimeCostPerHour decimal(15, 4)
	,@CostToRepair decimal(15, 4)
	,@MeanFailureRate decimal(15, 4)
	,@ReportServicesJson nvarchar(max)
	,@DEBearingJson nvarchar(max)
	,@NDEBearingJson nvarchar(max)
	,@Active VARCHAR(1)
	,@UserId INT
	,@ManufactureYear int
	,@FirstInstallationDate date
	,@OperationModeId int
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
  		DECLARE @Created TABLE (
			[DriveUnitId] INT
			,PRIMARY KEY ([DriveUnitId])
			); 

 		MERGE [dbo].[EquipmentDriveUnit] AS [target]
		USING (
			SELECT @DriveUnitId 
			) AS source(DriveUnitId)
			ON ([target].[DriveUnitId] = [source].[DriveUnitId])
		WHEN MATCHED
			THEN
 
				UPDATE
				SET AssetId = @AssetId 
				,IdentificationName = @IdentificationName
				,ListOrder = @ListOrder
				,ManufacturerId = @ManufacturerId
				,RPM = @RPM
				,Frame = @Frame
				,Voltage = @Voltage
				,PowerFactor = @PowerFactor
				,UnitRate = @UnitRate 
				,Model = @Model
				,HP = @HP
				,[Type] = @Type
				,MotorFanBlades = @MotorFanBlades
				,SerialNumber = @SerialNumber
				,RotorBars = @RotorBars
				,Poles = @Poles
				,Slots = @Slots  
				,PulleyDiaDrive = @PulleyDiaDrive
				,PulleyDiaDriven = @PulleyDiaDriven
				,BeltLength = @BeltLength
				,CouplingId = @CouplingId
				,MeanRepairManHours = @MeanRepairManHours
				,DownTimeCostPerHour = @DownTimeCostPerHour
				,CostToRepair = @CostToRepair
				,MeanFailureRate = @MeanFailureRate
				,Active = @Active
				,ManufactureYear = @ManufactureYear
				,FirstInstallationDate = @FirstInstallationDate
				,OperationModeId = @OperationModeId

	WHEN NOT MATCHED BY TARGET
			THEN
				INSERT ( 
				EquipmentId
				,AssetId 
				,IdentificationName
				,ListOrder
				,ManufacturerId
				,RPM
				,Frame
				,Voltage
				,PowerFactor
				,UnitRate
				,Model
				,HP
				,[Type]
				,MotorFanBlades 
				,SerialNumber
				,RotorBars
				,Poles 
				,Slots 
				,PulleyDiaDrive
				,PulleyDiaDriven 
				,BeltLength
				,CouplingId 
				,MeanRepairManHours 
				,DownTimeCostPerHour 
				,CostToRepair
				,MeanFailureRate 
				,Active
				,CreatedBy
				,ManufactureYear
				,FirstInstallationDate
				,OperationModeId
					)
				VALUES ( 
				@EquipmentId
				,@AssetId 
				,@IdentificationName
				,@ListOrder
				,@ManufacturerId
				,@RPM
				,@Frame
				,@Voltage
				,@PowerFactor
				,@UnitRate
				,@Model
				,@HP
				,@Type
				,@MotorFanBlades 
				,@SerialNumber
				,@RotorBars
				,@Poles 
				,@Slots 
				,@PulleyDiaDrive
				,@PulleyDiaDriven 
				,@BeltLength
				,@CouplingId 
				,@MeanRepairManHours 
				,@DownTimeCostPerHour 
				,@CostToRepair
				,@MeanFailureRate 
				,@Active
				,@UserId
				,@ManufactureYear
				,@FirstInstallationDate
				,@OperationModeId
					) OUTPUT INSERTED.DriveUnitId
				INTO @Created ;
			    
				SELECT @DriveUnitId = [DriveUnitId]
				FROM @Created; 
 ---- Process Start Report Service------
	DECLARE @DriveServiceId int,@ReportId int, @JActive varchar(1) 
	
	DROP TABLE IF EXISTS #LoadJson

	CREATE TABLE #LoadJson
	(
	  LoaderId int not null identity(1,1),
	  DriveServiceId int, 
	  ReportId int,
	  Active Varchar(1) 
	) 

Insert into #LoadJson (DriveServiceId,ReportId,Active)
SELECT
    JSON_Value (c.value, '$.UnitServiceId') as DriveServiceId,  
	JSON_Value (c.value, '$.ServiceId') as ReportId, 
	JSON_Value (c.value, '$.Active') as Active  
FROM OPENJSON ( @ReportServicesJson ) as c 
 
  
DECLARE GetIdCur CURSOR READ_ONLY
    FOR
    SELECT DriveServiceId,ReportId,Active
	from #LoadJson  

    OPEN GetIdCur
    FETCH NEXT FROM GetIdCur INTO
    @DriveServiceId,@ReportId,@JActive
    WHILE @@FETCH_STATUS = 0
		BEGIN
		 	MERGE [dbo].[DriveServices] AS [target]
			USING (
				SELECT @DriveUnitId,@ReportId 
				) AS source(DriveUnitId,ReportId)
				ON ([target].[DriveUnitId] = [source].[DriveUnitId] and [target].[ReportId] = [source].[ReportId])
			WHEN MATCHED
				THEN 
					UPDATE
					SET Active = @JActive
			WHEN NOT MATCHED BY TARGET
					THEN
						INSERT (  
						 DriveUnitId
						,ReportId
						,Active
						,CreatedBy
							)
						VALUES ( 
						 @DriveUnitId
						,@ReportId  
						,@JActive
						,@UserId
							)
						;
		FETCH NEXT FROM GetIdCur INTO    @DriveServiceId,@ReportId,@JActive
		END
    CLOSE GetIdCur
    DEALLOCATE GetIdCur
 ---- Process End Report Service------
 ---- Process Start Bearing Drive End------
	DECLARE @BearingId int, @DEActive varchar(1),@DEManufacturerId int ,@DEPlace varchar(3)
	
	DROP TABLE IF EXISTS #LoadDEBearingJson

	CREATE TABLE #LoadDEBearingJson
	(
	  LoaderId int not null identity(1,1),
	  Place varchar(3), 
	  BearingId int,
	  ManufacturerId Int,
	  Active Varchar(1) 
	) 

Insert into #LoadDEBearingJson (BearingId,ManufacturerId,Active,Place)
SELECT
    JSON_Value (c.value, '$.BearingId') as BearingId,
	JSON_Value (c.value, '$.ManufacturerId') as ManufacturerId,   
	JSON_Value (c.value, '$.Active') as Active,
	'DE' as Place  
FROM OPENJSON ( @DEBearingJson ) as c 
 
DECLARE GetBeringDECur CURSOR READ_ONLY
    FOR
    SELECT BearingId,ManufacturerId,Active,Place
	from #LoadDEBearingJson  

    OPEN GetBeringDECur
    FETCH NEXT FROM GetBeringDECur INTO
    @BearingId,@DEManufacturerId,@DEActive,@DEPlace
    WHILE @@FETCH_STATUS = 0
		BEGIN
		 	MERGE [dbo].[DriveBearing] AS [target]
			USING (
				SELECT @DriveUnitId, @BearingId, @DEPlace  
				) AS source(DriveUnitId,BearingId,Place)
				ON ([target].[DriveUnitId] = [source].[DriveUnitId] 
				and [target].[Place] = [source].[Place]
				and [target].[BearingId] = [source].[BearingId])				
			WHEN MATCHED
				THEN 
					UPDATE
					SET Active = @DEActive
			WHEN NOT MATCHED BY TARGET
					THEN
						INSERT (  
						 DriveUnitId
						,BearingId
						,ManufacturerId
						,Place
						,Active
						,CreatedBy
							)
						VALUES ( 
						 @DriveUnitId
						,@BearingId 
						,@DEManufacturerId
						,@DEPlace 
						,@DEActive
						,@UserId
							)
						;
		FETCH NEXT FROM GetBeringDECur INTO   @BearingId,@DEManufacturerId,@DEActive,@DEPlace
		END
    CLOSE GetBeringDECur
    DEALLOCATE GetBeringDECur
 ---- Process End Bearing Drive End------
  ---- Process Start Bearing Non Drive End------
	DECLARE @NDEActive varchar(1) ,@NDEPlace varchar(3) , @NDEManufacturerID int
	
	DROP TABLE IF EXISTS #LoadNDEBearingJson

	CREATE TABLE #LoadNDEBearingJson
	(
	  LoaderId int not null identity(1,1),
	  Place varchar(3), 
	  BearingId int,
	  ManufacturerId int,
	  Active Varchar(1) 
	) 
 
Insert into #LoadNDEBearingJson (BearingId,ManufacturerId,Active,Place)
SELECT
    JSON_Value (c.value, '$.BearingId') as BearingId,
	JSON_Value (c.value, '$.ManufacturerId') as ManufacturerId,  
	JSON_Value (c.value, '$.Active') as Active,
	'NDE' as Place  
FROM OPENJSON ( @NDEBearingJson ) as c 
 
DECLARE GetBeringNDECur CURSOR READ_ONLY
    FOR
    SELECT BearingId,ManufacturerId,Active,Place
	from #LoadNDEBearingJson  

    OPEN GetBeringNDECur
    FETCH NEXT FROM GetBeringNDECur INTO
    @BearingId,@NDEManufacturerID,@NDEActive,@NDEPlace
    WHILE @@FETCH_STATUS = 0
		BEGIN
		 	MERGE [dbo].[DriveBearing] AS [target]
			USING (
				SELECT @DriveUnitId, @BearingId,@NDEPlace  
				) AS source(DriveUnitId,BearingId,Place)
				ON ([target].[DriveUnitId] = [source].[DriveUnitId] 
				and [target].[Place] = [source].[Place]
				and [target].[BearingId] = [source].[BearingId])				
			WHEN MATCHED
				THEN 
					UPDATE
					SET Active = @NDEActive
			WHEN NOT MATCHED BY TARGET
					THEN
						INSERT (  
						 DriveUnitId
						,BearingId
						,ManufacturerId
						,Place
						,Active
						,CreatedBy
							)
						VALUES ( 
						 @DriveUnitId
						,@BearingId 
						,@NDEManufacturerID
						,@NDEPlace 
						,@NDEActive
						,@UserId
							)
						;
		FETCH NEXT FROM GetBeringNDECur INTO   @BearingId,@NDEManufacturerID,@NDEActive,@NDEPlace
		END
    CLOSE GetBeringNDECur
    DEALLOCATE GetBeringNDECur
 ---- Process End Bearing Non Drive End------ 

	COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveEquipmentIntermediateUnit]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppSaveEquipmentIntermediateUnit] 	
	@IntermediateUnitId int 
	,@EquipmentId int 
	,@AssetId int  
	,@IdentificationName nvarchar(150) 
	,@ListOrder int 
	,@ManufacturerId int 
	,@Ratio nvarchar(100) 
	,@Size nvarchar(100) 
	,@Model nvarchar(100) 
	,@BeltLength nvarchar(100) 
	,@PulleyDiaDrive nvarchar(100) 
	,@PulleyDiaDriven nvarchar(100) 
	,@RatedRPMInput nvarchar(100) 
	,@RatedRPMOutput nvarchar(100) 
	,@PinionInputGearTeeth nvarchar(100) 
	,@PinionOutputGearTeeth nvarchar(100) 
	,@IdlerInputGearTeeth nvarchar(100) 
	,@IdlerOutputGearTeeth nvarchar(100) 
	,@BullGearTeeth nvarchar(100) 
	,@Serial nvarchar(100) 
	,@MeanRepairManHours decimal(15, 4) 
	,@DownTimeCostPerHour decimal(15, 4) 
	,@CostToRepair decimal(15, 4) 
	,@MeanFailureRate decimal(15, 4) 
	,@ReportServicesJson nvarchar(max)
	,@DEBearingJson nvarchar(max)
	,@NDEBearingJson nvarchar(max)
	,@Active varchar(1)  
	,@UserId INT
	,@ManufactureYear int
	,@FirstInstallationDate date
	,@OperationModeId int
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
  		DECLARE @Created TABLE (
			[IntermediateUnitId] INT
			,PRIMARY KEY ([IntermediateUnitId])
			); 
			 
 		MERGE [dbo].[EquipmentIntermediateUnit] AS [target]
		USING (
			SELECT @IntermediateUnitId 
			) AS source(IntermediateUnitId)
			ON ([target].[IntermediateUnitId] = [source].[IntermediateUnitId])
		WHEN MATCHED
			THEN
 
				UPDATE
				SET  
				AssetId = @AssetId 
				,IdentificationName = @IdentificationName
				,ListOrder = @ListOrder
				,ManufacturerId = @ManufacturerId
				,Ratio = @Ratio
				,Size = @Size
				,BeltLength = @BeltLength
				,PulleyDiaDrive = @PulleyDiaDrive
				,PulleyDiaDriven = @PulleyDiaDriven 
				,RatedRPMInput = @RatedRPMInput
				,RatedRPMOutput = @RatedRPMOutput
				,PinionInputGearTeeth = @PinionInputGearTeeth
				,PinionOutputGearTeeth = @PinionOutputGearTeeth
				,IdlerInputGearTeeth = @IdlerInputGearTeeth
				,IdlerOutputGearTeeth = @IdlerOutputGearTeeth
				,BullGearTeeth = @BullGearTeeth
				,Model = @Model
				,Serial = @Serial 
				,MeanRepairManHours = @MeanRepairManHours
				,DownTimeCostPerHour = @DownTimeCostPerHour
				,CostToRepair = @CostToRepair
				,MeanFailureRate = @MeanFailureRate
				,Active = @Active
				,ManufactureYear = @ManufactureYear
				,FirstInstallationDate = @FirstInstallationDate
				,OperationModeId = @OperationModeId
				WHEN NOT MATCHED BY TARGET
			THEN
				INSERT ( 
				 EquipmentId
				,AssetId  
				,IdentificationName 
				,ListOrder 
				,ManufacturerId 
				,Ratio 
				,Size 
				,BeltLength 
				,PulleyDiaDrive 
				,PulleyDiaDriven 
				,RatedRPMInput 
				,RatedRPMOutput 
				,PinionInputGearTeeth 
				,PinionOutputGearTeeth 
				,IdlerInputGearTeeth 
				,IdlerOutputGearTeeth 
				,BullGearTeeth 
				,Model 
				,Serial  
				,MeanRepairManHours 
				,DownTimeCostPerHour 
				,CostToRepair 
				,MeanFailureRate 
				,Active 
				,CreatedBy
				,ManufactureYear
				,FirstInstallationDate
				,OperationModeId
					)
				VALUES ( 
				 @EquipmentId
				,@AssetId  
				,@IdentificationName 
				,@ListOrder 
				,@ManufacturerId 
				,@Ratio 
				,@Size 
				,@BeltLength 
				,@PulleyDiaDrive 
				,@PulleyDiaDriven 
				,@RatedRPMInput 
				,@RatedRPMOutput 
				,@PinionInputGearTeeth 
				,@PinionOutputGearTeeth 
				,@IdlerInputGearTeeth 
				,@IdlerOutputGearTeeth 
				,@BullGearTeeth 
				,@Model 
				,@Serial  
				,@MeanRepairManHours 
				,@DownTimeCostPerHour 
				,@CostToRepair 
				,@MeanFailureRate 
				,@Active 
				,@UserId
				,@ManufactureYear
				,@FirstInstallationDate
				,@OperationModeId
					) OUTPUT INSERTED.IntermediateUnitId
				INTO @Created ;
			    
				SELECT @IntermediateUnitId = [IntermediateUnitId]
				FROM @Created; 
---- Process Start Report Service------
 DECLARE @IntermediateServiceId int, @ReportId int, @JActive varchar(1) 
	
	DROP TABLE IF EXISTS #LoadJson
	 
	CREATE TABLE #LoadJson
	(
	  LoaderId int not null identity(1,1),
	  IntermediateServiceId int,
	  ReportId int,
	  Active varchar(1) 
	) 

Insert into #LoadJson (IntermediateServiceId,ReportId,Active)
SELECT
    JSON_Value (c.value, '$.UnitServiceId') as IntermediateServiceId, 
    JSON_Value (c.value, '$.ServiceId') as ReportId, 
	JSON_Value (c.value, '$.Active') as Active  
FROM OPENJSON ( @ReportServicesJson ) as c 
 
  
DECLARE GetIdCur CURSOR READ_ONLY
    FOR
    SELECT IntermediateServiceId,ReportId,Active
	from #LoadJson  

    OPEN GetIdCur
    FETCH NEXT FROM GetIdCur INTO
    @IntermediateServiceId,@ReportId,@JActive
    WHILE @@FETCH_STATUS = 0
		BEGIN
		 	MERGE [dbo].[IntermediateServices] AS [target]
			USING (
				SELECT @IntermediateUnitId,@ReportId 
				) AS source(IntermediateUnitId,ReportId)
				ON ([target].[IntermediateUnitId] = [source].[IntermediateUnitId] and [target].[ReportId] = [source].[ReportId])
			WHEN MATCHED
				THEN 
					UPDATE
					SET Active = @JActive
			WHEN NOT MATCHED BY TARGET
					THEN
						INSERT (  
						 IntermediateUnitId
						,ReportId
						,Active
						,CreatedBy
							)
						VALUES ( 
						 @IntermediateUnitId
						,@ReportId  
						,@JActive
						,@UserId
							)
						;
		FETCH NEXT FROM GetIdCur INTO @IntermediateServiceId,@ReportId,@JActive
		END
    CLOSE GetIdCur
    DEALLOCATE GetIdCur
 ---- Process End Report Service------ 
 ---- Process Start Bearing Drive End------
	DECLARE @BearingId int, @DEActive varchar(1),@DEManufacturerId int ,@DEPlace varchar(3)
	
	DROP TABLE IF EXISTS #LoadDEBearingJson

	CREATE TABLE #LoadDEBearingJson
	(
	  LoaderId int not null identity(1,1),
	  Place varchar(3), 
	  BearingId int,
	  ManufacturerId Int,
	  Active Varchar(1) 
	) 

Insert into #LoadDEBearingJson (BearingId,ManufacturerId,Active,Place)
SELECT
    JSON_Value (c.value, '$.BearingId') as BearingId,
	JSON_Value (c.value, '$.ManufacturerId') as ManufacturerId,   
	JSON_Value (c.value, '$.Active') as Active,
	'DE' as Place  
FROM OPENJSON ( @DEBearingJson ) as c 
 
DECLARE GetBeringDECur CURSOR READ_ONLY
    FOR
    SELECT BearingId,ManufacturerId,Active,Place
	from #LoadDEBearingJson  

    OPEN GetBeringDECur
    FETCH NEXT FROM GetBeringDECur INTO
    @BearingId,@DEManufacturerId,@DEActive,@DEPlace
    WHILE @@FETCH_STATUS = 0
		BEGIN
		 	MERGE [dbo].[IntermediateBearing] AS [target]
			USING (
				SELECT @IntermediateUnitId, @BearingId, @DEPlace  
				) AS source(IntermediateUnitId,BearingId,Place)
				ON ([target].[IntermediateUnitId] = [source].[IntermediateUnitId] 
				and [target].[Place] = [source].[Place]
				and [target].[BearingId] = [source].[BearingId])				
			WHEN MATCHED
				THEN 
					UPDATE
					SET Active = @DEActive
			WHEN NOT MATCHED BY TARGET
					THEN
						INSERT (  
						 IntermediateUnitId
						,BearingId
						,ManufacturerId
						,Place
						,Active
						,CreatedBy
							)
						VALUES ( 
						 @IntermediateUnitId
						,@BearingId 
						,@DEManufacturerId
						,@DEPlace 
						,@DEActive
						,@UserId
							)
						;
		FETCH NEXT FROM GetBeringDECur INTO   @BearingId,@DEManufacturerId,@DEActive,@DEPlace
		END
    CLOSE GetBeringDECur
    DEALLOCATE GetBeringDECur
 ---- Process End Bearing Drive End------
  ---- Process Start Bearing Non Drive End------
	DECLARE @NDEActive varchar(1) ,@NDEPlace varchar(3) , @NDEManufacturerID int
	
	DROP TABLE IF EXISTS #LoadNDEBearingJson

	CREATE TABLE #LoadNDEBearingJson
	(
	  LoaderId int not null identity(1,1),
	  Place varchar(3), 
	  BearingId int,
	  ManufacturerId int,
	  Active Varchar(1) 
	) 
 
Insert into #LoadNDEBearingJson (BearingId,ManufacturerId,Active,Place)
SELECT
    JSON_Value (c.value, '$.BearingId') as BearingId,
	JSON_Value (c.value, '$.ManufacturerId') as ManufacturerId,  
	JSON_Value (c.value, '$.Active') as Active,
	'NDE' as Place  
FROM OPENJSON ( @NDEBearingJson ) as c 
 
DECLARE GetBeringNDECur CURSOR READ_ONLY
    FOR
    SELECT BearingId,ManufacturerId,Active,Place
	from #LoadNDEBearingJson  

    OPEN GetBeringNDECur
    FETCH NEXT FROM GetBeringNDECur INTO
    @BearingId,@NDEManufacturerID,@NDEActive,@NDEPlace
    WHILE @@FETCH_STATUS = 0
		BEGIN
		 	MERGE [dbo].[IntermediateBearing] AS [target]
			USING (
				SELECT @IntermediateUnitId, @BearingId,@NDEPlace  
				) AS source(IntermediateUnitId,BearingId,Place)
				ON ([target].[IntermediateUnitId] = [source].[IntermediateUnitId] 
				and [target].[Place] = [source].[Place]
				and [target].[BearingId] = [source].[BearingId])				
			WHEN MATCHED
				THEN 
					UPDATE
					SET Active = @NDEActive
			WHEN NOT MATCHED BY TARGET
					THEN
						INSERT (  
						 IntermediateUnitId
						,BearingId
						,ManufacturerId
						,Place
						,Active
						,CreatedBy
							)
						VALUES ( 
						 @IntermediateUnitId
						,@BearingId 
						,@NDEManufacturerID
						,@NDEPlace 
						,@NDEActive
						,@UserId
							)
						;
		FETCH NEXT FROM GetBeringNDECur INTO   @BearingId,@NDEManufacturerID,@NDEActive,@NDEPlace
		END
    CLOSE GetBeringNDECur
    DEALLOCATE GetBeringNDECur
 ---- Process End Bearing Non Drive End------ 
		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveEquipmentWithDriveUnit]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppSaveEquipmentWithDriveUnit]
	 @EquipmentId INT
	,@PlantAreaId INT	  
	,@EquipmentCode VARCHAR(5)
	,@EquipmentName NVARCHAR(150)
	,@Descriptions NVARCHAR(250)
	,@EListOrder INT 
	,@OrientationId INT 
	,@MountingId INT 
	,@StandByEquipId INT 
	,@DriveUnitId int 
	,@AssetId int 
	,@IdentificationName nvarchar(150)
	,@DListOrder int
	,@ManufacturerId int
	,@RPM nvarchar(100)
	,@Frame nvarchar(100)
	,@Voltage nvarchar(100)
	,@PowerFactor nvarchar(100)
	,@UnitRate nvarchar(100)
	,@Model nvarchar(100)
	,@HP nvarchar(100)
	,@Type nvarchar(100)
	,@MotorFanBlades nvarchar(100)
	,@SerialNumber nvarchar(100)
	,@RotorBars nvarchar(100)
	,@Poles nvarchar(100)
	,@Slots nvarchar(100)
	,@PulleyDiaDrive nvarchar(100)
	,@PulleyDiaDriven nvarchar(100)
	,@BeltLength nvarchar(100)
	,@CouplingId int
	,@MeanRepairManHours decimal(15, 4)
	,@DownTimeCostPerHour decimal(15, 4)
	,@CostToRepair decimal(15, 4)
	,@MeanFailureRate decimal(15, 4) 
	,@ReportServicesJson nvarchar(max) 
	,@DEBearingJson nvarchar(max)
	,@NDEBearingJson nvarchar(max)
	,@Active VARCHAR(1)
	,@UserId INT
	,@ManufactureYear int
	,@FirstInstallationDate date
	,@OperationModeId int
	,@AreaId int
	,@SystemId int
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
 		DECLARE @Created TABLE (
			[EquipId] INT
			,PRIMARY KEY ([EquipId])
			);
 
		MERGE [dbo].[Equipment] AS [target]
		USING (
			SELECT @EquipmentId 
			) AS source(EquipmentId)
			ON ([target].[EquipmentId] = [source].[EquipmentId])
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
				 PlantAreaId
				,EquipmentCode
				,EquipmentName
				,Descriptions
				,ListOrder
				,OrientationId
				,MountingId
				,StandByEquipId
				,Active
				,CreatedBy
				,AreaId
				,SystemId
					)
				VALUES (
				 @PlantAreaId
				,@EquipmentCode
				,@EquipmentName
				,@Descriptions
				,@EListOrder
				,@OrientationId
				,@MountingId
				,@StandByEquipId
				,@Active
				,@UserId
				,@AreaId
				,@SystemId
					) 
				OUTPUT INSERTED.EquipmentId
				INTO @Created;
		  
				SELECT @EquipmentId = [EquipId]
				FROM @Created;
				 
		Exec dbo.EAppSaveEquipmentDriveUnit
			@DriveUnitId 
			,@EquipmentId 
			,@AssetId  
			,@IdentificationName 
			,@DListOrder 
			,@ManufacturerId 
			,@RPM 
			,@Frame 
			,@Voltage 
			,@PowerFactor 
			,@UnitRate 
			,@Model 
			,@HP 
			,@Type 
			,@MotorFanBlades 
			,@SerialNumber 
			,@RotorBars 
			,@Poles 
			,@Slots  
			,@PulleyDiaDrive 
			,@PulleyDiaDriven 
			,@BeltLength  
			,@CouplingId  
			,@MeanRepairManHours 
			,@DownTimeCostPerHour 
			,@CostToRepair 
			,@MeanFailureRate
			,@ReportServicesJson
			,@DEBearingJson
			,@NDEBearingJson
			,@Active 
			,@UserId 
			,@ManufactureYear 
	        ,@FirstInstallationDate 
			,@OperationModeId  

			SELECT @EquipmentId as EquipmentId;

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH
	
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveFailureCause]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppSaveFailureCause] @FailureCauseId INT
	,@LanguageId INT
	,@FailureCauseCode VARCHAR(5)
	,@FailureCauseName NVARCHAR(150)
	,@Descriptions NVARCHAR(150)
	,@Active VARCHAR(1)
	,@UserId INT
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
		DECLARE @Created TABLE (
			[FailureCauseId] INT
			,PRIMARY KEY ([FailureCauseId])
			);

		MERGE [dbo].[FailureCause] AS [target]
		USING (
			SELECT @FailureCauseId
			) AS source(FailureCauseId)
			ON ([target].[FailureCauseId] = [source].[FailureCauseId])
		WHEN MATCHED
			THEN
				UPDATE
				SET FailureCauseCode = @FailureCauseCode
					,Active = @Active
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					FailureCauseCode
					,CreatedLanguageId
					,Active
					,CreatedBy
					)
				VALUES (
					@FailureCauseCode
					,@Languageid
					,@Active
					,@UserId
					)
		OUTPUT INSERTED.[FailureCauseId]
		INTO @Created;;

		SELECT @FailureCauseId = (
				SELECT FailureCauseId
				FROM @Created
				)

		MERGE [dbo].[FailureCauseTranslated] AS [target]
		USING (
			SELECT @FailureCauseId
				,@LanguageId
			) AS source(FailureCauseId, LanguageId)
			ON ([target].[FailureCauseId] = [source].[FailureCauseId])
				AND [TARGET].LanguageId = @LanguageId
		WHEN MATCHED
			THEN
				UPDATE
				SET FailureCauseName = @FailureCauseName
					,Descriptions = @Descriptions
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					FailureCauseId
					,LanguageId
					,FailureCausename
					,Descriptions
					,CreatedBy
					)
				VALUES (
					@FailureCauseId
					,@Languageid
					,@FailureCauseName
					,@Descriptions
					,@UserId
					);

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveFailureCauseModeRelation]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppSaveFailureCauseModeRelation] 
	@FailureModeId INT
	,@FailureCauseId INT
	,@Active VARCHAR(1)
	,@UserId INT
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
		MERGE [dbo].[FailureCauseModeRelation] AS [target]
		USING (
			SELECT @FailureCauseId
				,@FailureModeId
			) AS source(FailureCauseId, FailureModeId)
			ON ([target].[FailureCauseId] = [source].[FailureCauseId])
				AND ([target].[FailureModeId] = [source].[FailureModeId])
		WHEN MATCHED
			THEN
				UPDATE
				SET Active = @Active
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					FailureCauseId
					,FailureModeId
					,Active
					,CreatedBy
					)
				VALUES (
					@FailureCauseId
					,@FailureModeId
					,@Active
					,@UserId
					);

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveFailureMode]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppSaveFailureMode] @FailureModeId INT
	,@LanguageId INT
	,@FailureModeCode VARCHAR(5)
	,@FailureModeName NVARCHAR(150)
	,@Descriptions NVARCHAR(150)
	,@Active VARCHAR(1)
	,@UserId INT
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
		DECLARE @Created TABLE (
			[FailureModeId] INT
			,PRIMARY KEY ([FailureModeId])
			);

		MERGE [dbo].[FailureMode] AS [target]
		USING (
			SELECT @FailureModeId
			) AS source(FailureModeId)
			ON ([target].[FailureModeId] = [source].[FailureModeId])
		WHEN MATCHED
			THEN
				UPDATE
				SET FailureModeCode = @FailureModeCode
					,Active = @Active
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					FailureModeCode
					,CreatedLanguageId
					,Active
					,CreatedBy
					)
				VALUES (
					@FailureModeCode
					,@Languageid
					,@Active
					,@UserId
					)
		OUTPUT INSERTED.[FailureModeId]
		INTO @Created;;

		SELECT @FailureModeId = (
				SELECT FailureModeId
				FROM @Created
				)

		MERGE [dbo].[FailureModeTranslated] AS [target]
		USING (
			SELECT @FailureModeId
				,@LanguageId
			) AS source(FailureModeId, LanguageId)
			ON ([target].[FailureModeId] = [source].[FailureModeId])
				AND [TARGET].LanguageId = @LanguageId
		WHEN MATCHED
			THEN
				UPDATE
				SET FailureModeName = @FailureModeName
					,Descriptions = @Descriptions
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					FailureModeId
					,LanguageId
					,FailureModename
					,Descriptions
					,CreatedBy
					)
				VALUES (
					@FailureModeId
					,@Languageid
					,@FailureModeName
					,@Descriptions
					,@UserId
					);

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveFailureModeAssetClassRelation]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppSaveFailureModeAssetClassRelation] 
	@FailureModeId INT
	,@AssetClassId INT
	,@Active VARCHAR(1)
	,@UserId INT
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
		MERGE [dbo].[FailureModeAssetClassRelation] AS [target]
		USING (
			SELECT @AssetClassId
				,@FailureModeId
			) AS source(AssetClassId, FailureModeId)
			ON ([target].[AssetClassId] = [source].[AssetClassId])
				AND ([target].[FailureModeId] = [source].[FailureModeId])
		WHEN MATCHED
			THEN
				UPDATE
				SET Active = @Active
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					AssetClassId
					,FailureModeId
					,Active
					,CreatedBy
					)
				VALUES (
					@AssetClassId
					,@FailureModeId
					,@Active
					,@UserId
					);

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveFailureReport]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppSaveFailureReport]
	 @FailureReportHeaderId bigint
	,@ReportType varchar(10)
	,@ClientSiteid int
	,@EquipmentId INT	  
	,@ReportDate Date 
	,@Active VARCHAR(1)
	,@UserId INT
	,@FailureDetailJson nvarchar(max)
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
 		DECLARE @Created TABLE (
			[FailureReportHeaderId] INT
			,PRIMARY KEY ([FailureReportHeaderId])
			);
 
		MERGE [dbo].[FailureReportHeader] AS [target]
		USING (
			SELECT @FailureReportHeaderId 
			) AS source(FailureReportHeaderId)
			ON ([target].[FailureReportHeaderId] = [source].[FailureReportHeaderId])
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT ( 
				ReportType
				,ClientSiteId
				,EquipmentId   
				,ReportDate  
				,Active 
				,CreatedBy  
					)
				VALUES (
				@ReportType
				,@ClientSiteid
				,@EquipmentId   
				,@ReportDate  
				,@Active 
				,@UserId 
					) 
				OUTPUT INSERTED.FailureReportHeaderId
				INTO @Created;
		  
				SELECT @FailureReportHeaderId = [FailureReportHeaderId]
				FROM @Created;
 --------------Detail Process---------------------
				DECLARE 
				  @FailureReportDetailId bigint  
				, @UnitType varchar(3) 
				, @UnitId int 
				, @FailureModeId int 
				, @FailureCauseId int 
				, @DActualRepairCost decimal(15, 4)  
				, @DActualOutageTime decimal(15, 4)
				, @Descriptions nvarchar(2500)
				, @MTTR decimal(15,4)
				, @MTBF decimal(15,4) 
				, @DActive varchar(1) 
	
				DROP TABLE IF EXISTS #LoadReportDetailJson

				CREATE TABLE #LoadReportDetailJson
				(
				LoaderId int not null identity(1,1)
				,FailureReportDetailId bigint  
				,UnitType varchar(3) 
				,UnitId int 
				,FailureModeId int 
				,FailureCauseId int 
				,DActualRepairCost decimal(15, 4)  
				,DActualOutageTime decimal(15, 4) 
				,Descriptions nvarchar(2500)
				,MTTR decimal(15,4)
				,MTBF decimal(15,4) 
				,DActive varchar(1) 
				) 

				Insert into #LoadReportDetailJson (FailureReportDetailId,UnitType,UnitId,FailureModeId,FailureCauseId,DActualRepairCost,DActualOutageTime,MTTR,MTBF,Descriptions,DActive)
				SELECT
				JSON_Value (c.value, '$.FailureReportDetailId') as FailureReportDetailId,  
				JSON_Value (c.value, '$.UnitType') as UnitType, 
				JSON_Value (c.value, '$.UnitId') as UnitId,  
				JSON_Value (c.value, '$.FailureModeId') as FailureModeId, 
				JSON_Value (c.value, '$.FailureCauseId') as FailureCauseId, 
				JSON_Value (c.value, '$.DActualRepairCost') as DActualRepairCost,
				JSON_Value (c.value, '$.DActualOutageTime') as DActualOutageTime,
				JSON_Value (c.value, '$.MTTR') as MTTR,
				JSON_Value (c.value, '$.MTBF') as MTBF,				
				JSON_Value (c.value, '$.Descriptions') as Descriptions,
				JSON_Value (c.value, '$.DActive') as DActive 
				FROM OPENJSON ( @FailureDetailJson ) as c 

	DECLARE GetDetailCur CURSOR READ_ONLY
    FOR
    SELECT FailureReportDetailId,UnitType,UnitId,FailureModeId,FailureCauseId,DActualRepairCost,DActualOutageTime,MTTR,MTBF,Descriptions,DActive
	from #LoadReportDetailJson  

    OPEN GetDetailCur
    FETCH NEXT FROM GetDetailCur INTO
    @FailureReportDetailId,@UnitType,@UnitId,@FailureModeId,@FailureCauseId,@DActualRepairCost,@DActualOutageTime,@MTTR,@MTBF,@Descriptions,@DActive
    WHILE @@FETCH_STATUS = 0
    BEGIN
		if isnull(@FailureReportDetailId,0) <> 0
		Begin
			MERGE [dbo].[FailureReportDetail] AS [target]
			USING (
				SELECT @FailureReportDetailId 
				) AS source(FailureReportDetailId)
				ON ([target].[FailureReportDetailId] = [source].[FailureReportDetailId])
			WHEN MATCHED THEN
				UPDATE	SET	UnitType = @UnitType
					,UnitId = @UnitId
					,FailureModeId = @FailureModeId
					,FailureCauseId = @FailureCauseId
					,ActualRepairCost = @DActualRepairCost
					,ActualOutageTime = @DActualOutageTime
					,Descriptions = @Descriptions
					,Active = case when isnull(@FailureModeId,0)=0 and @ReportType = 'FR' then 'N' 
								   when isnull(@FailureModeId,0)<>0 and @ReportType = 'FR' then 'Y'
							       when len(isnull(@Descriptions,''))=0 and @ReportType = 'APM' then 'N' 
								   when len(isnull(@Descriptions,''))>0 and @ReportType = 'APM' then 'Y' end
					;
		End
		if isnull(@FailureReportDetailId,0) = 0  and sum(case when isnull(@FailureModeId,0)=0 and @ReportType = 'FR' then 0 
								   when isnull(@FailureModeId,0)<>0 and @ReportType = 'FR' then 1
							       when len(isnull(@Descriptions,''))=0 and @ReportType = 'APM' then 0 
								   when len(isnull(@Descriptions,''))>0 and @ReportType = 'APM' then 1 end ) > 0
		Begin
			MERGE [dbo].[FailureReportDetail] AS [target]
			USING (
				SELECT @FailureReportDetailId 
				) AS source(FailureReportDetailId)
				ON ([target].[FailureReportDetailId] = [source].[FailureReportDetailId])
			WHEN NOT MATCHED BY TARGET
				THEN
					INSERT ( 
					 FailureReportHeaderId
					,UnitType
					,UnitId
					,FailureModeId
					,FailureCauseId
					,ActualRepairCost
					,ActualOutageTime
					,MTTR
					,MTBF
					,Descriptions
					,Active 
					,CreatedBy  
						)
					VALUES (
					@FailureReportHeaderId
					,@UnitType
					,@UnitId
					,@FailureModeId
					,@FailureCauseId
					,@DActualRepairCost
					,@DActualOutageTime 
					,@MTTR
					,@MTBF
					,@Descriptions
					,@DActive 
					,@UserId 
						) ;
		End
    FETCH NEXT FROM GetDetailCur INTO
		@FailureReportDetailId,@UnitType,@UnitId,@FailureModeId,@FailureCauseId,@DActualRepairCost,@DActualOutageTime,@MTTR,@MTBF,@Descriptions,@DActive
	END
	CLOSE GetDetailCur
	DEALLOCATE GetDetailCur 
	 
	-----------Start to Calculation for the Report Type is Failure Report Calculation-----------------
				if (@ReportType = 'FR')
				BEGIN
				Declare @HActualRepairCost decimal(15,4),@HBreakdowHours decimal(15,4),@HDownTimeCost decimal(15,4),@HBreakDownCost  decimal(15,4)
				Declare @FinalBreakdowHours decimal(15,4),@FinalBreakDownCost  decimal(15,4)

				select @HActualRepairCost = sum(DActualRepairCost) 
				From #LoadReportDetailJson 
				where isnull(FailureModeId,0) > 0 

				select @HBreakdowHours = max(DActualOutageTime) 
				From #LoadReportDetailJson 
				where isnull(FailureModeId,0) > 0 

				select @HDownTimeCost = max(@MTBF) --MTTR 
				From #LoadReportDetailJson 
				where isnull(FailureModeId,0) > 0 

			   SELECT @HBreakDownCost = (((@HBreakdowHours) * (@HDownTimeCost)) + (@HActualRepairCost))		
			   			  
				--@FinalBreakdowHours ='-'+@HBreakdowHours
				--@FinalBreakDownCost ='-'+@HBreakDownCost

				
				Update FailureReportHeader set ActualOutageTime =@HBreakdowHours, ActualRepairCost = @HActualRepairCost,BreakDownHrs = @HBreakdowHours , BreakDownCost = @HBreakDownCost
				Where FailureReportHeaderId = @FailureReportHeaderId

				END
			-----------End to Calculation for the Report Type is Failure Report Calculation-----------------
			

			----------Start to Calculation if  the Report Type is Avoided Plnned Maintenance -----------------
				else if (@ReportType = 'APM')
				BEGIN
				--Declare @HActualRepairCost decimal(15,4),@HBreakdowHours decimal(15,4),@HDownTimeCost decimal(15,4),@HBreakDownCost  decimal(15,4)
				 
				select @HActualRepairCost = sum(DActualRepairCost) 
				From #LoadReportDetailJson 
				
				select @HBreakdowHours = max(DActualOutageTime) 
				From #LoadReportDetailJson 
				
				select @HDownTimeCost = max(@MTBF) --MTTR 
				From #LoadReportDetailJson 
				
			   SELECT @HBreakDownCost = ((@HBreakdowHours) * (@HDownTimeCost)) + (@HActualRepairCost)		

						
				Update FailureReportHeader set ActualRepairCost = @HActualRepairCost,DownTimeCost=@HDownTimeCost,TrueSavingsHrs = @HBreakdowHours , TrueSavingsCost = @HBreakDownCost
				Where FailureReportHeaderId = @FailureReportHeaderId

				END
			----------End to Calculation if  the Report Type is Avoided Plnned Maintenance -----------------
			
    Select @FailureReportHeaderId as FailureReportHeaderId;
		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH
	
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveFailureReportAttachment]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
create   PROCEDURE [dbo].[EAppSaveFailureReportAttachment] 
	 @FailureReportAttachId bigint
	,@FailureReportHeaderId bigint 
	,@FileName VARCHAR(500)
	,@LogicalName VARCHAR(500)
	,@PhysicalPath VARCHAR(500)
	,@Active VARCHAR(1)
	,@UserId INT 
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
 
	MERGE [dbo].[FailureReportAttachment] AS [target]
		USING (
			SELECT @FailureReportAttachId 
			) AS source(FailureReportAttachId)
			ON ([target].[FailureReportAttachId] = [source].[FailureReportAttachId])
		WHEN MATCHED
			THEN
				UPDATE
				SET Active = @Active
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
 				 FailureReportHeaderId
				,FileName
				,LogicalName
				,PhysicalPath
				,Active
				,CreatedBy
					)
				VALUES (
				 @FailureReportHeaderId
				,@FileName
				,@LogicalName
				,@PhysicalPath
				,@Active
				,@UserId);
 

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveFailureReportSarav]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppSaveFailureReportSarav]
	 @FailureReportHeaderId bigint
	,@ClientSiteid int
	,@EquipmentId INT	  
	,@ReportDate Date
	,@ActualRepairCost Decimal(15,2)
	,@ActualOutageTime Decimal(15,2)
	,@BreakDownCost Decimal(15,2)
	,@BreakDownHrs Decimal(15,2) 
	,@Active VARCHAR(1)
	,@UserId INT
	,@FailureDetailJson nvarchar(max)
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
 		DECLARE @Created TABLE (
			[FailureReportHeaderId] INT
			,PRIMARY KEY ([FailureReportHeaderId])
			);
 
		MERGE [dbo].[FailureReportHeader] AS [target]
		USING (
			SELECT @FailureReportHeaderId 
			) AS source(FailureReportHeaderId)
			ON ([target].[FailureReportHeaderId] = [source].[FailureReportHeaderId])
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT ( 
				ClientSiteId
				,EquipmentId   
				,ReportDate 
				,ActualRepairCost 
				,ActualOutageTime 
				,BreakDownCost 
				,BreakDownHrs 
				,Active 
				,CreatedBy  
					)
				VALUES (
				@ClientSiteid
				,@EquipmentId   
				,@ReportDate 
				,@ActualRepairCost 
				,@ActualOutageTime 
				,@BreakDownCost 
				,@BreakDownHrs 
				,@Active 
				,@UserId 
					) 
				OUTPUT INSERTED.FailureReportHeaderId
				INTO @Created;
		  
				SELECT @FailureReportHeaderId = [FailureReportHeaderId]
				FROM @Created;
 --------------Detail Process---------------------
				DECLARE 
				  @FailureReportDetailId bigint  
				, @UnitType varchar(3) 
				, @UnitId int 
				, @FailureModeId int 
				, @FailureCauseId int 
				, @DActualRepairCost decimal(15, 2)  
				, @DActualOutageTime decimal(4, 2) 
				, @DActive varchar(1) 
	
				DROP TABLE IF EXISTS #LoadReportDetailJson

				CREATE TABLE #LoadReportDetailJson
				(
				LoaderId int not null identity(1,1)
				,FailureReportDetailId bigint  
				,UnitType varchar(3) 
				,UnitId int 
				,FailureModeId int 
				,FailureCauseId int 
				,DActualRepairCost decimal(15, 2)  
				,DActualOutageTime decimal(4, 2) 
				,DActive varchar(1) 
				) 

				Insert into #LoadReportDetailJson (FailureReportDetailId,UnitType,UnitId,FailureModeId,FailureCauseId,DActualRepairCost,DActualOutageTime,DActive)
				SELECT
				JSON_Value (c.value, '$.FailureReportDetailId') as FailureReportDetailId,  
				JSON_Value (c.value, '$.UnitType') as UnitType, 
				JSON_Value (c.value, '$.UnitId') as UnitId,  
				JSON_Value (c.value, '$.FailureModeId') as FailureModeId, 
				JSON_Value (c.value, '$.FailureCauseId') as FailureCauseId, 
				JSON_Value (c.value, '$.DActualRepairCost') as DActualRepairCost,
				JSON_Value (c.value, '$.DActualOutageTime') as DActualOutageTime,
				JSON_Value (c.value, '$.DActive') as DActive 
				FROM OPENJSON ( @FailureDetailJson ) as c 

				
				------------if the Report Type is Failure Report Calculation-----------------
				Declare @HActualRepairCost decimal(15,2),@HBreakdowHours decimal(15,2),@HDownTimeCost decimal(15,2),@HBreakDownCost  decimal(15,2)

				select @HActualRepairCost = sum(DActualRepairCost) 
				From #LoadReportDetailJson 
				where isnull(FailureModeId,0) = 0 

				select @HBreakdowHours = max(DActualOutageTime) 
				From #LoadReportDetailJson 
				where isnull(FailureModeId,0) = 0 

				select @HDownTimeCost = max(DActualOutageTime) --MTTR 
				From #LoadReportDetailJson 
				where isnull(FailureModeId,0) = 0 

				select @HBreakDownCost = ((@HBreakdowHours) * (@HDownTimeCost)) + (@HActualRepairCost)			

				Update FailureReportHeader set ActualOutageTime = @HActualRepairCost, ActualRepairCost = @HBreakdowHours ,BreakDownHrs = @HDownTimeCost , BreakDownCost = @HBreakDownCost
				Where FailureReportHeaderId = @FailureReportHeaderId
				--------------------------------------------------------------------------------

				------------If the Report Type is Avoided Plnned Maintenance Calculation-----------------
				
				--------------------------------------------------------------------------------



	DECLARE GetDetailCur CURSOR READ_ONLY
    FOR
    SELECT FailureReportDetailId,UnitType,UnitId,FailureModeId,FailureCauseId,DActualRepairCost,DActualOutageTime,DActive
	from #LoadReportDetailJson  

    OPEN GetDetailCur
    FETCH NEXT FROM GetDetailCur INTO
    @FailureReportDetailId,@UnitType,@UnitId,@FailureModeId,@FailureCauseId,@DActualRepairCost,@DActualOutageTime,@DActive
    WHILE @@FETCH_STATUS = 0
    BEGIN
		if isnull(@FailureReportDetailId,0) <> 0
		Begin
			MERGE [dbo].[FailureReportDetail] AS [target]
			USING (
				SELECT @FailureReportDetailId 
				) AS source(FailureReportDetailId)
				ON ([target].[FailureReportDetailId] = [source].[FailureReportDetailId])
			WHEN MATCHED THEN
				UPDATE	SET	UnitType = @UnitType
					,UnitId = @UnitId
					,FailureModeId = @FailureModeId
					,FailureCauseId = @FailureCauseId
					,ActualRepairCost = @DActualRepairCost
					,ActualOutageTime = @DActualOutageTime
					,Active = case when isnull(@FailureModeId,0)=0 then 'N' else @DActive end
					;
		End
		if isnull(@FailureReportDetailId,0) = 0 and isnull(@FailureModeId,0) <> 0 
		Begin
			MERGE [dbo].[FailureReportDetail] AS [target]
			USING (
				SELECT @FailureReportDetailId 
				) AS source(FailureReportDetailId)
				ON ([target].[FailureReportDetailId] = [source].[FailureReportDetailId])
			WHEN NOT MATCHED BY TARGET
				THEN
					INSERT ( 
					 FailureReportHeaderId
					,UnitType
					,UnitId
					,FailureModeId
					,FailureCauseId
					,ActualRepairCost
					,ActualOutageTime
					,Active 
					,CreatedBy  
						)
					VALUES (
					@FailureReportHeaderId
					,@UnitType
					,@UnitId
					,@FailureModeId
					,@FailureCauseId
					,@DActualRepairCost
					,@DActualOutageTime 
					,@DActive 
					,@UserId 
						) ;
		End
    FETCH NEXT FROM GetDetailCur INTO
		@FailureReportDetailId,@UnitType,@UnitId,@FailureModeId,@FailureCauseId,@DActualRepairCost,@DActualOutageTime,@DActive
	END
	CLOSE GetDetailCur
	DEALLOCATE GetDetailCur 
 

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH
	
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveIndustry]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppSaveIndustry] @IndustryId INT
	,@SegmentId INT
	,@LanguageId INT
	,@IndustryCode VARCHAR(5)
	,@IndustryName NVARCHAR(150)
	,@Descriptions NVARCHAR(150)
	,@Active VARCHAR(1)
	,@DownTimeCostPerHour Decimal(15, 4)
	,@UserId INT
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
		DECLARE @Created TABLE (
			[IndustryId] INT
			,PRIMARY KEY ([IndustryId])
			);

		MERGE [dbo].[Industry] AS [target]
		USING (
			SELECT @IndustryId
			) AS source(IndustryId)
			ON ([target].[IndustryId] = [source].[IndustryId])
		WHEN MATCHED
			THEN
				UPDATE
				SET SegmentId = @SegmentId
					,IndustryCode = @IndustryCode
					,Active = @Active
					,DownTimeCostPerHour = @DownTimeCostPerHour
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					SegmentId
					,CreatedLanguageId
					,IndustryCode
					,Active
					,DownTimeCostPerHour
					,CreatedBy
					)
				VALUES (
					@SegmentId
					,@Languageid
					,@IndustryCode
					,@Active
					,@DownTimeCostPerHour
					,@UserId
					)
		OUTPUT INSERTED.[IndustryId]
		INTO @Created;;

		SELECT @IndustryId = (
				SELECT IndustryId
				FROM @Created
				)

		MERGE [dbo].[IndustryTranslated] AS [target]
		USING (
			SELECT @IndustryId
				,@LanguageId
			) AS source(IndustryId, LanguageId)
			ON ([target].[IndustryId] = [source].[IndustryId])
				AND [TARGET].LanguageId = @LanguageId
		WHEN MATCHED
			THEN
				UPDATE
				SET IndustryName = @IndustryName
					,Descriptions = @Descriptions
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					IndustryId
					,LanguageId
					,Industryname
					,Descriptions
					,CreatedBy
					)
				VALUES (
					@IndustryId
					,@Languageid
					,@IndustryName
					,@Descriptions
					,@UserId
					);

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveJob]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 
CREATE   PROCEDURE [dbo].[EAppSaveJob]
	 @JobId Bigint 
	,@ScheduleSetupId Bigint 
	,@ClientSiteId int    
	,@JobName nvarchar(150) 
	,@EstStartDate Date 
	,@EstEndDate Date 
	,@AnalystId int  
    ,@JobEquipmentsJson nvarchar(max)
	,@JobServicesJson nvarchar(max)
	,@StatusId int
	,@UserId INT 
AS
BEGIN


	BEGIN TRANSACTION
	BEGIN TRY

		DECLARE @JobNumber varchar(50) Declare @UpdateScheduleStatusid int
  		DECLARE @Created TABLE (
			[JobId] Bigint
			,PRIMARY KEY ([JobId])
			);
		set @UpdateScheduleStatusid = 0 ;
		If @JobId = 0
		Begin
			Select @Statusid = dbo.GetStatusId(1,'JobProcessStatus','NS') , @JobNumber = (NEXT VALUE FOR [SeqJobNumber]),
			@UpdateScheduleStatusid = dbo.GetStatusId(1,'ScheduleStatus','JG') 
		End
 		MERGE [dbo].[Jobs] AS [target] 
		USING (
			SELECT @JobId 
			) AS source(JobId)
			ON ([target].[JobId] = [source].[JobId])
		WHEN MATCHED
			THEN 
				UPDATE 
				SET    
				 ClientSiteId = @ClientSiteId
				,ScheduleSetupId = @ScheduleSetupId 
				,AnalystId = @AnalystId
				,EstStartDate = @EstStartDate
				,EstEndDate = @EstEndDate
				,JobName = @JobName
			 WHEN NOT MATCHED BY TARGET
			THEN
				INSERT ( 
				 ClientSiteId  
				,ScheduleSetupId
				,JobNumber 
				,JobName 
				,EstStartDate
				,EstEndDate				
				,DataCollectionDate 
				,ReportDate 
				,AnalystId 
				,StatusId 
				,CreatedBy
					)
				VALUES ( 
				 @ClientSiteId  
				,@ScheduleSetupId
				,@JobNumber 
				,@JobName 
				,@EstStartDate
				,@EstEndDate
				,@EstStartDate 
				,@EstEndDate 
				,@AnalystId 
				,@StatusId  
				,@UserId
					) OUTPUT INSERTED.JobId
				INTO @Created ;
			    
				SELECT @JobId = [JobId]
				FROM @Created; 

				if isnull(@UpdateScheduleStatusid,0) > 0 and isnull(@ScheduleSetupId,0) > 0
				Begin
					Update ScheduleSetup set StatusId =	@UpdateScheduleStatusid where ScheduleSetupId = @ScheduleSetupId
				End
 ---- Process Start Report Service------
	DECLARE @JobServiceId int, @ServiceId int , @JActive varchar(1)
	
	DROP TABLE IF EXISTS #LoadReportJson

	CREATE TABLE #LoadReportJson
	(
	  LoaderId int not null identity(1,1),
	  JobServiceId int, 
	  ServiceId int,
	  Active varchar(1) 
	) 

Insert into #LoadReportJson (JobServiceId,ServiceId,Active)
SELECT
    JSON_Value (c.value, '$.JobServiceId') as JobServiceId, 
	JSON_Value (c.value, '$.ServiceId') as ServiceId, 
	JSON_Value (c.value, '$.Active') as Active  
FROM OPENJSON ( @JobServicesJson , '$.JobServices') as c 
 
  
DECLARE GetJobServiceIdCur CURSOR READ_ONLY
    FOR
    SELECT JobServiceId,ServiceId,Active
	from #LoadReportJson  

    OPEN GetJobServiceIdCur
    FETCH NEXT FROM GetJobServiceIdCur INTO
    @JobServiceId, @ServiceId, @JActive
    WHILE @@FETCH_STATUS = 0
		BEGIN
		 	MERGE [dbo].[JobServices] AS [target]
			USING (
				SELECT @JobServiceId
				) AS source(JobServiceId)
				ON ([target].[JobServiceId] = [source].[JobServiceId] )
			WHEN MATCHED
				THEN 
					UPDATE
					SET Active = @JActive
			WHEN NOT MATCHED BY TARGET  
					THEN
						INSERT (  
						 JobId
						,ServiceId
						,Active
						,CreatedBy
							)
						VALUES ( 
						 @JobId
						,@ServiceId  
						,@JActive
						,@UserId
							)
						; 
		FETCH NEXT FROM GetJobServiceIdCur INTO	@JobServiceId,@ServiceId,@JActive
		END
    CLOSE GetJobServiceIdCur
    DEALLOCATE GetJobServiceIdCur
 ---- Process End Report Service------				
 ---- Process Start Equipment ------
	DECLARE @JobEquipmentId int, @EquipmentId int, @EJServiceId int, @EStatusId int, @EActive varchar(1)
	Declare @DRCount int ,@DNCount int, @INCount int

	DROP TABLE IF EXISTS #LoadEquipmentJson

	CREATE TABLE #LoadEquipmentJson
	(
		LoaderId int not null identity(1,1),
		JobEquipmentId Bigint, 
		EquipmentId Bigint,
		Active Varchar(1) 
	) 
Select @EStatusId = dbo.GetStatusId(1,'JobProcessStatus','NS') 
Insert into #LoadEquipmentJson (JobEquipmentId,EquipmentId,Active)
SELECT
    JSON_Value (c.value, '$.JobEquipmentId') as JobEquipmentId, 
	JSON_Value (c.value, '$.EquipmentId') as EquipmentId ,
	JSON_Value (c.value, '$.Active') as Active 
FROM OPENJSON ( @JobEquipmentsJson , '$.JobEquipments') as c 
 
 set @AnalystId = case when @AnalystId = 0 then null else @AnalystId end 
  
DECLARE GetJobEquipmentIdCur CURSOR READ_ONLY
    FOR
    SELECT j.JobEquipmentId,j.EquipmentId,s.ServiceId, j.Active 
	from #LoadEquipmentJson  j cross join #LoadReportJson s 
	where s.Active = 'Y'
 
    OPEN GetJobEquipmentIdCur
    FETCH NEXT FROM GetJobEquipmentIdCur INTO
    @JobEquipmentId, @EquipmentId,@EJServiceId, @EActive 
    WHILE @@FETCH_STATUS = 0
		BEGIN  
		      select @DRCount = count(*) from EquipmentDriveUnit du join DriveServices dr   on dr.DriveUnitId = du.DriveUnitId   and ReportId = @EJServiceId  and dr.Active = 'Y'
					where du.EquipmentId = @EquipmentId
			  select @DNCount = count(*) from EquipmentDrivenUnit du join DrivenServices dr   on dr.DrivenUnitId = du.DrivenUnitId   and ReportId = @EJServiceId  and dr.Active = 'Y'
					where du.EquipmentId = @EquipmentId
			  select @INCount = count(*) from EquipmentIntermediateUnit du join IntermediateServices dr   on dr.IntermediateUnitId = du.IntermediateUnitId   and ReportId = @EJServiceId  and dr.Active = 'Y'
					where du.EquipmentId = @EquipmentId 
			if (isnull(@DRCount,0) + isnull(@DNCount,0) + isnull (@INCount,0) ) > 0
			Begin
		 		MERGE [dbo].[JobEquipment] AS [target]
				USING (
					SELECT @JobId, @EquipmentId, @EJServiceId
					) AS source(JobId, EquipmentId, EJServiceId)
					ON (
					[target].[JobId] = [source].[JobId] 
					and [target].[EquipmentId] = [source].[EquipmentId]
					and [target].[ServiceId] = [source].[EJServiceId]          
					)
				WHEN MATCHED THEN
					UPDATE SET Active = @EActive , AnalystId = @AnalystId
 				WHEN NOT MATCHED BY TARGET
						THEN
							INSERT (  
							 JobId
							,EquipmentId
							,ServiceId
							,StatusId
							,AnalystId
							,Active
							,CreatedBy
							,DataCollectionDate
							,ReportDate
								)
							VALUES (  
							 @JobId
							,@EquipmentId 
							,@EJServiceid
							,@EStatusId
							,@AnalystId
							,@EActive
							,@UserId
							,@EststartDate
							,@EstEndDate
								)
							;
		End
		FETCH NEXT FROM GetJobEquipmentIdCur INTO	@JobEquipmentId, @EquipmentId, @EJServiceid, @EActive
		END
    CLOSE GetJobEquipmentIdCur
    DEALLOCATE GetJobEquipmentIdCur
 ---- Process End Equipment ------ 
	
	COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveJobComment]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppSaveJobComment] @JobCommentId Bigint
	,@JobId Bigint
	,@StatusId Int 
	,@DatacollectionDone int
	,@ReportSent int
	,@Comments nvarchar(2500)
	,@DataCollectionDate Date
	,@ReportDate Date
	,@Active varchar(1)
	,@UserId int
	,@IsWarningAccepted int
	,@ReviewerId int
	,@Result varchar(1) OUTPUT
	,@ResultText nvarchar(2500) OUTPUT 
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY 
	Declare @SubmitStatus int ,@DCNStatus varchar(1), @CUDCUCount int, @OUDCUCount int, @OUDCSCount int, @JobCompleted int , @JobNotStarted int, @JobInprogress int
	Select @JobNotStarted = dbo.GetStatusId(1,'JobProcessStatus','NS') , @JobInprogress = dbo.GetStatusId(1,'JobProcessStatus','IP') ,  @SubmitStatus = dbo.GetStatusId(1,'JobProcessStatus','SU') ,@JobCompleted = dbo.GetStatusId(1,'JobProcessStatus','C') 
	If isnull(@DatacollectionDone,0) <> 0 or isnull(@DataCollectionDate,'')<> '' or isnull(@ReportDate,'') <> '' or isnull(@StatusId,0) <> 0 or isnull(@ReviewerId,0) <> 0
	Begin
		set @DCNStatus = 'N'
		if isnull(@DatacollectionDone,0) = 1
		Begin
	     	Update JobEquipment set DataCollectionDone = 1 where jobid = @Jobid and DataCollectorId = @UserId and DataCollectionDone = 0;
			Select @CUDCUCount = count(case when isnull(DatacollectorId,0) = @userId then 1 else 0 end)  ,
			@OUDCUCount = count(case when isnull(DatacollectorId,0) <> @userId then 1 else 0 end),
			@OUDCSCount = count(case when (isnull(DatacollectorId,0) <> @userId and isnull(DatacollectionDone,0) = 1 )then 1 else 0 end)  
			from JobEquipment where JobId = @JobId
			 
			If (isnull(@OUDCUCount,0) > 0 and isnull(@OUDCUCount,0) = isnull(@OUDCSCount,0))
			Begin
				Set @DCNStatus = 'Y'
			End
			Else If (isnull(@OUDCUCount,0) > 0 and isnull(@OUDCUCount,0) <> isnull(@OUDCSCount,0))
			Begin
				Set @DCNStatus = 'P'
			End

		End
		MERGE [dbo].[JobS] AS [target]
		USING (
			SELECT @JobId
			) AS source(JobId)
			ON ([target].[JobId] = [source].[JobId])
		WHEN MATCHED  
			THEN
			UPDATE SET 
			 DataCollectionDate = case when Isnull(@DataCollectionDate,'') <> '' then @DataCollectionDate else  DataCollectionDate end
			,ReportDate = case when Isnull(@ReportDate,'') <> '' then @ReportDate else  ReportDate end
		    ,DataCollectionDone = case when @DCNStatus <> 'N' then @DCNStatus else DataCollectionDone end
			,ReportSent = isnull(@ReportSent,0)
			; 
 
		if isnull(@ReportSent,0) = 1
		Begin
			Update JobEquipment set ReportSent = 1 where jobid = @Jobid and ReviewerId = @UserId and ReportSent = 0;
		End 
	End
		set @Result = 'N'		
		if  isnull(@StatusId,0) <> 0  
		Begin
		Declare @ECStatusId int	,@NStatusId int  ,@ECNewStatusId int, @ECSNRStatusId int 
		Select @ECStatusId = dbo.GetStatusId(1,'JobProcessStatus','SU') 
		if @ECStatusId = @StatusId  and isnull(@ISWarningAccepted,0) = 0 
		Begin
			EXEC [dbo].[EAppECJob]@JobId,@StatusId,@Result = @Result OUTPUT, @ResultText = @ResultText OUTPUT, @NStatusId = @NStatusId OUTPUT
			if @Result = 'S'
			Begin
				Update Jobs set statusid = @NStatusId where JobId = @JobId 
				set @StatusId = @NStatusId
			End

		End
		else if @ECStatusId = @StatusId  and isnull(@ISWarningAccepted,0) = 1
		Begin  
			Select @ECNewStatusId = dbo.GetStatusId(1,'JobProcessStatus','NS') , @ECSNRStatusId =  dbo.GetStatusId(1,'JobProcessStatus','NA') 
			DECLARE @JobEquipList TABLE (
			[jobEquipmentId] Bigint
			,PRIMARY KEY ([jobEquipmentId])
			); 
			Insert into @JobEquipList(jobEquipmentId)
			select JobEquipmentId from JobEquipment where JobId = @JobId and StatusId = @ECNewStatusId 
		    
			Update JobEquipUnitAnalysis set StatusId = @ECSNRStatusId 
			where JobEquipmentId in (select jobEquipmentId from @JobEquipList) and StatusId = @ECNewStatusId
			Update JobEquipment set StatusId = @ECSNRStatusId where JobId = @JobId and StatusId = @ECNewStatusId

			EXEC [dbo].[EAppECJob]	 @JobId,@StatusId,@NStatusId = @NStatusId OUTPUT, @Result = @Result OUTPUT, @ResultText = @ResultText OUTPUT
			set @StatusId = @NStatusId
			if @Result = 'S'
			Begin
				Update Jobs set statusid = @NStatusId where JobId = @JobId 
				set @ResultText = 'System marked as Service Not Required for associated Equipments and Assets under this Job in "Not Started" Status, and Submitted this Job'
			End
		End	
		if isnull(@StatusId,0) <> 0 and @Result = 'N'
			Update Jobs set statusid = @StatusId where JobId = @JobId
	
		if isnull(@JobCompleted,0) = @StatusId
		Begin
			Update JobEquipment set StatusId = @StatusId,  ReviewDone = 1 where ReviewerId = @UserId and statusid = @ECStatusId
			-- Work Notification Process Starts
			Exec [EAppSaveJobWorkNotifcation] @JobId,@UserId
		End
		if isnull(@DatacollectionDone,0) = 1 
		Begin
			Update Jobs set statusid =  @JobInprogress  
			where JobId = @JobId and statusid = @JobNotStarted
		End

		If @Result in('F','W')
		select @Comments = case when @Result = 'F' then 'System: Job Submit Prerequest check Failed' when @Result = 'W' then 'System:Job Submit Prerequest check Warning' end
	End
  if isnull(@Comments,'') <> ''	 
	Begin
	MERGE [dbo].[JobComments] AS [target]
	USING (
		SELECT @JobCommentId
		) AS source(JobCommentId)
		ON ([target].[JobCommentId] = [source].[JobCommentId])
	WHEN NOT MATCHED BY TARGET
		THEN
			INSERT (
					JobId
					,StatusId
					,Comments
					,Active
					,Createdby					  
				)
			VALUES ( 
					@JobId
					,@StatusId
					,@Comments
					,@Active
					,@UserId
				);

	End
	  COMMIT TRANSACTION; 
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
 
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveJobEquipmentComment]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppSaveJobEquipmentComment] 
     @JobEquipCommentId Bigint
	,@JobEquipmentId Bigint
	,@StatusId Int
	,@DataCollectionDate Date
	,@ReportDate Date
	,@Comments nvarchar(2500)
	,@ConditionId int
	,@EquipmentComment nvarchar(1500)
	,@Active varchar(1)
	,@UserId int
	,@Result varchar(1) OUTPUT
	,@ResultText nvarchar(2500) OUTPUT
	,@IsWarningAccepted int
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
	Declare @JCStatusId int
	MERGE [dbo].[JobEquipment] AS [target]
		USING (
			SELECT @JobEquipmentId
			) AS source(JobEquipmentId)
			ON ([target].[JobEquipmentId] = [source].[JobEquipmentId])
		WHEN MATCHED  
			THEN
			UPDATE SET 
			ConditionId = case when Isnull(@ConditionId,0) <> 0 then @ConditionId else  ConditionId end 
			,Comment = case when Isnull(@EquipmentComment,'') <> '' then @EquipmentComment else  Comment end
			,DataCollectionDate = case when Isnull(@DataCollectionDate,'') <> '' then @DataCollectionDate else  DataCollectionDate end
			,ReportDate = case when Isnull(@ReportDate,'') <> '' then @ReportDate else  ReportDate end
			;
		set @Result = 'N'		
		if  isnull(@StatusId,0) <> 0 or isnull(@ConditionId,0) <> 0  or Isnull(@EquipmentComment,'') <> '' or Isnull(@DataCollectionDate,'') <> '' or Isnull(@ReportDate,'') <> '' 
		Begin
		Declare @ECStatusId int	,@NStatusId int  ,@ECNewStatusId int, @ECSNRStatusId int 
		Select @ECStatusId = dbo.GetStatusId(1,'JobProcessStatus','SU') , @JCStatusId = dbo.GetStatusId(1,'JobProcessStatus','C')
		if @ECStatusId = @StatusId  and isnull(@ISWarningAccepted,0) = 0 
		Begin
			EXEC [dbo].[EAppECJobEquipment]	 @JobEquipmentId,@StatusId,@UserId,@IsWarningAccepted,@NStatusId = @NStatusId OUTPUT, @Result = @Result OUTPUT, @ResultText = @ResultText OUTPUT
			if @Result = 'S'
			Begin
				Update JobEquipment set statusid = @NStatusId where JobEquipmentId = @JobEquipmentId 
				update JobEquipUnitAnalysis set statusid = @NStatusId where JobEquipmentId = @JobEquipmentId
			End

			set @StatusId = @NStatusId
		End
		else if @ECStatusId = @StatusId  and isnull(@ISWarningAccepted,0) = 1
		Begin  
			Select @ECNewStatusId = dbo.GetStatusId(1,'JobProcessStatus','NS') , @ECSNRStatusId =  dbo.GetStatusId(1,'JobProcessStatus','NA') 
			Update JobEquipUnitAnalysis set DatavalidationStatus = 9 where JobEquipmentId = @JobEquipmentId and DatavalidationStatus = 0
			EXEC [dbo].[EAppECJobEquipment]	 @JobEquipmentId,@StatusId,@UserId,@IsWarningAccepted,@NStatusId = @NStatusId OUTPUT, @Result = @Result OUTPUT, @ResultText = @ResultText OUTPUT
			set @StatusId = @NStatusId
			if @Result = 'S'
			Begin
			Update JobEquipment set statusid = @NStatusId where JobEquipmentId = @JobEquipmentId 
			update JobEquipUnitAnalysis set statusid = @NStatusId where JobEquipmentId = @JobEquipmentId
			set @ResultText = 'System marked as [Service Not Required] for those Asset under this equiment in New Status, and Submitted this Equipment'
			End
		End	
		if isnull(@StatusId,0) <> 0 and @Result = 'N'
		Begin
			Update JobEquipment set ReviewDone = case when @StatusId = @JCStatusId then 1 else ReviewDone end
			,statusid = @StatusId where JobEquipmentId = @JobEquipmentId
			update JobEquipUnitAnalysis set statusid = @StatusId where JobEquipmentId = @JobEquipmentId
		End
	if @ECStatusId = @StatusId
	Begin --Auto Submit Job if all Equipments are Submitted  
		Declare @EquipCount int , @SU int, @NA int, @SUC int , @JobId Bigint
		Select @SU =  dbo.GetStatusId(1,'JobProcessStatus','SU') , @NA =  dbo.GetStatusId(1,'JobProcessStatus','NA') 
 		
		select @JobId = JobId from JobEquipment where JobEquipmentId = @JobEquipmentId
		select  @EquipCount = count(je.equipmentid),  
		@SUC = sum(Case when je.StatusId = @SU then 1 else 0 end) 
		from JobEquipment je	
		where je.JobId= @JobId and StatusId <> @NA and je.Active = 'Y'
		
		if isnull(@EquipCount,0) = isnull(@SUC,0)
		Begin
			Update Jobs set StatusId = @SU where JobId = @JobId;
				MERGE [dbo].[JobComments] AS [target]
				USING (
					SELECT 0
					) AS source(JobCommentId)
					ON ([target].[JobCommentId] = [source].[JobCommentId])
				WHEN NOT MATCHED BY TARGET
					THEN
						INSERT (
								JobId
								,StatusId
								,Comments
								,Active
								,Createdby					  
							)
						VALUES ( 
								 @JobId
								,@StatusId
								,'System: Job Auto Submitted up on Submitting all Equipments' 
								,@Active
								,@UserId
							); 
		End

	End

	If @Result in('F','W')
	select @Comments = case when @Result = 'F' then 'System: Equipment Submit Prerequest Failed' when @Result = 'W' then 'System:Equipment Submit Prerequest Warning' end
	  if isnull(@Comments,'') <> ''
	  Begin
			MERGE [dbo].[JobEquipmentComments] AS [target]
		USING (
			SELECT @JobEquipCommentId
			) AS source(JobEquipCommentId)
			ON ([target].[JobEquipCommentId] = [source].[JobEquipCommentId])
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					  JobEquipmentId
					 ,Statusid
					 ,Comments
					 ,Active
					 ,Createdby					  
					)
				VALUES ( 
					  @JobEquipmentId
					 ,@StatusId
					 ,@Comments
					 ,@Active
					 ,@UserId
					);

   End
 				
	End

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveJobEquipmentOilProperties]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppSaveJobEquipmentOilProperties]
  @JobEquipOilPropertiesId  bigint,
  @JobEquipmentId bigint,
  @OilPropertiesId  int ,
  @OilLevel nvarchar(250) ,
  @SeverityId int  NULL,
  @OAVibChangePercentageId int , 
  @Active VARCHAR(1),
  @UserId INT 
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
 
	MERGE [dbo].[JobEquipmentOilProperties] AS [target]
		USING (
			SELECT @JobEquipOilPropertiesId 
			) AS source(JobEquipOilPropertiesId)
			ON ([target].[JobEquipOilPropertiesId] = [source].[JobEquipOilPropertiesId])
		WHEN MATCHED
			THEN
				UPDATE
				SET Active = @Active
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
				 JobEquipmentId 
				,OilPropertiesId
				,OilLevel 
				,SeverityId
				,OAVibChangePercentageId
				,Active
				,CreatedBy
					)
				VALUES (
				 @JobEquipmentId 
				,@OilPropertiesId
				,@OilLevel 
				,@SeverityId
				,@OAVibChangePercentageId
				,@Active
				,@UserId);
  
		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveJobEquipUnitAnalysisComments]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppSaveJobEquipUnitAnalysisComments] 
	@UnitAnalysisId Bigint
	,@JobEquipmentId Bigint
	,@ServiceId int
	,@UnitType varchar(3)
	,@UnitId int
	,@StatusId Int 
	,@Comments nvarchar(2500)
	,@Active varchar(1)
	,@UserId int
	,@Result Varchar(1) OUTPUT
	,@ResultText nvarchar(2500) OUTPUT
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
		Declare @UnitAnalysisCommentId int ,@ECStatusId int, @NStatusId int

  		DECLARE @Created TABLE (
			[UnitAnalysisId] Bigint
			,PRIMARY KEY ([UnitAnalysisId])
			);
 
  		MERGE [dbo].[JobEquipUnitAnalysis] AS [target] 
		USING (
			SELECT @UnitAnalysisId 
			) AS source(UnitAnalysisId)
			ON ([target].[UnitAnalysisId] = [source].[UnitAnalysisId])
			WHEN NOT MATCHED BY TARGET
			THEN
				INSERT ( 
				JobEquipmentId 
				,ServiceId 
				,UnitType  
				,UnitId  
				,StatusId
				,CreatedBy
					)
				VALUES ( 
				@JobEquipmentId  
				,@ServiceId 
				,@UnitType 
				,@UnitId
				,@StatusId  
				,@UserId 
				) OUTPUT INSERTED.UnitAnalysisId
				INTO @Created ;
			    
				SELECT @UnitAnalysisId = [UnitAnalysisId]
				FROM @Created; 
				
				Select @ECStatusId = dbo.GetStatusId(1,'JobProcessStatus','SU') 
				if @ECStatusId = @StatusId
				Begin
					EXEC [dbo].[EAppECJobEquipUnitAnalysis]	 @UnitAnalysisId,@StatusId,@UserId,@NStatusId = @NStatusId OUTPUT, @Result = @Result OUTPUT, @ResultText = @ResultText OUTPUT
					set @StatusId = @NStatusId
				End

				Update JobEquipUnitAnalysis set StatusId = @StatusId where UnitAnalysisId = @UnitAnalysisId;

				If @Result in('F','W')
					select @Comments = case when @Result = 'F' then 'System: Submit Prerequest Failed' when @Result = 'W' then 'System: Submit Prerequest Warning' end
		 
		Set @UnitAnalysisCommentId = 0;
		if isnull(@comments,'') <> ''  
		Begin 
			MERGE [dbo].[JobEquipmentUnitAnalysisComments] AS [target]
			USING (
				SELECT @UnitAnalysisCommentId
				) AS source(UnitAnalysisCommentId)
				ON ([target].[UnitAnalysisCommentId] = [source].[UnitAnalysisCommentId])
			WHEN NOT MATCHED BY TARGET
				THEN
					INSERT (
						  UnitAnalysisId
						 ,Statusid
						 ,Comments
						 ,Active
						 ,Createdby					  
						)
					VALUES ( 
						  @UnitAnalysisId
						 ,@Statusid
						 ,@Comments
						 ,@Active
						 ,@UserId
						);

		End
		COMMIT TRANSACTION
 
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveJobEquipUnitSelected]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppSaveJobEquipUnitSelected] 
	 @JobEquipmentId Bigint 
	,@ServiceId int    
	,@UnitType  varchar(3) 
	,@UnitId Bigint  
	,@StatusId int
	,@UserId int
	,@LanguageId int 
AS
BEGIN
 	BEGIN TRANSACTION
	BEGIN TRY
	Declare @UnitAnalysisId Bigint, @UnitAmplitudeJson nvarchar(max) , @UnitSymptomsJson nvarchar(max) 
	Set @UnitAnalysisId = 0
 	Select  @StatusId = dbo.GetStatusId(1,'JobProcessStatus','NS');
   		DECLARE @Created TABLE (
			[UnitAnalysisId] Bigint
			,PRIMARY KEY ([UnitAnalysisId])
			);
 
  		MERGE [dbo].[JobEquipUnitAnalysis] AS [target] 
		USING (
			SELECT @UnitAnalysisId 
			) AS source(UnitAnalysisId)
			ON ([target].[UnitAnalysisId] = [source].[UnitAnalysisId])
 			 WHEN NOT MATCHED BY TARGET
			THEN
				INSERT ( 
				JobEquipmentId 
				,ServiceId 
				,UnitType  
				,UnitId  
				,StatusId
				,CreatedBy
					)
				VALUES ( 
				 @JobEquipmentId  
				,@ServiceId 
				,@UnitType 
				,@UnitId  
				,@StatusId
				,@UserId 
				) OUTPUT INSERTED.UnitAnalysisId
				INTO @Created ;
			    
				SELECT @UnitAnalysisId = [UnitAnalysisId]
				FROM @Created; 
---- Process Start Unit Systems ------
	DECLARE @ServiceType varchar(3) , @UnitSymptomsId Bigint, @SymptomTypeId int, @FrequencyId int, @FailureModeId Int, @IndicatedFaultId int, @Symptoms nvarchar (1500), @Active Varchar(1)
	
	Declare @SymptomsTemplate Table(SymptomJsonTemplate nvarchar(max))
	Set @ServiceType = isnull(dbo.GetLookupTranslated(@ServiceId, @LanguageId,'LookupCode'),'')
	
	Insert into @SymptomsTemplate(SymptomJsonTemplate)
	Exec [EAppGetUnitSymptomsTemplate] @UnitType,@ServiceType,@LanguageId
	Select @UnitSymptomsJson = SymptomJsonTemplate from @SymptomsTemplate

	DROP TABLE IF EXISTS #LoadUnitSymptomsJson
	
	CREATE TABLE #LoadUnitSymptomsJson
	(
	  LoaderId int not null identity(1,1),
      UnitSymptomsId Bigint, 
      UnitAnalysisId Bigint, 
      SymptomTypeId int, 
      FrequencyId int,
	  FailureModeId int,
      IndicatedFaultId int,
      Symptoms nvarchar (1500),
      Active Varchar(1)
	) 
	 
Insert into #LoadUnitSymptomsJson (UnitSymptomsId,UnitAnalysisId,SymptomTypeId,FrequencyId, FailureModeId ,IndicatedFaultId,Symptoms,Active)
SELECT
    JSON_Value (c.value, '$.UnitSymptomsId') as UnitSymptomsId, 
	JSON_Value (c.value, '$.UnitAnalysisId') as UnitAnalysisId,
	JSON_Value (c.value, '$.SymptomTypeId') as SymptomTypeId,
	JSON_Value (c.value, '$.FrequencyId') as FrequencyId,
	JSON_Value (c.value, '$.FailureModeId') as FailureModeId,
	JSON_Value (c.value, '$.IndicatedFaultId') as IndicatedFaultId,
	JSON_Value (c.value, '$.Symptoms') as Symptoms,
	JSON_Value (c.value, '$.Active') as Active
FROM OPENJSON ( @UnitSymptomsJson) as c 
  
DECLARE GetJobUnitSymptomsCur CURSOR READ_ONLY
    FOR
    SELECT UnitSymptomsId,SymptomTypeId,FrequencyId, case when FailureModeId = 0 then null else FailureModeId end FailureModeId ,case when IndicatedFaultId = 0 then null else IndicatedFaultId end IndicatedFaultId,Symptoms,Active
	from #LoadUnitSymptomsJson  

    OPEN GetJobUnitSymptomsCur
    FETCH NEXT FROM GetJobUnitSymptomsCur INTO
    @UnitSymptomsId,@SymptomTypeId,@FrequencyId, @FailureModeId ,@IndicatedFaultId,@Symptoms,@Active 
    WHILE @@FETCH_STATUS = 0
		BEGIN 
		 	MERGE [dbo].[JobEquipUnitSymptoms] AS [target]
			USING (
				SELECT @UnitSymptomsId
				) AS source(UnitSymptomsId)
				ON ([target].[UnitSymptomsId] = [source].[UnitSymptomsId])
 			WHEN NOT MATCHED BY TARGET
					THEN
						INSERT (  
						 UnitAnalysisId,
						 SymptomTypeId,
						 FrequencyId,
						 FailureModeId,
						 IndicatedFaultId,
						 Symptoms,
						 Active, 
						 CreatedBy
							)
						VALUES (  
						  @UnitAnalysisId
						 ,@SymptomTypeId
						 ,@FrequencyId
						 ,@FailureModeId
						 ,@IndicatedFaultId
						 ,@Symptoms
						 ,@Active 
						 ,@UserId
							)
						;
		FETCH NEXT FROM GetJobUnitSymptomsCur INTO @UnitSymptomsId,@SymptomTypeId,@FrequencyId, @FailureModeId ,@IndicatedFaultId,@Symptoms,@Active
		END
    CLOSE GetJobUnitSymptomsCur
    DEALLOCATE GetJobUnitSymptomsCur
 ---- Process End UnitAnalysis ------
 
 ---- Process Amplitude start------
 
 	DECLARE @UnitAmplitudeId Bigint, @OAVibration nvarchar(250), @OAGELevelPkPk nvarchar(250), @OASensorDirection int, @OASensorLocation int,@OAVibChangePercentage int, @AActive Varchar(1)
	set @UnitAmplitudeJson = '[{
                    "UnitAmplitudeId": 0,
                    "UnitAnalysisId": 0,
                    "OAVibration": null,
                    "OAGELevelPkPk": null,
                    "OASensorDirection": null,
                    "OASensorLocation": null,
                    "OAVibChangePercentage": null,
                    "Active": "Y"
                },
                {
                    "UnitAmplitudeId": 0,
                    "UnitAnalysisId": 0,
                    "OAVibration": null,
                    "OAGELevelPkPk": null,
                    "OASensorDirection": null,
                    "OASensorLocation": null,
                    "OAVibChangePercentage": null,
                    "Active": "Y"
                },
                {
                    "UnitAmplitudeId": 0,
                    "UnitAnalysisId": 0,
                    "OAVibration": null,
                    "OAGELevelPkPk": null,
                    "OASensorDirection": null,
                    "OASensorLocation": null,
                    "OAVibChangePercentage": null,
                    "Active": "Y"
                }]'
	DROP TABLE IF EXISTS #LoadUnitAmplitudeJson

	CREATE TABLE #LoadUnitAmplitudeJson
	(
	  LoaderId int not null identity(1,1),
      UnitAmplitudeId Bigint, 
      UnitAnalysisId Bigint, 
      OAVibration nvarchar(250),
	  OAGELevelPkPk nvarchar(250), 
	  OASensorDirection int,
	  OASensorLocation int,
	  OAVibChangePercentage int,
      Active Varchar(1)
	) 
	 
Insert into #LoadUnitAmplitudeJson (UnitAmplitudeId,UnitAnalysisId,OAVibration,OAGELevelPkPk,OASensorDirection,OASensorLocation,OAVibChangePercentage,Active)
SELECT
    JSON_Value (c.value, '$.UnitAmplitudeId') as UnitAmplitudeId, 
	JSON_Value (c.value, '$.UnitAnalysisId') as UnitAnalysisId,
	JSON_Value (c.value, '$.OAVibration') as OAVibration,
	JSON_Value (c.value, '$.OAGELevelPkPk') as OAGELevelPkPk,
	JSON_Value (c.value, '$.OASensorDirection') as OASensorDirection,
	JSON_Value (c.value, '$.OASensorLocation') as OASensorLocation,
	JSON_Value (c.value, '$.OAVibChangePercentage') as OAVibChangePercentage,
	JSON_Value (c.value, '$.Active') as Active
FROM OPENJSON ( @UnitAmplitudeJson  ) as c 
  
DECLARE GetJobUnitAmplitudeCur CURSOR READ_ONLY
    FOR
    SELECT UnitAmplitudeId,OAVibration,OAGELevelPkPk,OASensorDirection,OASensorLocation,OAVibChangePercentage,Active
	from #LoadUnitAmplitudeJson  

    OPEN GetJobUnitAmplitudeCur
    FETCH NEXT FROM GetJobUnitAmplitudeCur INTO
    @UnitAmplitudeId,@OAVibration,@OAGELevelPkPk,@OASensorDirection,@OASensorLocation,@OAVibChangePercentage,@AActive
    WHILE @@FETCH_STATUS = 0
		BEGIN
		 	MERGE [dbo].[JobEquipUnitAmplitude] AS [target]
			USING (
				SELECT @UnitAmplitudeId
				) AS source(UnitAmplitudeId)
				ON ([target].[UnitAmplitudeId] = [source].[UnitAmplitudeId])
			WHEN MATCHED THEN
				UPDATE SET
						 OAVibration = @OAVibration
						 ,OAGELevelPkPk = @OAGELevelPkPk
						 ,OASensorDirection = @OASensorDirection
						 ,OASensorLocation = @OASensorLocation
						 ,OAVibChangePercentage = @OAVibChangePercentage
						 ,Active = @Active 
 			WHEN NOT MATCHED BY TARGET
					THEN
						INSERT (  
 						 UnitAnalysisId,
						 OAVibration,
						 OAGELevelPkPk,
						 OASensorDirection,
						 OASensorLocation,
						 OAVibChangePercentage,
						 Active, 
						 CreatedBy
							)
						VALUES (  
						  @UnitAnalysisId
						 ,@OAVibration
						 ,@OAGELevelPkPk
						 ,@OASensorDirection
						 ,@OASensorLocation
						 ,@OAVibChangePercentage
						 ,@Active 
						 ,@UserId
						 )
						;
		FETCH NEXT FROM GetJobUnitAmplitudeCur INTO @UnitAmplitudeId,@OAVibration,@OAGELevelPkPk,@OASensorDirection,@OASensorLocation,@OAVibChangePercentage,@AActive
		END
    CLOSE GetJobUnitAmplitudeCur
    DEALLOCATE GetJobUnitAmplitudeCur
	COMMIT TRANSACTION 
		 
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveJobUnitAnalysis]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EAppSaveJobUnitAnalysis]
	 @UnitAnalysisId Bigint 
	,@JobEquipmentId Bigint 
	,@ServiceId int    
	,@UnitType  varchar(3) 
	,@UnitId Bigint 
	,@ConditionId Int
	,@ConfidentFactorId int
	,@FailureProbFactorId Int
	,@PriorityId int
	,@IsWorkNotification Varchar(1)
	,@NoOfDays Decimal(4,2)
	,@Recommendation nVarchar(1500)
	,@Comment nVarchar(2500)
    ,@UnitSymptomsJson nvarchar(max)
	,@UnitAmplitudeJson nvarchar(max)
	,@StatusId int
	,@UserId int
	,@IsEC varchar(1) 
	,@Result Varchar(1) OUTPUT
	,@ResultText nvarchar(2500) OUTPUT
AS
BEGIN
 	BEGIN TRANSACTION
	BEGIN TRY
		Declare @OldStatusid int, @UpdateEquipStatusid int, @WNConditionCheck int , @WNPriorityCheck varchar(30), @NStatusId int
  		DECLARE @Created TABLE (
			[UnitAnalysisId] Bigint
			,PRIMARY KEY ([UnitAnalysisId])
			);
		set @UpdateEquipStatusid =dbo.GetStatusId(1,'JobProcessStatus','IP');;
		Set @OldStatusid = 0;

		select @WNConditionCheck =  cast(isnull(dbo.GetLookupTranslated(@ConditionId,1,'LookupCode'),0) as int) 
			,@WNPriorityCheck =  isnull(dbo.GetLookupTranslated(@PriorityId,1,'LookupCode'),'')
		select  @IsWorkNotification = case when (isnull(@WNConditionCheck,0) > 1 and isnull(@WNPriorityCheck,'') in ('DPIA','DPRC')) then 'Y' else 'N' end
 
 
  		MERGE [dbo].[JobEquipUnitAnalysis] AS [target] 
		USING (
			SELECT @UnitAnalysisId 
			) AS source(UnitAnalysisId)
			ON ([target].[UnitAnalysisId] = [source].[UnitAnalysisId])
		WHEN MATCHED
			THEN 
				UPDATE 
				SET    
				JobEquipmentId = @JobEquipmentId  
				,ServiceId = @ServiceId 
				,UnitType = @UnitType
				,UnitId = @UnitId 
				,ConditionId = @ConditionId 
				,ConfidentFactorId = @ConfidentFactorId 
				,FailureProbFactorId = @FailureProbFactorId 
				,PriorityId = @PriorityId 
				,IsWorkNotification = @IsWorkNotification 
				,NoOfDays = @NoOfDays 
				,Recommendation = @Recommendation 
				,Comment = @Comment 
				,StatusId = @StatusId 
			 WHEN NOT MATCHED BY TARGET
			THEN
				INSERT ( 
				JobEquipmentId 
				,ServiceId 
				,UnitType  
				,UnitId 
				,ConditionId 
				,ConfidentFactorId 
				,FailureProbFactorId  
				,PriorityId 
				,IsWorkNotification 
				,NoOfDays  
				,Recommendation 
				,Comment 
				,StatusId
				,CreatedBy
					)
				VALUES ( 
				@JobEquipmentId  
				,@ServiceId 
				,@UnitType 
				,@UnitId 
				,@ConditionId 
				,@ConfidentFactorId 
				,@FailureProbFactorId 
				,@PriorityId 
				,@IsWorkNotification 
				,@NoOfDays 
				,@Recommendation 
				,@Comment 
				,@StatusId
				,@UserId 
				) OUTPUT INSERTED.UnitAnalysisId
				INTO @Created ;
			    
				SELECT @UnitAnalysisId = [UnitAnalysisId]
				FROM @Created; 

				if  isnull(@UnitAnalysisId,0) > 0
				Begin
					Declare @JobId Bigint
					Update JobEquipment set StatusId =	@UpdateEquipStatusid where JobEquipmentId = @JobEquipmentId 
					Select @JobId = JobId from JobEquipment where JobEquipmentId = @JobEquipmentId
					Update Jobs set StatusId =@UpdateEquipStatusid where Jobid = @JobId
				End
				
 ---- Process Start Unit Systems ------
	DECLARE @UnitSymptomsId Bigint, @SymptomTypeId int, @FrequencyId int, @FailureModeId Int, @IndicatedFaultId int, @Symptoms nvarchar (1500), @Active Varchar(1)
	
	DROP TABLE IF EXISTS #LoadUnitSymptomsJson

	CREATE TABLE #LoadUnitSymptomsJson
	(
	  LoaderId int not null identity(1,1),
      UnitSymptomsId Bigint, 
      UnitAnalysisId Bigint, 
      SymptomTypeId int, 
      FrequencyId int,
	  FailureModeId int,
      IndicatedFaultId int,
      Symptoms nvarchar (1500),
      Active Varchar(1)
	) 
	 
Insert into #LoadUnitSymptomsJson (UnitSymptomsId,UnitAnalysisId,SymptomTypeId,FrequencyId, FailureModeId ,IndicatedFaultId,Symptoms,Active)
SELECT
    JSON_Value (c.value, '$.UnitSymptomsId') as UnitSymptomsId, 
	JSON_Value (c.value, '$.UnitAnalysisId') as UnitAnalysisId,
	JSON_Value (c.value, '$.SymptomTypeId') as SymptomTypeId,
	JSON_Value (c.value, '$.FrequencyId') as FrequencyId,
	JSON_Value (c.value, '$.FailureModeId') as FailureModeId,
	JSON_Value (c.value, '$.IndicatedFaultId') as IndicatedFaultId,
	JSON_Value (c.value, '$.Symptoms') as Symptoms,
	JSON_Value (c.value, '$.Active') as Active
FROM OPENJSON ( @UnitSymptomsJson , '$.JobUnitSymptomsList') as c 
  
DECLARE GetJobUnitSymptomsCur CURSOR READ_ONLY
    FOR
    SELECT UnitSymptomsId,SymptomTypeId,FrequencyId, case when FailureModeId = 0 then null else FailureModeId end FailureModeId ,case when IndicatedFaultId = 0 then null else IndicatedFaultId end IndicatedFaultId,Symptoms,Active
	from #LoadUnitSymptomsJson  

    OPEN GetJobUnitSymptomsCur
    FETCH NEXT FROM GetJobUnitSymptomsCur INTO
    @UnitSymptomsId,@SymptomTypeId,@FrequencyId, @FailureModeId ,@IndicatedFaultId,@Symptoms,@Active 
    WHILE @@FETCH_STATUS = 0
		BEGIN 
		 	MERGE [dbo].[JobEquipUnitSymptoms] AS [target]
			USING (
				SELECT @UnitSymptomsId
				) AS source(UnitSymptomsId)
				ON ([target].[UnitSymptomsId] = [source].[UnitSymptomsId])
			WHEN MATCHED THEN
				UPDATE SET  
						 SymptomTypeId = @SymptomTypeId
						 ,FrequencyId = @FrequencyId
						 ,FailureModeId = @FailureModeId
						 ,IndicatedFaultId = @IndicatedFaultId
						 ,Symptoms = @Symptoms
						 ,Active = @Active 
 			WHEN NOT MATCHED BY TARGET
					THEN
						INSERT (  
						 UnitAnalysisId,
						 SymptomTypeId,
						 FrequencyId,
						 FailureModeId,
						 IndicatedFaultId,
						 Symptoms,
						 Active, 
						 CreatedBy
							)
						VALUES (  
						  @UnitAnalysisId
						 ,@SymptomTypeId
						 ,@FrequencyId
						 ,@FailureModeId
						 ,@IndicatedFaultId
						 ,@Symptoms
						 ,@Active 
						 ,@UserId
							)
						;
		FETCH NEXT FROM GetJobUnitSymptomsCur INTO @UnitSymptomsId,@SymptomTypeId,@FrequencyId, @FailureModeId ,@IndicatedFaultId,@Symptoms,@Active
		END
    CLOSE GetJobUnitSymptomsCur
    DEALLOCATE GetJobUnitSymptomsCur
 ---- Process End UnitAnalysis ------
 
 ---- Process Amplitude start------
 
 	DECLARE @UnitAmplitudeId Bigint, @OAVibration nvarchar(250), @OAGELevelPkPk nvarchar(250), @OASensorDirection int, @OASensorLocation int,@OAVibChangePercentage int, @AActive Varchar(1)
	
	DROP TABLE IF EXISTS #LoadUnitAmplitudeJson

	CREATE TABLE #LoadUnitAmplitudeJson
	(
	  LoaderId int not null identity(1,1),
      UnitAmplitudeId Bigint, 
      UnitAnalysisId Bigint, 
      OAVibration nvarchar(250),
	  OAGELevelPkPk nvarchar(250), 
	  OASensorDirection int,
	  OASensorLocation int,
	  OAVibChangePercentage int,
      Active Varchar(1)
	) 
	 
Insert into #LoadUnitAmplitudeJson (UnitAmplitudeId,UnitAnalysisId,OAVibration,OAGELevelPkPk,OASensorDirection,OASensorLocation,OAVibChangePercentage,Active)
SELECT
    JSON_Value (c.value, '$.UnitAmplitudeId') as UnitAmplitudeId, 
	JSON_Value (c.value, '$.UnitAnalysisId') as UnitAnalysisId,
	JSON_Value (c.value, '$.OAVibration') as OAVibration,
	JSON_Value (c.value, '$.OAGELevelPkPk') as OAGELevelPkPk,
	JSON_Value (c.value, '$.OASensorDirection') as OASensorDirection,
	JSON_Value (c.value, '$.OASensorLocation') as OASensorLocation,
	JSON_Value (c.value, '$.OAVibChangePercentage') as OAVibChangePercentage,
	JSON_Value (c.value, '$.Active') as Active
FROM OPENJSON ( @UnitAmplitudeJson , '$.JobUnitAmplitudeList') as c 
  
DECLARE GetJobUnitAmplitudeCur CURSOR READ_ONLY
    FOR
    SELECT UnitAmplitudeId,OAVibration,OAGELevelPkPk,OASensorDirection,OASensorLocation,OAVibChangePercentage,Active
	from #LoadUnitAmplitudeJson  

    OPEN GetJobUnitAmplitudeCur
    FETCH NEXT FROM GetJobUnitAmplitudeCur INTO
    @UnitAmplitudeId,@OAVibration,@OAGELevelPkPk,@OASensorDirection,@OASensorLocation,@OAVibChangePercentage,@AActive
    WHILE @@FETCH_STATUS = 0
		BEGIN
		 	MERGE [dbo].[JobEquipUnitAmplitude] AS [target]
			USING (
				SELECT @UnitAmplitudeId
				) AS source(UnitAmplitudeId)
				ON ([target].[UnitAmplitudeId] = [source].[UnitAmplitudeId])
			WHEN MATCHED THEN
				UPDATE SET
						 OAVibration = @OAVibration
						 ,OAGELevelPkPk = @OAGELevelPkPk
						 ,OASensorDirection = @OASensorDirection
						 ,OASensorLocation = @OASensorLocation
						 ,OAVibChangePercentage = @OAVibChangePercentage
						 ,Active = @Active 
 			WHEN NOT MATCHED BY TARGET
					THEN
						INSERT (  
 						 UnitAnalysisId,
						 OAVibration,
						 OAGELevelPkPk,
						 OASensorDirection,
						 OASensorLocation,
						 OAVibChangePercentage,
						 Active, 
						 CreatedBy
							)
						VALUES (  
						  @UnitAnalysisId
						 ,@OAVibration
						 ,@OAGELevelPkPk
						 ,@OASensorDirection
						 ,@OASensorLocation
						 ,@OAVibChangePercentage
						 ,@Active 
						 ,@UserId
						 )
						;
		FETCH NEXT FROM GetJobUnitAmplitudeCur INTO @UnitAmplitudeId,@OAVibration,@OAGELevelPkPk,@OASensorDirection,@OASensorLocation,@OAVibChangePercentage,@AActive
		END
    CLOSE GetJobUnitAmplitudeCur
    DEALLOCATE GetJobUnitAmplitudeCur
 ---- Process Amplitude End------
  	EXEC [dbo].[EAppECJobEquipUnitAnalysis]	 @UnitAnalysisId,@StatusId,@UserId,@NStatusId = @NStatusId OUTPUT,@Result = @Result OUTPUT, @ResultText = @ResultText OUTPUT
 	if @Result in('E', 'S')
	Begin
		Update JobEquipUnitAnalysis set DataValidationStatus = case when @Result = 'S' then 1 when @Result = 'E' then 2 end,
		DataValidationText = case when @Result = 'E' then @ResultText else '' end 
		where UnitAnalysisId = @UnitAnalysisId;
	End
	
 		Declare @ECCode int  
		select top 1 @ECCode = l.LookupId from lookups l join JobEquipUnitAnalysis ju on ju.ConditionId = l.LookupId
		where ju.JobEquipmentId = @JobEquipmentId order by l.lookupcode desc 
		if isnull(@ECCode,0) <> 0
		Begin---Job Equipment Auto Condition Update.
			Update JobEquipment set ConditionId = @ECCode where JobEquipmentId = @JobEquipmentId;
		End 
	COMMIT TRANSACTION 
	SELECT UnitAnalysisId as UnitAnalysisId FROM @Created;

	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveJobUnitAnalysisAttachments]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppSaveJobUnitAnalysisAttachments] 
	 @UnitAnalysisAttachId bigint
	,@UnitAnalysisId bigint 
	,@FileName VARCHAR(500)
	,@LogicalName VARCHAR(500)
	,@PhysicalPath VARCHAR(500)
	,@Active VARCHAR(1)
	,@UserId INT 
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
 
	MERGE [dbo].[JobEquipUnitAnalysisAttachments] AS [target]
		USING (
			SELECT @UnitAnalysisAttachId 
			) AS source(UnitAnalysisAttachId)
			ON ([target].[UnitAnalysisAttachId] = [source].[UnitAnalysisAttachId])
		WHEN MATCHED
			THEN
				UPDATE
				SET Active = @Active
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
 				 UnitAnalysisId
				,FileName
				,LogicalName
				,PhysicalPath
				,Active
				,CreatedBy
					)
				VALUES (
				 @UnitAnalysisId
				,@FileName
				,@LogicalName
				,@PhysicalPath
				,@Active
				,@UserId);
 

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveJobWorkNotifcation]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppSaveJobWorkNotifcation]  
	 @JobId Bigint 
	,@UserId int 
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
			-- Work Notification Process Starts
				Declare @MeanRepairManHours int, @DownTimeCostPerHour int,@CostToRepair int,@TotalCost decimal(15,4) ,@ProbabilityFactor int
				,@RiskAvoidanceRevenue decimal(15,2), @RiskAvoidanceHours int
				DECLARE @WNDCreated TABLE (
				 UnitType varchar(10)
				,MeanRepairManHours Decimal(15,4)
				,DownTimeCostPerHour Decimal(15,4) 
				,CostToRepair Decimal(15,4) 
				,ProbabilityFactor int  
				); 
			Declare @WNOPStatusId int,@WNServiceId int  
			select @WNOPStatusId =  dbo.GetStatusId(1,'WorkNotificationStatus','OP' ) ;
			
			Declare @WorkNotificationNumber varchar(30), @ClientSiteId int ,@EquipmentId int 
			,@WNConditionId int ,@WNDataCollectionDate Date, @WNEquipmentName nvarchar(750),
			@WorkNotificationDate Date,@WNComment nvarchar(2500),@WNEquipmentId int, @AnalystId int
			
			select @ClientSiteId = ClientSiteId from jobs where JobId = @JobId 
 			DECLARE GetWNEquipmentDetails CURSOR READ_ONLY
			FOR
			select @ClientSiteId,je.EquipmentId,
			dbo.GetStatusId(1,'ConditionCodeMap', max(dbo.GetLookupTranslated(je.ConditionId,1,'LookupCode')) ) as ConditionId,
			max(je.DataCollectionDate) as DataCollectionDate, 
			e.EquipmentName, getdate() as 'WorkNotificationDate',
			STUFF((SELECT  case when dbo.GetLookupTranslated(jes.ServiceId,1,'LookupCode') = 'VA' then  ' VA :' else ' OA :' end  + jes.Comment
			FROM JobEquipment  AS jes WHERE jobid = je.jobId and  EquipmentId = je.EquipmentId 
			FOR XML PATH('')), 1, 1, '') as Comment , je.AnalystId
				from JobEquipment je join JobEquipUnitAnalysis ja on ja.JobEquipmentId = je.JobEquipmentId
				join Equipment e on e.EquipmentId = je.EquipmentId
				where je.JobId =@JobId and ja.IsWorkNotification = 'Y'
			Group by je.Jobid,je.EquipmentId, je.AnalystId,e.equipmentName  
		
			OPEN GetWNEquipmentDetails
			FETCH NEXT FROM GetWNEquipmentDetails INTO @ClientSiteId,@EquipmentId,@WNConditionId,@WNDataCollectionDate,
			@WNEquipmentName,@WorkNotificationDate,@WNComment,@AnalystId
			WHILE @@FETCH_STATUS = 0
			BEGIN 

			set @WorkNotificationNumber = concat('WN',NEXT VALUE FOR [SeqWNumber]);
			DECLARE @WNCreated TABLE (
			[WNEquipmentId] Bigint 
			,PRIMARY KEY ([WNEquipmentId])
			);
				  
			MERGE [dbo].[WorkNotificationEquipment] AS [target]
			USING (
				SELECT @ClientSiteId,@JobId,@EquipmentId
				) AS source(ClientSiteId,JobId,EquipmentId)
				ON ([target].[ClientSiteId] = [source].[ClientSiteId]
				and [target].[JobId] = [source].[JobId]
				and [target].[EquipmentId] = [source].[EquipmentId]
				)
			WHEN NOT MATCHED BY TARGET
				THEN
					INSERT (
					ClientSiteId,JobId,EquipmentId,ConditionId,DataCollectionDate,StatusId,EquipmentName,WorkNotificationDate,
				CreatedBy,WorkNotificationNumber,Comment,Active
						)
					VALUES (
					 @ClientSiteId,@JobId,@EquipmentId,@WNConditionId,@WNDataCollectionDate,@WNOPStatusId,@WNEquipmentName,
				@WorkNotificationDate,@AnalystId,@WorkNotificationNumber,@WNComment,'Y'
						)  
				OUTPUT INSERTED.WNEquipmentId
				INTO @WNCreated;
		  
				SELECT @WNEquipmentId = [WNEquipmentId] 
				FROM @WNCreated;
 
 ----------------------- WN Asset Insertion Ends ---------------------------------
		 if isnull(@WNEquipmentId,0) > 0
		 Begin
 			Declare @WNUUnitType varchar(5) , @WNUAssetName nvarchar(250), @WNUTaxonomyId bigint, @WNUConditionId int,
			@WNUConfidentFactorId int, @WNUFailureProbFactorId int ,@WNUPriorityId int ,@WNURecommendation nvarchar(2500),@WNUComment nvarchar(2500)
			,@WNUUnitId int ,@WNUMeanRepairManHours decimal(20,5),@WNUDownTimeCostPerHour decimal(20,5),@WNUCostToRepair decimal(20,5), @WNUIndicatedFault nvarchar(2500)
 
			DECLARE GetWNAssetDetails CURSOR READ_ONLY
			FOR
			select @WNEquipmentId as WNEquipmentId, ja.UnitType,ja.UnitId,
			case 
			when ja.UnitType = 'DR' then (du.IdentificationName)
			when ja.UnitType = 'DN' then (dn.IdentificationName)
			when ja.UnitType = 'IN' then (iu.IdentificationName)
			end AssetName, 
			case 
			when ja.UnitType = 'DR' then (du.AssetId)
			when ja.UnitType = 'DN' then (dn.AssetId)
			when ja.UnitType = 'IN' then (iu.AssetId)
			end TaxonomyId, 
			case 
			when ja.UnitType = 'DR' then (du.MeanRepairManHours)
			when ja.UnitType = 'DN' then (dn.MeanRepairManHours)
			when ja.UnitType = 'IN' then (iu.MeanRepairManHours)
			end MeanRepairManHours, 
			case 
			when ja.UnitType = 'DR' then (du.DownTimeCostPerHour)
			when ja.UnitType = 'DN' then (dn.DownTimeCostPerHour)
			when ja.UnitType = 'IN' then (iu.DownTimeCostPerHour)
			end DownTimeCostPerHour,  
 			case 
			when ja.UnitType = 'DR' then (du.CostToRepair)
			when ja.UnitType = 'DN' then (dn.CostToRepair)
			when ja.UnitType = 'IN' then (iu.CostToRepair)
			end CostToRepair,   
			dbo.GetStatusId(1,'ConditionCodeMap', max(dbo.GetLookupTranslated(ja.ConditionId,1,'LookupCode')) ) as ConditionId,
			dbo.GetStatusId(1,'DiagnosisConfidenceFactor', max(dbo.GetLookupTranslated(ja.ConfidentFactorId,1,'LookupCode')) ) as ConfidentFactorId,
			dbo.GetStatusId(1,'DiagnosisFailureProbability', max(dbo.GetLookupTranslated(ja.FailureProbFactorId,1,'LookupCode')) ) as FailureProbFactorId,
			dbo.GetStatusId(1,'DiagnosisPriority', max(dbo.GetLookupTranslated(ja.PriorityId,1,'LookupCode')) ) as PriorityId,
			STUFF((SELECT  case when dbo.GetLookupTranslated(jas.ServiceId,1,'LookupCode') = 'VA' then  ' VA :' else ' OA :' end  + jas.Comment
			FROM JobEquipUnitAnalysis  AS jas WHERE jas.UnitAnalysisId = ja.UnitAnalysisId 
			FOR XML PATH('')), 1, 1, '') as Comment,
	        STUFF((SELECT  case when dbo.GetLookupTranslated(jas.ServiceId,1,'LookupCode') = 'VA' then  ' VA :' else ' OA :' end  + jas.Recommendation
			FROM JobEquipUnitAnalysis  AS jas WHERE jas.UnitAnalysisId = ja.UnitAnalysisId 
			FOR XML PATH('')), 1, 1, '') as Recommendation,
 	        STUFF((SELECT  ','  + dbo.GetNameTranslated(jus.IndicatedFaultId ,1,'FailureCauseName')
			FROM JobEquipUnitSymptoms  AS jus WHERE jus.UnitAnalysisId = ja.UnitAnalysisId and jus.IndicatedFaultId > 0
			Group by IndicatedFaultId 
			FOR XML PATH('')), 1, 1, '') as IndicatedFault 
			from JobEquipment je join JobEquipUnitAnalysis ja on ja.JobEquipmentId = je.JobEquipmentId 
			left join EquipmentDriveUnit du on du.DriveUnitId = ja.UnitId and ja.UnitType = 'DR'
			left join EquipmentDrivenUnit dn on dn.DrivenUnitId = ja.UnitId and ja.UnitType = 'DN'
			left join EquipmentIntermediateUnit iu on iu.IntermediateUnitId = ja.UnitId and ja.UnitType = 'IN'
			where je.JobId = @JobId and je.EquipmentId = @EquipmentId and ja.IsWorkNotification = 'Y'
			Group by je.Jobid,je.EquipmentId,ja.UnitAnalysisId, ja.UnitType,ja.UnitId,ja.ServiceId, 
			 case 
			when ja.UnitType = 'DR' then (du.IdentificationName)
			when ja.UnitType = 'DN' then (dn.IdentificationName)
			when ja.UnitType = 'IN' then (iu.IdentificationName)
			end  , 
			case 
			when ja.UnitType = 'DR' then (du.AssetId)
			when ja.UnitType = 'DN' then (dn.AssetId)
			when ja.UnitType = 'IN' then (iu.AssetId)
			end  , 
			case 
			when ja.UnitType = 'DR' then (du.MeanRepairManHours)
			when ja.UnitType = 'DN' then (dn.MeanRepairManHours)
			when ja.UnitType = 'IN' then (iu.MeanRepairManHours)
			end  , 
			case 
			when ja.UnitType = 'DR' then (du.DownTimeCostPerHour)
			when ja.UnitType = 'DN' then (dn.DownTimeCostPerHour)
			when ja.UnitType = 'IN' then (iu.DownTimeCostPerHour)
			end ,  
 			case 
			when ja.UnitType = 'DR' then (du.CostToRepair)
			when ja.UnitType = 'DN' then (dn.CostToRepair)
			when ja.UnitType = 'IN' then (iu.CostToRepair)
			end    
		
			OPEN GetWNAssetDetails
			FETCH NEXT FROM GetWNAssetDetails INTO @WNEquipmentId,@WNUUnitType, @WNUUnitId, @WNUAssetName, @WNUTaxonomyId,@WNUMeanRepairManHours,@WNUDownTimeCostPerHour,@WNUCostToRepair
			,@WNUConditionId, @WNUConfidentFactorId, @WNUFailureProbFactorId,@WNUPriorityId,@WNUComment,@WNURecommendation,@WNUIndicatedFault
			WHILE @@FETCH_STATUS = 0
			BEGIN 
 
		 	MERGE [dbo].[WorkNotificationUnits] AS [target]
			USING (
				SELECT @WNEquipmentId,@WNUUnitType,@WNUUnitId 
				) AS source(WNEquipmentId,UnitType,UnitId)
				ON ([target].[WNEquipmentId] = [source].[WNEquipmentId]
				and [target].[UnitType] = [source].[UnitType]
				and [target].[UnitId] = [source].[UnitId]
				)
			WHEN NOT MATCHED BY TARGET
				THEN
					INSERT (
					WNEquipmentId,UnitType,UnitId,AssetName,TaxonomyId,MeanRepairManHours,DownTimeCostPerHour,CostToRepair,Conditionid,
					ConfidentFactorId,FailureProbFactorId,PriorityId,Comment,Recommendation,IndicatedFault, StatusId,Active, CreatedBy
						)
					VALUES (
					@WNEquipmentId,@WNUUnitType,@WNUUnitId,@WNUAssetName,@WNUTaxonomyId,@WNUMeanRepairManHours,@WNUDownTimeCostPerHour,@WNUCostToRepair,@WNUConditionid,
					@WNUConfidentFactorId,@WNUFailureProbFactorId,@WNUPriorityId,@WNUComment,@WNURecommendation,@WNUIndicatedFault, @WNOPStatusId,'Y',@AnalystId
						)  ; 
			 
 
			FETCH NEXT FROM GetWNAssetDetails INTO @WNEquipmentId,@WNUUnitType, @WNUUnitId, @WNUAssetName, @WNUTaxonomyId,@WNUMeanRepairManHours,@WNUDownTimeCostPerHour,@WNUCostToRepair
			,@WNUConditionId, @WNUConfidentFactorId, @WNUFailureProbFactorId,@WNUPriorityId,@WNUComment,@WNURecommendation,@WNUIndicatedFault
			END
			CLOSE GetWNAssetDetails
			DEALLOCATE GetWNAssetDetails 

				-----------Updating OUtage time to header
 			delete from @WNDCreated

				Insert into @WNDCreated(UnitType,MeanRepairManHours,DownTimeCostPerHour,CostToRepair,ProbabilityFactor)
				select UnitType,max(round(MeanRepairManHours,0)), max(DownTimeCostPerHour),max(CostToRepair),
				max(dbo.GetLookupTranslated(FailureProbFactorId,1,'LookupValue'))
				from WorkNotificationUnits 
				where WNEquipmentId = @WNEquipmentId
				Group by UnitType
				
				select @MeanRepairManHours = 0 ,@DownTimeCostPerHour = 0,@CostToRepair = 0,@TotalCost = 0 ,@ProbabilityFactor = 0

				select @MeanRepairManHours = max(MeanRepairManHours), @DownTimeCostPerHour = max(DownTimeCostPerHour),@CostToRepair = sum(isnull(CostToRepair,0))
				,@TotalCost = ((isnull(max(DownTimeCostPerHour),0) * isnull(max(MeanRepairManHours),0) ) + sum(isnull(CostToRepair,0)))
				,@RiskAvoidanceHours = max(MeanRepairManHours) * max(ProbabilityFactor) / 100
			--	,@RiskAvoidanceRevenue = ((((max(MeanRepairManHours) * max(DownTimeCostPerHour)) + sum(isnull(CostToRepair,0)) ) * max(ProbabilityFactor)) /100 )
				,@ProbabilityFactor = max(ProbabilityFactor)
				From @WNDCreated
				
				set  @RiskAvoidanceRevenue = ((@MeanRepairManHours * @DownTimeCostPerHour) + @CostToRepair) * @ProbabilityFactor / 100
 				
				Update WorkNotificationEquipment set RiskAvoidanceHours = @RiskAvoidanceHours, RiskAvoidanceRevenue = @RiskAvoidanceRevenue, MeanRepairManHours = @MeanRepairManHours , DownTimeCostPerHour = @DownTimeCostPerHour,CostToRepair = @CostToRepair,TotalCost = @TotalCost
				where WNEquipmentId = @WNEquipmentId 
--------- Work Notification Process Ends	

		End
 ------------------------ WN Asset Insertion Ends ----------------------------
	
			FETCH NEXT FROM GetWNEquipmentDetails INTO @ClientSiteId,@EquipmentId,@WNConditionId,@WNDataCollectionDate,
			@WNEquipmentName,@WorkNotificationDate,@WNComment,@AnalystId
			END
			CLOSE GetWNEquipmentDetails
			DEALLOCATE GetWNEquipmentDetails 
			

	
	  COMMIT TRANSACTION; 
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH

END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveLastSession]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppSaveLastSession] 
	 @UserId INT
	,@ClientSiteId Int 
	,@SessionId varchar(300)
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
		MERGE [dbo].[Users] AS [target]
		USING (
			SELECT @Userid
			) AS source(UserId)
			ON ([target].[UserId] = [source].[UserId])
		WHEN MATCHED
			THEN
				UPDATE
				SET LastSessionClient = @ClientSiteId  ;
				Declare @CountryId int, @CostCentreId int
	--@prakash uncomment below two lines and parameter declaration at top
				Select @CountryId = CountryId, @CostCentreId = CostCentreId from ClientSite where ClientSiteId = @ClientSiteId
				Update AuditLogHeader set ClientSiteId = @ClientSiteId, CountryId = @CountryId, CostCentreId = @CostCentreId where  SessionId = @SessionId and UserId = @UserId 

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveLeverageService]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppSaveLeverageService]
	 @LeverageServiceId Bigint 
	,@JobEquipmentId Bigint 
	,@OpportunityTypeId int    
	,@Descriptions nvarchar(1500)  
	,@LeverageExportId int   
	,@Active Varchar(1)
	,@UserId INT 
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
 
 		MERGE [dbo].[LeverageService] AS [target] 
		USING (
			SELECT @LeverageServiceId 
			) AS source(LeverageServiceId)
			ON ([target].[LeverageServiceId] = [source].[LeverageServiceId])
		WHEN MATCHED
			THEN 
				UPDATE 
				SET   
				 Descriptions = @Descriptions 
				,Active = @Active
			 WHEN NOT MATCHED BY TARGET
			THEN
				INSERT ( 
				JobEquipmentId 
				,OpportunityTypeId    
				,Descriptions
				,LeverageExportId   
				,Active
				,CreatedBy
					)
				VALUES ( 
				@JobEquipmentId
				,@OpportunityTypeId
				,@Descriptions
				,@LeverageExportId
				,@Active  
				,@UserId
					);

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveLeverageServiceExport]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppSaveLeverageServiceExport]  
	@LeverageServiceJson nvarchar(max), 
	@FilePath nvarchar(250),
	@UserId int 
AS
BEGIN

	BEGIN TRANSACTION
	BEGIN TRY
 
		DECLARE @LeverageExportId Bigint, @FileName nvarchar(150)
		Select @FileName = concat('LSExport-',format(getdate(),'yyyyMMMdd') , (NEXT VALUE FOR [SeqLeverageServiceExport]) )  
 		DECLARE @Created TABLE (
			[LeverageExportId] Bigint
			,PRIMARY KEY ([LeverageExportId])
			);
		set @LeverageExportId = 0 ;

 		MERGE [dbo].[LeverageExport] AS [target] 
		USING (
			SELECT @LeverageExportId
			) AS source(LeverageExportId)
			ON ([target].[LeverageExportId] = [source].[LeverageExportId])
		 WHEN NOT MATCHED BY TARGET
			THEN  
				INSERT ( 
				 [FileName]  
				,FileDate
				,FilePath   
				,CreatedBy
					)
				VALUES ( 
				 @FileName
				,getdate()
				,@FilePath  
				,@UserId
					) OUTPUT INSERTED.LeverageExportId
				INTO @Created ;
			    
				SELECT @LeverageExportId = [LeverageExportId]
				FROM @Created; 


--------Start Update Leverage Export Id------------ 
	DECLARE @LeverageServiceId int 
	
	DROP TABLE IF EXISTS #LoadLeverageServiceJson

	CREATE TABLE #LoadLeverageServiceJson
	(
	  LoaderId int not null identity(1,1),
	  LeverageServiceId Bigint 
	) 

Insert into #LoadLeverageServiceJson (LeverageServiceId)
SELECT
    JSON_Value (c.value, '$.LeverageServiceId') as LeverageServiceId 
FROM OPENJSON ( @LeverageServiceJson , '$.LeverageService') as c 
 
  
DECLARE GetLeverageServiceCur CURSOR READ_ONLY
    FOR
    SELECT LeverageServiceId
	from #LoadLeverageServiceJson  

    OPEN GetLeverageServiceCur
    FETCH NEXT FROM GetLeverageServiceCur INTO
    @LeverageServiceId
    WHILE @@FETCH_STATUS = 0
		BEGIN
		 	MERGE [dbo].[LeverageService] AS [target]
			USING (
				SELECT @LeverageServiceId
				) AS source(LeverageServiceId)
				ON ([target].[LeverageServiceId] = [source].[LeverageServiceId] and isnull([target].LeverageExportId,0) = 0)
			WHEN MATCHED THEN
				UPDATE SET LeverageExportId = @LeverageExportId 
						;
		FETCH NEXT FROM GetLeverageServiceCur INTO	@LeverageServiceId
		END
    CLOSE GetLeverageServiceCur
    DEALLOCATE GetLeverageServiceCur 

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH
		    
End
 
  
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveLookups]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppSaveLookups] @LookupId INT
	,@LanguageId INT
	,@LookupCode VARCHAR(50)
	,@LookupName NVARCHAR(150)
	,@LookupValue NVARCHAR(150)
	,@ListOrder INT
	,@Descriptions NVARCHAR(150)
	,@Active VARCHAR(1)
	,@UserId INT
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
		DECLARE @Created TABLE (
			[LookupId] INT
			,PRIMARY KEY ([LookupId])
			);

		MERGE [dbo].[Lookups] AS [target]
		USING (
			SELECT @LookupId
				,@LookupCode
				,@LanguageId
				,@UserId
			) AS source(LookupId, LookupCode, LanguageId, Userid)
			ON ([target].[LookupId] = [source].[LookupId])
		WHEN MATCHED
			THEN
				UPDATE
				SET LookupCode = @LookupCode
					,ListOrder = @ListOrder
					,LName = @LookupName
					,Active = @Active
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					Lookupcode
					,LName
					,ListOrder
					,CreatedLanguageId
					,CreatedBy
					)
				VALUES (
					@LookupCode
					,@LookupName
					,@ListOrder
					,@Languageid
					,@UserId
					)
		OUTPUT INSERTED.[LookupId]
		INTO @Created;;

		SELECT @LookupId = (
				SELECT LookupId
				FROM @Created
				)

		MERGE [dbo].[LookupTranslated] AS [target]
		USING (
			SELECT @LookupId
				,@LanguageId
			) AS source(LookupId, LanguageId)
			ON ([target].[LookupId] = [source].[LookupId])
				AND [TARGET].LanguageId = @LanguageId
		WHEN MATCHED
			THEN
				UPDATE
				SET LValue = @LookupValue
					,Descriptions = @Descriptions
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					LookupId
					,LanguageId
					,LValue
					,Descriptions
					,CreatedBy
					)
				VALUES (
					@LookupId
					,@Languageid
					,@LookupValue
					,@Descriptions
					,@UserId
					);

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveManufacturer]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppSaveManufacturer] @ManufacturerId INT
	,@LanguageId INT
	,@ManufacturerCode VARCHAR(5)
	,@ManufacturerName NVARCHAR(150)
	,@Descriptions NVARCHAR(150)
	,@Active VARCHAR(1)
	,@BearingMFT VARCHAR(1)
	,@DriveMFT VARCHAR(1)
	,@IntermediateMFT VARCHAR(1)
	,@DrivenMFT VARCHAR(1)
	,@UserId INT
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
		DECLARE @Created TABLE (
			[ManufacturerId] INT
			,PRIMARY KEY ([ManufacturerId])
			);

		MERGE [dbo].[Manufacturer] AS [target]
		USING (
			SELECT @ManufacturerId 
			) AS source(ManufacturerId)
			ON ([target].[ManufacturerId] = [source].[ManufacturerId])
		WHEN MATCHED
			THEN
				UPDATE
				SET ManufacturerCode = @ManufacturerCode
				    ,BearingMFT = @BearingMFT
					,DriveMFT = @DriveMFT
					,IntermediateMFT = @IntermediateMFT
					,DrivenMFT = @DrivenMFT
					,Active = @Active
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					ManufacturerCode
					,CreatedLanguageId
					,Active
					,BearingMFT
					,DriveMFT
					,IntermediateMFT
					,DrivenMFT
					,CreatedBy
					)
				VALUES (
					@ManufacturerCode
					,@Languageid
					,@Active
					,@BearingMFT 
					,@DriveMFT
					,@IntermediateMFT
					,@DrivenMFT 
					,@UserId
					)
				OUTPUT INSERTED.[ManufacturerId]
				INTO @Created;

		SELECT @ManufacturerId = (
				SELECT ManufacturerId
				FROM @Created
				)

		MERGE [dbo].[ManufacturerTranslated] AS [target]
		USING (
			SELECT @ManufacturerId
				,@LanguageId
			) AS source(ManufacturerId, LanguageId)
			ON ([target].[ManufacturerId] = [source].[ManufacturerId])
				AND [TARGET].LanguageId = @LanguageId
		WHEN MATCHED
			THEN
				UPDATE
				SET ManufacturerName = @ManufacturerName
					,Descriptions = @Descriptions
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					ManufacturerId
					,LanguageId
					,ManufacturerName
					,Descriptions
					,CreatedBy
					)
				VALUES (
					@ManufacturerId
					,@Languageid
					,@ManufacturerName
					,@Descriptions
					,@UserId
					);

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveOtherReportsAttachments]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create   PROCEDURE [dbo].[EAppSaveOtherReportsAttachments] 
	 @OtherReportsAttachId INT
	,@ClientSiteId int 
	,@ReportTypeId int
	,@PlantAreaId int
	,@ReportDate Date
	,@FileName nVarchar(150)
	,@FileDescription nVarchar(250)
	,@LogicalName VARCHAR(500)
	,@PhysicalPath VARCHAR(500)
	,@Active VARCHAR(1)
	,@UserId INT
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
 
	MERGE [dbo].[OtherReportsAttachment] AS [target]
		USING (
			SELECT @OtherReportsAttachId 
			) AS source(OtherReportsAttachId)
			ON ([target].OtherReportsAttachId = [source].OtherReportsAttachId)
		WHEN MATCHED
			THEN
				UPDATE
				SET Active = @Active, ReportTypeId = @ReportTypeId, PlantAreaId = @PlantAreaId, ReportDate = @ReportDate
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
				 ClientSiteId
				,ReportTypeId
				,PlantAreaId
				,ReportDate
				,FileName
				,FileDescription
				,LogicalName
				,PhysicalPath
				,Active
				,CreatedBy
					)
				VALUES (
				 @ClientSiteId
				,@ReportTypeId
				,@PlantAreaId
				,@ReportDate
				,@FileName
				,@FileDescription
				,@LogicalName
				,@PhysicalPath
				,@Active
				,@UserId);
	 

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSavePlantArea]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppSavePlantArea] @PlantAreaId INT
	,@LanguageId INT
	,@ClientSiteId INT
	,@PlantAreaCode varchar(30)
	,@PlantAreaName NVARCHAR(150)
	,@Descriptions NVARCHAR(150)
	,@UserId INT
	,@Active VARCHAR(1)
	,@ReturnKey int 
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
		DECLARE @Created TABLE (
			[PlantAreaId] INT
			,PRIMARY KEY ([PlantAreaId])
			);

		MERGE [dbo].[PlantArea] AS [target]
		USING (
			SELECT @PlantAreaId
			) AS source(PlantAreaId)
			ON ([target].[PlantAreaId] = [source].[PlantAreaId])
		WHEN MATCHED
			THEN
				UPDATE
				SET Active = @Active
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					ClientSiteId
					,PlantAreaCode
					,CreatedLanguageId
					,CreatedBy
					)
				VALUES (
					@ClientSiteId
					,@PlantAreaCode
					,@Languageid
					,@UserId
					)
		OUTPUT INSERTED.[PlantAreaId]
		INTO @Created;;

		SELECT @PlantAreaId = (
				SELECT PlantAreaId
				FROM @Created
				)

		MERGE [dbo].[PlantAreaTranslated] AS [target]
		USING (
			SELECT @PlantAreaId
				,@LanguageId
			) AS source(PlantAreaId, LanguageId)
			ON ([target].[PlantAreaId] = [source].[PlantAreaId])
				AND [TARGET].LanguageId = @LanguageId
		WHEN MATCHED
			THEN
				UPDATE
				SET PlantAreaName = @PlantAreaName
					,Descriptions = @Descriptions
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					 ClientSiteId
					,PlantAreaId
					,LanguageId
					,PlantAreaName
					,Descriptions
					,CreatedBy
					)
				VALUES (
					@ClientSiteId
					,@PlantAreaId
					,@Languageid
					,@PlantAreaName
					,@Descriptions
					,@UserId
					);

		COMMIT TRANSACTION
		if isnull(@ReturnKey,0) = 1 
		Begin
			SELECT PlantAreaId as PlantAreaId FROM @Created;
		End

	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSavePrivileges]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppSavePrivileges] @PrivilegeId INT
	,@PrivilegeCode NVARCHAR(50)
	,@PrivilegeName NVARCHAR(150)
	,@Active VARCHAR(1)
	,@UserId INT
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
		MERGE [dbo].[Privileges] AS [target]
		USING (
			SELECT @PrivilegeId
			) AS source(PrivilegeId)
			ON ([target].[PrivilegeId] = [source].PrivilegeId)
		WHEN MATCHED
			THEN
				UPDATE
				SET Active = @Active
					,PrivilegeCode = @PrivilegeCode
					,PrivilegeName = @PrivilegeName
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					PrivilegeCode
					,PrivilegeName
					,Active
					,CreatedBy
					)
				VALUES (
					@PrivilegeCode
					,@PrivilegeName
					,@Active
					,@UserId
					);

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveProgramPrivilege]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppSaveProgramPrivilege] @ProgramId INT
	,@PrivilegeId INT
	,@Active VARCHAR(1)
	,@UserId INT
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
		MERGE [dbo].[ProgramPrivilegeRelation] AS [target]
		USING (
			SELECT @ProgramId
				,@PrivilegeId
			) AS source(ProgramId, PrivilegeId)
			ON (
					[target].[ProgramId] = [source].[ProgramId]
					AND [target].[PrivilegeId] = [source].[PrivilegeId]
					)
		WHEN MATCHED
			THEN
				UPDATE
				SET Active = @Active
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					ProgramId
					,PrivilegeId
					,Active
					,CreatedBy
					)
				VALUES (
					@ProgramId
					,@PrivilegeId
					,@Active
					,@UserId
					);

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSavePrograms]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppSavePrograms] @ProgramId INT
	,@LanguageId INT
	,@ProgramCode VARCHAR(5)
	,@Menuorder INT
	,@ControllerName NVARCHAR(150)
	,@ProgramName NVARCHAR(150)
	,@MenuName NVARCHAR(150)
	,@IconName NVARCHAR(150)
	,@GroupCode VARCHAR(50)
	,@SubGroupCode VARCHAR(50)
	,@Descriptions NVARCHAR(150)
	,@MenuGroupid INT
	,@Internal VARCHAR(1)
	,@Active VARCHAR(1)
	,@UserId INT
	,@ActionName NVARCHAR(150)
	,@LinkUrl NVARCHAR(150)
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
		DECLARE @Created TABLE (
			[ProgramId] INT
			,PRIMARY KEY ([ProgramId])
			);

		MERGE [dbo].[Programs] AS [target]
		USING (
			SELECT @ProgramId
				,@LanguageId
			) AS source(ProgramId, LanguageId)
			ON ([target].[ProgramId] = [source].[ProgramId])
		WHEN MATCHED
			THEN
				UPDATE
				SET ProgramCode = @ProgramCode
					,MenuOrder = @MenuOrder
					,ControllerName = @ControllerName
					,Iconname = @IconName
					,GroupCode = @GroupCode
					,SubGroupCode = @SubGroupCode
					,MenuGroupId = @MenuGroupId
					,Active = @Active
					,Internal = @Internal
					,ActionName = @ActionName
					,LinkUrl = @LinkUrl
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					ProgramCode
					,MenuOrder
					,ControllerName
					,Iconname
					,GroupCode
					,SubGroupCode
					,MenuGroupId
					,Active
					,CreatedLanguageid
					,CreatedBy
					,ActionName
					,LinkUrl
					)
				VALUES (
					@ProgramCode
					,@MenuOrder
					,@ControllerName
					,@Iconname
					,@GroupCode
					,@SubGroupCode
					,@MenuGroupId
					,@Active
					,@Languageid
					,@UserId
					,@ActionName
					,@LinkUrl
					)
		OUTPUT INSERTED.[ProgramId]
		INTO @Created;;

		SELECT @ProgramId = (
				SELECT ProgramId
				FROM @Created
				)

		MERGE [dbo].[ProgramTranslated] AS [target]
		USING (
			SELECT @ProgramId
				,@LanguageId
			) AS source(ProgramId, LanguageId)
			ON ([target].[ProgramId] = [source].[ProgramId])
				AND [TARGET].LanguageId = @LanguageId
		WHEN MATCHED
			THEN
				UPDATE
				SET ProgramName = @ProgramName
					,Descriptions = @Descriptions
					,MenuName = @MenuName
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					ProgramId
					,LanguageId
					,ProgramName
					,MenuName
					,Descriptions
					,CreatedBy
					)
				VALUES (
					@ProgramId
					,@Languageid
					,@ProgramName
					,@MenuName
					,@Descriptions
					,@UserId
					);

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveRoleGroup]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppSaveRoleGroup] @RoleGroupId INT
	,@LanguageId INT
	,@RoleGroupName NVARCHAR(150)
	,@Descriptions NVARCHAR(150)
	,@Active VARCHAR(1)
	,@UserId INT
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
		DECLARE @Created TABLE (
			[RoleGroupId] INT
			,PRIMARY KEY ([RoleGroupId])
			);

		MERGE [dbo].[RoleGroup] AS [target]
		USING (
			SELECT @RoleGroupId
				,@LanguageId
				,@UserId
			) AS source(RoleGroupId, LanguageId, Userid)
			ON ([target].[RoleGroupId] = [source].[RoleGroupId])
		WHEN MATCHED
			THEN
				UPDATE
				SET Active = @Active
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					CreatedLanguageId
					,CreatedBy
					)
				VALUES (
					@Languageid
					,@UserId
					)
		OUTPUT INSERTED.[RoleGroupId]
		INTO @Created;;

		SELECT @RoleGroupId = (
				SELECT RoleGroupId
				FROM @Created
				)

		MERGE [dbo].[RoleGroupTranslated] AS [target]
		USING (
			SELECT @RoleGroupId
				,@LanguageId
			) AS source(RoleGroupId, LanguageId)
			ON ([target].[RoleGroupId] = [source].[RoleGroupId])
				AND [TARGET].LanguageId = @LanguageId
		WHEN MATCHED
			THEN
				UPDATE
				SET RoleGroupName = @RoleGroupName
					,Descriptions = @Descriptions
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					RoleGroupId
					,LanguageId
					,RoleGroupName
					,Descriptions
					,CreatedBy
					)
				VALUES (
					@RoleGroupId
					,@Languageid
					,@RoleGroupName
					,@Descriptions
					,@UserId
					);

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveRoleGroupRoles]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppSaveRoleGroupRoles] @RoleGroupId INT
	,@Roleid INT
	,@Active VARCHAR(1)
	,@UserId INT
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
		MERGE [dbo].[RoleGroupRoleRelation] AS [target]
		USING (
			SELECT @RoleId
				,@RoleGroupid
			) AS source(RoleId, RoleGroupId)
			ON ([target].[RoleId] = [source].[RoleId])
				AND ([target].[RoleGroupId] = [source].[RoleGroupId])
		WHEN MATCHED
			THEN
				UPDATE
				SET Active = @Active
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					RoleId
					,RoleGroupId
					,Active
					,CreatedBy
					)
				VALUES (
					@RoleId
					,@RoleGroupId
					,@Active
					,@UserId
					);

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveRoleProgramPrivileges]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppSaveRoleProgramPrivileges] @RoleId INT
	,@ProgramId INT
	,@PrivilegeId INT
	,@Active VARCHAR(1)
	,@HideProgram VARCHAR(1)
	,@UserId INT
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
		MERGE [dbo].[RolePrgPrivilegeRelation] AS [target]
		USING (
			SELECT @RoleId
				,@ProgramId
				,@PrivilegeId
			) AS source(RoleId, ProgramId, PrivilegeId)
			ON ([target].[RoleId] = [source].[RoleId])
				AND ([target].[ProgramId] = [source].[ProgramId])
				AND ([target].[PrivilegeId] = [source].[PrivilegeId])
		WHEN MATCHED
			THEN
				UPDATE
				SET Active = @Active
				,HideProgram = @HideProgram
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					RoleId
					,ProgramId
					,PrivilegeId
					,Active
					,HideProgram
					,CreatedBy
					)
				VALUES (
					@RoleId
					,@ProgramId
					,@PrivilegeId
					,@Active
					,@HideProgram
					,@UserId
					);

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveRoles]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppSaveRoles] @RoleId INT
	,@RoleName NVARCHAR(150)
	,@Descriptions NVARCHAR(250)
	,@Active VARCHAR(1)
	,@Internal VARCHAR(1)
	,@UserId INT
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
		MERGE [dbo].[Roles] AS [target]
		USING (
			SELECT @RoleId
			) AS source(RoleId)
			ON ([target].[RoleId] = [source].[RoleId])
		WHEN MATCHED
			THEN
				UPDATE
				SET Active = @Active
					,@Internal = @Internal
					,RoleName = @RoleName
					,Descriptions = @Descriptions
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					RoleName
					,Descriptions
					,Internal
					,Active
					,CreatedBy
					)
				VALUES (
					@RoleName
					,@Descriptions
					,@Internal
					,@Active
					,@UserId
					);

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveScheduleSetup]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppSaveScheduleSetup] 
	 @ScheduleSetupId Bigint 
	,@ClientSiteId int    
	,@ScheduleName nvarchar(150) 
	,@StartDate Date 
	,@EndDate Date 
	,@IntervalDays INT
	,@EstJobDays INT
	,@ScheduleEquipmentsJson nvarchar(max)
	,@ScheduleServicesJson nvarchar(max)
	,@StatusId int
	,@UserId INT 
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
  		DECLARE @Created TABLE (
			[ScheduleSetupId] Bigint
			,PRIMARY KEY ([ScheduleSetupId])
			);
		If @ScheduleSetupId = 0
		Begin
			Select @Statusid = dbo.GetStatusId(1,'ScheduleStatus','N') 
		End
 		MERGE [dbo].[ScheduleSetup] AS [target]
		USING (
			SELECT @ScheduleSetupId 
			) AS source(ScheduleSetupId)
			ON ([target].[ScheduleSetupId] = [source].[ScheduleSetupId])
		WHEN MATCHED
			THEN
 
				UPDATE
				SET   
				 ClientSiteId = @ClientSiteId      
				,ScheduleName = @ScheduleName 
				,StartDate = @StartDate 
				,EndDate = @EndDate 
				,IntervalDays = @IntervalDays 
				,EstJobDays = @EstJobDays 
					WHEN NOT MATCHED BY TARGET
			THEN
				INSERT ( 
				 ClientSiteId  
				,ScheduleName 
				,StartDate 
				,EndDate 
				,IntervalDays
				,EstJobDays
				,StatusId 
				,CreatedBy
					)
				VALUES ( 
				 @ClientSiteId  
				,@ScheduleName 
				,@StartDate 
				,@EndDate 
				,@IntervalDays
				,@EstJobDays 
				,@StatusId
				,@UserId
					) OUTPUT INSERTED.ScheduleSetupId
				INTO @Created ;
			    
				SELECT @ScheduleSetupId = [ScheduleSetupId]
				FROM @Created; 
 ---- Process Start Equipment ------
	DECLARE @ScheduleEquipmentId int, @EquipmentId int, @JActive varchar(1) 
	
	DROP TABLE IF EXISTS #LoadEquipmentJson

	CREATE TABLE #LoadEquipmentJson
	(
	  LoaderId int not null identity(1,1),
	  ScheduleEquipmentId int, 
	  EquipmentId int,
	  Active varchar(1) 
	) 

Insert into #LoadEquipmentJson (ScheduleEquipmentId,EquipmentId,Active)
SELECT
    JSON_Value (c.value, '$.ScheduleEquipmentId') as ScheduleEquipmentId, 
	JSON_Value (c.value, '$.EquipmentId') as EquipmentId, 
	JSON_Value (c.value, '$.Active') as Active  
FROM OPENJSON ( @ScheduleEquipmentsJson , '$.ScheduleEquipments') as c 
 
  
DECLARE GetScheduleEquipmentIdCur CURSOR READ_ONLY
    FOR
    SELECT ScheduleEquipmentId,EquipmentId,Active
	from #LoadEquipmentJson  

    OPEN GetScheduleEquipmentIdCur
    FETCH NEXT FROM GetScheduleEquipmentIdCur INTO
    @ScheduleEquipmentId, @EquipmentId, @JActive
    WHILE @@FETCH_STATUS = 0
		BEGIN
		 	MERGE [dbo].[ScheduleEquipments] AS [target]
			USING (
				SELECT @ScheduleEquipmentId
				) AS source(ScheduleEquipmentId)
				ON ([target].[ScheduleEquipmentId] = [source].[ScheduleEquipmentId])
			WHEN MATCHED
				THEN 
					UPDATE
					SET Active = @JActive
			WHEN NOT MATCHED BY TARGET
					THEN
						INSERT (  
						 ScheduleSetupId
						,EquipmentId
						,Active
						,CreatedBy
							)
						VALUES ( 
						 @ScheduleSetupId
						,@EquipmentId 
						,@JActive
						,@UserId
							)
						;
		FETCH NEXT FROM GetScheduleEquipmentIdCur INTO	@ScheduleEquipmentId,@EquipmentId,@JActive
		END
    CLOSE GetScheduleEquipmentIdCur
    DEALLOCATE GetScheduleEquipmentIdCur
 ---- Process End Equipment ------
 
 ---- Process Start Report Service------
	DECLARE @ScheduleServiceId int, @ServiceId int 
	
	DROP TABLE IF EXISTS #LoadReportJson

	CREATE TABLE #LoadReportJson
	(
	  LoaderId int not null identity(1,1),
	  ScheduleServiceId int, 
	  ServiceId int,
	  Active varchar(1) 
	) 

Insert into #LoadReportJson (ScheduleServiceId,ServiceId,Active)
SELECT
    JSON_Value (c.value, '$.ScheduleServiceId') as ScheduleServiceId, 
	JSON_Value (c.value, '$.ServiceId') as ServiceId, 
	JSON_Value (c.value, '$.Active') as Active  
FROM OPENJSON ( @ScheduleServicesJson , '$.ScheduleServices') as c 
 
  
DECLARE GetScheduleServiceIdCur CURSOR READ_ONLY
    FOR
    SELECT ScheduleServiceId,ServiceId,Active
	from #LoadReportJson  

    OPEN GetScheduleServiceIdCur
    FETCH NEXT FROM GetScheduleServiceIdCur INTO
    @ScheduleServiceId, @ServiceId, @JActive
    WHILE @@FETCH_STATUS = 0
		BEGIN
		 	MERGE [dbo].[ScheduleServices] AS [target]
			USING (
				SELECT @ScheduleServiceId
				) AS source(ScheduleServiceId)
				ON ([target].[ScheduleServiceId] = [source].[ScheduleServiceId] )
			WHEN MATCHED
				THEN 
					UPDATE
					SET Active = @JActive
			WHEN NOT MATCHED BY TARGET
					THEN
						INSERT (  
						 ScheduleSetupId
						,ServiceId
						,Active
						,CreatedBy
							)
						VALUES ( 
						 @ScheduleSetupId
						,@ServiceId  
						,@JActive
						,@UserId
							)
						;
		FETCH NEXT FROM GetScheduleServiceIdCur INTO	@ScheduleServiceId,@ServiceId,@JActive
		END
    CLOSE GetScheduleServiceIdCur
    DEALLOCATE GetScheduleServiceIdCur
 ---- Process End Report Service------

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveSector]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppSaveSector] @SectorId INT
	,@LanguageId INT
	,@SectorCode VARCHAR(5)
	,@SectorName NVARCHAR(150)
	,@Descriptions NVARCHAR(250)
	,@Active VARCHAR(1)
	,@UserId INT
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
		DECLARE @Created TABLE (
			[SectorId] INT
			,PRIMARY KEY ([SectorId])
			);

		MERGE [dbo].[Sector] AS [target]
		USING (
			SELECT @SectorId
				,@LanguageId
				,@UserId
			) AS source(SectorId, LanguageId, Userid)
			ON ([target].[SectorId] = [source].[SectorId])
		WHEN MATCHED
			THEN
				UPDATE
				SET SectorCode = @SectorCode
					,Active = @Active
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					Sectorcode
					,CreatedLanguageId
					,CreatedBy
					)
				VALUES (
					@SectorCode
					,@Languageid
					,@UserId
					)
		OUTPUT INSERTED.[SectorId]
		INTO @Created;;

		SELECT @SectorId = (
				SELECT SectorId
				FROM @Created
				)

		MERGE [dbo].[SectorTranslated] AS [target]
		USING (
			SELECT @SectorId
				,@LanguageId
				,@SectorName
				,@Descriptions
				,@UserId
			) AS source(SectorId, LanguageId, SectorName, Descriptions, Userid)
			ON ([target].[SectorId] = [source].[SectorId])
				AND [TARGET].LanguageId = @LanguageId
		WHEN MATCHED
			THEN
				UPDATE
				SET SectorName = @SectorName
					,Descriptions = @Descriptions
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					SectorId
					,LanguageId
					,Sectorname
					,Descriptions
					,CreatedBy
					)
				VALUES (
					@SectorId
					,@Languageid
					,@SectorName
					,@Descriptions
					,@UserId
					);

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveSegment]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppSaveSegment] @SegmentId INT
	,@SectorId INT
	,@LanguageId INT
	,@SegmentCode VARCHAR(5)
	,@SegmentName NVARCHAR(150)
	,@Descriptions NVARCHAR(150)
	,@Active VARCHAR(1)
	,@UserId INT
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
		DECLARE @Created TABLE (
			[SegmentId] INT
			,PRIMARY KEY ([SegmentId])
			);

		MERGE [dbo].[Segment] AS [target]
		USING (
			SELECT @SegmentId
			) AS source(SegmentId)
			ON ([target].[SegmentId] = [source].[SegmentId])
		WHEN MATCHED
			THEN
				UPDATE
				SET SegmentCode = @SegmentCode
					,SectorId = @SectorId
					,Active = @Active
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					SectorId
					,SegmentCode
					,CreatedLanguageId
					,Active
					,CreatedBy
					)
				VALUES (
					@SectorId
					,@SegmentCode
					,@Languageid
					,@Active
					,@UserId
					)
		OUTPUT INSERTED.[SegmentId]
		INTO @Created;;

		SELECT @SegmentId = (
				SELECT SegmentId
				FROM @Created
				)

		MERGE [dbo].[SegmentTranslated] AS [target]
		USING (
			SELECT @SegmentId
			) AS source(SegmentId)
			ON ([target].[SegmentId] = [source].[SegmentId])
				AND [TARGET].LanguageId = @LanguageId
		WHEN MATCHED
			THEN
				UPDATE
				SET SegmentName = @SegmentName
					,Descriptions = @Descriptions
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					SegmentId
					,LanguageId
					,Segmentname
					,Descriptions
					,CreatedBy
					)
				VALUES (
					@SegmentId
					,@Languageid
					,@SegmentName
					,@Descriptions
					,@UserId
					);

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveSystem]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppSaveSystem] @SystemId INT
    ,@PlantAreaId INT
	,@AreaId INT
	,@LanguageId INT
	,@SystemName NVARCHAR(150)
	,@Descriptions NVARCHAR(150)
	,@Active VARCHAR(1)
	,@UserId INT
	,@ReturnKey int
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
		DECLARE @Created TABLE (
			[SystemId] INT
			,PRIMARY KEY ([SystemId])
			);

		MERGE [dbo].[System] AS [target]
		USING (
			SELECT @SystemId
				,@LanguageId
				,@UserId
			) AS source(SystemId, LanguageId, Userid)
			ON ([target].[SystemId] = [source].[SystemId])
		WHEN MATCHED
			THEN
				UPDATE
				SET AreaId = @AreaId
				   , PlantAreaId = @PlantAreaId
					,Active = @Active
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
				     PlantAreaId
					,AreaId
					,CreatedLanguageId
					,Active
					,CreatedBy
					)
				VALUES (
				   @PlantAreaId
					,@AreaId
					,@Languageid
					,@Active
					,@UserId
					)
		OUTPUT INSERTED.[SystemId]
		INTO @Created;;

		SELECT @SystemId = (
				SELECT SystemId
				FROM @Created
				)

		MERGE [dbo].[SystemTranslated] AS [target]
		USING (
			SELECT @SystemId
				,@LanguageId
				,@SystemName
				,@Descriptions
				,@UserId
			) AS source(SystemId, LanguageId, SystemName, Descriptions, Userid)
			ON ([target].[SystemId] = [source].[SystemId])
				AND [TARGET].LanguageId = @LanguageId
		WHEN MATCHED
			THEN
				UPDATE
				SET SystemName = @SystemName
					,Descriptions = @Descriptions
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					SystemId
					,LanguageId
					,Systemname
					,Descriptions
					,CreatedBy
					)
				VALUES (
					@SystemId
					,@Languageid
					,@SystemName
					,@Descriptions
					,@UserId
					);

		COMMIT TRANSACTION
		if isnull(@ReturnKey,0) = 1 
		Begin
			SELECT SystemId as SystemId FROM @Created;
		End
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveTaxonomy]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppSaveTaxonomy] @TaxonomyId INT
	,@TaxonomyCode VARCHAR(25)
	,@SectorId INT
	,@SegmentId INT
	,@IndustryId INT
	,@AssetTypeId INT
	,@FailureModeId INT
	,@FailureCauseId INT
	,@MTTR DECIMAL(10, 2)
	,@MTTROld DECIMAL(10, 2)
	,@MTBF DECIMAL(10, 2)
	,@MTBFOld DECIMAL(10, 2)
	,@Active VARCHAR(1)
	,@UserId INT
	,@AssetCategoryId Int
	,@AssetClassId Int
	,@AssetSequenceId Int
	,@AssetClassTypeCode VARCHAR(50)
	,@TaxonomyType VARCHAR(1) 
AS
BEGIN  
	
	BEGIN TRANSACTION 
	BEGIN TRY

		IF Isnull(@FailureModeId,0) = 0
		Begin
			SET @FailureModeId = NULL
			SET @TaxonomyType = 'A'
		End
		Else
		Begin
			SET @TaxonomyType = 'T'
		End
		IF @FailureCauseId = 0
			SET @FailureCauseId = NULL
		SET @TaxonomyCode = CONCAT (
				@SectorId
				,'.'
				,@SegmentId
				,'.'
				,@IndustryId
				,'.'
				,@AssetCategoryId
				,'.'
				,@AssetClassId
				,'.'
				,@AssetTypeId
				,'.'
				,@AssetSequenceId
				,case when isnull(@FailureModeId, '') <> '' then concat('.',@FailureModeId) else '' end 
				,case when isnull(@FailureCauseId, '') <> '' then concat('.',@FailureCauseId) else '' end 
				)

        SET @AssetClassTypeCode = Concat(
		(Select AssetClassCode from AssetClass where AssetClassId = @AssetClassId)
		, (Select AssetTypeCode from AssetType where AssetTypeId = @AssetTypeId)
		, (Select AssetSequenceCode from AssetSequence where AssetSequenceId = @AssetSequenceId)
		)
		
		MERGE [dbo].[Taxonomy] AS [target]
		USING (
			SELECT @TaxonomyId
			) AS source(TaxonomyId)
			ON ([target].[TaxonomyId] = [source].[TaxonomyId])
		WHEN MATCHED
			THEN
				UPDATE
				SET TaxonomyCode = @TaxonomyCode
				    ,AssetClassTypeCode = @AssetClassTypeCode
					,SectorId = @SectorId
					,SegmentId = @SegmentId
					,IndustryId = @IndustryId
					,AssetCategoryId = @AssetCategoryId
					,AssetClassId = @AssetClassId
					,AssetTypeId = @AssetTypeId
					,AssetSequenceId = @AssetSequenceId
					,FailureModeId = @FailureModeId
					,FailureCauseId = @FailureCauseId
					,Active = @Active
					,MTTR = @MTTR
					,MTTROld = @MTTROld
					,MTBF = @MTBF
					,MTBFOld = @MTBFOld
					,TaxonomyType = @TaxonomyType

		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					SectorId
					,SegmentId
					,IndustryId
					,AssetTypeId
					,FailureModeId
					,FailureCauseid
					,TaxonomyCode
					,AssetClassTypeCode
					,MTTR
					,MTTROld
					,MTBF
					,MTBFOld
					,Active
					,CreatedBy
					,AssetCategoryId
					,AssetClassId
					,AssetSequenceId 
					,TaxonomyType
					)
				VALUES (
					@SectorId
					,@SegmentId
					,@IndustryId
					,@AssetTypeId
					,@FailureModeId
					,@FailureCauseid
					,@TaxonomyCode
					,@AssetClassTypeCode
					,@MTTR
					,@MTTROld
					,@MTBF
					,@MTBFOld
					,@Active
					,@UserId
					,@AssetCategoryId
					,@AssetClassId
					,@AssetSequenceId 
					,@TaxonomyType
					);

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveTechUpgrade]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppSaveTechUpgrade] 
	 @TechupgradeId INT
	,@ClientSiteId int 
	,@EquipmentId int 
	,@ReportDate Date	
	,@RecommendationDate Date
	,@Saving decimal(15, 4) 
	,@Recommendation nVarchar(250)
	,@Remarks nvarchar(1500)	
	,@OriginalFileName nVarchar(150)
	,@LogicalFileName VARCHAR(500)
	,@PhysicalFilePath VARCHAR(500)
	,@Active VARCHAR(1)
	,@UserId INT
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
 
	MERGE [dbo].[TechUpgrade] AS [target]
		USING (
			SELECT @TechupgradeId 
			) AS source(TechupgradeId )
			ON ([target].[TechUpgradeId] = [source].[TechUpgradeId])
		WHEN MATCHED
			THEN
				UPDATE
				SET Active = @Active
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
				 ClientSiteId
				 ,ReportDate
				 ,RecommendationDate
				 ,EquipmentId
				 ,Saving
				 ,Recommendation
				 ,Remarks
				 ,[FileName]
				,LogicalName
				,PhysicalPath
				,CreatedBy
				,Active
				
					)
				VALUES (
				 @ClientSiteId
				 ,@ReportDate
				 ,@RecommendationDate
				 ,@EquipmentId
				 ,@Saving
				 ,@Recommendation
				 ,@Remarks
				 ,@OriginalFileName
				 ,@LogicalFileName
				 ,@PhysicalFilePath
				 ,@UserId
				 ,@Active);
	 

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveUserDashboard]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create   PROCEDURE [dbo].[EAppSaveUserDashboard] 
	 @UserDashboardId int 
	,@WidgetId int 
	,@UserId int 
	,@XAxis int 
	,@YAxis int 
	,@WRow int 
	,@WColumn int 
	,@DataViewPrefId int
	,@Param1 nvarchar(75) 
	,@Param2 nvarchar(75) 
	,@Param3 nvarchar(75) 
	,@Param4 nvarchar(75) 
	,@Param5 nvarchar(75)  
	,@Active varchar(1)
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY

		MERGE [dbo].[UserDashboard] AS [target]
		USING (
			SELECT @UserId,@WidgetId
			) AS source(UserId,WidgetId)
			ON ([target].[UserId] = [source].[UserId] and [target].[WidgetId] = [source].[WidgetId])
		WHEN MATCHED
			THEN
				UPDATE
				SET  
				 XAxis = @XAxis
				,YAxis = @YAxis 
				,WRow = @WRow 
				,WColumn = @WColumn 
				,DataViewPrefId = @DataViewPrefId
				,Param1 = @Param1
				,Param2 = @Param2
				,Param3 = @Param3
				,Param4 = @Param4
				,Param5 = @Param5
				,Active = @Active
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
				     UserId
					,WidgetId
					,XAxis
					,YAxis
					,WRow
					,WColumn
					,DataViewPrefId
					,Param1 
					,Param2 
					,Param3 
					,Param4
					,Param5
					,Active
					,CreatedBy
					)
				VALUES (
				    @UserId
					,@WidgetId
					,@XAxis
					,@YAxis
					,@WRow
					,@WColumn
					,@DataViewPrefId
					,@Param1 
					,@Param2 
					,@Param3 
					,@Param4
					,@Param5
					,@Active 
					,@UserId
					);


		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveUserRoleGroup]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppSaveUserRoleGroup] @UserId INT
	,@RoleGroupid INT
	,@Active VARCHAR(1)
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
		MERGE [dbo].[UserRoleGroupRelation] AS [target]
		USING (
			SELECT @UserId
				,@RoleGroupid
			) AS source(UserId, RoleGroupId)
			ON ([target].[UserId] = [source].[Userid])
				AND ([target].[RoleGroupId] = [source].[RoleGroupId])
		WHEN MATCHED
			THEN
				UPDATE
				SET Active = @Active
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					Userid
					,RoleGroupId
					,Active
					,CreatedBy
					)
				VALUES (
					@UserId
					,@RoleGroupId
					,@Active
					,@UserId
					);

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveUsers]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppSaveUsers] @UserId INT
	,@UserName NVARCHAR(50)
	,@FirstName NVARCHAR(50)
	,@MiddleName NVARCHAR(50)
	,@LastName NVARCHAR(50)
	,@EmailId NVARCHAR(50)
	,@Mobile NVARCHAR(50)
	,@Phone NVARCHAR(50)
	,@UserTypeId INT
	,@UserStatusId INT
	,@CreatedUserId INT
	,@Id NVARCHAR(450)
	,@Password NVARCHAR(30)
	,@ReturnKey int
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
	DECLARE @Created TABLE (
			[UserId] INT
			,PRIMARY KEY ([UserId])
			);

		if isnull(@UserStatusId,0) = 0 
		set @UserStatusId = dbo.GetStatusId(1,'UserStatus','A') 
		MERGE [dbo].[Users] AS [target]
		USING (
			SELECT @UserId
			) AS source(UserId)
			ON ([target].[UserId] = [source].[UserId])
		WHEN MATCHED
			THEN
				UPDATE
				SET FirstName = @FirstName
					,MiddleName = @MiddleName
					,LastName = @LastName
					,EmailId = @EmailId
					,Mobile = @Mobile
					,Phone = @Phone
					,UserTypeid = @UserTypeId
					,UserStatusId = @UserStatusId
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					UserName
					,FirstName
					,MiddleName
					,LastName
					,EmailId
					,Mobile
					,Phone
					,UserTypeId
					,UserStatusid
					,CreatedBy
					,Id
					,Password
					)
				VALUES (
					@UserName
					,@FirstName
					,@MiddleName
					,@LastName
					,@EmailId
					,@Mobile
					,@Phone
					,@UserTypeId
					,@UserStatusid
					,@CreatedUserId
					,@Id
					,@Password
					)OUTPUT INSERTED.[UserId] INTO @Created;;

		COMMIT TRANSACTION
		if isnull(@ReturnKey,0) = 1 
		Begin
			SELECT UserId as UserId FROM @Created;
		End
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveUserSiteAccess]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppSaveUserSiteAccess] @UserId INT
	,@LoginUserId INT
	,@Type VARCHAR(50)
	,@Id INT
	,@Active VARCHAR(1)
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
 
		IF @Type = 'Country'
		BEGIN
			MERGE [dbo].[UserCountryRelation] AS [target]
			USING (
				SELECT @Id
					,@LoginUserId
				) AS source(CountryId, Userid)
				ON (
						[target].[CountryId] = [source].[CountryId]
						AND [target].[UserId] = [source].[UserId]
						)
			WHEN MATCHED
				THEN
					UPDATE
					SET Active = @Active
			WHEN NOT MATCHED BY TARGET
				THEN
					INSERT (
						UserId
						,CountryId
						,Active
						,CreatedBy
						)
					VALUES (
						@LoginUserId
						,@Id
						,@Active
						,@UserId
						);
		Delete from UserCountryRelation where userid = @LoginUserId and Active = 'N';
 
		END
		ELSE IF @Type = 'CostCentre'
		BEGIN
			MERGE [dbo].[UserCostCentreRelation] AS [target]
			USING (
				SELECT @Id
					,@LoginUserId
				) AS source(CostCentreId, Userid)
				ON (
						[target].[CostCentreId] = [source].[CostCentreId]
						AND [target].[UserId] = [source].[UserId]
						)
			WHEN MATCHED
				THEN
					UPDATE
					SET Active = @Active
			WHEN NOT MATCHED BY TARGET
				THEN
					INSERT (
						UserId
						,CostCentreId
						,Active
						,CreatedBy
						)
					VALUES (
						@LoginUserId
						,@Id
						,@Active
						,@UserId
						);
			Delete from UserCostCentreRelation where userid = @LoginUserId and Active = 'N';
		END
		ELSE IF @Type = 'Client'
		BEGIN
			MERGE [dbo].[UserClientRelation] AS [target]
			USING (
				SELECT @Id
					,@LoginUserId
				) AS source(ClientId, Userid)
				ON (
						[target].[ClientId] = [source].[ClientId]
						AND [target].[UserId] = [source].[UserId]
						)
			WHEN MATCHED
				THEN
					UPDATE
					SET Active = @Active
			WHEN NOT MATCHED BY TARGET
				THEN
					INSERT (
						UserId
						,ClientId
						,Active
						,CreatedBy
						)
					VALUES (
						@LoginUserId
						,@Id
						,@Active
						,@UserId
						);
			Delete from UserClientRelation where userid = @LoginUserId and Active = 'N';
		END
		ELSE IF @Type = 'ClientSite'
		BEGIN
			MERGE [dbo].[UserClientSiteRelation] AS [target]
			USING (
				SELECT @Id
					,@LoginUserId
				) AS source(ClientSiteId, Userid)
				ON (
						[target].[ClientSiteId] = [source].[ClientSiteId]
						AND [target].[UserId] = [source].[UserId]
						)
			WHEN MATCHED
				THEN
					UPDATE
					SET Active = @Active
			WHEN NOT MATCHED BY TARGET
				THEN
					INSERT (
						UserId
						,ClientSiteId
						,Active
						,CreatedBy
						)
					VALUES (
						@LoginUserId
						,@Id
						,@Active
						,@UserId
						);
				
				if isnull(@Active,'N') = 'Y' 
				begin
					update users set LastSessionClient =@Id  where userid = @LoginUserId and LastSessionClient is null
				end

			Delete from UserClientSiteRelation where userid = @LoginUserId and Active = 'N';
		END

		
		Declare @ActiveClientAccess int 
		set @ActiveClientAccess = null
		select @ActiveClientAccess = ClientSiteId  from [udtfClientAccess](2) where clientsiteid = @LoginUserId

		if Isnull(@ActiveClientAccess,0) = 0 
		Begin
		Update Users set LastSessionClient = null where UserId = @LoginUserId
		End

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END

 
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveWNEquipmentAttachments]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppSaveWNEquipmentAttachments] 
	 @WNEquipmentAttachId bigint
	,@WNEquipmentId bigint 
	,@FileName VARCHAR(500)
	,@LogicalName VARCHAR(500)
	,@PhysicalPath VARCHAR(500)
	,@Active VARCHAR(1)
	,@UserId INT 
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
 
	MERGE [dbo].[WorkNotificationAttachment] AS [target]
		USING (
			SELECT @WNEquipmentAttachId 
			) AS source(WNAttachmentId)
			ON ([target].[WNAttachmentId] = [source].[WNAttachmentId])
		WHEN MATCHED
			THEN
				UPDATE
				SET Active = @Active
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
 				 WNEquipmentId
				,FileName
				,LogicalName
				,PhysicalPath
				,Active
				,CreatedBy
					)
				VALUES (
				 @WNEquipmentId
				,@FileName
				,@LogicalName
				,@PhysicalPath
				,@Active
				,@UserId);
 

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveWNEquipmentOpportunity]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EAppSaveWNEquipmentOpportunity] --0, 142, 187618, 32, 32, 0, 1, 84, 'Y', 187
  @WNOpportunityId  bigint,
  @WNEquipmentId bigint,
  @WorkNotificationNumber VARCHAR(100), 
  @EquipmentId bigint,
  @ActualOutageHours decimal (4,2),
  @ActualRepairCost decimal (10,2),
  @TrueSavings decimal (10,2),
  @FailureModeId int,
  @FailureCauseId int,
  @ActionDoneBy int,
  @Active VARCHAR(1),
  @UserId INT 
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
 
	MERGE [dbo].[WorkNotificationOpportunity] AS [target]
		USING (
			SELECT @WNOpportunityId 
			) AS source(WNOpportunityId)
			ON ([target].[WNOpportunityId] = [source].[WNOpportunityId])
		WHEN MATCHED
			THEN
				UPDATE
				SET Active = @Active
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
				 WNEquipmentId
				,[EquipmentId]
				,[WorkNotificationNumber]
				,[ActualOutageHours]
				,[ActualRepairCost]
				,[TrueSavings]
				,[FailureModeId]
				,[FailureCauseId]
				,ActionDoneBy 
				,Active
				,CreatedBy
					)
				VALUES (

				 @WNEquipmentId 
				,@EquipmentId 
				,@WorkNotificationNumber
				,@ActualOutageHours
				,@ActualRepairCost
				,@TrueSavings
				,@FailureModeId
				,@FailureCauseId
				,@ActionDoneBy 
				,@Active
				,@UserId);
  
		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveWorkNotificationComplete]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EAppSaveWorkNotificationComplete] 
	 @WNEquipmentId int 
	,@RiAmperage decimal(15,4)
	,@IsAccurate int
	,@WNCompletionDate date
	,@Feedback nvarchar(3500) 
	,@UserId INT
AS
BEGIN   
	BEGIN TRANSACTION
 	BEGIN TRY
 		Declare @Result varchar(1), @ResultText varchar(1500), @WNEquipmentCompleted varchar(1), @TotalCount int,@OpenCount int,@CloseCount int,@CancelCount int, @CancelStatus int, @CloseStatus int, @OpenStatus int
		select  @OpenStatus = dbo.GetStatusId(1,'WorkNotificationStatus','OP') ,  @CancelStatus = dbo.GetStatusId(1,'WorkNotificationStatus','CN') , @CloseStatus = dbo.GetStatusId(1,'WorkNotificationStatus','CL') 
		Set @WNEquipmentCompleted = 'N'
 
		select @OpenCount  = sum(case when StatusId = @OpenStatus then 1 else 0 end),   
		@CloseCount  = sum(case when StatusId = @CloseStatus then 1 else 0 end),
		@CancelCount  = sum(case when StatusId = @CancelStatus then 1 else 0 end), 
		@TotalCount = count(*)
		from WorkNotificationUnits where WNEquipmentId = @WNEquipmentId 
		
		if  ((isnull(@CloseCount,0)  + isnull(@CancelCount,0)) = isnull(@TotalCount,0)  )
		Begin
			Declare @DownTimeCost decimal(15,4), @RiskAvoidanceRevenue decimal(15,4), @RiskAvoidanceHours decimal(15,2)
			
			Select top 1 @DownTimeCost = DownTimeCostPerHour
			From WorkNotificationUnits where WNEquipmentId = @WNEquipmentId
			Order by MeanRepairManHours desc

			Select @RiskAvoidanceRevenue = ( ((@DownTimeCost * Max(MeanRepairManHours)) + 
												Sum(case when isnull(ActualRepairCost,0) > isnull(CostToRepair,0) then ActualRepairCost else CostToRepair end) 
											  )
											  -((Max(ActualOutageHours)*@DownTimeCost )+sum(isnull(ActualRepairCost,0)) )	
											  ) 
												* max(dbo.GetLookupTranslated(FailureProbFactorId,1,'LookupValue')) / 100
				,@RiskAvoidanceHours = (Max(MeanRepairManHours)-Max(ActualOutageHours))* max(dbo.GetLookupTranslated(FailureProbFactorId,1,'LookupValue')) / 100
			From WorkNotificationUnits Where WNEquipmentId = @WNEquipmentId  

			select @RiskAvoidanceRevenue , @RiskAvoidanceHours


			MERGE [dbo].[WorkNotificationEquipment] AS [target]
			USING (
				SELECT @WNEquipmentId 
				) AS source(WNEquipmentId)
				ON ([target].[WNEquipmentId] = [source].[WNEquipmentId])
			WHEN MATCHED
				THEN
					UPDATE
					SET 
						RiAmperage = @RiAmperage 
						,IsAccurate = @IsAccurate
						,WNCompletionDate = @WNCompletionDate
						,Feedback  = @Feedback 
						,StatusId = case when @WNCompletionDate is not null then @CloseStatus else StatusId end
						,RiskAvoidanceRevenue = @RiskAvoidanceRevenue
						,RiskAvoidanceHours = @RiskAvoidanceHours
						 ;
			set @Result = 'S'
			set @ResultText = 'Work Notification Saved Successfully.'
		End
		Else
		Begin
			set @Result = 'E'
			set @ResultText = Concat('Still ',@OpenCount ,' are in open status, Please close those Assets and try.')
		End 
			COMMIT TRANSACTION
			select @Result Result, @ResultText ResultText 
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
 		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveWorkNotificationUnitCancel]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE   PROCEDURE [dbo].[EAppSaveWorkNotificationUnitCancel] 
	 @WNEquipmentId int
	,@WNUnitAnalysisId bigint
	,@CancelRemarks nvarchar(4000)
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
	  
		Declare @WNEquipmentCompleted varchar(1), @TotalCount int,@OpenCount int,@CloseCount int,@CancelCount int, @CancelStatus int, @CloseStatus int, @OpenStatus int
		select  @OpenStatus = dbo.GetStatusId(1,'WorkNotificationStatus','OP') ,  @CancelStatus = dbo.GetStatusId(1,'WorkNotificationStatus','CN') , @CloseStatus = dbo.GetStatusId(1,'WorkNotificationStatus','CL') 
		Set @WNEquipmentCompleted = 'N'
		MERGE [dbo].[WorkNotificationUnits] AS [target]
		USING (
			SELECT @WNUnitAnalysisId 
			) AS source(WNUnitAnalysisId)
			ON ([target].[WNUnitAnalysisId] = [source].[WNUnitAnalysisId])
		WHEN MATCHED
			THEN
				UPDATE
				SET  StatusId = @CancelStatus,
				CancelRemarks = @CancelRemarks ; 
 
		select @OpenCount  = sum(case when StatusId = @OpenStatus then 1 else 0 end),   
		@CloseCount  = sum(case when StatusId = @CloseStatus then 1 else 0 end),
		@CancelCount  = sum(case when StatusId = @CancelStatus then 1 else 0 end), 
		@TotalCount = count(*)
		from WorkNotificationUnits where WNEquipmentId = @WNEquipmentId 
		
		if isnull(@CancelCount,0)  = isnull(@TotalCount,0)  
		Begin
			Update WorkNotificationEquipment set statusid = @CancelStatus where WNEquipmentId = @WNEquipmentId
		End
		 
	
	COMMIT TRANSACTION
	
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
 		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EAppSaveWorkNotificationUnitComplete]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EAppSaveWorkNotificationUnitComplete] 
	 @WNEquipmentId int
	,@WNUnitAnalysisId bigint
	,@ActualRepairCost decimal(15,4)
	,@ActualOutageHours decimal(15,4) 
	,@UserId INT
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
 
		Declare @WNEquipmentCompleted varchar(1), @TotalCount int,@OpenCount int,@CloseCount int,@CancelCount int, @CancelStatus int, @CloseStatus int, @OpenStatus int
		select  @OpenStatus = dbo.GetStatusId(1,'WorkNotificationStatus','OP') ,  @CancelStatus = dbo.GetStatusId(1,'WorkNotificationStatus','CN') , @CloseStatus = dbo.GetStatusId(1,'WorkNotificationStatus','CL') 
		Set @WNEquipmentCompleted = 'N'
		MERGE [dbo].[WorkNotificationUnits] AS [target]
		USING (
			SELECT @WNUnitAnalysisId 
			) AS source(WNUnitAnalysisId)
			ON ([target].[WNUnitAnalysisId] = [source].[WNUnitAnalysisId])
		WHEN MATCHED
			THEN
				UPDATE
				SET ActualRepairCost = @ActualRepairCost 
					,ActualOutageHours = @ActualOutageHours
					,StatusId = case when (isnull(@ActualRepairCost,0)+isnull(@ActualOutageHours,0) <> 0) then @CloseStatus else StatusId end ;
	 
			/*

		select @OpenCount  = sum(case when StatusId = @OpenStatus then 1 else 0 end),   
		@CloseCount  = sum(case when StatusId = @CloseStatus then 1 else 0 end),
		@CancelCount  = sum(case when StatusId = @CancelStatus then 1 else 0 end), 
		@TotalCount = count(*)
		from WorkNotificationUnits where WNEquipmentId = @WNEquipmentId 
		
		if isnull(@CloseCount,0) > 1 and ((isnull(@CloseCount,0)  + isnull(@CancelCount,0)) = isnull(@TotalCount,0)  )
		Begin
			set @WNEquipmentCompleted  = 'Y'
		End
		Else
		Begin
			 set @WNEquipmentCompleted  = 'N'
		End
		select @WNEquipmentCompleted as WorkNotificationDone
	*/
			COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
 		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[EJobRptFeedAnalystPeformance]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EJobRptFeedAnalystPeformance] 
AS
BEGIN 
 
	Truncate Table RptAnalystPerformance
	  
	Insert into RptAnalystPerformance
	(CountryId, CostCentreId, SectorId, segmentId, IndustryId , ClientSiteId ,AnalystId,
	CountryName , CostCentreName ,SectorName ,SegmentName ,IndustryName, ClientSiteName, ReportDate , 
	AnalystName , TypeId , ActivityType , TypeName , ActivityCount   ) 
	Select 
	 CountryId, CostCentreId, SectorId, segmentId, IndustryId , ClientSiteId ,AnalystId,
	CountryName , CostCentreName ,SectorName ,SegmentName ,IndustryName, ClientSiteName, ReportDate , 
	AnalystName , TypeId , ActivityType , TypeName , ActivityCount
	from dbo.[udtfAnalystPerformance] ()
END
 
GO
/****** Object:  StoredProcedure [dbo].[EJobRptFeedAssetHealth]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
CREATE   PROCEDURE [dbo].[EJobRptFeedAssetHealth] 
AS
BEGIN
 	Truncate Table [RptJobAssetHealthStatus]
	 
 
	Insert into [RptJobAssetHealthStatus]
	(CountryId,SectorId,segmentId,IndustryId,CostCentreId,ClientSiteId,PlantAreaId,ServiceId,ManufacturerId,UnitType,
	CountryName,CostCentreName,SectorName,SegmentName,IndustryName,ClientSiteName,PlantAreaName,ServiceType,
	ManufacturerName,ConditionId,ConditionName,JobPeriod,EventCount)
 	select CountryId,SectorId,segmentId,IndustryId,CostCentreId,ClientSiteId,PlantAreaId,ServiceId,ManufacturerId,'Drive' UnitType,
	CountryName,CostCentreName,SectorName,SegmentName,IndustryName,ClientSiteName,PlantAreaName,ServiceType,
	ManufacturerName,ConditionId,ConditionName,JobPeriod,EventCount from dbo.[udtfDriveHealthStatus]()
	--Driven Load
	Insert into [RptJobAssetHealthStatus]
	(CountryId,SectorId,segmentId,IndustryId,CostCentreId,ClientSiteId,PlantAreaId,ServiceId,ManufacturerId,UnitType,
	CountryName,CostCentreName,SectorName,SegmentName,IndustryName,ClientSiteName,PlantAreaName,ServiceType,
	ManufacturerName,ConditionId,ConditionName,JobPeriod,EventCount)
 	select CountryId,SectorId,segmentId,IndustryId,CostCentreId,ClientSiteId,PlantAreaId,ServiceId,ManufacturerId,'Driven'UnitType,
	CountryName,CostCentreName,SectorName,SegmentName,IndustryName,ClientSiteName,PlantAreaName,ServiceType,
	ManufacturerName,ConditionId,ConditionName,JobPeriod,EventCount from dbo.[udtfDrivenHealthStatus]()
	-- Intermediate Load
		Insert into [RptJobAssetHealthStatus]
	(CountryId,SectorId,segmentId,IndustryId,CostCentreId,ClientSiteId,PlantAreaId,ServiceId,ManufacturerId,UnitType,
	CountryName,CostCentreName,SectorName,SegmentName,IndustryName,ClientSiteName,PlantAreaName,ServiceType,
	ManufacturerName,ConditionId,ConditionName,JobPeriod,EventCount)
 	select CountryId,SectorId,segmentId,IndustryId,CostCentreId,ClientSiteId,PlantAreaId,ServiceId,ManufacturerId,'Intermediate'UnitType,
	CountryName,CostCentreName,SectorName,SegmentName,IndustryName,ClientSiteName,PlantAreaName,ServiceType,
	ManufacturerName,ConditionId,ConditionName,JobPeriod,EventCount from dbo.[udtfIntermediateHealthStatus]()

End
 
GO
/****** Object:  StoredProcedure [dbo].[EJobRptFeedBearingList]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EJobRptFeedBearingList] 
AS
BEGIN 
 
	Declare @ClientSiteId Int,@ClientSiteName nvarchar(500) ,@PlantAreaId Int ,@PlantAreaName nvarchar(500), 
	@AssetType Varchar(50),@AssetLocation varchar(10),@ManufacturerId Int ,@ManufacturerName nvarchar(500),
	@BearingCount Int,@AssetCount Int, @UnitManufacturerId Int ,@UnitManufacturerName nvarchar(500),
	@EquipmentCount int,
	@CountryId Int,@CostCentreId Int,@SectorId Int,@SegmentId Int,@IndustryId Int,@CountryName nvarchar(500),@CostCentreName nvarchar(500),@SectorName nvarchar(500),@SegmentName nvarchar(500),@IndustryName nvarchar(500)
	Select @ClientSiteId = null, @PlantAreaId = null, @PlantAreaName = null, @AssetType = null,@AssetLocation = null, @ManufacturerId = null, @ManufacturerName = null, @BearingCount = null,@UnitManufacturerId= null,	@UnitManufacturerName= null,
	@CountryId  = null,@CostCentreId  = null,@SectorId  = null,@SegmentId  = null,@IndustryId  = null,@CountryName  = null,@CostCentreName  = null,@SectorName  = null,@SegmentName  = null,@IndustryName = null
	
	Truncate table RptBearingList
	 
	DECLARE GetDriveBearingList CURSOR READ_ONLY
	FOR
	select p.ClientSiteId,dbo.GetNameTranslated(p.ClientSiteId,1,'ClientSiteName') ClientSiteName,p.PlantAreaId,dbo.GetNameTranslated(p.PlantAreaId,1,'PlantAreaName') PlantAreaName, 
	'Drive' as AssetType,b.ManufacturerId as BManufacturerId,dbo.GetNameTranslated(b.ManufacturerId,1,'ManufacturerName') BManufacturerName,
	Count(Distinct e.EquipmentId) EquipmentCount,
	Count(Distinct d.DriveUnitId) AssetCount,
	Count(Distinct b.DriveBearingId) BearingCount, d.ManufacturerId as AManufacturerId,
	dbo.GetNameTranslated(d.ManufacturerId,1,'ManufacturerName') AManufacturerName,
	c.CountryId ,c.CostCentreId ,s.SectorId,s.SegmentId, c.IndustryId, 
	dbo.GetNameTranslated(c.CountryId,1,'Countryname') CountryName, 
	dbo.GetNameTranslated(c.CostCentreId,1,'CostCentreName') CostCentreName,
	dbo.GetNameTranslated(s.SectorId,1,'SectorName') SectorName,
	dbo.GetNameTranslated(s.SegmentId,1,'SegmentName') SegmentName,
	dbo.GetNameTranslated(c.IndustryId,1,'IndustryName') IndustryName 
	from DriveBearing b join EquipmentDriveUnit d on b.DriveUnitId = d.DriveUnitId 
	join Equipment e on e.EquipmentId = d.EquipmentId
	Join PlantArea p on p.PlantAreaId = e.PlantAreaId 
	Join ClientSite c on c.ClientSiteId = p.ClientSiteId
	Join Industry i on i.IndustryId = c.IndustryId
	join Segment s on s.SegmentId = i.SegmentId
	where b.Active = 'Y'
	Group by c.CountryId ,c.CostCentreId ,s.SectorId,s.SegmentId, c.IndustryId,p.ClientSiteId,p.PlantAreaId,b.ManufacturerId,d.ManufacturerId
 
	OPEN GetDriveBearingList
	FETCH NEXT FROM GetDriveBearingList INTO
	@ClientSiteId,@ClientSiteName,@PlantAreaId,@PlantAreaName, 
	@AssetType,@ManufacturerId,@ManufacturerName,@EquipmentCount,@AssetCount,@BearingCount,@UnitManufacturerId,@UnitManufacturerName,
	@CountryId,@CostCentreId,@SectorId,@SegmentId,@IndustryId,@CountryName,@CostCentreName,@SectorName,@SegmentName,@IndustryName
	WHILE @@FETCH_STATUS = 0
	BEGIN 
	  
	MERGE [dbo].[RptBearingList] AS [target]
		USING (
			SELECT @ClientSiteId,@PlantAreaId,@AssetType,@ManufacturerId,@UnitManufacturerId
			) AS source(ClientSiteId,PlantAreaId,AssetType,ManufacturerId,UnitManufacturerId)
			ON ([target].[ClientSiteId] = [source].[ClientSiteId]
			and [target].[PlantAreaId] = [source].[PlantAreaId]
			and [target].[AssetType] = [source].[AssetType]
			and [target].[ManufacturerId] = [source].[ManufacturerId]
			and [target].[UnitManufacturerId] = [source].[UnitManufacturerId]
			)
		WHEN MATCHED
			THEN
				UPDATE
				SET 
				EquipmentCount = @EquipmentCount
				,BearingCount = @BearingCount
				,AssetCount = @AssetCount
				,ModifiedOn = getdate()
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
				ClientSiteId ,
				ClientSiteName,
				PlantAreaId ,
				PlantAreaName ,
				AssetType ,
				AssetLocation ,
				ManufacturerId ,
				ManufacturerName ,
				BearingCount,
				EquipmentCount,
				AssetCount,
				UnitManufacturerId,
				UnitManufacturerName,
				CountryId,CostCentreId,SectorId,SegmentId,IndustryId,CountryName,CostCentreName,SectorName,SegmentName,IndustryName,
				CreatedOn  
					)
				VALUES (
				@ClientSiteId ,
				@ClientSiteName,
				@PlantAreaId ,
				@PlantAreaName ,
				@AssetType ,
				@AssetLocation ,
				@ManufacturerId ,
				@ManufacturerName ,
				@BearingCount ,
				@EquipmentCount,
				@AssetCount,
				@UnitManufacturerId,
				@UnitManufacturerName,
				@CountryId,@CostCentreId,@SectorId,@SegmentId,@IndustryId,@CountryName,@CostCentreName,@SectorName,@SegmentName,@IndustryName,
				Getdate()
					) ;
			FETCH NEXT FROM GetDriveBearingList INTO
   			@ClientSiteId,@ClientSiteName,@PlantAreaId,@PlantAreaName, 
			@AssetType,@ManufacturerId,@ManufacturerName,@EquipmentCount,@AssetCount,@BearingCount,@UnitManufacturerId,@UnitManufacturerName,
			@CountryId,@CostCentreId,@SectorId,@SegmentId,@IndustryId, 
				@CountryName,@CostCentreName,@SectorName,@SegmentName,@IndustryName
			END
			CLOSE GetDriveBearingList
			DEALLOCATE GetDriveBearingList 
-------Driven Bearing Load-------
	Select @ClientSiteId = null, @PlantAreaId = null, @PlantAreaName = null, @AssetType = null,@AssetLocation = null, @ManufacturerId = null, @ManufacturerName = null, @BearingCount = null,@UnitManufacturerId= null,	@UnitManufacturerName= null,
	@CountryId  = null,@CostCentreId  = null,@SectorId  = null,@SegmentId  = null,@IndustryId  = null,@CountryName  = null,@CostCentreName  = null,@SectorName  = null,@SegmentName  = null,@IndustryName = null
		
	DECLARE GetDrivenBearingList CURSOR READ_ONLY
	FOR
	select p.ClientSiteId,dbo.GetNameTranslated(p.ClientSiteId,1,'ClientSiteName') ClientSiteName, p.PlantAreaId,dbo.GetNameTranslated(p.PlantAreaId,1,'PlantAreaName') PlantAreaName, 
	'Driven' as AssetType,b.ManufacturerId,dbo.GetNameTranslated(b.ManufacturerId,1,'ManufacturerName') ManufacturerName,
	Count(Distinct d.DrivenUnitId) AssetCount,
	Count(Distinct b.DrivenBearingId) BearingCount, d.ManufacturerId,dbo.GetNameTranslated(d.ManufacturerId,1,'ManufacturerName') UnitManufacturerName,
	c.CountryId ,c.CostCentreId ,s.SectorId,s.SegmentId, c.IndustryId, 
	dbo.GetNameTranslated(c.CountryId,1,'Countryname') CountryName, 
	dbo.GetNameTranslated(c.CostCentreId,1,'CostCentreName') CostCentreName,
	dbo.GetNameTranslated(s.SectorId,1,'SectorName') SectorName,
	dbo.GetNameTranslated(s.SegmentId,1,'SegmentName') SegmentName,
	dbo.GetNameTranslated(c.IndustryId,1,'IndustryName') IndustryName 
	from DrivenBearing b join EquipmentDrivenUnit d on b.DrivenUnitId = d.DrivenUnitId 
	join Equipment e on e.EquipmentId = d.EquipmentId
	Join PlantArea p on p.PlantAreaId = e.PlantAreaId 
	Join ClientSite c on c.ClientSiteId = p.ClientSiteId
	Join Industry i on i.IndustryId = c.IndustryId
	join Segment s on s.SegmentId = i.SegmentId
	where b.Active = 'Y'
	Group by c.CountryId ,c.CostCentreId ,s.SectorId,s.SegmentId, c.IndustryId,p.ClientSiteId,p.PlantAreaId,b.Place,b.ManufacturerId,d.ManufacturerId
  
	OPEN GetDrivenBearingList
	FETCH NEXT FROM GetDrivenBearingList INTO
	@ClientSiteId,@ClientSiteName,@PlantAreaId,@PlantAreaName, 
	@AssetType,@ManufacturerId,@ManufacturerName,@AssetCount,@BearingCount,@UnitManufacturerId,@UnitManufacturerName,
	@CountryId,@CostCentreId,@SectorId,@SegmentId,@IndustryId,@CountryName,@CostCentreName,@SectorName,@SegmentName,@IndustryName
	WHILE @@FETCH_STATUS = 0
	BEGIN 
	 
	MERGE [dbo].[RptBearingList] AS [target]
		USING (
			SELECT @ClientSiteId,@PlantAreaId,@AssetType,@ManufacturerId,@UnitManufacturerId
			) AS source(ClientSiteId,PlantAreaId,AssetType,ManufacturerId,UnitManufacturerId)
			ON ([target].[ClientSiteId] = [source].[ClientSiteId]
			and [target].[PlantAreaId] = [source].[PlantAreaId]
			and [target].[AssetType] = [source].[AssetType]
			and [target].[ManufacturerId] = [source].[ManufacturerId]
			and [target].[UnitManufacturerId] = [source].[UnitManufacturerId]
			)
		WHEN MATCHED
			THEN
				UPDATE
				SET BearingCount = @BearingCount
				,AssetCount = @AssetCount
				,ModifiedOn = getdate()
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
				ClientSiteId ,
				ClientSiteName,
				PlantAreaId ,
				PlantAreaName ,
				AssetType ,
				AssetLocation ,
				ManufacturerId ,
				ManufacturerName ,
				BearingCount,
				AssetCount,
				UnitManufacturerId,
				UnitManufacturerName,
				CountryId,CostCentreId,SectorId,SegmentId,IndustryId,CountryName,CostCentreName,SectorName,SegmentName,IndustryName,
				CreatedOn  
					)
				VALUES (
				@ClientSiteId ,
				@ClientSiteName,
				@PlantAreaId ,
				@PlantAreaName ,
				@AssetType ,
				@AssetLocation ,
				@ManufacturerId ,
				@ManufacturerName ,
				@BearingCount,
				@AssetCount,
				@UnitManufacturerId,
				@UnitManufacturerName,
				@CountryId,@CostCentreId,@SectorId,@SegmentId,@IndustryId,@CountryName,@CostCentreName,@SectorName,@SegmentName,@IndustryName,
				getdate()
					) ;
			FETCH NEXT FROM GetDrivenBearingList INTO
   			@ClientSiteId,@ClientSiteName,@PlantAreaId,@PlantAreaName, 
			@AssetType,@ManufacturerId,@ManufacturerName,@AssetCount,@BearingCount,@UnitManufacturerId,@UnitManufacturerName,
			@CountryId,@CostCentreId,@SectorId,@SegmentId,@IndustryId,@CountryName,@CostCentreName,@SectorName,@SegmentName,@IndustryName
			END
			CLOSE GetDrivenBearingList
			DEALLOCATE GetDrivenBearingList 
--------Intermediate Bearing Load
	Select @ClientSiteId = null, @PlantAreaId = null, @PlantAreaName = null, @AssetType = null,@AssetLocation = null, @ManufacturerId = null, @ManufacturerName = null, @BearingCount = null,@UnitManufacturerId= null,	@UnitManufacturerName= null,
	@CountryId  = null,@CostCentreId  = null,@SectorId  = null,@SegmentId  = null,@IndustryId  = null,@CountryName  = null,@CostCentreName  = null,@SectorName  = null,@SegmentName  = null,@IndustryName = null
	
	DECLARE GetIntermediateBearingList CURSOR READ_ONLY
	FOR
	select p.ClientSiteId,dbo.GetNameTranslated(p.ClientSiteId,1,'ClientSiteName') ClientSiteName,p.PlantAreaId,dbo.GetNameTranslated(p.PlantAreaId,1,'PlantAreaName') PlantAreaName, 
	'Intermediate' as AssetType,b.ManufacturerId,dbo.GetNameTranslated(b.ManufacturerId,1,'ManufacturerName') ManufacturerName,
	Count(Distinct d.IntermediateUnitId) AssetCount,
	Count(Distinct b.IntermediateBearingId) BearingCount, d.ManufacturerId,dbo.GetNameTranslated(d.ManufacturerId,1,'ManufacturerName') UnitManufacturerName,
	c.CountryId ,c.CostCentreId ,s.SectorId,s.SegmentId, c.IndustryId, 
	dbo.GetNameTranslated(c.CountryId,1,'Countryname') CountryName, 
	dbo.GetNameTranslated(c.CostCentreId,1,'CostCentreName') CostCentreName,
	dbo.GetNameTranslated(s.SectorId,1,'SectorName') SectorName,
	dbo.GetNameTranslated(s.SegmentId,1,'SegmentName') SegmentName,
	dbo.GetNameTranslated(c.IndustryId,1,'IndustryName') IndustryName 
	from IntermediateBearing b join EquipmentIntermediateUnit d on b.IntermediateUnitId = d.IntermediateUnitId 
	join Equipment e on e.EquipmentId = d.EquipmentId
	Join PlantArea p on p.PlantAreaId = e.PlantAreaId 
	Join ClientSite c on c.ClientSiteId = p.ClientSiteId
	Join Industry i on i.IndustryId = c.IndustryId
	join Segment s on s.SegmentId = i.SegmentId
	where b.Active = 'Y'
	Group by c.CountryId ,c.CostCentreId ,s.SectorId,s.SegmentId, c.IndustryId,p.ClientSiteId,p.PlantAreaId,b.ManufacturerId,d.ManufacturerId
  
	OPEN GetIntermediateBearingList
	FETCH NEXT FROM GetIntermediateBearingList INTO
	@ClientSiteId,@ClientSiteName,@PlantAreaId,@PlantAreaName, 
	@AssetType,@ManufacturerId,@ManufacturerName,@AssetCount,@BearingCount,@UnitManufacturerId,@UnitManufacturerName,
	@CountryId,@CostCentreId,@SectorId,@SegmentId,@IndustryId,@CountryName,@CostCentreName,@SectorName,@SegmentName,@IndustryName
	WHILE @@FETCH_STATUS = 0
	BEGIN 
	 
	MERGE [dbo].[RptBearingList] AS [target]
		USING (
			SELECT @ClientSiteId,@PlantAreaId,@AssetType,@ManufacturerId,@UnitManufacturerId
			) AS source(ClientSiteId,PlantAreaId,AssetType,ManufacturerId,UnitManufacturerId)
			ON ([target].[ClientSiteId] = [source].[ClientSiteId]
			and [target].[PlantAreaId] = [source].[PlantAreaId]
			and [target].[AssetType] = [source].[AssetType]
			and [target].[ManufacturerId] = [source].[ManufacturerId]
			and [target].[UnitManufacturerId] = [source].[UnitManufacturerId]
			)
		WHEN MATCHED
			THEN
				UPDATE
				SET BearingCount = @BearingCount
				,AssetCount = @AssetCount
				,ModifiedOn = getdate()
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
				ClientSiteId ,
				ClientSiteName,
				PlantAreaId ,
				PlantAreaName ,
				AssetType ,
				AssetLocation ,
				ManufacturerId ,
				ManufacturerName ,
				BearingCount  ,
				AssetCount,
				UnitManufacturerId,
				UnitManufacturerName,
				CountryId,CostCentreId,SectorId,SegmentId,IndustryId,CountryName,CostCentreName,SectorName,SegmentName,IndustryName,
				CreatedOn
					)
				VALUES (
				@ClientSiteId ,
				@ClientSiteName,
				@PlantAreaId ,
				@PlantAreaName ,
				@AssetType ,
				@AssetLocation ,
				@ManufacturerId ,
				@ManufacturerName ,
				@BearingCount,
				@AssetCount,
				@UnitManufacturerId,
				@UnitManufacturerName,
				@CountryId,@CostCentreId,@SectorId,@SegmentId,@IndustryId,@CountryName,@CostCentreName,@SectorName,@SegmentName,@IndustryName,
				getdate()
					) ;
			FETCH NEXT FROM GetIntermediateBearingList INTO
   			@ClientSiteId,@ClientSiteName,@PlantAreaId,@PlantAreaName, 
			@AssetType,@ManufacturerId,@ManufacturerName,@AssetCount,@BearingCount,@UnitManufacturerId,@UnitManufacturerName,
			@CountryId,@CostCentreId,@SectorId,@SegmentId,@IndustryId,@CountryName,@CostCentreName,@SectorName,@SegmentName,@IndustryName
			END
			CLOSE GetIntermediateBearingList
			DEALLOCATE GetIntermediateBearingList 					 
End
 
GO
/****** Object:  StoredProcedure [dbo].[EJobRptFeedClientList]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EJobRptFeedClientList] 
AS
BEGIN 
 	Truncate table RptClientList
 
	Insert into RptClientList (CountryId,CostCentreId,SectorId,SegmentId,IndustryId,ClientSiteId,
	CountryName,CostCentreName,SectorName,SegmentName,IndustryName,ClientSiteName,PMPOfflineProgram,PMPOnlineProgram,SmartSupplierProgram)
	select c.CountryId ,c.CostCentreId ,s.SectorId,s.SegmentId, c.IndustryId,  c.ClientSiteId, 
	dbo.GetNameTranslated(c.CountryId,1,'Countryname') CountryName, 
	dbo.GetNameTranslated(c.CostCentreId,1,'CostCentreName') CostCentreName,
	dbo.GetNameTranslated(s.SectorId,1,'SectorName') SectorName,
	dbo.GetNameTranslated(s.SegmentId,1,'SegmentName') SegmentName,
	dbo.GetNameTranslated(c.IndustryId,1,'IndustryName') IndustryName,
	dbo.GetNameTranslated(c.ClientSiteId,1,'ClientSiteName') ClientSiteName,
	PMPOfflineProgram,PMPOnlineProgram,SmartSupplierProgram
	 from ClientSite c Join Industry i on i.IndustryId = c.IndustryId
	join Segment s on s.SegmentId = i.SegmentId
 				 
End
 
GO
/****** Object:  StoredProcedure [dbo].[EJobRptFeedContractPerformance]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EJobRptFeedContractPerformance] 
AS
BEGIN

 	Declare @RiskAvoidance Table(
	ClientSiteId int 
	,PlantAreaId int
	,RDate date
	,VType varchar(50)
	,VName varchar(50)
	,RValue  decimal(15,2) 
	,ROrder int 
	) 

	Truncate table [RptContractPerformance]
 
	Declare @ClientSiteId Int, @ClientSiteName nvarchar(500), @PlantAreaId int, @PlantAreaName nvarchar(500), @JDate date, @Rdate Date,@RValue decimal(15,2), @RiskAvoidanceRevenue decimal(15,2), @EnergySavings decimal(15,2),@RiskAvoidanceHours decimal(15,2), @EnergySavingsHours decimal(15,2)
	,@RType varchar(50),@RName Varchar(50),@TrueSavingsCost decimal(15,2), @UnexpectedBreakdownCost decimal(15,2),@TrueSavingsHours decimal(15,2), @UnexpectedBreakdownHours decimal(15,2),
	@TechUpgradeSavings decimal(15,2), @TechUpgradeSavingsHours  decimal(15,2)
	
	Select @RiskAvoidanceRevenue = 0,@EnergySavings = 0,@TrueSavingsCost = 0,@UnexpectedBreakdownCost = 0,@TechUpgradeSavings = 0,
	@RiskAvoidanceHours = 0,@EnergySavingsHours = 0,@TrueSavingsHours = 0,@UnexpectedBreakdownHours = 0,@TechUpgradeSavingsHours = 0
	
	DECLARE GetWNList CURSOR READ_ONLY
	FOR
	SELECT wn.ClientSiteId, p.PlantAreaId , DATEADD(month, DATEDIFF(month, 0, wn.WorkNotificationDate), 0) , SUM(isnull(RiskAvoidanceRevenue,0)), SUM(isnull(EnergySavings,0)), 
	SUM(isnull(RiskAvoidanceHours,0)) 
	FROM dbo.WorkNotificationEquipment wn join Equipment e on e.EquipmentId = wn.EquipmentId
	join PlantArea p on p.PlantAreaId = e.PlantAreaId 
	Group by wn.ClientSiteId ,p.PlantAreaId, DATEADD(month, DATEDIFF(month, 0, wn.WorkNotificationDate), 0)

 	OPEN GetWNList
	FETCH NEXT FROM GetWNList INTO
	@ClientSiteId,@PlantAreaId, @Rdate, @RiskAvoidanceRevenue, @EnergySavings,@RiskAvoidanceHours 
	WHILE @@FETCH_STATUS = 0
	BEGIN 
		Insert into @RiskAvoidance (ClientSiteId,PlantAreaId,Rdate, VName,VType, RValue)
		select @ClientSiteId,@PlantAreaId,@Rdate,'RiskAvoidance','Revenue',@RiskAvoidanceRevenue 
		Union all
		select @ClientSiteId,@PlantAreaId,@Rdate,'EnergySavings','Revenue',@EnergySavings 
		Union all
		select @ClientSiteId,@PlantAreaId,@Rdate,'EnergySavings','Hours',0 
		Union all
		select @ClientSiteId,@PlantAreaId,@Rdate,'RiskAvoidance','Hours',@RiskAvoidanceHours  

	FETCH NEXT FROM GetWNList INTO
	@ClientSiteId,@PlantAreaId,@RDate,@RiskAvoidanceRevenue, @EnergySavings,@RiskAvoidanceHours 
	END
	CLOSE GetWNList
	DEALLOCATE GetWNList

	DECLARE GetFailureReportList CURSOR READ_ONLY
	FOR 
	SELECT r.ClientSiteId, p.PlantAreaId,  DATEADD(month, DATEDIFF(month, 0, r.ReportDate), 0), SUM(isnull(TrueSavingsCost,0)), SUM(isnull(BreakDownCost,0)),
	SUM(isnull(TrueSavingsHrs,0)) , SUM(isnull(BreakDownHrs,0))  
	FROM FailureReportHeader r join Equipment e on e.EquipmentId = r.EquipmentId
	join PlantArea p on p.PlantAreaId = e.PlantAreaId 
	Group by r.ClientSiteId, p.PlantAreaId, DATEADD(month, DATEDIFF(month, 0, r.ReportDate), 0)

 	OPEN GetFailureReportList
	FETCH NEXT FROM GetFailureReportList INTO
	@ClientSiteId, @PlantAreaId, @RDate, @TrueSavingsCost, @UnexpectedBreakdownCost, @TrueSavingsHours, @UnexpectedBreakdownHours 
	WHILE @@FETCH_STATUS = 0
	BEGIN
 		Insert into @RiskAvoidance (ClientSiteId,PlantAreaId,RDate, VName,VType, RValue)
		select @ClientSiteId,@PlantAreaId,@Rdate,'Extended Maintenance Savings','Revenue',@TrueSavingsCost 
		Union all
		select @ClientSiteId,@PlantAreaId,@Rdate,'UnexpectedBreakdown','Revenue',-1*@UnexpectedBreakdownCost
		Union all
		select  @ClientSiteId,@PlantAreaId,@Rdate,'Extended Maintenance Savings','Hours',@TrueSavingsHours
		Union all
		select @ClientSiteId,@PlantAreaId,@Rdate,'UnexpectedBreakdown','Hours',-1*@UnexpectedBreakdownHours

	FETCH NEXT FROM GetFailureReportList INTO
	@ClientSiteId, @PlantAreaId, @RDate,  @TrueSavingsCost, @UnexpectedBreakdownCost, @TrueSavingsHours, @UnexpectedBreakdownHours 
	END
	CLOSE GetFailureReportList
	DEALLOCATE GetFailureReportList

	DECLARE GetTechUpgradeList CURSOR READ_ONLY
	FOR 
	SELECT  r.ClientSiteId,p.PlantAreaId, DATEADD(month, DATEDIFF(month, 0, r.ReportDate), 0), SUM(Isnull(Saving,0)) 
	FROM TechUpgrade r  join Equipment e on e.EquipmentId = r.EquipmentId
	join PlantArea p on p.PlantAreaId = e.PlantAreaId 
	Group by r.ClientSiteId,p.PlantAreaId,  DATEADD(month, DATEDIFF(month, 0, r.ReportDate), 0)
 
	OPEN GetTechUpgradeList
	FETCH NEXT FROM GetTechUpgradeList INTO
	@ClientSiteId, @PlantAreaId, @RDate,@TechUpgradeSavings 
	WHILE @@FETCH_STATUS = 0
	BEGIN
 		Insert into @RiskAvoidance (ClientSiteId,PlantAreaId,RDate, VName,VType,RValue)
		select @ClientSiteId,@PlantAreaId,@Rdate,'Reliability Improvement Savings','Revenue',@TechUpgradeSavings 
		Union all
		select @ClientSiteId,@PlantAreaId,@Rdate,'Reliability Improvement Savings','Hours',0  

	FETCH NEXT FROM GetTechUpgradeList INTO
	@ClientSiteId,@PlantAreaId, @RDate, @TechUpgradeSavings 
	END
	CLOSE GetTechUpgradeList
	DEALLOCATE GetTechUpgradeList

	Insert into @RiskAvoidance (ClientSiteId,PlantAreaId, Rdate,VType, VName,RValue)
	select ClientSiteId,PlantAreaId,RDate,VType,'TotalSavings',sum(isnull(RValue,0)) 
	from @RiskAvoidance
	Group by ClientSiteId,PlantAreaId,RDate,VType

	DECLARE GetFeed CURSOR READ_ONLY
	FOR 
	select VType, ClientSiteId,dbo.GetNameTranslated(ClientSiteId,1,'ClientSiteName')ClientSiteName,PlantAreaId,dbo.GetNameTranslated(PlantAreaId,1,'PlantAreaName')PlantAreaName,  RDate, VName as 'Desc' ,isnull(RValue,0) "Risk Avoidance"   
 	from @RiskAvoidance 
	order by ClientSiteId,VType  
	OPEN GetFeed
	FETCH NEXT FROM GetFeed INTO
	@RType, @ClientSiteId,@ClientSiteName,@PlantAreaId,@PlantAreaName, @RDate, @RName,@Rvalue
	WHILE @@FETCH_STATUS = 0
	BEGIN 
	 
	MERGE [dbo].[RptContractPerformance] AS [target]
		USING (
			SELECT @ClientSiteId,@PlantAreaId, @RType,@RDate,@RName
			) AS source(ClientSiteId,PlantAreaId,RType,RDate,RName)
			ON ([target].[ClientSiteId] = [source].[ClientSiteId]
			and [target].[PlantAreaId] = [source].[PlantAreaId]
			and [target].[RType] = [source].[RType]
			and [target].[RDate] = [source].[RDate]
			and [target].[RName] = [source].[RName]
			)
		WHEN MATCHED
			THEN
				UPDATE
				SET RValue = @Rvalue
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					ClientSiteId ,
					ClientSiteName,
					PlantAreaId,
					PlantAreaName,
					RType ,
					RName ,
					RDate ,
					RValue  
					)
				VALUES (
					@ClientSiteId ,
					@ClientSiteName,
					@PlantAreaId,
					@PlantAreaName,
					@RType ,
					@RName ,
					@RDate ,
					@RValue
					) ;
	FETCH NEXT FROM GetFeed INTO
	@RType, @ClientSiteId,@ClientSiteName,@PlantAreaId,@PlantAreaName, @RDate, @RName,@Rvalue
	END
	CLOSE GetFeed
	DEALLOCATE GetFeed 

End
 
GO
/****** Object:  StoredProcedure [dbo].[EJobRptFeedEquipmentHealth]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EJobRptFeedEquipmentHealth] 
AS
BEGIN
 	Truncate Table RptEquipmentHealthStatus 
 
	Insert into RptEquipmentHealthStatus
	(CountryId,SectorId,segmentId,IndustryId,CostCentreId,ClientSiteId,PlantAreaId,ServiceId, 
	CountryName,CostCentreName,SectorName,SegmentName,IndustryName,ClientSiteName,PlantAreaName,ServiceType,
	ConditionId,ConditionCode,ConditionName,EventCount,EquipmentCount,JobPeriod)
 	select CountryId,SectorId,segmentId,IndustryId,CostCentreId,ClientSiteId,PlantAreaId,ServiceId, 
	CountryName,CostCentreName,SectorName,SegmentName,IndustryName,ClientSiteName,PlantAreaName,ServiceType,
	 ConditionId,ConditionCode,concat(ConditionCode,' ',ConditionName)ConditionName,EventCount,Equipmentcount,JobPeriod from dbo.[udtfEquipmentHealthStatus]() where conditionid is not null

End
 
GO
/****** Object:  StoredProcedure [dbo].[EJobRptFeedFailureCause]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EJobRptFeedFailureCause] 
AS
BEGIN
  	Truncate Table RptFailureCauseStatistics
     
	Insert into RptFailureCauseStatistics
	(ReportType,ReportDate,ClientSiteId ,PlantAreaId ,UnitType ,FailureCauseId ,Consequence ,
	ClientSiteName , PlantAreaName , FailureCause, EventCount,
	CountryId, CostCentreId, SectorId, segmentId, IndustryId, CountryName, CostCentreName,SectorName,SegmentName,IndustryName  )
 	select ReportType,ReportDate, f.ClientSiteId ,f.PlantAreaId ,UnitType ,FailureCauseId ,Consequence ,
	ClientSiteName , PlantAreaName , FailureCause,Eventcount,
	c.CountryId,c.CostCentreId,s.SectorId,s.SegmentId,i.IndustryId,
	dbo.GetNameTranslated(c.CountryId,1,'CountryName') CountryName,
	dbo.GetNameTranslated(c.CostCentreId,1,'CostCentreName') CostCentreName,
	dbo.GetNameTranslated(s.SectorId,1,'SectorName') SectorName,
	dbo.GetNameTranslated(s.segmentId,1,'SegmentName') SegmentName,
	dbo.GetNameTranslated(i.IndustryId,1,'IndustryName') IndustryName 
	from dbo.[udtfFailureCauseStatistics]() f    
			join PlantArea p on p.PlantAreaId = f.PlantAreaId
			Join ClientSite c on c.ClientSiteId = p.ClientSiteId
			join Industry i on i.IndustryId = c.IndustryId
			join Segment s on s.SegmentId = i.SegmentId 
	where f.FailureCauseId is not null

End
GO
/****** Object:  StoredProcedure [dbo].[EJobRptFeedJobList]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE   PROCEDURE [dbo].[EJobRptFeedJobList] 
AS
BEGIN
 
	Truncate table [RptJobList]
	Truncate Table RptJobEquipList
	Truncate Table RptJobEquipHealthStatus

	Declare @ClientSiteId Int,@JobId BigInt, @EstStartDate Date ,@EstEndDate Date ,@Jobtype varchar(50), @ReportSent Varchar(1), @JCStatusId int, @NSStatusId int, @StatusId Int, @StatusName nvarchar(100)
	
	Declare @EJobId bigint,  @EStartDate date, @CountryId int, @CostCentreId int, @SectorId int, @SegmentId int, @Industryid int, @EClientSiteId int, @PlantAreaId int, @ServiceId int,
	@CountryName nvarchar(100), @CostCentreName nvarchar(250), @SectorName nvarchar(250), @SegmentName  nvarchar(250), @IndustryName  nvarchar(250),
	@ServiceType  nvarchar(100), @DataCollectorId int,@AnalystId int ,@ReviewerId int ,@DataCollectorName nvarchar(250), @AnalystName nvarchar(250), @ReviewerName nvarchar(250),
	@ClientSiteName nvarchar(250)
	set @NSStatusId = dbo.GetStatusId(1,'JobProcessStatus','NS')
	set @JCStatusId = dbo.GetStatusId(1,'JobProcessStatus','C')

	DECLARE CGetJobList CURSOR READ_ONLY
	FOR 
	Select j.ClientSiteId, j.JobId,j.EstStartDate, j.EstEndDate, Case when j.ScheduleSetupId is null then 'UnScheduled' else 'Scheduled' end JobType, 
	case when ReportSent = 1 then 'Y' else 'N' end ReportSent ,	j.StatusId,	isnull(dbo.GetLookupTranslated(j.StatusId,1,'LookupValue'),'') StatusName  
	from  Jobs j 
	order by j.EstStartDate desc, j.JobNumber desc  
 	
	OPEN CGetJobList
	FETCH NEXT FROM CGetJobList INTO
	@ClientSiteId, @JobId,@EstStartDate,@EstEndDate, @JobType,@ReportSent,@StatusId,@StatusName 
	WHILE @@FETCH_STATUS = 0
	BEGIN 
	
	Set @StatusName = case when @NSStatusId = @StatusId and datediff(D,@EstStartDate,getdate()) > 5  then 'OverDue' else @StatusName end
	
	MERGE [dbo].[RptJobList] AS [target]
		USING (
			SELECT @ClientSiteId,@JobId
			) AS source(ClientSiteId,JobId)
			ON ([target].[ClientSiteId] = [source].[ClientSiteId]
			and [target].[JobId] = [source].[JobId] 
			)
		WHEN MATCHED
			THEN
				UPDATE
				SET ReportSent = @ReportSent
				 ,StatusName = @StatusName
				 ,ModifiedOn = getdate()
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
				 ClientSiteId 
				 ,JobId 
				 ,EstStartDate 
				 ,EstEndDate 
				 ,Jobtype 
				 ,ReportSent 
				 ,StatusName  
					)
				VALUES (
				 @ClientSiteId 
				 ,@JobId 
				 ,@EstStartDate 
				 ,@EstEndDate 
				 ,@Jobtype 
				 ,@ReportSent 
				 ,@StatusName
					) ;
			
			Insert into RptJobEquipList 
			(JobId,EstStartDate,CountryId,CostCentreId,SectorId,segmentId,IndustryId,ClientSiteId,PlantAreaId,ServiceId,
			DataCollectorId,AnalystId,ReviewerId,CountryName,CostCentreName,SectorName,SegmentName,IndustryName,ClientSiteName,PlantAreaName,ServiceType,
			DataCollectorName,AnalystName,ReviewerName,EquipmentCount)
			Select 	j.JobId,js.EstStartDate,c.CountryId,c.CostCentreId,s.SectorId,s.segmentId,i.IndustryId, c.ClientSiteId, p.PlantAreaId, 
			j.ServiceId, j.DataCollectorId, j.AnalystId, j.ReviewerId, 
			dbo.GetNameTranslated(c.CountryId,1,'CountryName') CountryName,
			dbo.GetNameTranslated(c.CostCentreId,1,'CostCentreName') CostCentreName,
			dbo.GetNameTranslated(s.SectorId,1,'SectorName') SectorName,
			dbo.GetNameTranslated(s.segmentId,1,'SegmentName') SegmentName,
			dbo.GetNameTranslated(i.IndustryId,1,'IndustryName') IndustryName,
			dbo.GetNameTranslated(c.ClientSiteId,1,'ClientSiteName') ClientSiteName,
			dbo.GetNameTranslated(p.PlantAreaId,1,'PlantAreaName') PlantAreaName,
			dbo.GetLookupTranslated(j.ServiceId,1,'LookupValue') ServiceType,
			(select UserName from users where userid = j.DataCollectorId) DataCollectorName,
			(select UserName from users where userid = j.AnalystId) AnalystName,
			(select UserName from users where userid = j.ReviewerId) ReviewerName,
			Count(j.EquipmentId) EquipmentCount
			from  JobEquipment j join Jobs js on js.JobId = j.JobId 
				join Equipment e on e.EquipmentId = j.EquipmentId
			join PlantArea p on p.PlantAreaId = e.PlantAreaId
			Join ClientSite c on c.ClientSiteId = p.ClientSiteId
			join Industry i on i.IndustryId = c.IndustryId
			join Segment s on s.SegmentId = i.SegmentId
			where j.JobId = @Jobid and j.Active = 'Y'
			Group by j.JobId, js.EstStartDate, c.CountryId,c.CostCentreId,s.SectorId,s.segmentId,i.IndustryId,c.ClientSiteId, p.PlantAreaId,j.ServiceId,j.DataCollectorId, j.AnalystId, j.ReviewerId
  
	FETCH NEXT FROM CGetJobList INTO
	@ClientSiteId, @JobId,@EstStartDate,@EstEndDate, @JobType,@ReportSent,@StatusId,@StatusName 
	END
	CLOSE CGetJobList
	DEALLOCATE CGetJobList 
	
	Insert into RptJobEquipHealthStatus 
	(JobId,JobType, EstStartDate,CountryId,CostCentreId,SectorId,segmentId,IndustryId,ClientSiteId,PlantAreaId,ServiceId,ConditionId,
	DataCollectorId,AnalystId,ReviewerId,CountryName,CostCentreName,SectorName,SegmentName,IndustryName,ClientSiteName,PlantAreaName,ServiceType,
	ConditionCode,ConditionName,
	DataCollectorName,AnalystName,ReviewerName,EquipmentCount)
	Select 	j.JobId,Case when js.ScheduleSetupId is null then 'UnScheduled' else 'Scheduled' end JobType,  js.EstStartDate,c.CountryId,c.CostCentreId,s.SectorId,s.segmentId,i.IndustryId, c.ClientSiteId, p.PlantAreaId, 
	j.ServiceId, j.ConditionId, j.DataCollectorId, j.AnalystId, j.ReviewerId, 
	dbo.GetNameTranslated(c.CountryId,1,'CountryName') CountryName,
	dbo.GetNameTranslated(c.CostCentreId,1,'CostCentreName') CostCentreName,
	dbo.GetNameTranslated(s.SectorId,1,'SectorName') SectorName,
	dbo.GetNameTranslated(s.segmentId,1,'SegmentName') SegmentName,
	dbo.GetNameTranslated(i.IndustryId,1,'IndustryName') IndustryName,
	dbo.GetNameTranslated(c.ClientSiteId,1,'ClientSiteName') ClientSiteName,
	dbo.GetNameTranslated(p.PlantAreaId,1,'PlantAreaName') PlantAreaName,
	dbo.GetLookupTranslated(j.ServiceId,1,'LookupValue') ServiceType,
	dbo.GetLookupTranslated(j.ConditionId,1,'LookupCode') ConditionCode,
	dbo.GetLookupTranslated(j.ConditionId,1,'LookupValue') ConditionName,
	(select UserName from users where userid = j.DataCollectorId) DataCollectorName,
	(select UserName from users where userid = j.AnalystId) AnalystName,
	(select UserName from users where userid = j.ReviewerId) ReviewerName,
	Count(j.EquipmentId) EquipmentCount
	from  JobEquipment j join Jobs js on js.JobId = j.JobId 
		join Equipment e on e.EquipmentId = j.EquipmentId
	join PlantArea p on p.PlantAreaId = e.PlantAreaId
	Join ClientSite c on c.ClientSiteId = p.ClientSiteId
	join Industry i on i.IndustryId = c.IndustryId
	join Segment s on s.SegmentId = i.SegmentId
	where js.StatusId = @JCStatusId and j.Active = 'Y'   
	Group by j.JobId,js.ScheduleSetupId, js.EstStartDate, c.CountryId,c.CostCentreId,s.SectorId,s.segmentId,i.IndustryId,c.ClientSiteId, p.PlantAreaId,j.ServiceId,j.ConditionId,j.DataCollectorId, j.AnalystId, j.ReviewerId
  
End
 
GO
/****** Object:  StoredProcedure [dbo].[EJobRptFeedOpportunities]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
create   PROCEDURE [dbo].[EJobRptFeedOpportunities] 
AS
BEGIN 

	Truncate Table RptOpportunities
	 
	Insert into RptOpportunities
	(CountryId,SectorId,SegmentId,IndustryId,CostCentreId,PlantAreaId,ClientSiteid,LeverageDate, 
  AssetType,BManufacturerId, OpportunityCount, BearingCount,CountryName,SectorName,SegmentName,IndustryName,
  CostCentreName,ClientSiteName,PlantAreaName,BManufacturerName,OpportunityName,OpportunityCode )
  select r.CountryId,r.SectorId,r.SegmentId,r.IndustryId,r.CostCentreId,r.PlantAreaId,r.ClientSiteid,r.LeverageDate, 
  r.AssetType,r.BManufacturerId, r.OpportunityCount, r.BearingCount,r.CountryName,r.SectorName,r.SegmentName,r.IndustryName,
  r.CostCentreName,r.ClientSiteName,r.PlantAreaName,r.BManufacturerName,r.OpportunityName,r.OpportunityCode 
    from [dbo].[udtfGetOpportunityList] () r 

END
GO
/****** Object:  StoredProcedure [dbo].[EJobRptFeedWorkNotification]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EJobRptFeedWorkNotification] 
AS
BEGIN 
  	Declare @OpStatus int, @ClStatus int, @CNStatus int 
	select @OpStatus = dbo.GetStatusId(1,'WorkNotificationStatus','OP'),@ClStatus = dbo.GetStatusId(1,'WorkNotificationStatus','CL'), @CNStatus = dbo.GetStatusId(1,'WorkNotificationStatus','CN')
	
	Truncate Table RptWorkNotification
	  
	Insert into RptWorkNotification
	(CountryId, CostCentreId, SectorId, segmentId, IndustryId , ClientSiteId , PlantAreaId, AnalystId,
	CountryName , CostCentreName ,SectorName ,SegmentName ,IndustryName, ClientSiteName,PlantAreaName ,WorkNotificationDate ,
	TotalJobs ,	TotalWN ,OpenWN ,CancelledWN ,ClosedWN ,TotalAssets ,TotalFailureReported ,
	TT,TF,FT,FF )
	Select 
	c.CountryId, c.CostCentreId, s.SectorId, s.segmentId, i.IndustryId, c.ClientSiteId,p.PlantAreaId, wn.CreatedBy,
	dbo.GetNameTranslated(c.CountryId,1,'CountryName') CountryName,
	dbo.GetNameTranslated(c.CostCentreId,1,'CostCentreName') CostCentreName,
	dbo.GetNameTranslated(s.SectorId,1,'SectorName') SectorName,
	dbo.GetNameTranslated(s.segmentId,1,'SegmentName') SegmentName,
	dbo.GetNameTranslated(i.IndustryId,1,'IndustryName') IndustryName ,	
	dbo.GetNameTranslated(c.ClientSiteId,1,'ClientSiteName') ClientSiteName,
	Concat(dbo.GetNameTranslated(p.PlantAreaId,1,'PlantAreaName'),'-',p.PlantAreaId) PlantAreaName,
	DATEADD(month, DATEDIFF(month, 0, wn.WorkNotificationDate), 0) WorkNotifcationDate,
	count(Distinct wn.JobId) TotalJobs, 
	count(Distinct concat(wd.UnitType,wd.UnitId)) TotalWN,
	sum(Case when wd.StatusId =  @OpStatus then 1 else 0 end) OpenWN,
	sum(Case when wd.StatusId =  @CNStatus then 1 else 0 end) CancelledWN,
	sum(Case when wd.StatusId =  @ClStatus then 1 else 0 end) ClosedWN ,
	(select TotalAsset from [dbo].[udtfGetTotalAssets](c.clientSiteId,p.PlantAreaId)) TotalAssets,
	(select TotalFailureReported from [dbo].[udtfGetTotalFailureReportedAssets](c.clientSiteId,p.PlantAreaId,DATEADD(month, DATEDIFF(month, 0, wn.WorkNotificationDate), 0) )) TotalFailureReported,
 	sum(Case when (wd.StatusId =  @ClStatus and wn.isaccurate = 1) then 1 else 0 end) TT,
	sum(Case when (wd.StatusId =  @ClStatus and wn.isaccurate = 0) then 1 else 0 end) TF,
	(select TotalFailureReported from [dbo].[udtfGetTotalFailureReportedAssets](c.clientSiteId,p.PlantAreaId,DATEADD(month, DATEDIFF(month, 0, wn.WorkNotificationDate), 0) )) FT,
	((select TotalAsset from [dbo].[udtfGetTotalAssets](c.clientSiteId,p.PlantAreaId)) - 
	(count(Distinct concat(wd.UnitType,wd.UnitId)) + (select TotalFailureReported from [dbo].[udtfGetTotalFailureReportedAssets](c.clientSiteId,p.PlantAreaId,DATEADD(month, DATEDIFF(month, 0, wn.WorkNotificationDate), 0) )))
	)FF
	from WorkNotificationEquipment wn Join WorkNotificationUnits wd on wn.WNEquipmentId = wd.WNEquipmentId and wn.Active = 'Y' and wd.Active = 'Y'
	Join equipment e on e.EquipmentId = wn.EquipmentId 
 	join PlantArea p on p.PlantAreaId = e.PlantAreaId
	Join ClientSite c on c.ClientSiteId = p.ClientSiteId
	join Industry i on i.IndustryId = c.IndustryId
	join Segment s on s.SegmentId = i.SegmentId 
	Group by
	c.CountryId, c.CostCentreId, s.SectorId, s.segmentId, i.IndustryId, c.ClientSiteId,p.PlantAreaId,wn.Createdby, DATEADD(month, DATEDIFF(month, 0, wn.WorkNotificationDate), 0)  
END
 
GO
/****** Object:  StoredProcedure [dbo].[SKFEmaintenanceSQLMaintenance]    Script Date: 7/12/2019 12:06:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Procedure [dbo].[SKFEmaintenanceSQLMaintenance]
	(
		@operation nvarchar(10) = null,
		@mode nvarchar(10) = 'smart',
		@LogToTable bit = 0
	)
as
begin
	set nocount on
	declare @msg nvarchar(max);
	declare @minPageCountForIndex int = 40;
	declare @OperationTime datetime2 = sysdatetime();
	declare @KeepXOperationInLog int =3;

	/* make sure parameters selected correctly */
	set @operation = lower(@operation)
	set @mode = lower(@mode)
	
	if @mode not in ('smart','dummy')
		set @mode = 'smart'

	if @operation not in ('index','statistics','all') or @operation is null
	begin
		raiserror('@operation (varchar(10)) [mandatory]',0,0)
		raiserror(' Select operation to perform:',0,0)
		raiserror('     "index" to perform index maintenance',0,0)
		raiserror('     "statistics" to perform statistics maintenance',0,0)
		raiserror('     "all" to perform indexes and statistics maintenance',0,0)
		raiserror(' ',0,0)
		raiserror('@mode(varchar(10)) [optional]',0,0)
		raiserror(' optionaly you can supply second parameter for operation mode: ',0,0)
		raiserror('     "smart" (Default) using smart decition about what index or stats should be touched.',0,0)
		raiserror('     "dummy" going through all indexes and statistics regardless thier modifications or fragmentation.',0,0)
		raiserror(' ',0,0)
		raiserror('@LogToTable(bit) [optional]',0,0)
		raiserror(' Logging option: @LogToTable(bit)',0,0)
		raiserror('     0 - (Default) do not log operation to table',0,0)
		raiserror('     1 - log operation to table',0,0)
		raiserror('		for logging option only 3 last execution will be kept by default. this can be changed by easily in the procedure body.',0,0)
		raiserror('		Log table will be created automatically if not exists.',0,0)
	end
	else 
	begin
		/*Write operation parameters*/
		raiserror('-----------------------',0,0)
		set @msg = 'set operation = ' + @operation;
		raiserror(@msg,0,0)
		set @msg = 'set mode = ' + @mode;
		raiserror(@msg,0,0)
		set @msg = 'set LogToTable = ' + cast(@LogToTable as varchar(1));
		raiserror(@msg,0,0)
		raiserror('-----------------------',0,0)
	end
	
	/* Prepare Log Table */
		if object_id('SKFSQLMaintenanceLog') is null 
		begin
			create table SKFSQLMaintenanceLog (id bigint primary key identity(1,1), OperationTime datetime2, command varchar(4000),ExtraInfo varchar(4000), StartTime datetime2, EndTime datetime2, StatusMessage varchar(1000));
		end

	if @LogToTable=1 insert into SKFSQLMaintenanceLog values(@OperationTime,null,null,sysdatetime(),sysdatetime(),'Starting operation: Operation=' +@operation + ' Mode=' + @mode + ' Keep log for last ' + cast(@KeepXOperationInLog as varchar(10)) + ' operations' )	

	create table #cmdQueue (txtCMD nvarchar(max),ExtraInfo varchar(max))


	if @operation in('index','all')
	begin
		raiserror('Get index information...(wait)',0,0) with nowait;
		/* Get Index Information */
		select 
			i.[object_id]
			,ObjectSchema = OBJECT_SCHEMA_NAME(i.object_id)
			,ObjectName = object_name(i.object_id) 
			,IndexName = idxs.name
			,i.avg_fragmentation_in_percent
			,i.page_count
			,i.index_id
			,i.partition_number
			,i.index_type_desc
			,i.avg_page_space_used_in_percent
			,i.record_count
			,i.ghost_record_count
			,i.forwarded_record_count
			,null as OnlineOpIsNotSupported
		into #idxBefore
		from sys.dm_db_index_physical_stats(DB_ID(),NULL, NULL, NULL ,'limited') i
		left join sys.indexes idxs on i.object_id = idxs.object_id and i.index_id = idxs.index_id
		where idxs.type in (1/*Clustered index*/,2/*NonClustered index*/) /*Avoid HEAPS*/
		and OBJECT_SCHEMA_NAME(i.object_id) in ('dbo','Trn','Rpt')
		order by i.avg_fragmentation_in_percent desc, page_count desc


		-- mark indexes XML,spatial and columnstore not to run online update 
		update #idxBefore set OnlineOpIsNotSupported=1 where [object_id] in (select [object_id] from #idxBefore where index_id >=1000)
		
		
		raiserror('---------------------------------------',0,0) with nowait
		raiserror('Index Information:',0,0) with nowait
		raiserror('---------------------------------------',0,0) with nowait

		select @msg = count(*) from #idxBefore 
		set @msg = 'Total Indexes: ' + @msg
		raiserror(@msg,0,0) with nowait

		select @msg = avg(avg_fragmentation_in_percent) from #idxBefore where page_count>@minPageCountForIndex
		set @msg = 'Average Fragmentation: ' + @msg
		raiserror(@msg,0,0) with nowait

		select @msg = sum(iif(avg_fragmentation_in_percent>=5 and page_count>@minPageCountForIndex,1,0)) from #idxBefore 
		set @msg = 'Fragmented Indexes: ' + @msg
		raiserror(@msg,0,0) with nowait

				
		raiserror('---------------------------------------',0,0) with nowait

			
			
			
		/* create queue for update indexes */
		insert into #cmdQueue
		select 
		txtCMD = 
		case when avg_fragmentation_in_percent>5 and avg_fragmentation_in_percent<30 and @mode = 'smart' then
			'ALTER INDEX [' + IndexName + '] ON [' + ObjectSchema + '].[' + ObjectName + '] REORGANIZE;'
			when OnlineOpIsNotSupported=1 then
			'ALTER INDEX [' + IndexName + '] ON [' + ObjectSchema + '].[' + ObjectName + '] REBUILD WITH(ONLINE=OFF,MAXDOP=1);'
			else
			'ALTER INDEX [' + IndexName + '] ON [' + ObjectSchema + '].[' + ObjectName + '] REBUILD WITH(ONLINE=ON,MAXDOP=1);'
		end
		, ExtraInfo = 'Current fragmentation: ' + format(avg_fragmentation_in_percent/100,'p')
		from #idxBefore
		where 
			index_id>0 /*disable heaps*/ 
			and index_id < 1000 /* disable XML indexes */
			--
			and 
				(
					page_count> @minPageCountForIndex and /* not small tables */
					avg_fragmentation_in_percent>=5
				)
			or
				(
					@mode ='dummy'
				)
	end

	if @operation in('statistics','all')
	begin 
		/*Gets Stats for database*/
		raiserror('Get statistics information...',0,0) with nowait;
		select 
			ObjectSchema = OBJECT_SCHEMA_NAME(s.object_id)
			,ObjectName = object_name(s.object_id) 
			,StatsName = s.name
			,sp.last_updated
			,sp.rows
			,sp.rows_sampled
			,sp.modification_counter
		into #statsBefore
		from sys.stats s cross apply sys.dm_db_stats_properties(s.object_id,s.stats_id) sp 
		where OBJECT_SCHEMA_NAME(s.object_id) not in ('sys' ) and (sp.modification_counter>0 or @mode='dummy')
		order by sp.last_updated asc

		
		raiserror('---------------------------------------',0,0) with nowait
		raiserror('Statistics Information:',0,0) with nowait
		raiserror('---------------------------------------',0,0) with nowait

		select @msg = sum(modification_counter) from #statsBefore
		set @msg = 'Total Modifications: ' + @msg
		raiserror(@msg,0,0) with nowait
		
		select @msg = sum(iif(modification_counter>0,1,0)) from #statsBefore
		set @msg = 'Modified Statistics: ' + @msg
		raiserror(@msg,0,0) with nowait
				
		raiserror('---------------------------------------',0,0) with nowait




		/* create queue for update stats */
		insert into #cmdQueue
		select 
		txtCMD = 'UPDATE STATISTICS [' + ObjectSchema + '].[' + ObjectName + '] (['+ StatsName +']) WITH FULLSCAN;'
		, ExtraInfo = '#rows:' + cast([rows] as varchar(100)) + ' #modifications:' + cast(modification_counter as varchar(100)) + ' modification percent: ' + format((1.0 * modification_counter/ rows ),'p')
		from #statsBefore
	end


if @operation in('statistics','index','all')
	begin 
		/* iterate through all stats */
		raiserror('Start executing commands...',0,0) with nowait
		declare @SQLCMD nvarchar(max);
		declare @ExtraInfo nvarchar(max);
		declare @T table(txtCMD nvarchar(max),ExtraInfo nvarchar(max));
		while exists(select * from #cmdQueue)
		begin
			delete top (1) from #cmdQueue output deleted.* into @T;
			select top (1) @SQLCMD = txtCMD, @ExtraInfo=ExtraInfo from @T
			raiserror(@SQLCMD,0,0) with nowait
			if @LogToTable=1 insert into SKFSQLMaintenanceLog values(@OperationTime,@SQLCMD,@ExtraInfo,sysdatetime(),null,'Started')
			begin try
				exec(@SQLCMD)	
				if @LogToTable=1 update SKFSQLMaintenanceLog set EndTime = sysdatetime(), StatusMessage = 'Succeeded' where id=SCOPE_IDENTITY()
			end try
			begin catch
				raiserror('cached',0,0) with nowait
				if @LogToTable=1 update SKFSQLMaintenanceLog set EndTime = sysdatetime(), StatusMessage = 'FAILED : ' + CAST(ERROR_NUMBER() AS VARCHAR(50)) + ERROR_MESSAGE() where id=SCOPE_IDENTITY()
			end catch
			delete from @T
		end
	end
	
	/* Clean old records from log table */
	if @LogToTable=1
	begin
		delete from SKFSQLMaintenanceLog 
		from 
			SKFSQLMaintenanceLog L join 
			(select distinct OperationTime from SKFSQLMaintenanceLog order by OperationTime desc offset @KeepXOperationInLog rows) F
				ON L.OperationTime = F.OperationTime
		insert into SKFSQLMaintenanceLog values(@OperationTime,null,cast(@@rowcount as varchar(100))+ ' rows purged from log table because number of operations to keep is set to: ' + cast( @KeepXOperationInLog as varchar(100)),sysdatetime(),sysdatetime(),'Cleanup Log Table')
	end

	raiserror('Done',0,0)
	if @LogToTable=1 insert into SKFSQLMaintenanceLog values(@OperationTime,null,null,sysdatetime(),sysdatetime(),'End of operation')
end
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AssetID is reffered to the TaxonomyId since we are using Taxonomy table to store both Asset and taxonomy details, TaxonomyType A refer to Asset and T referred to Taxonomy records' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EquipmentIntermediateUnit', @level2type=N'COLUMN',@level2name=N'AssetId'
GO
USE [master]
GO
ALTER DATABASE [EmaintenanceDRT] SET  READ_WRITE 
GO
