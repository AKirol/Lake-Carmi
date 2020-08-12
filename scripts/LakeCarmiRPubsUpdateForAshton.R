library(markdown)
library(rmarkdown)

## Don't forget to setwd('stuff') to where your CarmiSite.Rmd file is!!

render("./CarmiSite.Rmd",output_file="./LakeCarmiData.html")
rpubsUpload("UVM Lake Carmi Platform Data", htmlFile="./LakeCarmiData.html", id="https://api.rpubs.com/api/v1/document/644651/30cef508876a47dda2da12c8759093fc")

unlink("./LakeCarmiData.html")
