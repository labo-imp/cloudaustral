options(repos = c("https://cloud.r-project.org/"))
options(Ncpus = 4)

library("devtools")
install_github("lantanacamara/lightgbmExplainer", INSTALL_opts="--no-multiarch" )

quit( save="no" )
