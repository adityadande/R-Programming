# Install and load the readxl package
install.packages("readxl")
install.packages("data.table")
library(data.table)


library(readr)
RICE <- read_csv("RICE.csv")
View(RICE)

# Filter the data based on the "RICE" column values above 1974
filtered_data <- filter(RICE, 'Observation Year' > 1974)

# Display the filtered data
print(filtered_data)
return(filtered_data)
