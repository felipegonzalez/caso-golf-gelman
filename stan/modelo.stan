// Modelo de regresión logística para tiros de golf

data {
  // observaciones
  int p; // Número de cubetas
  int x[p]; // Distancia para cubeta
  int n[p]; // Número de intentos en cada cubeta
  int exitos_obs[p]; // Número de exitos en cada cubeta
}

parameters {
  real<lower=0> beta_0;
  real<lower=0> beta;
}

transformed parameters {
  real<lower=0, upper=1> prob_exito[p];
  for(i in 1:p) {
   prob_exito[p] = inv_logit(beta_0 + beta * x[p]); 
  }
}

model {
  //iniciales
  beta_0 ~ normal(8, 1);
  beta ~ normal(0.015, 0.0025);
  //observaciones
  for(i in 1:p){
    exitos_obs[p] ~ binomial(n[p], prob_exito[p]);
  }
}

generated quantities {
  
}
