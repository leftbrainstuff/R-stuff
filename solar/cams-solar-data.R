# from https://cran.r-project.org/web/packages/camsRad/vignettes/CAMS_solar_data.html for accessing solar irradition data at http://www.soda-pro.com/web-services/radiation/cams-radiation-service?p_p_lifecycle=0&p_p_id=58 and https://data.gov.au/dataset/ds-nsw-f6b1069d-3fc4-4897-a550-d16e20c1a18d/details?q=solar

# To Run use Rscript cams-solar-data.R

library(camsRad)
# Authentication
cams_set_user("leftbrainstuff@gmail.com") # An email registered at soda-pro.com

# Fetch Date

df <- cams_get_radiation(
  lat=35, lng=15, # Latitude & longitude coordinates 
  date_begin="2016-07-01", date_end="2019-07-01", # Date range
  time_step="PT01H") # Use hourly time step
  
# Validate the Data Frame
summary(df)
head(df)
print(df)

# Advanced Retrievals
library(ncdf4)

filename <- paste0(tempfile(), ".nc")

r <- cams_api(
  60, 15, "2016-06-01", "2016-07-1", # Latitude/longitude and date range 
  format="application/x-netcdf", # specifies output format as netCDF
  time_step = "P01D", # daily sum is specified
  filename=filename)

# Access the on disk stored netCDF file
nc <- nc_open(r$response$content)  

# List names of available variables
names(nc$var)

# Create data.frame with datetime and global horizontal irradiation
df <- data.frame(
  timestamp = as.POSIXct(nc$dim$time$vals, "UTC", origin="1970-01-01"),
  GHI = ncvar_get(nc, "GHI"))
df$timestamp <- df$timestamp-3600*24 # shift timestamp 24 hours backwards

nc_close(nc) # close connection

# And plot it
par(mar=c(4.5,4,0.8,1))
plot(df, type="b", ylab="GHI, Wh/m2,day", xlab="2016")



