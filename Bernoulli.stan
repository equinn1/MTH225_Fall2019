//Estimate the probability of success in a Bernoulli distribution
data {
  int N;                       //sample size
  int<lower=0,upper=1> y[N];   //y consists of N binary values
}
parameters {
  real<lower=0,upper=1> theta; //theta is constrained to be between 0 and 1
}
model {
  theta ~ beta(1,1);           //equivalent to uniform(0,1) 
  
  y     ~ bernoulli(theta);    //Bernoulli likelihood given parameter theta
}
