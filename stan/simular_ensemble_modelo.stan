data {
  int p; // Número de cubetas
  int x[p]; // Distancia para cubeta
  int n[p]; // Número de intentos en cada cubeta
  real beta_0_pars[2];
  real beta_pars[2];
}

generated quantities {
  real<lower=0, upper=1> prob_exito[p];
  int exitos[p];
  real beta_0 = normal_rng(beta_0_pars[1], beta_0_pars[2]);
  real beta = normal_rng(beta_pars[1], beta_pars[2]);
  for(i in 1:p){
    prob_exito[i] = inv_logit(beta_0 - beta * x[i]); 
    exitos[i] = binomial_rng(n[i], prob_exito[i]);
  }
}