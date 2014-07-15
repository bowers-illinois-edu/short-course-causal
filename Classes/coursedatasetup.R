## Merge neighborhood level covariates and neighborhood level outcomes for use in a Matching short course

rm(list=ls()) ## clear existing data
load("../Resources/Cerdaetal/RIoutcomeAnalysisv3.RData")
load("../Resources/Cerdaetal/nhData.rda")
row.names(nhData)<-as.character(nhData$nh03)
stopifnot(all.equal(row.names(DiDRE),row.names(nhData)))
meddat<-cbind(nhData,DiDRE[,c("BE","CE","PV","QP","TP","hom")])


## Add the actual homicide counts
load("../Resources/Medellin/dataPrep/2010-10/homd.rda")
homd2008<-subset(homd,year==2008,select=c("nh","year","Count","Pop"))
homd2003<-subset(homd,year==2003,select=c("nh","year","Group","Count","Pop"))
row.names(homd2008)<-as.character(homd2008$nh)
row.names(homd2003)<-as.character(homd2003$nh)
names(homd2008)<-c("nh","year","HomCount2008","Pop2008")
names(homd2003)<-c("nh","year","Group","HomCount2003","Pop2003")
stopifnot(all.equal(row.names(homd2008),row.names(homd2003)))
homd0308<-cbind(homd2003,homd2008[,c("HomCount2008","Pop2008")])

# Now we only have the homicide counts for 45/48 neighborhoods, so restrict analysis to them.

meddat<-meddat[row.names(homd0308),]

stopifnot(all.equal(row.names(homd0308),row.names(meddat)))

meddat<-cbind(meddat,homd0308)

save(meddat,file="meddat.rda")
write.csv(meddat,file="meddat.csv")

