This repo collects 6 NFL draft charts into one single .csv file, with the same number of rows, and all in the same data format. 

These draft charts are: Jimmy Johnson (johnson), Rich Hill (hill), Chase Stuart (stuart), Fitzgerald-Spielberger (otc), Pro Football Focus (pff), and Ben Baldwin (baldwin).

It also adds a column named `pick_label`, which identifies if a pick is an early pick in that round, middle pick, or late pick. Early, mid, and late are calculated by simply dividing the draft round into thirds. I take the average number of picks for each round based on the 5 most recent draft classes, and use that average for the pick labels. This data will run on May 15th each year to get the newest draft class information.

Here is a look at the data it shows: 
```r
    pick johnson stuart  hill   otc   pff baldwin pick_label
   <int>   <int>  <dbl> <dbl> <int> <dbl>   <int> <chr>     
 1     1    3000   34.6 1000   3000 1.14       63 Early 1   
 2     2    2600   30.2  717.  2635 1.10       66 Early 1   
 3     3    2200   27.6  514.  2421 1.06       67 Early 1   
 4     4    1800   25.8  491.  2270 1.03       69 Early 1   
 5     5    1700   24.3  468.  2152 0.991      73 Early 1   
 6     6    1600   23.2  446.  2056 0.955      82 Early 1   
 7     7    1500   22.2  426.  1975 0.919      89 Early 1   
 8     8    1400   21.4  406.  1905 0.883      96 Early 1   
 9     9    1350   20.6  387.  1843 0.847      94 Early 1   
10    10    1300   19.9  369.  1787 0.811      95 Early 1   
```
