options(repos = c("https://cloud.r-project.org/"))
options(Ncpus = 4)

install.packages("devtools", INSTALL_opts="--no-multiarch" )
library( "devtools" )
devtools::install_github("IRkernel/IRkernel", force=TRUE, INSTALL_opts="--no-multiarch" )
library( "IRkernel" )
IRkernel::installspec()
quit( save="no" )
