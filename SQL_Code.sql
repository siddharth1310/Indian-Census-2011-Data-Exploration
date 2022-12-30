-- Exploring Datasets
select * from Data1;
select * from Data2;

-----------------------------------------------------------------------------------------------

-- Total Number of Rows in the dataset
select count(*) as total_rows from Data1;
select count(*) as total_rows from Data2;

-----------------------------------------------------------------------------------------------

--Dataset for Jharkhand and Bihar
select * from Data1 where State in ('Jharkhand', 'Bihar');

-----------------------------------------------------------------------------------------------

-- Total Population of India
select sum(Population) as total_population from Data2;

-----------------------------------------------------------------------------------------------

-- Average Growth of India
select avg(Growth) * 100 as Average_Growth from Data1;


-- Average Growth of States
select State, avg(Growth) * 100 as Average_Growth from Data1 group by State order by Average_Growth desc;


-- Average Sex Ratio of States
select State, round(avg(Sex_Ratio), 0) as Average_Sex_Ratio from Data1 group by State order by Average_Sex_Ratio desc;

-----------------------------------------------------------------------------------------------

-- Average Literacy Rate of States
select State, round(avg(Literacy), 0) as Average_Literacy from Data1 group by State having round(avg(Literacy), 0) > 90 order by Average_Literacy desc;

-----------------------------------------------------------------------------------------------

-- Top 3 States showing highest growth
select top 3 State, avg(Growth) * 100 as Average_Growth from Data1 group by State order by Average_Growth desc;

-----------------------------------------------------------------------------------------------

-- Top 3 states showing lowest sex ratio
select top 3 State, round(avg(Sex_Ratio), 0) as Average_Sex_Ratio from Data1 group by State order by Average_Sex_Ratio;

-----------------------------------------------------------------------------------------------

-- Top and bottom 3 states in literacy rate
-- Top State table
drop table if exists #topstates;

create table #topstates (state nvarchar(255), topstates float);

insert into #topstates 
select top 3 State, round(avg(Literacy), 0) as Average_Literacy from Data1 group by State order by Average_Literacy desc;

select * from #topstates;


-- Bottom State table
drop table if exists #bottomstates;

create table #bottomstates (state nvarchar(255), topstates float);

insert into #bottomstates 
select top 3 State, round(avg(Literacy), 0) as Average_Literacy from Data1 group by State order by Average_Literacy;

select * from #bottomstates;


-- Combining both tables
select * from #topstates
union
select * from #bottomstates order by topstates desc;

-----------------------------------------------------------------------------------------------

-- States starting with letter 'a'
select distinct State from Data1 where lower(State) like 'a%';

-----------------------------------------------------------------------------------------------

-- States starting with letter 'a' or 'b'
select distinct State from Data1 where lower(State) like 'a%' or lower(State) like 'b%' ;

-----------------------------------------------------------------------------------------------

-- States starting with letter 'a' or ending with 'd'
select distinct State from Data1 where lower(State) like 'a%' or lower(State) like '%d';

-----------------------------------------------------------------------------------------------

-- Number of male and female

--------FORMULA USED------------
-- female/male = sex_ratio ---------- (1)
-- female + male = population ------- (2)

-- male = population - female
-- female/(population - female) = sex_ratio
-- female = sex_ratio*population - sex_ratio*female
-- female(1+sex_ratio) = sex_ratio*population
-- female = (sex_ratio*population)/(1+sex_ratio)

select Data1.District, Data1.State, Sex_Ratio/1000 as Sex_Ratio, Population,
round(((Sex_Ratio/1000)*Population)/(1+(Sex_Ratio/1000)), 0) as Female_Count,
Population - round(((Sex_Ratio/1000)*Population)/(1+(Sex_Ratio/1000)), 0) as Male_Count
from Data1 inner join Data2 on Data1.District = Data2.District;


-- State wise data
select  Data1.State,
sum(round(((Sex_Ratio/1000)*Population)/(1+(Sex_Ratio/1000)), 0)) as Female_Count,
sum(Population - round(((Sex_Ratio/1000)*Population)/(1+(Sex_Ratio/1000)), 0)) as Male_Count
from Data1 inner join Data2 on Data1.District = Data2.District group by Data1.State;

-----------------------------------------------------------------------------------------------

-- total literacy Rate

---------FORMULA USED---------------
-- total_educated_population/population = literacy_ratio
-- total_educated_population = literacy_ratio * population

select Data1.District, Data1.State, Population, Literacy/100 as literacy_ratio,
round((Literacy/100)*Population, 0) as total_educated_population,
Population - round((Literacy/100)*Population, 0) as total_illetrate_population
from Data1 inner join Data2 on Data1.District = Data2.District;

--state wise data
select Data1.State,
sum(round((Literacy/100)*Population, 0)) as total_educated_population,
sum(Population - round((Literacy/100)*Population, 0)) as total_illetrate_population
from Data1 inner join Data2 on Data1.District = Data2.District group by Data1.State;

-----------------------------------------------------------------------------------------------

-- Population in Previous Census
---------------------FORMULA USED----------------
-- present_population = old_population + (growth*old_population)

select Data1.District, Data1.State, Growth, Population,
round(Population/(1+Growth), 0) as Old_Population
from Data1 inner join Data2 on Data1.District = Data2.District;

-- state wise
select Data1.State,
sum(round(Population/(1+Growth), 0)) as Old_Population,
sum(Population) as Latest_Population
from Data1 inner join Data2 on Data1.District = Data2.District group by Data1.State;

-- Country Population vs Old Population Stats
select sum(round(Population/(1+Growth), 0)) as Old_Population,
sum(Population) as Latest_Population
from Data1 inner join Data2 on Data1.District = Data2.District;

-----------------------------------------------------------------------------------------------

-- Population vs Area
select s.Total_area/q.Latest_Population as latest_area_population, 
s.Total_area/q.Old_Population as old_area_population 
from 
(select '1' as common_key, n.* 
from(select sum(round(Population/(1+Growth), 0)) as Old_Population,
sum(Population) as Latest_Population
from Data1 inner join Data2 on Data1.District = Data2.District) as n) as q 
inner join
(select '1' as common_key, r.* 
from(select sum(Area_km2) as Total_area from Data2) as r) as s 
on s.common_key = q.common_key;

-----------------------------------------------------------------------------------------------

-- Top 3 districts from each state using WINDOW function with highest literacy rate
select a.* from (
select District, State, Literacy, 
RANK() over (partition by State order by literacy desc) as Rank from Data1) as a
where Rank in (1, 2, 3) order by State;

