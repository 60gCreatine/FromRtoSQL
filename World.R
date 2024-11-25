library(DBI)
library(RMariaDB)

# Hvis i skal bruge hjælp til at opsætte dette, kan i min repo guide: https://github.com/60gCreatine/Skjul_API-KEY_i_RStudio_Git
# Ellers bare i stedet for password i con skriv jeres password HUSK IKKE AT UPLOADE TIL GIT HVIS I GØR DET!!!!!
readRenviron(".Renviron")
password <- paste0(Sys.getenv("password"),'"')

# I workbench lav database med navnet newbilbasen
# CREATE DATABASE newbilbasen;
con <- dbConnect(MariaDB(),
                 db="world",
                 host="localhost",
                 port=3306,
                 user="root",
                 password=password)

# Indsætter dataframen i SQL
countrydf <- dbReadTable(con,"country") 
citydf <- dbReadTable(con,"city")
cldf <- dbReadTable(con,"countrylanguage")
mycictr <- left_join(citydf,countrydf,by="CountryCode")


library(dplyr)
countrycodes <- citydf %>% group_by(CountryCode) %>% mutate(ccpop=sum(Population)) %>% 
  select(CountryCode,ccpop) %>% unique()

