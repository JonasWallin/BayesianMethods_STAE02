library(rstan)

# in the data.list you must have all the data with the correct name
Y <- c( 3,  5,  7,  9, 10, 18,  6, 14, 11,
        9, 5, 11, 15,  6, 11, 17, 12, 15,  8,  4)
data.list <- list( Y = Y, 
                   n = length(Y),
                   alpha = 1,
                   beta  = 0.1)
res_stan <- stan(file = "horseKick.stan", 
                 data = data.list, 
                 iter = 4000, 
                 chains = 2, 
                 cores  = 2 )
stan_hist(res_stan, par = "theta")
summary(res_stan)
theta_samples <- extract(res_stan,par="theta")$theta #take the actual output
theta_plot <- stan_hist(res_stan, par = "exptheta") + xlab("exp(theta)")
ggsave("theta_hist2.png")