# Hent CSV direkte for GitHub
library(readr)
GitURL <- "https://raw.githubusercontent.com/cphstud/DALE22-W45/refs/heads/master/biler.csv"
biler <- read_csv(url(GitURL))

library(DBI)
library(RMariaDB)

# Hvis i skal bruge hjælp til at opsætte dette, kan i min repo guide: https://github.com/60gCreatine/Skjul_API-KEY_i_RStudio_Git
# Ellers bare i stedet for password i con skriv jeres password HUSK IKKE AT UPLOADE TIL GIT HVIS I GØR DET!!!!!
readRenviron(".Renviron")
password <- paste0(Sys.getenv("password"),'"')

# I workbench lav database med navnet newbilbasen
# CREATE DATABASE newbilbasen;
con <- dbConnect(MariaDB(),
                 db="newbilbasen",
                 host="localhost",
                 port=3306,
                 user="root",
                 password=password)

# Indsætter dataframen i SQL
dbWriteTable(con,"cars",biler)