<h1>🚲 Pedals & Patterns: Analyzing Bike-Hire Usage in London</h1>

 ### [Bike-Hire Dataset](https://www.kaggle.com/datasets/kalacheva/london-bike-share-usage-dataset)

<h2>Description</h2>
Within August 2023, there were 776,527 trips made with the Transport for London (TfL) Cycle Hire scheme. These trips were all recorded, with datapoints including: starting location, duration, ending location, as well as time-of-day. I hope to use exploratory data analysis techniques and translate raw data into actionable insights so as to improve the Cycle Hire service by TfL and boost the overall efficiency of public transport.
<br />


<h2>Tech Stack Used</h2>

- <b>Excel</b> 
- <b>MySQL</b>
- <b>Python</b>

<h2>Environments Used </h2>

- <b>Windows 11</b>

<h2>Walkthrough</h2>
<h3>Cleaning</h3>

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
<hr style="margin: 20px 0;" />
<img src="https://i.imgur.com/TfWfZgl.png" height="45%" width="45%" alt="Disk Sanitization Steps"/>

As shown by the above graph, the theory I propsed was correct in that across the weekdays, bike usage was greatest during rush-hour. It can be seen by the set of peaks in the interval of [07:00-09:00] and [17:00-19:00]. Additionally, we can see the least popular times to ride are in the earliest hours of the morning before 05:00. TfL currently runs a series of different pricings for Cycle Hire (https://tfl.gov.uk/modes/cycling/santander-cycles/what-you-pay). What I would propose is trialling a subset of the current Day Pass that is valid only during what TfL currently outlines as 'peak times' ([06:30-09:30], [16:00-19:00]). This could be an even lower cost than the current £3.50, but it could be offset by an increase in rider numbers, thus reducing strain on other existing public transport networks whilst also promoting a low-cost carbon carbon-neutral method of travel. I also wanted to investigate how this distribution would change on the weekend. This is because we cannot assume peak usage would be during rush hour due to the fact that on weekends, people do not commute to work during this time. Consequently, the graph produced was very different.
<hr style="margin: 20px 0;" />
<img src="https://i.imgur.com/2Kr9rxU.png" height="45%" width="45%" alt="Disk Sanitization Steps"/>

As shown in the graph, we can see how my proposed 'Peak Time Day Pass' would not be viable here due to the fact that at what would typically be morning rush-hour on a weekend is shown to actually be a time during the day when bike hire usage is at its lowest. Therefore, it can be said that if my suggestion was to be trialled, we would likely only see growth in bike hire during the weekday. This data was derived using the below SQL query.
```SQL
SELECT
    HOUR(start_date) AS Hour,
    COUNT(start_date) AS Count
FROM london_bikes.journeys
WHERE DAYOFWEEK(start_date) IN (1,7)
GROUP BY Hour
ORDER BY Hour;
```
Continuing on with the idea of investigating rider frequency, I also wished to look into how external factors will affect the number of cycle hires within a day.

 ```diff
- text in red
+ text in green
! text in orange
# text in gray
@@ text in purple (and bold)@@
```
--!>
