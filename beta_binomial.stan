//Estimate the probability of success in a Bernoulli distribution
data {
  int<lower=0>         n;   //number of Bernoulli trials
  int<lower=0,upper=n> y;   //y consists of N binary values
}
parameters {
  real<lower=0,upper=1> p;          //probability of success
}
model {
  p ~ beta(1,1);           //broad Gaussian for mu prior
  
  y     ~ binomial(n,p);   
}
