# Checking the data Bruce sent for any errors
# M. Espe
# 2023-08-23

library(readxl)
yield_file = "data/yield_contest.xlsx"
d = read_excel(yield_file)

table(d$Year)

# unify the growers, and get a family name
sort(unique(d$Grower))
d$Grower = gsub(" \\([0-9]\\)$", "", d$Grower)
d$Grower = gsub("Wyle", "Wylie", d$Grower)
d$Grower = gsub("Gallager", "Gallagher", d$Grower)
i = grep("average", d$Grower)
d = d[-i,]

i = is.na(d$Grower)
d = d[!i,]
d$grower_family_name = gsub("^[A-z]+ ", "", d$Grower)
sort(unique(d$grower_family_name))

# Fix one variety
table(d$Variety)
d$Variety[d$Variety == "M209"] = "M-209"

# Fix the straw management 
table(d$`Previous yr straw mgmt`)
d$straw_mgmt = d$`Previous yr straw mgmt`

d$straw_mgmt = tools::toTitleCase(d$straw_mgmt)
d$straw_mgmt = gsub("^Incorp$|^Inc$", "Incorporated", d$straw_mgmt)
d$straw_mgmt = gsub("^(None)-.*$", "\\1", d$straw_mgmt)
table(d$straw_mgmt)

# get previous crop from straw management
d$previous_crop = "rice"
d$previous_crop[d$straw_mgmt == "Fallow"] = "fallow"
i = grep("None", d$straw_mgmt)
d$previous_crop[i] = gsub("[Nn]one-(.*)$", "\\1", d$`Previous yr straw mgmt`[i])

# winter flood status
table(d$`Winter flood`)
d$winter_flood = toupper(d$`Winter flood`)
d$winter_flood[is.na(d$winter_flood) | d$winter_flood == "NA"] = "Unknown"
d$winter_flood[d$winter_flood == "N"] = "NO"
d$winter_flood[d$winter_flood == "Y"] = "YES"

# Fertility mgmt
d$topdress = d$`Topdress Y/N`

# Pest
table(d$AI)
d$propanil = grepl("propanil", d$AI, ignore.case = TRUE)
d$penosxulam = grepl("penosxulam", d$AI, ignore.case = TRUE)
d$bispyribac = grepl("bispyribac", d$AI, ignore.case = TRUE)

saveRDS(d, file = "data/yield_cleaned.rds")
