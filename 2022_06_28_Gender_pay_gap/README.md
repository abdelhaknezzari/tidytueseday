The data are coming form tidytuesday dataset for the last week of June
2022, the data are about paygap between genders in UK, you can find more
description of the data are
[link](https://github.com/rfordatascience/tidytuesday/tree/master/data/2022/2022-06-28)
or at [link2](https://gender-pay-gap.service.gov.uk/viewing/download)

The following
[code](https://github.com/rfordatascience/tidytuesday/tree/master/data/2022/2022-06-28)
was provided to retrieve the data:

    library(tidyverse)

    ## Warning: package 'tidyverse' was built under R version 4.1.3

    ## -- Attaching packages --------------------------------------- tidyverse 1.3.1 --

    ## v ggplot2 3.3.5     v purrr   0.3.4
    ## v tibble  3.1.6     v dplyr   1.0.9
    ## v tidyr   1.1.4     v stringr 1.4.0
    ## v readr   2.1.1     v forcats 0.5.1

    ## Warning: package 'dplyr' was built under R version 4.1.3

    ## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

    library(vroom)
    library(fs)

let’s create a folder where to put the files of data ‘2022\_06\_28’

    #fs::dir_create("2022_06_28")

Let’s retrieve the data, and store it as rds file, as it is faster for
reading and writing comparing to csv

    # tidytuesdayR::tt_load(2022, week = 26) %>% .$paygap %>% saveRDS("2022_06_28/paygap.rds")

show the different columns of the data, and statistics like number of
rows:

    df <- "2022_06_28/paygap.rds" %>%   readRDS()

    df %>% glimpse()

    ## Rows: 48,711
    ## Columns: 27
    ## $ employer_name                <chr> "Bryanston School, Incorporated", "RED BA~
    ## $ employer_id                  <dbl> 676, 16879, 17677, 682, 17101, 687, 17484~
    ## $ address                      <chr> "Bryanston House, Blandford, Dorset, DT11~
    ## $ post_code                    <chr> "DT11 0PX", "EH6 8NU", "LS7 1AB", "TA6 3J~
    ## $ company_number               <chr> "00226143", "SC016876", "10530651", "0672~
    ## $ sic_codes                    <chr> "85310", "47730", "78300", "93110", "5621~
    ## $ diff_mean_hourly_percent     <dbl> 18.0, 2.3, 41.0, -22.0, 13.4, 15.1, 15.0,~
    ## $ diff_median_hourly_percent   <dbl> 28.2, -2.7, 36.0, -34.0, 8.1, 2.8, 0.0, 0~
    ## $ diff_mean_bonus_percent      <dbl> 0.0, 15.0, -69.8, -47.0, 41.4, 77.6, 0.0,~
    ## $ diff_median_bonus_percent    <dbl> 0.0, 37.5, -157.2, -67.0, 43.7, 71.2, 0.0~
    ## $ male_bonus_percent           <dbl> 0.0, 15.6, 50.0, 25.0, 8.7, 5.8, 0.0, 0.0~
    ## $ female_bonus_percent         <dbl> 0.0, 66.7, 73.5, 75.0, 3.2, 4.2, 0.0, 0.0~
    ## $ male_lower_quartile          <dbl> 24.4, 20.3, 0.0, 56.0, 29.1, 42.6, 10.0, ~
    ## $ female_lower_quartile        <dbl> 75.6, 79.7, 100.0, 44.0, 70.9, 57.4, 90.0~
    ## $ male_lower_middle_quartile   <dbl> 50.8, 25.4, 2.0, 52.0, 49.4, 45.2, 9.0, 5~
    ## $ female_lower_middle_quartile <dbl> 49.2, 74.6, 98.0, 48.0, 50.6, 54.8, 91.0,~
    ## $ male_upper_middle_quartile   <dbl> 49.2, 10.3, 11.0, 30.0, 22.8, 46.8, 10.0,~
    ## $ female_upper_middle_quartile <dbl> 50.8, 89.7, 89.0, 70.0, 77.2, 53.2, 90.0,~
    ## $ male_top_quartile            <dbl> 51.5, 18.1, 23.0, 24.0, 58.2, 35.5, 9.0, ~
    ## $ female_top_quartile          <dbl> 48.5, 81.9, 77.0, 76.0, 41.8, 64.5, 91.0,~
    ## $ company_link_to_gpg_info     <chr> "https://www.bryanston.co.uk/employment",~
    ## $ responsible_person           <chr> "Nick McRobb (Bursar and Clerk to the Gov~
    ## $ employer_size                <chr> "500 to 999", "250 to 499", "250 to 499",~
    ## $ current_name                 <chr> "BRYANSTON SCHOOL INCORPORATED", "\"RED B~
    ## $ submitted_after_the_deadline <lgl> FALSE, FALSE, TRUE, TRUE, FALSE, FALSE, F~
    ## $ due_date                     <dttm> 2018-04-05, 2018-04-05, 2018-04-05, 2018~
    ## $ date_submitted               <dttm> 2018-03-27 11:42:49, 2018-03-28 16:44:25~

some more statistics about the different columns:

    df %>% summary()

    ##  employer_name       employer_id      address           post_code        
    ##  Length:48711       Min.   :    4   Length:48711       Length:48711      
    ##  Class :character   1st Qu.: 4958   Class :character   Class :character  
    ##  Mode  :character   Median :10292   Mode  :character   Mode  :character  
    ##                     Mean   :10125                                        
    ##                     3rd Qu.:15292                                        
    ##                     Max.   :21498                                        
    ##                                                                          
    ##  company_number      sic_codes         diff_mean_hourly_percent
    ##  Length:48711       Length:48711       Min.   :-499.90         
    ##  Class :character   Class :character   1st Qu.:   4.80         
    ##  Mode  :character   Mode  :character   Median :  13.20         
    ##                                        Mean   :  14.04         
    ##                                        3rd Qu.:  22.40         
    ##                                        Max.   : 159.00         
    ##                                                                
    ##  diff_median_hourly_percent diff_mean_bonus_percent diff_median_bonus_percent
    ##  Min.   :-499.50            Min.   :-82000.0        Min.   :-120695.00       
    ##  1st Qu.:   1.00            1st Qu.:     0.3        1st Qu.:      0.00       
    ##  Median :   9.90            Median :    31.5        Median :     15.50       
    ##  Mean   :  12.22            Mean   :    17.0        Mean   :     -3.85       
    ##  3rd Qu.:  21.65            3rd Qu.:    55.7        3rd Qu.:     42.70       
    ##  Max.   : 121.20            Max.   :  3848.2        Max.   :   4000.00       
    ##                             NA's   :8931            NA's   :8933             
    ##  male_bonus_percent female_bonus_percent male_lower_quartile
    ##  Min.   :  0.00     Min.   :  0.0        Min.   :  0.00     
    ##  1st Qu.:  0.20     1st Qu.:  0.0        1st Qu.: 26.50     
    ##  Median : 19.30     Median : 17.1        Median : 44.00     
    ##  Mean   : 36.22     Mean   : 34.9        Mean   : 45.76     
    ##  3rd Qu.: 76.40     3rd Qu.: 74.0        3rd Qu.: 64.00     
    ##  Max.   :100.00     Max.   :100.4        Max.   :100.00     
    ##                                          NA's   :392        
    ##  female_lower_quartile male_lower_middle_quartile female_lower_middle_quartile
    ##  Min.   :  0.00        Min.   :  0.00             Min.   :  0.00              
    ##  1st Qu.: 36.00        1st Qu.: 29.00             1st Qu.: 28.00              
    ##  Median : 56.00        Median : 48.00             Median : 52.00              
    ##  Mean   : 54.24        Mean   : 50.12             Mean   : 49.88              
    ##  3rd Qu.: 73.50        3rd Qu.: 72.00             3rd Qu.: 71.00              
    ##  Max.   :100.00        Max.   :100.00             Max.   :100.00              
    ##  NA's   :392           NA's   :392                NA's   :392                 
    ##  male_upper_middle_quartile female_upper_middle_quartile male_top_quartile
    ##  Min.   :  0.00             Min.   :  0.00               Min.   :  0.00   
    ##  1st Qu.: 33.30             1st Qu.: 22.00               1st Qu.: 41.00   
    ##  Median : 53.30             Median : 46.70               Median : 62.00   
    ##  Mean   : 54.48             Mean   : 45.52               Mean   : 60.14   
    ##  3rd Qu.: 78.00             3rd Qu.: 66.70               3rd Qu.: 81.80   
    ##  Max.   :100.00             Max.   :100.00               Max.   :100.00   
    ##  NA's   :392                NA's   :392                  NA's   :392      
    ##  female_top_quartile company_link_to_gpg_info responsible_person
    ##  Min.   :  0.00      Length:48711             Length:48711      
    ##  1st Qu.: 18.20      Class :character         Class :character  
    ##  Median : 38.00      Mode  :character         Mode  :character  
    ##  Mean   : 39.86                                                 
    ##  3rd Qu.: 59.00                                                 
    ##  Max.   :100.00                                                 
    ##  NA's   :392                                                    
    ##  employer_size      current_name       submitted_after_the_deadline
    ##  Length:48711       Length:48711       Mode :logical               
    ##  Class :character   Class :character   FALSE:45725                 
    ##  Mode  :character   Mode  :character   TRUE :2986                  
    ##                                                                    
    ##                                                                    
    ##                                                                    
    ##                                                                    
    ##     due_date                   date_submitted               
    ##  Min.   :2018-03-31 00:00:00   Min.   :2017-04-10 09:14:59  
    ##  1st Qu.:2019-04-05 00:00:00   1st Qu.:2019-03-18 10:20:28  
    ##  Median :2020-04-05 00:00:00   Median :2020-04-01 11:52:54  
    ##  Mean   :2020-05-19 21:54:53   Mean   :2020-05-08 01:32:28  
    ##  3rd Qu.:2021-10-06 00:00:00   3rd Qu.:2021-10-05 15:12:34  
    ##  Max.   :2023-04-05 00:00:00   Max.   :2022-06-27 08:31:39  
    ## 

We plot all the numeric values like: “diff\_mean\_hourly\_percent”
“diff\_median\_hourly\_percent” “diff\_mean\_bonus\_percent”
“diff\_median\_bonus\_percent” “male\_bonus\_percent”
“female\_bonus\_percent” “male\_lower\_quartile”
“female\_lower\_quartile” “male\_lower\_middle\_quartile”
“female\_lower\_middle\_quartile” “male\_upper\_middle\_quartile”
“female\_upper\_middle\_quartile” “male\_top\_quartile”
“female\_top\_quartile”

to do that we convert the table to show all the values of above columns
in the one column, and we differentiate them with and additional colum
that shows the name of the values, we use function gather of tidyr

    df %>% select(-c("employer_id", "address", "post_code","company_number","sic_codes", "company_link_to_gpg_info", "responsible_person", "employer_size", "current_name", "submitted_after_the_deadline", "due_date", "date_submitted")) %>%
            gather( metricName, metricValue, - employer_name ) %>% head() %>% knitr::kable()

<table>
<thead>
<tr class="header">
<th style="text-align: left;">employer_name</th>
<th style="text-align: left;">metricName</th>
<th style="text-align: right;">metricValue</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">Bryanston School, Incorporated</td>
<td style="text-align: left;">diff_mean_hourly_percent</td>
<td style="text-align: right;">18.0</td>
</tr>
<tr class="even">
<td style="text-align: left;">RED BAND CHEMICAL COMPANY, LIMITED</td>
<td style="text-align: left;">diff_mean_hourly_percent</td>
<td style="text-align: right;">2.3</td>
</tr>
<tr class="odd">
<td style="text-align: left;">123 EMPLOYEES LTD</td>
<td style="text-align: left;">diff_mean_hourly_percent</td>
<td style="text-align: right;">41.0</td>
</tr>
<tr class="even">
<td style="text-align: left;">1610 LIMITED</td>
<td style="text-align: left;">diff_mean_hourly_percent</td>
<td style="text-align: right;">-22.0</td>
</tr>
<tr class="odd">
<td style="text-align: left;">1879 EVENTS MANAGEMENT LIMITED</td>
<td style="text-align: left;">diff_mean_hourly_percent</td>
<td style="text-align: right;">13.4</td>
</tr>
<tr class="even">
<td style="text-align: left;">1LIFE MANAGEMENT SOLUTIONS LIMITED</td>
<td style="text-align: left;">diff_mean_hourly_percent</td>
<td style="text-align: right;">15.1</td>
</tr>
</tbody>
</table>
