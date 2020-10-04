simular_ensemble <- function(modelo_archivo, sim_datos, R = 1000){
  # compilar
  ruta <- file.path(modelo_archivo)
  mod_sim_logistico <- cmdstan_model(ruta)
  # simular
  ensemble_1 <- mod_sim_logistico$sample(
    data = sim_datos,
    iter_sampling = R, iter_warmup = 0, 
    chains = 1,
    refresh = R, seed = 432,
    fixed_param = TRUE
  )
  ensemble_1
}

ajustar_modelo <- function(modelo_archivo, datos, iter_sampling = 2000, iter_warmup = 2000){
  ruta <- file.path(modelo_archivo)
  modelo <- cmdstan_model(ruta)
  ajuste <- modelo$sample(data = datos, 
                          seed = 2210,
                          iter_sampling = iter_sampling, iter_warmup = iter_sampling,
                          refresh = 0, 
                          show_messages = FALSE)
  ajuste
}

curvas_exito <- function(sims, sim_data){
  exitos <- sims$draws("exitos") %>% as_draws_df %>% 
    mutate(rep = 1:1000) %>% 
    pivot_longer(cols = starts_with("exitos"))
  sim_data_tbl <- tibble(x = sim_data$x, n = sim_data$n, id = 1:7) %>% 
    mutate(name = paste0("exitos[", id, "]"))
  exitos_tbl <- exitos %>% left_join(sim_data_tbl) %>% 
    mutate(prop_exitos = value / n)
  exitos_tbl
}