WITH Lancaster_Rent AS (
  SELECT
    countyname,
    stusps,
    fmr_1 AS one_bedroom_rent
  FROM `wage-vs-housing-510817.welfare_data.rent`
  WHERE UPPER(countyname) LIKE '%LANCASTER%'
    AND (stusps = 'PA' OR stusps = 'Pennsylvania')
),
Combined_Metrics AS (
  SELECT
    r.countyname,
    r.stusps,
    r.one_bedroom_rent,
    w.minimum_wage,
    w.living_wage,
    w.poverty_wage,
    (w.minimum_wage - w.living_wage) AS hourly_wage_gap,
    (r.one_bedroom_rent / (w.minimum_wage * 160)) * 100 AS rent_to_income_percentage
  FROM Lancaster_Rent r
  CROSS JOIN `wage-vs-housing-510817.welfare_data.wage` w
)
SELECT
  countyname AS County,
  stusps AS State,
  ROUND(one_bedroom_rent, 2) AS Fair_Market_Rent_1Bed,
  ROUND(minimum_wage, 2) AS Min_Wage,
  ROUND(living_wage, 2) AS Living_Wage,
  ROUND(poverty_wage, 2) AS Poverty_Wage,
  ROUND(hourly_wage_gap, 2) AS Hourly_Wage_Gap,
  ROUND(rent_to_income_percentage, 1) AS Income_Percentage_Spent_On_Rent
FROM Combined_Metrics;
