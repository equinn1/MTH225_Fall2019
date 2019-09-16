//Estimate the probability of success in a Bernoulli distribution
data {
  int N;                       //sample size
  vector[N] y;   //y consists of N binary values
}
parameters {
  real mu;                // mean
  real<lower=0> sigma;    //sd
}
model {
  mu ~ normal(0,200);           //broad Gaussian for mu prior
  sigma ~ cauchy(0,10);         //Cauchy for sigma prior 
  
  y     ~ normal(mu,sigma);   
}
