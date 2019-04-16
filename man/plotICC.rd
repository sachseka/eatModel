\name{plotICC}
\alias{plotICC}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Plots item charactestic curves.}
\description{Function provides item characteristic plots for each item. To date, 
only dichotomouls 1pl and 2pl models are supported.}
\usage{plotICC  ( resultsObj, defineModelObj, item = NULL, personPar = c("WLE", "EAP", "PV"),
       personsPerGroup = 30, pdfFolder = NULL, smooth = 7 )}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{resultsObj}{
%%     ~~Describe \code{file} here~~
The object returned by \code{getResults}. 
}
  \item{defineModelObj}{
%%     ~~Describe \code{file} here~~
The object returned by \code{defineModel}. 
}
  \item{item}{
%%     ~~Describe \code{file} here~~
Optional: The item for which the ICC should be plotted. If NULL, ICCs of all items
will be collected in a common pdf. The \code{pdfFolder} argument than must not be NULL.
}
  \item{personPar}{
Which person parameter should be used for plotting? To mimic the
behavior of the S3 plot method of \code{TAM}, use \code{"WLE"}.
}
  \item{personsPerGroup}{
%%     ~~Describe \code{file} here~~
Specifies the number of persons in each interval of the theta scale for dividing the 
persons in various groups according to mean EAP score. 
}
  \item{pdfFolder}{
%%     ~~Describe \code{file} here~~
Optional: A folder with writing access for the pdf file. Necessary only if ICCs for more
than one item should be plotted.
}
  \item{smooth}{
%%     ~~Describe \code{file} here~~
Optional: A parameter (integer value) for smoothing the plot. If the number of examinees is high, the
icc plot may become scratchy. \code{smooth} defines the maximum number of discret nodes
across the theta scale for evaluating the icc. Higher values result in a less smooth icc. To mimic the
behavior of the S3 plot method of \code{TAM}, use the value 7.
}
}
\author{
Sebastian Weirich
}
\note{
This function is beta! Use with care...
}
\examples{
data(sciences)

# first reshape the data set into wide format
datW <- reshape2::dcast(sciences, id+grade+sex~variable, value.var="value")

# defining the model: specifying q matrix is not necessary
mod1 <- defineModel(dat=datW, items= -c(1:3), id="id", software = "tam")

# run the model
run1 <- runModel(mod1)

# get the results
res1 <- getResults(run1)

# plot for one item 
plotICC  ( resultsObj = res1, defineModelObj = mod1, item = "BioPro13")
}
