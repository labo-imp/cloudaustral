options(repos = c("https://cloud.r-project.org/"))
options(Ncpus = 4)

install.packages( "data.table",  dependencies= TRUE, INSTALL_opts="--no-multiarch" )
install.packages( "rpart",  dependencies= TRUE, INSTALL_opts="--no-multiarch" )
install.packages( "yaml",  dependencies= TRUE, INSTALL_opts="--no-multiarch" )
install.packages( "mlflow",  dependencies= TRUE, INSTALL_opts="--no-multiarch" )
install.packages( "httr",  dependencies= TRUE, INSTALL_opts="--no-multiarch" )

install.packages( "devtools",  dependencies= TRUE, INSTALL_opts="--no-multiarch" )


library( "devtools" )
devtools::install_github("IRkernel/IRkernel", force=TRUE, INSTALL_opts="--no-multiarch" )
devtools::install_github("krlmlr/ulimit", force=TRUE, INSTALL_opts="--no-multiarch" )

quit( save="no" )