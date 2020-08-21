library(markdown)
library(rmarkdown)

## Don't forget to setwd('stuff') to where your CarmiSite.Rmd file is!!

render("./StAlbansSite.Rmd",output_file="./StAlbansData.html")
rpubsUpload("UVM St Albans and Missisqoui Bay Platform Data", htmlFile="./StAlbansData.html", id="https://api.rpubs.com/api/v1/document/651369/c63adee243c64e2698f45ba20ca3a2c7"))

unlink("./StAlbansData.html")
