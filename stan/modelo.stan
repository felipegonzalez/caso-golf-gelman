// Modelo de regresión logística para tiros de golf

data {
  // observaciones
  int p; // Número de cubetas
  int x[p]; // Distancia para cubeta
  int n[p]; // Número de intentos en cada cubeta
  int exitos_obs[p]; // Número de exitos en cada cubeta
  real beta_0_pars[2];
  real beta_pars[2];
}

parameters {
  real<lower=0> beta_0;
  real<lower=0> beta;
}

transformed parameters {
  real<lower=0, upper=1> prob_exito[p];
  for(i in 1:p) {
   prob_exito[i] = inv_logit(beta_0 - beta * x[i]); 
  }
}

model {
  //iniciales
  beta_0 ~ normal(beta_0_pars[1], beta_0_pars[2]);
  beta ~ normal(beta_pars[1], beta_pars[2]);
  //observaciones
  for(i in 1:p){
    exitos_obs[i] ~ binomial(n[i], prob_exito[i]);
  }
}

generated quantities {
  real prob_sim[p];
  for(i in 1:p){
    prob_sim[i] = binomial_rng(n[i], prob_exito[i]);
    prob_sim[i] = prob_sim[i] / n[i];
  }
}

