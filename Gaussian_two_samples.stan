//Estimate the probability of success in a Bernoulli distribution
data {
  int N;                          //sample size
  vector[N] y;                    //y consists of N normal variates
  int<lower=1,upper=2> group[N];  //group - 1 or 2
}
parameters {
  real mu[2];                     // mean
  real<lower=0> sigma[2];         //sd
}
model {
  mu ~ normal(0,200);           //broad Gaussian for mu prior
  sigma ~ cauchy(0,10);         //Cauchy for sigma prior 
  
  for (i in 1:N) {
    y[i] ~ normal(mu[group[i]],sigma[group[i]]);
  }
}
