library(here)
library(dplyr)
library(stringr)

# store data dictionary file path
DD_FILEPATH <- here::here( "data/rodeo/ltdb_data_dictionary.csv" )

# import data dictionary
dd <- read.csv( DD_FILEPATH, stringsAsFactors=F )

# ONE: Filter variables by theme or group. 

age <- c (str_detect(dd$definition, regex("years old", ignore_case = T)),
          str_detect(dd$definition, regex("age", ignore_case = T)),
          str_detect(dd$definition, regex("persons age", ignore_case = T)))


age <- age %>%
  cbind.data.frame(dd, age) %>%
  filter(age == T) 

View(age)

# another example 

# The function should return all of the rows of the dataframe that belong to the group.

dd %>% filter(str_detect(definition, "income")) %>%
  slice()


# The function should return all of the rows of the dataframe that belong to the group.

age.search <- function(age.string) {
  vector <- age
  these <- grepl (age.string, vector, ignore.case = T)
  dat.sub.age <- age [these ]
  return( dat.sub.age)
}

age.search("age")

# TWO: create a function that searches variable descriptions for a specific string and returns any 
# that match. 

varsearch <- function( string)
{
  vector <- dd$definition 
  these <- grepl( string, vector, ignore.case=T )
  dat.sub <- dd[ these, ]
  return( dat.sub )
}
varsearch("income")








# Create a function to filter variables by time periods. 
#Specifically, the user will specify the time periods of interest for the study and the
#function will identify all variables that have measures for those periods.

#variable formation:
seventies <- c (grepl("[1-9]",dd$X1970.f),
                grepl("[1-9]",dd$X1970.s))

variables.1970s <- cbind (dd,seventies) %>%
  filter(seventies == T)



eighties <- c (grepl("[1-9]",dd$X1980.f),
               grepl("[1-9]",dd$X1980.s))

variables.1980s <- cbind (dd,eighties) %>%
  filter(eighties == T)




nineties <- c (grepl("[1-9]",dd$X1990.f),
               grepl("[1-9]",dd$X1990.s))

variables.1990s <- cbind (dd,nineties) %>%
  filter(nineties == T)




early.2000s <- c(grepl("[1-9]",dd$X2000.f),
                 grepl("[1-9]",dd$X2000.s))

variables.2000s <- cbind (dd,early.2000s) %>%
  filter(early.2000s == T)




later.2000s<- c(grepl("[1-9]",dd$X2010.f),
                grepl("[1-9]",dd$X2010.s))

variables.2010s <- cbind (dd,later.2000s) %>%
  filter(later.2000s == T)
# choose from time periods:
variables.1970s
variables.1980s
variables.1990s
variables.2000s
variables.2010s

# function
find.variables.for.time.period <- function(time.period) {
  variables <- time.period %>% 
    select(4)
  return(variables)
}


find.variables.for.time.period("your time period here")

find.variables.for.time.period(variables.1990s)




#BONUS: create a function that adds a column to the current LTDB dataset
# does not work don't fool yourselves. just playing around at 3am

