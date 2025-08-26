options(repos = c("https://cloud.r-project.org/"))
options(Ncpus = 4)

paq1 <- c("yaml", "rlist","microbenchmark")
paq2 <- c("magrittr", "stringi", "curl", "Rcpp", "Matrix", "glm2")
paq3 <- c("ROCR", "MASS", "openssl", "roxygen2", "synchronicity")
paq4 <- c("rsvg", "DiagrammeRsvg", "DiagrammeR", "modules")
paq5 <- c("DiceKriging",  "mlrMBO", "ParBayesianOptimization")
paq6 <- c("rpart", "rpart.plot", "ranger", "randomForest", "mice")
paq7 <- c("dplyr", "caret", "tidyr", "shiny", "languageserver")
paq8 <- c("SHAPforxgboost", "shapr", "mlflow", "visNetwork")
paq9 <- c("iml","primes","ggplot2","plotly","RhpcBLASctl")
paq10 <- c("mlr3","mlr3mbo","mlr3learners","mlr3tuning","bbotk","treeClust")
paq11 <- c("DBI","RMariaDB","filelock","Boruta","lime")
paq12 <- c("h2o","agua","automl")

paq <- c( paq1, paq2, paq3, paq4, paq5, paq6, paq7, paq8, paq9, paq10, paq11, paq12 )

install.packages( paq,  dependencies= TRUE, Ncpus= 4, INSTALL_opts="--no-multiarch" )


library( "devtools" )
install.packages("tibble", INSTALL_opts="--no-multiarch" )
devtools::install_github( "AppliedDataSciencePartners/xgboostExplainer", INSTALL_opts="--no-multiarch" )

install.packages( c("purrr","ps","diffobj","pkgbuild","fs","sass","mime","commonmark","tinytex"), dependencies= TRUE, Ncpus= 4, INSTALL_opts="--no-multiarch" )
devtools::install_github( "NorskRegnesentral/shapr", dependencies = TRUE, INSTALL_opts="--no-multiarch" )

devtools::install_url('https://github.com/catboost/catboost/releases/download/v1.2.8/catboost-R-Linux-1.2.8.tgz', INSTALL_opts = c("--no-multiarch", "--no-test-load"))

devtools::install_github("ManuelHentschel/vscDebugger", INSTALL_opts="--no-multiarch" )

devtools::install_github("ja-thomas/autoxgboost", INSTALL_opts="--no-multiarch" )

Sys.setenv(NOT_CRAN = "true")
install.packages("polars", repos = "https://community.r-multiverse.org", INSTALL_opts="--no-multiarch" )

quit( save="no" )
