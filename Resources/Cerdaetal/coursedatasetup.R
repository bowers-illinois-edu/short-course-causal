## Merge neighborhood level covariates and neighborhood level outcomes for use in a Matching short course

rm(list=ls()) ## clear existing data
load("RIoutcomeAnalysisv3.RData")
load("nhData.rda")
row.names(nhData)<-as.character(nhData$nh03)

stopifnot(all.equal(row.names(DiDRE),row.names(nhData)))

meddat<-cbind(nhData,DiDRE[,c("BE","CE","PV","QP","TP","hom")])

save(meddat,file="meddat.rda")

