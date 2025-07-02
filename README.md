# 🚲 Pedals & Patterns: Analysing Bike-Hire Usage in London

 ### [Bike-Hire Dataset](https://www.kaggle.com/datasets/kalacheva/london-bike-share-usage-dataset)
 ### [Weather Dataset](https://www.kaggle.com/datasets/zongaobian/london-weather-data-from-1979-to-2023?resource=download)

## Project Background

Transport for London (TfL) launched its Cycle Hire scheme at the end of July 2010. It was aimed to promote biking as a healthy and sustainable form of transport across London. Since then, TfL has gathered significant quantities of data on the usage of these bikes, including:

- Starting date-time  
- Ending date-time  
- Location of stations where the bike was removed and docked  
- Different types of bikes used  
- Duration of each hire  

This project aims to thoroughly analyze and synthesize this data to uncover critical insights that will improve the efficiency and attraction of the TfL Cycle Hire scheme.

Insights and recommendations are provided on the following key areas:

- **Trends in Hire Times:**  
  Evaluation of historical usage to identify which hours of each day are the most popular, providing opportunities to capitalize on peak times.

- **Impact of Weather on Hiring Frequency:**  
  Identifying trends in bike hire related to weather changes. Finding correlations can help forecast usage and optimize service.

- **Opportunities for Redistribution:**  
  Identifying opportunities for bike redistribution to cover gaps in availability across the 800 docking stations throughout the day.


## Data Structure & Initial Checks
The database structure used consists of two tables that were used in this project. Their names were 'journeys' and 'weather' and are shown below.
<div align="center">
  <img src="https://i.imgur.com/jwINRuN.png" alt="TfL Cycle Hire" width="400" />
</div>

The dataset consists of a total of over 700,000 records spread across the two tables. Journeys consist of all bike hires and journeys that were made using the Cycle Hire scheme over the course of August 2023. Weather consists of a record of all weather records from 1979 to 2023.

Prior to starting the data analysis, a series of checks were made through each table and dataset for quality-control and familiarization. The SQL queries utilised to inspect and perform quality checks can be found here.

## Executive Summary
### Overview of Findings
### Trends In Hiring Times
- **During the weekdays the frequency of bicycle hires peaks at two time periods in the day.** These correspond to the peak times outlined by TfL when running other public transportation which are between 6:30 and 9:30 AM as well as between 4:30 and 7:30 PM. On average, these peak at around **2737 hires** during the morning and **3000 hires** in the evening.
  
- Commuters make up **60.06%** of total bike hires during the working week.
  
- **The weekend shows a far wider distribution.** It is most likely due to a change in _how_ the bikes are being used. Unlike being used as a commuting tool, where people will hire them at set times to arrive at their workplace, they are more commonly used as a means of leisure travel.

- **Peak hours are between 12 and 6 PM with a consistent number of 1500 bikes being hired per hour**. However, compared to the weekdays, the weekend will see a **26.63% decrease** in total hires.

<p align="center">
  <img src="https://i.imgur.com/9ZN0KNI.png" alt="TfL Cycle Hire" width="500" />
</p>


### Impact of Weather On Hiring Frequency
- **A positive correlation is shown between temperature and bike hires.**

- **Other Stuff**

### Gaps in Distribution

## Walkthrough
### Cleaning

Before beginning with any data analysis, I want to clean-up the data to ensure that it's fit for processing. What I first want to check is for any duplicates within the dataset which could potentially affect any results. I did this within MySQL using the following query.

```SQL
SELECT
    id,
    COUNT(id) AS Total
FROM london_bikes.journeys
GROUP BY id
HAVING Total>1;
```
This worked since all the rows were given a PRIMARY KEY meaning I could very easily look for duplicates by searching for any repeated ids. The search yielded zero duplicates within the dataset. Continuing on, I noticed that the DATETIME format for both 'start_date' and 'end_date' columns was incorrect. Instead of being in YYYY-MM-DD HH:MM:SS format, it was in MM/DD/YYYY HH:MM. The extract below should better illustrate my point.
```
08/01/2023 00:01
08/01/2023 00:01
08/01/2023 00:01
01/08/2023 00:02
01/08/2023 00:02
01/08/2023 00:02
01/08/2023 00:03
01/08/2023 00:03
01/08/2023 00:03
```
Although it would have been simple to manually rearrange each of the rows in the columns, I wrote a basic Python program that would automate the process for me. It reordered all 700,000+ rows.

```python
FILENAME = "LondonBikeJourneyAug2023.csv"
DATA = []

with open(FILENAME, "r") as file:
    lines = file.readlines()
    for line in lines:
        month, day, period = line.split("/")
        year, time = period.split(" ")
        DATA.append(f"{year}-{month}-{day} {time}")

with open("FILE.csv", "a") as file:
    file.writelines(DATA)
```
To round up the data-cleaning, I thought about doing a statistical analysis to find and remove any outliers from the dataset. However, I later decided that I would remove any outliers after I had decided what data analysis I wanted to do to prevent me from deleting data that I would later potentially need.

<h3>Rider Frequency</h3>
To properly optimise the TfL Cycle Hire, it is essential to gain an understanding as to both how and why the bikes are being used, thus enabling us to enact data-driven decisions that will produce real change. A theory I wanted to explore was the bikes were hired the most during rush hour of each weekday.

<div align="center">
  <img src="https://i.imgur.com/TfWfZgl.png" alt="TfL Cycle Hire" width="500" />
</div>

As shown by the above graph, the theory I propsed was correct in that across the weekdays, bike usage was greatest during rush-hour. It can be seen by the set of peaks in the interval of [07:00-09:00] and [17:00-19:00]. Additionally, we can see the least popular times to ride are in the earliest hours of the morning before 05:00. TfL currently runs a series of different pricings for Cycle Hire (https://tfl.gov.uk/modes/cycling/santander-cycles/what-you-pay). What I would propose is trialling a subset of the current Day Pass that is valid only during what TfL currently outlines as 'peak times' ([06:30-09:30], [16:00-19:00]). This could be an even lower cost than the current £3.50, but it could be offset by an increase in rider numbers, thus reducing strain on other existing public transport networks whilst also promoting a low-cost carbon carbon-neutral method of travel. I also wanted to investigate how this distribution would change on the weekend. This is because we cannot assume peak usage would be during rush hour due to the fact that on weekends, people do not commute to work during this time. Consequently, the graph produced was very different.
<hr style="margin: 20px 0;" />
<img src="https://i.imgur.com/2Kr9rxU.png" height="45%" width="45%" alt="Disk Sanitization Steps"/>

As shown in the graph, we can see how my proposed 'Peak Time Day Pass' would not be viable here due to the fact that at what would typically be morning rush-hour on a weekend is shown to actually be a time during the day when bike hire usage is at its lowest. Therefore, it can be said that if my suggestion was to be trialled, we would likely only see growth in bike hire during the weekday. This data was derived using the following SQL query.
```SQL
SELECT
    HOUR(start_date) AS Hour,
    COUNT(start_date) AS Count
FROM london_bikes.journeys
WHERE DAYOFWEEK(start_date) IN (1,7)
GROUP BY Hour
ORDER BY Hour;
```
Continuing on with the idea of investigating rider frequency, I also wished to look into how external factors will affect the number of cycle hires within a day. The reason for this was to reduce the costs associated with collecting and redistributing bikes for hire. If we are able to make data-driven predictions as to how many bikes will be needed for a given day, we can aim to reduce associated costs such as fuel or employee time. My current hypothesis was that during August, as temperatures went up, we'd see a reduction in the number of riders, allowing us to create predictions based on the number of bikes that need to be distributed based on future weather forecasts.

<h3>Weather</h3>
In order to draw conclusions based on the weather, I had to find a source of weather data within the London area, as well as within the August 2023 timeframe. Luckily, it was not difficult to find such a dataset. Again, like how I did with the Bikes dataset, I would first begin by cleaning the data to ensure it is fit for purpose. Not only did I check for duplicates in the dataset, but I also checked to see if any data points were missing. Fortunately, the dataset came with a system to confirm to the user whether or not a piece of data was missing in that each column came with an accompanying 'quality' column. A value of 0 meant valid data, 1 meant suspect and 9 meant the data was missing. So I used Excels in-built filtering tool to filter out all the blank cells in the columns so it could be imported into MySQL Workbench.

```SQL
SELECT
	   w.Day,
    w.Temperature,
    j.Total_Rides
FROM
	(SELECT
		DAY(DATE) AS Day,
		TG AS Temperature
	FROM london_bikes.weather
	WHERE YEAR(DATE)=2023 AND MONTH(DATE)=8
	ORDER BY DAY) AS w
    JOIN
    (SELECT
		DAY(start_date) AS Day,
		COUNT(start_date) AS Total_Rides
	FROM london_bikes.journeys
	GROUP BY Day) AS j
    ON w.Day=j.Day;
```
The above query gave me a table of the required data needed for me to create a graph and draw a conclusion as to whether or not there was a correlation between the temperature and the number of hires of TfL bikes. What I was expecting to see was a negative correlation between the two data points due to the temperature being _too_ hot to ride. The nature of the data made it difficult to represent appropriately with a line graph, so instead, I chose to create a Pearson correlation coefficient. The value obtained was 0.23 which, contrary to my hypothesis, shows a slight positive correlation between the two variables. This shows that people instead _choose_ to ride a bicycle more frequently in the heat. We can then use this information to plan out how many bikes TfL should distribute based on the local weather forecast knowing that a higher temperature will require more bikes.

<hr style="margin: 20px 0;" />
<h3>Distribution</h3>
The distribution of the bikes is another factor that could be an area of improvement for TfL. By finding out where exactly bikes are unused, we could enact better distribution in order to best serve the general public. What I want to investigate is distribution across three timezones; morning rush hour, evening rush hour and the weekend. I hypothesize that if we were to cover up any inefficiencies during these three time periods, it would be of immense benefit to the service as a whole. I wrote out a SQL query that would give me a table containing all stations within the dataset. It would also show the _average_ number of bikes arriving and leaving a station at both AM and PM peak times. Additionally, it would show me the average net change for each station so I can visually draw comparisons between stations.

<img src="https://i.imgur.com/jIPAd3o.png" height="55%" width="55%" alt="Disk Sanitization Steps"/>

As can be seen from the image shown, we have the stations that will end peak time, having gained far more bikes than they originally started with. This issue could lead to larger problems like the overcrowding of bikes around the station due to a lack of docking bays. This could lead to bikes being parked on pedestrian walkways and as such, causing excessive crowding. Additionally, it could result in stations elsewhere in London being deprived of available bikes, meaning people who would otherwise hire a bike with TfL would instead take other forms of transport. This is far from what we would deem to be an optimal scenario for TfL Cycle Hire.

<img src="https://i.imgur.com/HmajoVO.png" height="55%" width="55%" alt="Disk Sanitization Steps"/>

From the above image, you can also observe how the other extremity which is the stations that instead end peak-time having lost bikes. What I would propose for when vans come and during the night and collect the bikes is to specifically target stations for collection like Hyde Park Corner or Albert Gate and then deliberately redistribute extra bikes at Waterloo Station 2. This would then allow demand to be more evened out. The MySQL query used to obtain these insights has been attached to repository and can easily be modified to analyse the weekend.

<hr style="margin: 20px 0;" />
<h2>Conclusion</h2>

From the analysis conducted, we can conclude that the TfL Cycle Hire scheme, although running well, certainly has room for improvement. The areas of improvement include predicting the demand for bikes across London in order to minimise transport and maintenance costs, as well as predicting the distribution frequency of bikes across the Greater London area. It can be concluded that there is a positive correlation between temperature and bike hire frequency, as well as how different stations will experience different levels of accumulation of bicycles.


