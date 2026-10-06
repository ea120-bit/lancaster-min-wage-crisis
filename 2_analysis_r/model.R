> library(tidyverse)

> welfare_data <- read_csv("/Users/ethanaddy/Desktop/welfare_project_data/final_welfare_pipeline_output.csv")

> glimpse(welfare_data)
Rows: 1
Columns: 8
$ County                          <chr> "Lancaster County"
$ State                           <chr> "PA"
$ Fair_Market_Rent_1Bed           <dbl> 1256
$ Min_Wage                        <dbl> 7.25
$ Living_Wage                     <dbl> 23.32
$ Poverty_Wage                    <dbl> 7.67
$ Hourly_Wage_Gap                 <dbl> -16.07
$ Income_Percentage_Spent_On_Rent <dbl> 108.3

> welfare_data$survival_deficit_hourly <-welfare_data$Min_Wage - welfare_data$Living_Wage
> welfare_data$weekly_shortfall <- welfare_data$survival_deficit_hourly * 40
> welfare_data %>% select(County, Min_Wage, Poverty_Wage, Living_Wage, survival_deficit_hourly, weekly_shortfall, Income_Percentage_Spent_On_Rent)
# A tibble: 1 × 7
  County           Min_Wage Poverty_Wage Living_Wage survival_deficit_hourly weekly_shortfall Income_Percentage_Spent_On_Rent
  <chr>               <dbl>        <dbl>       <dbl>                   <dbl>            <dbl>                           <dbl>
1 Lancaster County     7.25         7.67        23.3                   -16.1            -643.                            108. 
