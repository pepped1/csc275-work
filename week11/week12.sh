#!/bin/bash
# this script manipulates film data based on specific rules

# downloads the film.csv file
wget https://perso.telecom-paristech.fr/eagan/class/igr204/data/film.csv

# change delimiter from semi-colon to comma, using the vertical bar
sed -i 's/,/|/g' film.csv
sed -i 's/;/,/g' film.csv
sed -i 's/|/;/g' film.csv

# remove last column from file, using a temp file to update the existing file
awk -F , '{print $1,$2,$3,$4,$5,$6,$7,$8,$9}' OFS=, film.csv > temp && mv temp film.csv

# remove the second row
awk -F , 'NR!=2{print $0}' film.csv > temp && mv temp film.csv

# include only movies that have won awards
awk -F , '$9=="Yes"{print $0}' film.csv > temp && mv temp film.csv

# include movies greater than 100 minutes
awk -F , '$2>100{print $0}' film.csv > temp && mv temp film.csv

# filters movies between the years of 1980 and 2000
awk -F , '$1>=1980 && $1<=2000{print $0}' film.csv > temp && mv temp film.csv

# add column headers back if they are lost
sed -i '1i Year,Length,Title,Subject,Actor,Actress,Director,Popularity,Awards' film.csv

# show the remaining movies from 1981
if [[ ${1} -eq 1981 ]]
then
    awk -F , '$1==1981{print $0}' film.csv > temp && mv temp film.csv
fi

# show the remaining items in the file
wc film.csv -l

exit 0
