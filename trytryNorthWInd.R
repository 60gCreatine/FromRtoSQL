library(DBI)
library(RMariaDB)

# Hvis i skal bruge hjælp til at opsætte dette, kan i min repo guide: https://github.com/60gCreatine/Skjul_API-KEY_i_RStudio_Git
# Ellers bare i stedet for password i con skriv jeres password HUSK IKKE AT UPLOADE TIL GIT HVIS I GØR DET!!!!!
readRenviron(".Renviron")
password <- paste0(Sys.getenv("password"),'"')

# I workbench lav database med navnet newbilbasen
# CREATE DATABASE newbilbasen;
con <- dbConnect(MariaDB(),
                 db="trytrynorthwind",
                 host="localhost",
                 port=3306,
                 user="root",
                 password=password)
wbquery <- 'SELECT concat(e.firstname, " ", e.lastname), SUM(od.Quantity) as "sq" 
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN Order_Details od ON o.OrderID = od.OrderID
where o.orderdate between "1998-04-01" and "1998-05-01"
group by e.firstname,e.lastname
ORDER BY 2 desc
limit 3;'

reswb <- dbGetQuery(con,wbquery)

# Chose start and end date yourself
getEmStat <- function(from_date,to_date){
  query <- paste0('SELECT concat(e.firstname, " ", e.lastname), SUM(od.Quantity) as "sq" 
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN Order_Details od ON o.OrderID = od.OrderID
where o.orderdate between "',from_date, '" and "',to_date,'" 
group by e.firstname,e.lastname ORDER BY 2 desc
limit 3;')
SQL <- dbGetQuery(con,query)
  }

yo <- getEmStat("1998-04-01","1998-05-01")
