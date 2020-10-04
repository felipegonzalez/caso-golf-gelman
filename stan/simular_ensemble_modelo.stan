functions {
  real prob(real x, real sigma) {
    return 2 * normal_cdf(atan(3.25 / x), 0, sigma) - 1;
  }
}

data {
  int p; // Número de cubetas
  int x[p]; // Distancia para cubeta
  int n[p]; // Número de intentos en cada cubeta
  real gamma_pars[2];
}

generated quantities {
  real<lower=0, upper=1> prob_exito[p];
  int exitos[p];
  real sigma = gamma_rng(gamma_pars[1], gamma_pars[2]);
  for(i in 1:p){
    prob_exito[i] = prob(x[i], sigma); 
    exitos[i] = binomial_rng(n[i], prob_exito[i]);
  }
}