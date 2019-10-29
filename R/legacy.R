#' Find connected explanatory SNPs.
#' 
#' @description Finds the SNPs maximally associated with a phenotype while being
#'  connected in an underlying network (Azencott et al., 2013).
#' 
#' @param gwas A SnpMatrix object with the GWAS information.
#' @param net An igraph network that connects the SNPs.
#' @param encoding SNP encoding. Possible values: additive (default), resessive,
#' dominant, codominant.
#' @param sigmod Boolean. If TRUE, use the Sigmod variant of SConES, meant to 
#' prioritize tightly connected clusters of SNPs.
#' @param ... Extra arguments for \code{\link{get_evo_settings}}.
#' @return A copy of the \code{SnpMatrix$map} \code{data.frame}, with the 
#' following additions:
#' \itemize{
#' \item{C: contains the univariate association score for every single SNP.}
#' \item{selected: logical vector indicating if the SNP was selected by SConES 
#' or not.}
#' \item{module: integer with the number of the module the SNP belongs to.}
#' }
#' @references Azencott, C. A., Grimm, D., Sugiyama, M., Kawahara, Y., & 
#' Borgwardt, K. M. (2013). Efficient network-guided multi-locus 
#' association mapping with graph cuts. Bioinformatics, 29(13), 171-179. 
#' \url{https://doi.org/10.1093/bioinformatics/btt238}
#' @importFrom igraph simplify as_adj
#' @importFrom Matrix diag rowSums
#' @importFrom methods as
#' @examples
#' gi <- get_GI_network(minigwas, snpMapping = minisnpMapping, ppi = minippi)
#' search_cones(minigwas, gi)
#' search_cones(minigwas, gi, encoding = "recessive")
#' search_cones(minigwas, gi, associationScore = "skat")
#' @export
search_cones <- function(gwas, net, encoding = "additive", sigmod = FALSE, ...) {
  
  colnames(gwas[["map"]]) <- c("chr","snp","cm","pos","allele.1", "allele.2")
  X <- as(gwas[['genotypes']], "numeric")
  X <- encode_gwas(X, encoding)
  Y <- gwas[['fam']][['affected']]
  
  # remove redundant edges and self-edges
  net <- simplify(net)
  W <- as_adj(net, type="both", sparse = TRUE, attr = "weight")
  diag(W) <- ifelse(sigmod, -rowSums(W), 0)
  
  # order according to order in map
  W <- W[gwas[["map"]][['snp']], gwas[["map"]][['snp']]]
  
  settings <- get_evo_settings(...)
  
  test <- evo(X, Y, W, settings)
  cat("eta =", test[['eta']], "\nlambda =", test[['lambda']], "\n")
  
  cones <- gwas[["map"]]
  cones[['c']] <- test[['c']]
  cones[['selected']] <- as.logical(test[['selected']])
  
  cones <- get_snp_modules(cones, net)
  
  return(cones)
  
}

#' Get evo settings.
#' 
#' @description Creates a list composed by all \code{evo} settings, with the 
#' values provided by the user, or the default ones if none is provided.
#' @param associationScore Association score to measure association between 
#' genotype and phenotype. Possible values: chi2 (default), glm.
#' @param modelScore Model selection criterion Possible values: consistency, 
#' bic (default), aic, aicc, mbic.
#' @param etas Numeric vector with the etas to explore in the grid search. If 
#' ommited, it's automatically created based on the association
#' scores.
#' @param lambdas Numeric vector with the lambdas to explore in the grid search.
#' If ommited, it's automatically created based on the association scores.
#' @param debug Display additional information. Possible values: TRUE, FALSE
#' (default).
#' @return A list of \code{evo} settings.
#' @examples 
#' martini:::get_evo_settings()
#' martini:::get_evo_settings(associationScore = "skat")
#' @keywords internal
get_evo_settings <- function(associationScore = "chi2", modelScore = "bic", 
                             etas = numeric(), lambdas = numeric(), 
                             debug = FALSE){
  
  settings <- list()
  
  # unsigned int
  settings[['associationScore']] <- switch(associationScore, skat = 0, chi2 = 1)
  if (length(settings[['associationScore']]) == 0) {
    stop(paste("Error: invalid associationScore", associationScore))
  }
  
  # unsigned int
  settings[['modelScore']] <- switch(modelScore, consistency = 0, bic = 1, 
                                     aic = 2, aicc = 3, mbic = 4)
  if (length(settings[['modelScore']]) == 0) {
    stop(paste("Error: invalid modelScore", modelScore))
  }
  
  # bool
  if (! is.logical(debug)) {
    stop("Error: debug must be logical.")
  } else {
    settings[['debug']] <- debug;
  }
  
  # VectorXd
  if (!is.numeric(etas)){
    stop("Error: etas must be numeric")
  } else {
    settings[['etas']] <- etas
  }
  
  # VectorXd
  if (!is.numeric(lambdas)){
    stop("Error: lambdas must be numeric")
  } else {
    settings[['lambdas']] <- lambdas
  }
  
  return(settings);
  
}

#' Change encoding of dataset
#' 
#' @description Converts the encoding from additive to another one.
#' 
#' @param X Genotype matrix with SNPs encoded as 0 for major homozygous, 1 for
#' heterozygous and 2 for minor homozygous.
#' @param encoding Genetic model assumed: additive, recessive, dominant or
#' codominant.
#' @return A genotype matrix 
#' @examples 
#' X <- as(minigwas[["genotypes"]], "numeric")
#' martini:::encode_gwas(X, "recessive")
#' @keywords internal
encode_gwas <- function(X, encoding) {
  
  if (! encoding %in% c("additive", "recessive", "dominant", "codominant")) {
    stop("Invalid encoding.", call. = FALSE)
  }
  
  code <- data.frame(e = c('additive', 'recessive', 'dominant', 'codominant'),
                     AA = c(0,0,0,0),
                     AB = c(1,0,1,1),
                     BB = c(2,1,1,0))
  
  X[X == 0] <- code[code$e == encoding, 'AA']
  X[X == 1] <- code[code$e == encoding, 'AB']
  X[X == 2] <- code[code$e == encoding, 'BB']
  
  return(X)
  
}