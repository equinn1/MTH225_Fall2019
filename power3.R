N1 =200
N2 =200
N = N1+N2
mu=c(45,40)
dif=abs(mu[1]-mu[2])
sigma=c(25,25)

group= c(rep(1,N1),rep(2,N2))

y = rnorm(N,mu[group],sigma[group])         

df = data.frame(group,y)

boxplot(y~group)

y1 = y[1:N1]
y2 = y[(N1+1):N]

t = t.test(y1,y=y2)

replications = 10000

contains = rep(FALSE,replications)
plt_05   = rep(FALSE,replications)

degf = c(rep(45,N1),rep(40,N2))

for (i in 1:replications){
#  y = rnorm(N,mu[group],sigma[group])
  y = rchisq(N,degf)
  y1 = y[1:N1]
  y2 = y[(N1+1):N]
  t = t.test(y1,y=y2,conf.level=0.95)
  if ((t$conf.int[1]<dif) && (t$conf.int[2]>dif)) contains[i]=TRUE
  if (t$p.value < .05) plt_05[i]=TRUE
}

mean(contains)
mean(plt_05)
