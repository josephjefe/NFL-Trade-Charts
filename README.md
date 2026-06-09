This repo collects 6 NFL draft charts into one single .csv file, with the same number of rows, and all in the same data format. 

It also adds a column named `pick_label`, which identifies if a pick is an early pick in that round, middle pick, or late pick. Early, mid, and late are calculated by simply dividing the draft round into thirds. I take the average number of picks for each round based on the 5 most recent draft classes, and use that average for the pick labels. This data will run on May 15th each year to get the newest draft class information.
