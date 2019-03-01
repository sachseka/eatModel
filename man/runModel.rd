\name{runModel}
\alias{runModel}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Run IRT model specified by 'defineModel' using Conquest or TAM}
\description{Start the estimation of an IRT model defined by \code{defineModel}. \code{runModel} 
should be called with the argument returned by \code{defineModel}.}
\usage{
runModel(defineModelObj, show.output.on.console = FALSE, 
    show.dos.console = TRUE, wait = TRUE) }
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{defineModelObj}{
%%     ~~Describe \code{file} here~~
The object returned by \code{defineModel}.
}
  \item{show.output.on.console}{
%%     ~~Describe \code{dif.term} here~~
Applies only if \code{defineModel} previously was called with \code{software = "conquest"}.
Logical: Should the output of the conquest console be printed on the R console during estimation?
}
  \item{show.dos.console}{
%%     ~~Describe \code{split.dif} here~~
Applies only if \code{defineModel} previously was called with \code{software = "conquest"}.
Logical: Should the output of the conquest console be printed on screen?
}
  \item{wait}{
%%     ~~Describe \code{abs.dif.bound} here~~
Applies only if \code{defineModel} previously was called with \code{software = "conquest"}.
A logical (not NA) indicating whether the R interpreter should wait for the command to finish,
or run it asynchronously.
}
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
If \code{defineModel} previously was called with \code{software = "tam"}, the returned value
is identically to the corresponding TAM output. If \code{defineModel} previously was called
with \code{software = "conquest"}, the returned value contains only internally used information
useful for \code{getResults}.
}
\author{
Sebastian Weirich
}
\examples{
# see examples in the help file of defineModel()
}
