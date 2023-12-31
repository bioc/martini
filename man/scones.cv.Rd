% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/scones.R
\name{scones.cv}
\alias{scones.cv}
\title{Find connected explanatory SNPs.}
\usage{
scones.cv(
  gwas,
  net,
  covars = data.frame(),
  score = c("chi2", "glm", "r2"),
  criterion = c("stability", "bic", "aic", "aicc", "global_clustering",
    "local_clustering"),
  etas = numeric(),
  lambdas = numeric(),
  family = c("binomial", "poisson", "gaussian", "gamma"),
  link = c("logit", "log", "identity", "inverse"),
  max_prop_snp = 0.5
)
}
\arguments{
\item{gwas}{A SnpMatrix object with the GWAS information.}

\item{net}{An igraph network that connects the SNPs.}

\item{covars}{A data frame with the covariates. It must contain a column 
'sample' containing the sample IDs, and an additional columns for each 
covariate.}

\item{score}{Association score to measure association between genotype and 
phenotype. Possible values: chi2 (default), glm.}

\item{criterion}{String with the function to measure the quality of a split.}

\item{etas}{Numeric vector with the etas to explore in the grid search. If 
ommited, it's automatically created based on the association
scores.}

\item{lambdas}{Numeric vector with the lambdas to explore in the grid search.
If ommited, it's automatically created based on the association scores.}

\item{family}{A string defining the generalized linear model family. This 
should match one of "binomial", "poisson", "gaussian" or "gamma". See
\link[snpStats]{snp.rhs.tests} for details.}

\item{link}{A string defining the link function for the GLM. This should
match one of "logit", "log", "identity" or "inverse". See 
\link[snpStats]{snp.rhs.tests} for details.}

\item{max_prop_snp}{Maximum proportion of SNPs accepted in the model (between 0 and 1). Larger solutions will be discarded.}
}
\value{
A copy of the \code{SnpMatrix$map} \code{data.frame}, with the 
following additions:
\itemize{
\item{c: contains the univariate association score for every single SNP.}
\item{selected: logical vector indicating if the SNP was selected by SConES 
or not.}
\item{module: integer with the number of the module the SNP belongs to.}
}
}
\description{
Finds the SNPs maximally associated with a phenotype while being
connected in an underlying network. Select the hyperparameters by
cross-validation.
}
\examples{
gi <- get_GI_network(minigwas, snpMapping = minisnpMapping, ppi = minippi)
scones.cv(minigwas, gi)
scones.cv(minigwas, gi, score = "glm")
}
\references{
Azencott, C. A., Grimm, D., Sugiyama, M., Kawahara, Y., &
Borgwardt, K. M. (2013). Efficient network-guided multi-locus association
mapping with graph cuts. Bioinformatics, 29(13), 171-179.
\url{https://doi.org/10.1093/bioinformatics/btt238}
}
