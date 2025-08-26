options(repos = c("https://cloud.r-project.org/"))
options(Ncpus = 4)

install.packages( c("duckdb","duckplyr"),  dependencies= TRUE, Ncpus= 4)


quit( save="no" )
