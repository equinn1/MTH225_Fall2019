library(boot)
#rm(list=ls())
nboot <- 10000 # Number of simulations
alpha <- .05 # alpha level
n <- 200 # sample size
mu <- 40
sigma <- 15
bootThetaQuantile <- function(x,i) {
  quantile(x[i], probs=.5)
}

bootThetaMean <- function(x,i) {
  mean(x[i])
}

raw <- rnorm(n,mu, sigma) # raw data
theta.boot.median <- boot(raw, bootThetaQuantile, R=nboot) 
boot.ci(theta.boot.median, conf=(1-alpha))

theta.boot.mean <- boot(raw, bootThetaMean, R=nboot) 
boot.ci(theta.boot.mean, conf=(1-alpha))

my.replicate <- replicate(nboot, raw[sample(1:length(raw), n, replace=TRUE)])

# Bootstrap
theta.median <- apply(my.replicate, 2, bootThetaQuantile)
theta.mean <- apply(my.replicate, 2, bootThetaMean)

hist(theta.median, xlim=c(35,45), nclass=50, col=3, main="Histogram of Bootstrap Confidence Intervals for Median")
hist(theta.mean, xlim=c(35,45), nclass=50, col=3, main="Histogram of Bootstrap Confidence Intervals for Mean")

sort(theta.median)[nboot*alpha/2]
sort(theta.median)[nboot*(1-alpha/2)]

sort(theta.mean)[nboot*alpha/2]
sort(theta.mean)[nboot*(1-alpha/2)]

### Randomly generated data
my.replicate <- replicate(nboot, rnorm(n,mu,sigma))

nrow(my.replicate)
ncol(my.replicate)

theta.rand.median <- apply(my.replicate, 2, bootThetaQuantile)
theta.rand.mean <- apply(my.replicate, 2, bootThetaMean)

ci.u <- mean(theta.rand.mean)+qnorm(1-alpha/2)*sd(raw)/sqrt(n)
ci.l <- mean(theta.rand.mean)-qnorm(1-alpha/2)*sd(raw)/sqrt(n)

hist(theta.rand.median, xlim=c(35,45), nclass=100, col=3, main="Histogram of Randomly Generated Data for Medians")

hist(theta.rand.mean, xlim=c(35,45), nclass=50, col=3, main="Histogram of Randomly Generated Data for Means")
abline(v=c(ci.u,ci.l))

