
## Load the Medellin data from the web
## load(url("http://jakebowers.org/Matching/meddat.rda"))

meddat<-read.csv(url("http://jakebowers.org/Matching/meddat.csv"))

estate<-with(meddat,mean(PV[nhTrt==1])-mean(PV[nhTrt==0]))

## A simulation based method to show that the difference of observed means is an 
## unbiased estimator of the difference of partially observed potential outcome means.

y0<-meddat$PV ## we could have also use y0<-rnorm(48) or something else
y1<-y0-.82

newexperiment<-function(origZ,y1,y0){
  Znew<-sample(origZ)
  Y<-Znew*y1+(1-Znew)*y0
  epthat<-mean(Y[Znew==1] - mean(Y[Znew==0]))
  return(epthat)
}

## set.seed(123456) ## if we uncomment set.seed, everyone should have the
## exact same answer
randdist<-replicate(1000,newexperiment(origZ=meddat$nhTrt,y1=y1,y0=y0))
randdist2<-replicate(1000,newexperiment(origZ=meddat$nhTrt,y1=y1,y0=y0))
randdist3<-replicate(10000,newexperiment(origZ=meddat$nhTrt,y1=y1,y0=y0))
randdist4<-replicate(50000,newexperiment(origZ=meddat$nhTrt,y1=y1,y0=y0))

summary(randdist)

plot(density(randdist))
rug(randdist)
rug(1,ticksize=.3,lwd=2,col="blue")
rug(mean(randdist),ticksize=.3,lwd=2,col="red")


## Testing


newTestStat<-function(Y,Z){
  Znew<-sample(Z)
  mean(Y[Znew==1])-mean(Y[Znew==0])
}

nullDist<-replicate(1000,newTestStat(Y=meddat$PV,Z=meddat$nhTrt))

obsTestStat<-with(meddat,mean(PV[nhTrt==1])-mean(PV[nhTrt==0]))

oneSidedP<-mean(nullDist<=obsTestStat)

oneSidedP

newTestStatRank<-function(Y,Z){
  Znew<-sample(Z)
  rankY<-rank(Y)
  mean(rankY[Znew==1])-mean(rankY[Znew==0])
}

nullDistRank<-replicate(1000,newTestStatRank(Y=meddat$PV,Z=meddat$nhTrt))

obsTestStatRank<-with(meddat,{rankPV<-rank(PV);
                              mean(rankPV[nhTrt==1])-mean(rankPV[nhTrt==0])})

nullDistRank<-replicate(1000,newTestStatRank(Y=meddat$PV,Z=meddat$nhTrt))

oneSidedPRank<-mean(nullDistRank<=obsTestStatRank)

oneSidedPRank

