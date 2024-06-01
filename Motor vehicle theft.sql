create database motor_v_theft ;

use motor_v_theft ;

create table stolen_vehicle
(
   vehicle_id	int,
   vehicle_type	text,
    make_id int,
   model_year	text,
   vehicle_desc	text,
    color	text,
   date_stolen	text,
  location_id int
  
  );
  
LOAD DATA LOCAL INFILE 'D:\\SQL\\Data set Project\\Motor vehicle theft\\stolen_vehicles.csv'
INTO TABLE stolen_vehicle
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';


select * from stolen_vehicles ;



alter table stolen_vehicles
add column newdate_stolen date ;

update stolen_vehicles

set newdate_stolen= str_to_date(date_stolen, "%d/%m/%Y");

SET SQL_SAFE_UPDATEs = 0;

update  stolen_vehicles

set new_date_stolen = str_to_date(date_stolen,"%d/%m/%Y");

alter table stolen_vehicles
drop column new_date_stolen ;

alter table stolen_vehicles

rename column ï»¿vehicle_id to vehicle_id ;


                                                      /*1.What day of the week are vehicles most often and least often stolen?*/
		
select * from stolen_vehicles;   

select dayname(newdate_stolen) as Day_name ,count(vehicle_type) as vehicle from stolen_vehicles 

group by  day_name   order by vehicle desc ; 

select monthname(newdate_stolen) as month_name, count(vehicle_type) as vehicle from stolen_vehicles

group by month_name order by vehicle desc ;                               
								
													/*5.In which region in which month which car is maximum stolen ?*/
select  * from locations ;

select * from stolen_vehicles ;

select l.region,monthname(newdate_stolen) as `month name`,count(v.vehicle_type) as total_type from stolen_vehicles as v 

left join locations as l on l.location_id=v.location_id

group by l.region ,monthname(newdate_stolen)

order by total_type desc ;

                                    /*2.	What types of vehicles are most often and least often stolen? Does this vary by region?*/

select * from details;

select * from locations;

select * from stolen_vehicles;

select l.region,v.vehicle_type,count(v.vehicle_type) as vehicle_count from locations as l 
left join stolen_vehicles as v on l.location_id = v.location_id 


group by l.region,v.vehicle_type order by vehicle_count desc;   

-- Auckland saloon car are most stolen car  where Tasman Marlborough West Coast with zero record .--


                      /*3.	What is the average age of the vehicles that are stolen? Does this vary based on the vehicle type?
                                         Does this vary based on the vehicle type?*/
                      

select * from stolen_vehicles;

alter table  stolen_vehicles
add column new_date_stolen year;

 SET SQL_SAFE_UPDATEs = 0;

update stolen_vehicles

set new_date_stolen= year(newdate_stolen);

alter table stolen_vehicles

add column modelyear year;

set sql_safe_updates =0 ;

update stolen_vehicles

set modelyear = cast(model_year as unsigned) ;


select l.region,round(avg(new_date_stolen-modelyear),0) as age,v.vehicle_type,count(vehicle_type) as vehicle_count from stolen_vehicles as v

left join locations as l on l.location_id=v.location_id

group by l.region,v.vehicle_type

order by l.region,vehicle_count desc;
-- Saloon car in auckland  are most  targated car which are18 years old  and sports car in willington are less targeted car .

             
             /*6.Find the vehicle type and their  age according to region and what is the average age  of most stolen  car according to make_name*/
             
select * from  details;

select * from stolen_vehicles;      

select d.make_name,round(avg((new_date_stolen-modelyear)),0) as age,count(vehicle_type) as totalnumber from details as d

left join stolen_vehicles as v on d.make_id = v.make_id 

group by d.make_name  order by totalnumber desc;     

 -- According to their  region average age of stolen car 
 
 select * from locations;
 
 select * from stolen_vehicles;
 
 select l.region,
 
 round(avg(new_date_stolen - modelyear),0) as age 
 
 from locations as l
 
 left join stolen_vehicles as s on l.location_id = s.location_id 
 
 group by l.region order by age desc;
 
                                                      
                                                      /*In which month car has maximum stolen*/
 
 select monthname(newdate_stolen) as month_name, count(vehicle_id) as stolencar from stolen_vehicles
 
 group by month_name order by stolencar desc;
 
 -- In the month of March there are most stolen car  and in the month of April there are least  stolen  car.
 








