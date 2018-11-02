# 2018-MSCI-6050-Kickstarter-Projects-Analysis

## Description: 
Analyzing data on Kickstarter Projects as a class project for MSCI:6050 Data Management and Visual Analytics

## Credits: 
  1) Mickaël Mouillé (https://www.kaggle.com/kemical) for the dataset on Kickstarter Projects (https://www.kaggle.com/kemical/kickstarter-projects)
  2) Koki Ando (https://www.kaggle.com/koki25ando) for the dataset on Country Codes (https://www.kaggle.com/koki25ando/country-code)

## Contributors: 
  1) Clarisse Chia 
  2) Olivia Nauman
  3) David Langley
  4) Oluwasayo Taiwo
  5) Hutan Vahdat

## Process:
  1) Collect data on both Kickstarter Projects and Country Codes from Kaggle.com 
  2) Building Entity Relationship (ER) Diagrams to visualize the relationship between the datapoints
  3) Clean and build upon the dataset on R
  4) Split the dataset into smaller subsets on R before importing them into Oracle SQL
  5) Query the datasets on Oracle SQL
  6) Visualize our findings on Tableau

## Data Dictionary
      COLUMN NAMES              DATA TYPE (len)   DESCRIPTION
  1)  project_ID                integer (7)       Project identifier
  2)  name                      character (96)    Name of the project
  3)  category                  factor (18)       Sub-category of the project
  4)  main_category             factor (12)       Main category of the project
  5)  original_currency         factor (3)        Currency of the project
  6)  deadline                  date (10)         Deadline of the project
  7)  goal                      numeric (11)      Goal amount in project currency
  8)  launch_date               date (10)         Date project was launched
  9)  pledged_amount            numeric (11)      Pledged amount in project currency
  10) project_state             factor (10)       Current state of project
  11) backers                   integer (6)       Number of backers
  12) country_code              factor (2)        Country in which the project started
  13) usd_pledged               numeric (11)      Pledged amount in USD
  14) usd_pledged_real          numeric (11)      Pledged amount in USD adjusted for inflation
  15) usd_goal_real             numeric (12)      Goal amount in USD
  16) active_days               integer (2)       Number of days the project was active
  17) category_ID               integer (4)       Category IDs uniquely assigned to each subcategory
  18) proportion_goal_reached   numeric (6, 2)    Proportion of goals reached (Pledged/goal)
  19) date                      date (10)         Collection of all dates from 2009 to 2018
  20) day_of_week               character (3)     Day of the week for "date" column
  21) weekday                   character (7)     Indicates "date" column is a weekday
