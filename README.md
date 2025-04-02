# Citi Bike Gender Perspective Analysis

## Overview

This project analyzes a sample dataset from Citi Bike, covering June 2016 and June 2019, to examine the gender-based perspective of bike usage in New York City. The analysis aims to explore how bike usage has evolved over time and how gender influences bike-sharing habits. The trip data is publicly available on the [Citi Bike System Data](https://citibikenyc.com/system-data) website.

To structure the project, I implemented a full **Extract, Transform, and Load (ETL)** process, followed by data visualization in **Tableau** to present compelling insights based on the findings.
## Dashboard Deployment link: [Click Here](https://atnafb.github.io/tableau_CitiBike_Usage/index.html)
## ETL Process

### Extraction

The raw data files for June 2016 and June 2019 were extracted in chunks to prevent memory overload due to their large size.  Below is the Python function used to download the data:

``` python
import requests

def download_zip(url, filename):
    response = requests.get(url, stream=True)
    if response.status_code == 200:
        with open(filename, 'wb') as file:
            for chunk in response.iter_content(chunk_size=1024):
                file.write(chunk)
        print(f'Downloaded: {filename}')
    else:
        print(f'Failed to download {filename}')

  for year, url in urls.items():
     download_zip(url, f"{year}-citibike-tripdata.zip")
```

After downloading the ZIP files, the relevant CSV files were extracted.

## Transforming 
- Merging, handling missing values and renaming handled. Converted data types where necessary. Mapping Gender Values. The dataset encoded gender as`:0: Unknown: 0 Male: 1 Female: 2`. These values were mapped accordingly for better readability.
- Stratified random sampling to optimize Tableau performance and enable efficient analysis. A stratified random sample of 5% of the dataset per gender category was selected.This ensured a proportional representation of gender categories.
``` python
df_2016_sample = june_merged_df_2016.groupby('gender', group_keys=False).apply(
     lambda x: x.sample(frac=0.05, random_state=42)
 ).reset_index(drop=True)


df_2019_sample = june_merged_df_2019.groupby('gender', group_keys=False).apply(
     lambda x: x.sample(frac=0.05, random_state=42)
 ).reset_index(drop=True)
```
### Loading the Data 
Loading the DataFor storage, PostgreSQL was chosen as the database solution. The cleaned data was loaded into PostgreSQL using SQLAlchemy and Jupyter Notebook.Steps Before LoadingRenamed columns to ensure compatibility with PostgreSQL.Saved cleaned data as a CSV file.Reduced dataset size: The original dataset was over 350MB, but to comply with Tableau Public’s limitations, the dataset was reduced to 20MB by sampling 5% of records from each gender category.Table Schema in PostgreSQL

``` SQL
CREATE TABLE bike_trips (
    trip_duration INT,
    start_time TIMESTAMP,
    stop_time TIMESTAMP,
    start_station_id INT,
    start_station_name TEXT,
    start_station_latitude FLOAT,
    start_station_longitude FLOAT,
    end_station_id INT,
    end_station_name TEXT,
    end_station_latitude FLOAT,
    end_station_longitude FLOAT,
    bike_id INT,
    user_type TEXT,
    gender TEXT,
    age FLOAT
);
```
Loading Data into PostgreSQLfrom sqlalchemy import create_engine

### Example Usage:
`df.to_sql("bike_trips", engine, if_exists="replace", index=False)`

After loading, a few queries were executed to validate the data. The database successfully stored over 450,000 rows.Project 

Repository StructureThe GitHub repository contains the following key files:
- cleaned_data.csv – The cleaned and preprocessed dataset.
- citybike_data_ETL.ipynb – Jupyter Notebook with the full ETL process.
- Tableau– Folder containing Tableau visualizations and dashboards.
- index.html – Homepage for deployment.

## Conclusion:
This project successfully explored gender-based differences in bike-sharing behavior in NYC over time. By leveraging ETL techniques, PostgreSQL, and Tableau, the data was efficiently managed, transformed, and visualized to provide insights into urban mobility trends.For further improvements, additional years of data could be analyzed, and more advanced statistical methods could be applied to uncover deeper trends.

Author: Atnafu Ayalew
