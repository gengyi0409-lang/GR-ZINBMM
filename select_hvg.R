select_hvg <- function(counts_raw, nHVG = 1000) {
  gene_sums <- rowSums(counts_raw)
  keep_genes <- which(gene_sums > 0)
  if (length(keep_genes) == 0) stop("All genes are zero.")
  counts_filtered <- counts_raw[keep_genes, , drop = FALSE]
  
  gene_means <- rowMeans(counts_filtered)
  gene_vars  <- apply(counts_filtered, 1, var)
  valid_idx <- which(gene_means > 0 & gene_vars >= 0)
  if (length(valid_idx) == 0) stop("No valid genes after filtering.")
  
  df2 <- data.frame(mean = gene_means[valid_idx], var = gene_vars[valid_idx])
  
  if (nrow(df2) < 10) {
    hvg_score <- df2$var
  } else {
    fit <- tryCatch({
      loess(log(var) ~ log(mean), data = df2, span = 0.3)
    }, error = function(e) {
      NULL
    })
    if (is.null(fit)) {
      hvg_score <- df2$var
    } else {
      hvg_score <- log(df2$var) - predict(fit)
    }
  }
  
  top_n <- min(nHVG, length(hvg_score))
  ranked_idx <- order(hvg_score, decreasing = TRUE)[1:top_n]
  rownames(counts_filtered)[valid_idx[ranked_idx]]
}