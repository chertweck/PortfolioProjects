
--Rename a Column

exec sp_rename 'Medals$.medal_type', 'MedalType', 'Column'
exec sp_rename 'Medals$.medal_code', 'MedalCode', 'Column'
exec sp_rename 'Medals$.athlete_name', 'AthleteName', 'Column'
exec sp_rename 'Medals$.athlete_sex', 'AthleteSex', 'Column'
exec sp_rename 'Medals$.event', 'Event', 'Column'
exec sp_rename 'Medals$.country', 'Country', 'Column'
exec sp_rename 'Medals$.country_code', 'CountryCode', 'Column'
exec sp_rename 'Medals$.discipline', 'Discipline', 'Column'
exec sp_rename 'Medals$.discipline_code', 'DisciplineCode', 'Column'

exec sp_rename 'MedalsTotal$.Gold', 'CountryGold', 'Column'
exec sp_rename 'MedalsTotal$.Silver', 'CountrySilver', 'Column'
exec sp_rename 'MedalsTotal$.Bronze', 'CountryBronze', 'Column'
exec sp_rename 'MedalsTotal$.Total', 'CountryTotal', 'Column'
exec sp_rename 'MedalsTotal$.Order', 'CountryRank', 'Column'
exec sp_rename 'Medals$.MedalType', 'AthleteMedalType', 'Column'


Select *
From PortfolioProject..Medals$

Select *
From PortfolioProject..MedalsTotal$

Select *
From PortfolioProject..Athletes$

Select AthleteMedalType, AthleteName, AthleteSex 
From PortfolioProject..Medals$
Order by 2



Select *
From PortfolioProject..Medals$
order by 3

--Select *
--From PortfolioProject..MedalsTotal$

--Joins

Select *
From PortfolioProject..Athletes$
Join PortfolioProject..Medals$
	On Athletes$.ATHLETENAME = Medals$.AthleteName

--Select *
--From PortfolioProject..Athletes$
--Full Outer Join PortfolioProject..Medals$
--	On Athletes$.ATHLETENAME = Medals$.AthleteName

--Select *
--From PortfolioProject..Athletes$
--Left Outer Join PortfolioProject..Medals$
--	On Athletes$.ATHLETENAME = Medals$.AthleteName

--Select *
--From PortfolioProject..Athletes$
--Right Outer Join PortfolioProject..Medals$
--	On Athletes$.ATHLETENAME = Medals$.AthleteName

Select Athletes$.AthleteName, Athletes$.Country, MedalType, Athletes$.Discipline
From PortfolioProject..Athletes$
Join PortfolioProject..Medals$
	On Athletes$.AthleteName = Medals$.AthleteName

--Unions

Select AthleteName, Country, Discipline 
From PortfolioProject..Athletes$
Union
Select AthleteName, MedalType, AthleteSex
From PortfolioProject..Medals$


--Case Statements

Select Country, CountryTotal,
Case 
	When CountryTotal > 20 then 'Top Countries' Else 'Bottom Countries'
End
From PortfolioProject..MedalsTotal$
Order by CountryTotal Desc



Select Medals$.AthleteName, AthleteSex, Medals$.Discipline, AthleteMedalType, MedalsTotal$.Country, CountryGold, CountrySilver, CountryBronze, CountryTotal, CountryRank
From PortfolioProject..MedalsTotal$
Join PortfolioProject..Medals$
	On MedalsTotal$.Country = Medals$.country
Order by CountryTotal Desc


--Having Clause

Select AthleteMedalType, COUNT(AthleteMedalType)
From PortfolioProject..Medals$
Join PortfolioProject..Athletes$
	On Athletes$.AthleteName = Medals$.AthleteName
Group by Medals$.AthleteMedalType
Having COUNT(Medals$.AthleteMedalType) > 230


--Partition By

Select Athletes$.AthleteName, AthleteSex, AthleteMedalType, MedalCode
, COUNT(AthleteSex) Over (Partition by AthleteSex) as TotalAthleteSex
From PortfolioProject..Athletes$
Join PortfolioProject..Medals$
	On Athletes$.AthleteName = Medals$.AthleteName


Select Athletes$.AthleteName, AthleteSex, AthleteMedalType, MedalCode, COUNT(AthleteSex)
From PortfolioProject..Athletes$
Join PortfolioProject..Medals$
	On Athletes$.AthleteName = Medals$.AthleteName
Group by Athletes$.AthleteName, AthleteSex, AthleteMedalType, MedalCode


Update PortfolioProject..Athletes$
Set Birthdate = CONVERT(Date,Birthdate)

SELECT Birthdate, CONVERT(Date,BirthDate) as BirthdateNew	
From PortfolioProject..Athletes$


--Finding Age of Athletes

SELECT Athletes$.AthleteName, Athletes$.BirthdateNew, (DATEDIFF(YY,BirthdateNew,GETDATE())) as Age	
From PortfolioProject..Athletes$
Order by 3 desc

Select Athletes$.AthleteName,Athletes$.BirthdateNew, Country
From PortfolioProject..Athletes$ 
Order by 2 desc


--Using Common Table Expressions

With CTE_Athlete as
(Select Medals$.AthleteName, AthleteSex, AthleteMedalType
, COUNT(AthleteSex) Over (Partition by AthleteSex) as TotalAthleteSex
From PortfolioProject..Athletes$
Join PortfolioProject..Medals$
	On Athletes$.AthleteName = Medals$.AthleteName
)

Select TotalAthleteSex
From CTE_Athlete


--Stored Procedure: group of statements stored in a database

Create Procedure Test
as 
Select *
From Athletes$

Exec Test


--Subquery

Select*
From MedalsTotal$


Select Country, CountryTotal, (Select AVG(CountryTotal) From MedalsTotal$) as AllAvgMedals
From MedalsTotal$

--or

Select Country, CountryTotal, AVG(CountryTotal) over () as AllAvgMedals
From MedalsTotal$

--Group by doesn't work for Subqueries, as shown below

Select Country, CountryTotal, AVG(CountryTotal) as AllAvgMedals
From MedalsTotal$
Group by Country, CountryTotal
Order by 1

--Subquery in From

Select A.Country, AllAvgMedals
From (Select Country, CountryTotal, AVG(CountryTotal) over () as AllAvgMedals From MedalsTotal$) A

--Subquery in Where

Select Country, CountryTotal
From MedalsTotal$
Where Country in(
		Select Country
		From Athletes$)
		Order by CountryTotal desc