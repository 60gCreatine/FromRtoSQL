library(DBI)
library(RMariaDB)
library(dplyr)
readRenviron(".Renviron")
password <- paste0(Sys.getenv("password"),'"')

con <- dbConnect(MariaDB(),
                 db="trytrynorthwind",
                 host="localhost",
                 port=3306,
                 user="root",
                 password=password)

# Loop for SQL tables -> Dataframes
tables <- dbListTables(con)
for (i in tables) {
  assign(i, dbReadTable(con, i))
}

sales_test <- dbGetQuery(con, "SELECT 
    p.productname, od.quantity, cu.companyname, o.orderdate
FROM
    products p,
    order_details od,
    customers cu,
    orders o
WHERE
    o.orderid = od.orderid
        AND o.customerid = cu.customerid
        AND od.productid = p.productid
        AND o.orderdate BETWEEN '1996-07-04' AND '1996-07-11';")

get_sales <- function(start_date, end_date) {
  query <- paste0("SELECT 
                  p.productname, od.quantity, cu.companyname, o.orderdate
                  FROM
                  products p,
                  order_details od,
                  customers cu,
                  orders o
                  WHERE
                  o.orderid = od.orderid
                  AND o.customerid = cu.customerid
                  AND od.productid = p.productid
                  AND o.orderdate BETWEEN ", start_date, " AND ", end_date, ";")
  dbGetQuery(con, query)
}

sales <- get_sales("'1996-07-04'","'1996-07-11'")

# Lav en function, som gør det muligt selv at indsætte nye datoer:
#   select p.productname, od.quantity, cu.companyname, o.orderdate
#   from products p, order_details od, customers cu, orders o
#   where o.orderid=od.orderid and o.customerid=cu.customerid and od.productid=p.productid
#   and o.orderdate between '1996-07-04' and '1996-07-11';




