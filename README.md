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

SQL queries regarding to trends in the hiring times of bikes can be found [here](https://github.com/Yusuf-M-Mirza/Project-1/blob/main/Trends_In_Hiring_Times.sql).

SQL queries regarding to how the weather will affect the frequency of hires can be found [here](https://github.com/Yusuf-M-Mirza/Project-1/blob/main/Impact_Of_Weather_On_Hiring_Frequency.sql).


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
- **A positive correlation is shown between temperature and bike hires.**Although weak, it can be linked to a Pearson correlation coefficient of 0.44, thus concluding that people will hire more bikes as the temperature increases. **

- **A negative correlation is shown between rainfall and bike hires** It is somewhat stronger than the Pearson correlation coefficient for temperature. It stands at **-0.43.** We can then more confidently say that more rainfall will result in fewer bikes being hired throughout the entire day.

<div align="center">
  <img src="https://i.imgur.com/O6DeRDd.png" alt="TfL Cycle Hire" width="500" />
</div>

### Gaps in Distribution
- **Major deficits appear at the most popular station**. Waterloo Station 2 consistently will lose **27** bikes a day. Resulting in a **46.2%** _decrease_ in quantity of bikes.

- **A large excess of bikes at other stations**. Hyde Park Coner and Albert Gate both experienced a massive increase in total number of bikes topping at a **911.8%** and **1466.7%** increase, respectively.

- This abscence of bikes at once station and excessive accumulation at another can lead to problems in efficiency such as bikes being abandoned on walkways due to a lack of stations. As well as potential riders choosing to get on overcrownded trains and buses from a lack of available bikes.

<div align="center">
  <img src="https://i.imgur.com/jIPAd3o.png" alt="TfL Cycle Hire" width="500" />
  <img src="https://i.imgur.com/HmajoVO.png" alt="TfL Cycle Hire" width="500" />
</div>

# Recommendations
Based on current insights, the following recommendations have been provided:

- 


