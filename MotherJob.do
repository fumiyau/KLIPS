*This stata code is to create a variable to indicate whether respondent's (co-resident) mother is employed or not. 
*Please run this code after you successfully merge multiple waves in a wide format.

forvalue i=1/9{
*if respondent is household head's female spouse
gen femalespousejob0`i'=.
replace femalespousejob0`i'=p0`i'0203 if p0`i'0101==2 & p0`i'0102==20
*if respondent is female household head
replace femalespousejob0`i'=p0`i'0203 if p0`i'0101==2 & p0`i'0102==10
replace femalespousejob0`i'=. if femalespousejob0`i'==.
bysort hhid0`i': egen mjob0`i'=max(femalespousejob0`i') 
gen motherjob0`i'=mjob0`i' if p0`i'0102>=11 & p0`i'0102<=19
}

forvalue i=10/17{
*if respondent is household head's female spouse
gen femalespousejob`i'=.
replace femalespousejob`i'=p`i'0203 if p`i'0101==2 & p`i'0102==20
*if respondent is female household head
replace femalespousejob`i'=p`i'0203 if p`i'0101==2 & p`i'0102==10
replace femalespousejob`i'=. if femalespousejob`i'==.
bysort hhid`i': egen mjob`i'=max(femalespousejob`i') 
gen motherjob`i'=mjob`i' if p`i'0102>=11 & p`i'0102<=19
}
drop female* mjob*

forvalue i=1/9{
*if respondent is household head's son's female spouse
gen femalespousejob0`i'=.
forvalue j=1/9{
replace femalespousejob0`i'=p0`i'0203 if p0`i'0101==2 & p0`i'0102==2`j' 
*if respondent is household head's daugter 
replace femalespousejob0`i'=p0`i'0203 if p0`i'0101==2 & p0`i'0102==1`j'
}
replace femalespousejob0`i'=. if femalespousejob0`i'==.
bysort hhid0`i': egen mjob0`i'=max(femalespousejob0`i') 
gen motherjob0`i'x=.
forvalue j=1/9{
replace motherjob0`i'x=mjob0`i' if p0`i'0102>=1`j'1 & p0`i'0102<=1`j'9
}
}

forvalue i=10/17{
*if respondent is household head's son's female spouse
gen femalespousejob`i'=.
forvalue j=1/9{
replace femalespousejob`i'=p`i'0203 if p`i'0101==2 & p`i'0102==2`j' 
*if respondent is household head's daugter 
replace femalespousejob`i'=p`i'0203 if p`i'0101==2 & p`i'0102==1`j'
}
replace femalespousejob`i'=. if femalespousejob`i'==.
bysort hhid`i': egen mjob`i'=max(femalespousejob`i') 
gen motherjob`i'x=.
forvalue j=1/9{
replace motherjob`i'x=mjob`i' if p`i'0102>=1`j'1 & p`i'0102<=1`j'9
}
}
drop female* mjob*

forvalue i=1/9{
replace motherjob0`i'=motherjob0`i'x if motherjob0`i'==.
}
forvalue i=10/17{
replace motherjob`i'=motherjob`i'x if motherjob`i'==.
}

drop motherjob01x-motherjob17x

fsum motherjob01-motherjob17
