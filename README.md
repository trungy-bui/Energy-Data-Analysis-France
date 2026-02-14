# Energy Exploratory Data Analysis

# Overview
This project analyzes historical electricity generation and emissions data (2016–2025) for Germany and compares it to France, Poland, and Denmark.

# Executive Summary
From 2016–2025, emissions decline while electricity generation increasingly decouples from emissions, showing that new demand is being met by cleaner energy. Renewables are taking a larger share of the mix, driving lower emissions per unit of power. Installed capacity is growing faster than output due to intermittent renewables, improving emissions performance but creating grid efficiency challenges. Emissions remain concentrated in a few key countries, so progress there drives most regional impact.

Below is an overview page of PowerBI Dashboard that highlights our findings and insights.
<img width="950" height="595" alt="image" src="https://github.com/user-attachments/assets/f41d56e4-f40b-4a4b-800f-b3fd78cb51bd" />

### Overview of Findings

# Business and Stakeholders' questions
This anaylsis was conducted to address the following questions:
* What is the current carbon intensity (gCO₂/kWh)?
* How does carbon intensity change hour by hour?
* Are there unexpected emission spikes?
* How does Germany compare to France / Poland / Denmark?
* Which country has the lowest average CO₂ intensity?
* Which country is most dependent on fossil fuels?

# Dataset
- [Electricity Maps API](https://analysesetdonnees.rte-france.com/en)

# Tech Stack
- Python (Pandas, ScikitLearn, Prophet) - Data Extraction
- Snowflake - Data storage
- DBT (Data build tool) - Data transformation
- Power BI - Visualization and insights
- Git - Version Control

# Data Pipeline
### 1. Data Collection
* Extracted energy-related data from flat files
### 2. Data Ingestion
* Loaded raw data directly into Snowflake Database inside the warehouse
### 3. Data Cleaning & Exploration
* Handled missing and duplicated values
* Transformed data types and renamed columns' name for further analysis
### 4. Analysis & EDA
* Built semantic layers with DBT
### 5. Visualization
* Published Power BI Dashboard

# Insights Deep Dive
### Overall KPIs
* Total Net Energy (TWh): 26.67k
* Total Emissions (MT): 12.88k
* Total Generation (TWH): 53.18k
* Total Energy Types: 18

<img width="685" height="450" alt="image" src="https://github.com/user-attachments/assets/caefc8ed-8295-4494-acd8-5feb4bb1811b" />

### Net Energy by Energy Type
Baseload stability enables higher renewable penetration, but fossil fuels remain the marginal supply during peaks — making peak-hour decarbonization the highest-leverage intervention point.

* **Energy mix is still dominated by baseload generation**. A large share comes from stable sources (nuclear + hydropower), anchoring system reliability.
* **Renewables are meaningful but still secondary**. Wind and solar together form a solid share, but they’re not yet the majority—there’s room to scale.
* **Hydropower is the largest clean contributor**. Hydro plays a major role in clean energy output, but it’s constrained by geography and climate variability.

<img width="685" height="450" alt="image" src="https://github.com/user-attachments/assets/d4aa2a61-bf22-4f42-8056-dcc20381fc1e" />

### Structural Decline in Power-Sector Emissions
Emissions show a long-term downward trend driven mainly by large emitting countries, meaning targeted decarbonization in a few markets delivers outsized impact.

* Sharp dip around 2020, partial rebound 2021–2022, then continued decline
* Biggest contributors (e.g., Germany/Belgium) drive most of the movement

<img width="685" height="450" alt="image" src="https://github.com/user-attachments/assets/df1d8d85-5817-4f80-b6a8-ddaad6d5b8f9" />

### Strong Seasonal Cycles Drive Peak Energy Generation (TWH)
Despite short-term fluctuations, overall generation stays within a similar range across 2016–2025. There’s no explosive growth or collapse — demand is stable with cyclical variation.

* Peak demand periods are high-risk for grid congestion and price spikes
* Predictable seasonality enables proactive capacity and maintenance planning
* Targeting peak hours yields higher ROI for flexibility investments
* Peak periods are prime targets for:
  * Storage
  * Demand response
  * Clean peaker plants

<img width="685" height="450" alt="image" src="https://github.com/user-attachments/assets/c21cea6f-3eeb-4b3e-a187-dfe7bb037eac" />
<img width="685" height="450" alt="image" src="https://github.com/user-attachments/assets/15b0b920-3efd-47b2-afa4-0daeb599ab11" />

### Declining Emissions Intensity Over Time
Emissions intensity is falling over time, confirming structural decarbonization rather than demand-driven reductions.

* Emissions per TWh is declining
* Correlation heatmap shows weak generation ↔ emissions link

<img width="685" height="450" alt="image" src="https://github.com/user-attachments/assets/b02c2826-2212-4c2e-9de7-de89dc6c7026" />

---

# Recommendations:
Based on our analysis and findings, we would propose the following strategies:
* **Prioritize Grid Flexibility & Storage**. Invest in storage, demand response, and flexible generation to manage seasonality and peak-emission periods without reverting to high-carbon sources.
* **Target High-Intensity Generation for Retirement**. Systematically phase out the most carbon-intensive assets to sustain the downward trend in emissions intensity.
* **Use Seasonal Forecasting for Emissions Control**. Apply seasonal forecasting to pre-position low-carbon supply ahead of peak demand periods and avoid emissions spikes.

Below is an image of our forecasted and actual values (
<img width="906" height="326" alt="image" src="https://github.com/user-attachments/assets/a88a4cc4-6c65-4b0f-9070-ae4a6df8c532" />

# Future Improvements
* Add Forecasting & Scenario Analysis
* Integrate Cost & Economic Signals
* Track Reliability & Flexibility Metrics

---

# License
This project is licensed under the [Open Source Initiative (OSI)](https://opensource.org/) approved GNU General Public License v3.0 License - see the [LICENSE.txt](LICENSE.txt) file for details.<br>
