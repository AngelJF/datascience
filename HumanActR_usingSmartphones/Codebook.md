---
title: "CodeBook.md"
author: "Angel Juarez Flores"
date: "October 12, 2020"
output: html_document
---


## General characteristics

Two main objects were created at first to store the names of the files main data from Train and test datasets
1.- filestestinertial
2.- filestraininertial

From this objects "sapply" + "read.table" was use to merge and store the data in two objects on for train and other for test. From this stored data all the next computations were made.

## Data processing and cleaning

The next thing made was the tag assignment for the columns names it was read from "features.txt" + the addition of two additional tags: "subject", "activity_label". Data assigment was need to be in a character vector in order to automatize the tag assigment. A loop were used to create the tag vector and special characters were removed as "()", "-". Resulting file were used with colnames function to add tags.

Then merging of data were made to create the main merged data called "fulldata". 

To select data mean and std. Column names were used, a vector with the columns that match "mean, std" was created and used as the input to select columns. A object from this process was created and called "meanstdfulldata". Finally "group_by" function was used to group by "subject" and "activity_label" and create a tidy data. "summarise_all" function was used to apply mean to all the columns in the grouped data and final object "Finaltable" was used to create a final file with the tidy data.

