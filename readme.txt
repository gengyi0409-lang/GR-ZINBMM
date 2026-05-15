GR-ZINBMM: A graph-regularized zero-inflated negative binomial mixture model for identifying cell type from scRNA-seq data

The R code contains the main functions of GR-ZINBMM, as well as experiments based on two real datasets.

human_res <- grzinbmm(human_data, K = 6, 
                 top_k_graph = 50, lambda1 = 0.1, lambda2 = 0.2,
                 max_iter = 100, inner_beta_steps = 100, verbose = TRUE)

muraro_res <- grzinbmm(muraro_data, K = 10, 
                top_k_graph = 50, lambda1 = 0.1, lambda2 = 0.1,
                max_iter = 100, inner_beta_steps = 100, verbose = TRUE)