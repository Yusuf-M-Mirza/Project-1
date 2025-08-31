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

An Excel dashboard to predict the quantity of bikes required across London based upon temperature and precipitation forecast can be downloaded [here](https://github.com/Yusuf-M-Mirza/Project-1/blob/main/Forecasting_Dashboard.xlsx).

SQL queries to clean and process both the Bike-Hire and Weather datasets can be found [here](https://github.com/Yusuf-M-Mirza/Project-1/blob/main/Cleaning_Datasets.sql). The start_date and end_date columns both had their DATETIME rows in an incompatible MM/DD/YYYY HH:MM:SS format. The Weather dataset also had it's DATE in the incorrect format of YYYYMMDD. The python program to correct both of these can be found [here](https://github.com/Yusuf-M-Mirza/Project-1/blob/main/LondonDataRemapper.py).

SQL queries regarding to trends in the hiring times of bikes can be found [here](https://github.com/Yusuf-M-Mirza/Project-1/blob/main/Trends_In_Hiring_Times.sql).

SQL queries regarding to how the weather will affect the frequency of hires can be found [here](https://github.com/Yusuf-M-Mirza/Project-1/blob/main/Impact_Of_Weather_On_Hiring_Frequency.sql).

SQL queries to find gaps in the distribution of bikes can be found [here](https://github.com/Yusuf-M-Mirza/Project-1/blob/main/Gaps_In_Distribution.sql).

## Data Structure & Initial Checks
The database structure used consists of two tables that were used in this project. Their names were 'journeys' and 'weather' and are shown below.
<div align="center">
  <img src="https://i.imgur.com/jwINRuN.png" alt="TfL Cycle Hire" width="400" />
</div>

The dataset consists of a total of over 700,000 records spread across the two tables. Journeys consist of all bike hires and journeys that were made using the Cycle Hire scheme over the course of August 2023. Weather consists of a record of all weather records from 1979 to 2023.

Prior to starting the data analysis, a series of checks were made through each table and dataset for quality-control and familiarization. The SQL queries utilised to inspect and perform quality checks can be found here.

## Executive Summary
### Overview of Findings
The analysis of over 700,000 bike hire records from August 2023, along with historic London weather data, revealed three major insights into user behaviour and system performance:

- Bike usage strongly follows commuter patterns. On weekdays, hires peak at ~2,737 bikes between 6:30–9:30 AM and ~3,000 bikes between 4:30–7:30 PM, aligning with London’s traditional rush hours. Around 60.06% of weekday hires are commuter-driven. On weekends, usage shifts toward leisure, with a consistent 1,500 hires/hour from 12–6 PM, despite an overall 26.63% drop in total hires compared to weekdays.

- Weather conditions noticeably influence hire frequency. Warmer days correlate with increased hires (r = 0.44), while rainfall shows a stronger negative effect (r = -0.43), indicating that people are significantly less likely to rent bikes in wet conditions.

- Bike availability is inconsistent across docking stations. High-traffic hubs like Waterloo Station 2 lose an average of 27 bikes per day, a 46.2% decrease in bike stock, while others — such as Hyde Park Corner and Albert Gate — show excessive accumulation, with stock levels rising by 911.8% and 1466.7% respectively. These imbalances could hinder accessibility and create bottlenecks during peak times.

### Trends In Hiring Times
- **During the weekdays the frequency of bicycle hires peaks at two time periods in the day.** These correspond to the peak times outlined by TfL when running other public transportation which are between 6:30 and 9:30 AM as well as between 4:30 and 7:30 PM. On average, these peak at around **2737 hires** during the morning and **3000 hires** in the evening.
  
- Commuters make up **60.06%** of total bike hires during the working week.
  
- **The weekend shows a far wider distribution.** It is most likely due to a change in _how_ the bikes are being used. Unlike being used as a commuting tool, where people will hire them at set times to arrive at their workplace, they are more commonly used as a means of leisure travel.

- **Peak hours are between 12 and 6 PM with a consistent number of 1500 bikes being hired per hour**. However, compared to the weekdays, the weekend will see a **26.63% decrease** in total hires.

<p align="center">
  <img src="https://i.imgur.com/9ZN0KNI.png" alt="TfL Cycle Hire" width="500" />
</p>


### Impact of Weather On Hiring Frequency
- **A positive correlation is shown between temperature and bike hires.** Although weak, it can be linked to a Pearson correlation coefficient of 0.44, thus concluding that people will hire more bikes as the temperature increases.

- **A negative correlation is shown between rainfall and bike hires** It is somewhat stronger than the Pearson correlation coefficient for temperature. It stands at **-0.43.** We can then more confidently say that more rainfall will result in fewer bikes being hired throughout the entire day.

<div align="center">
  <img src="https://i.imgur.com/O6DeRDd.png" alt="TfL Cycle Hire" width="500" />
</div>

### Gaps in Distribution
- **Major deficits appear at the most popular station**. Waterloo Station 2 consistently will lose **27** bikes a day. Resulting in a **46.2%** _decrease_ in the quantity of bikes.

- **A large excess of bikes at other stations**. Hyde Park Coner and Albert Gate both experienced a massive increase in total number of bikes topping at a **911.8%** and **1466.7%** increase, respectively.

- This abscence of bikes at once station and excessive accumulation at another can lead to problems in efficiency such as bikes being abandoned on walkways due to a lack of stations. As well as potential riders choosing to get on overcrownded trains and buses from a lack of available bikes.

<div align="center">
  <img src="https://i.imgur.com/jIPAd3o.png" alt="TfL Cycle Hire" width="500" />
  <img src="https://i.imgur.com/HmajoVO.png" alt="TfL Cycle Hire" width="500" />
</div>

# Recommendations
Based on current insights, the following recommendations have been provided:

- Since during the week most of the cycle hires are by commuters during peak hours only, we should explore ways to lower the barrier to entry for bikes. This would maximise their usage and take strain away from the other transport forms. We could implement a system where similar to buses and trains, users could swipe their Oyster card to begin and end their journey and be billed on any Travelcards they may have purchased. This would be a far smoother process than having commuters pay for bike use separately as (according to this [link](https://www.london.gov.uk/who-we-are/what-london-assembly-does/questions-mayor/find-an-answer/travelcards-4)) there are around a million Travelcards currently in use that account for 35% of all TfL journeys.

- We could use the historical data on weather patterns affecting bike hire to make predictions into the future as to how many bikes are required by commuters daily using multivariate linear regression. That way, we could optimally balance between having _too many_ bikes and having _too few_. Working proactively like this instead of reactively would produce far greater results as it means we can increase the _speed_ at which we operate.
<div align="center">
  <img src="https://i.imgur.com/WPp6GNi.png" alt="TfL Cycle Hire" width="650" />
</div>

- By monitoring where we have gaps in distribution, we can again enable people as much as possible to choose bikes over other modes of transport. This could be done by being proactive instead of reactive. By modelling how and where bikes will move around London, we can create a plan to give to couriers to follow on a day-by-day basis. So instead of operating only at night, they could instead be transporting bikes throughout peak hours to maximise availability and minimise build-up. 


