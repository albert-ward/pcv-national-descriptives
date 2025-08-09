*** Proposed hard quotas for geopoll

** 31st August 2022
** 2nd version, for GeoPoll, 1 May 2023

clear
cd "/Users/stephenfisher/Documents/Projects/Mission 1 point 5/PCV22_planning"
import delimited "/Users/stephenfisher/Documents/Projects/Mission 1 point 5/PCV22_planning/country_targets_29042023.csv", case(preserve) 

gen IdealFrom1k = target // No division by 2
gen Pct30Ideal = 0.3*IdealFrom1k
gen Pct30orAbs20 = max(Pct30Ideal,20)
gen quota = IdealFrom1k - Pct30orAbs20
replace quota = 35 if quota>35
replace quota = 0 if quota<0
replace quota = round(quota)

gen pctIdeal = 100*quota/IdealFrom1k


su Ideal Pct* quota pctIdeal, detail

outsheet country iso gender age left_educ Ideal quota using "PCV23_GeoPoll_hard_quotas_v1_20230501.csv", comma replace
