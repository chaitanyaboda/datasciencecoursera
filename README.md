The script file run_analysis.R works once the zip file is downloaded and extracted to a location. The script must run from the extracted directory or its parent directory.
The script first imports the necessary files from the directory into R tables. These tables are given their corresponding column names and deduplicated to remove repeated column names.
Using the aggregate function, the mean is then calculated for each unique entry of the combination, subject and activity
