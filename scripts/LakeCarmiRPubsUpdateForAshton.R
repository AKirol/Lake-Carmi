library(markdown)
library(rmarkdown)

## Don't forget to setwd('stuff') to where your CarmiSite.Rmd file is!!

render("./CarmiSite.Rmd",output_file="./LakeCarmiData.html")
rpubsUpload("UVM Lake Carmi Platform Data", htmlFile="./LakeCarmiData.html", id="https://api.rpubs.com/api/v1/document/648834/6e16202f48734b3682e5b3e1dca9c099"))

unlink("./LakeCarmiData.html")
