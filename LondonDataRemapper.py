FILENAME = "LondonBikeJourneyAug2023.csv"
DATA = []

# Section that will correct the formatting of start_date and end_date in the Bike-Hire Dataset
with open(FILENAME, "r") as file:
    lines = file.readlines()
    for line in lines:
        month, day, period = line.split("/")
        year, time = period.split(" ")
        DATA.append(f"{year}-{month}-{day} {time}")

with open("FILE.csv", "a") as file:
    file.writelines(DATA)

# Code section that will correct the formatting of DATE in the Weather Dataset
with open(FILENAME, "r") as file:
    lines = file.readlines()
    for line in lines:
        year = line[0:4]
        month = line[4:6]
        day = line[6:8]
        DATA.append(f"{year}-{month}-{day}\n")

with open("FILE.csv", "a") as file:
    file.writelines(DATA)
