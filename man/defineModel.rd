\name{defineModel}
\alias{defineModel}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Prepares IRT analysis for Conquest and TAM}
\description{Facilitates data analysis using the software Conquest and/or TAM. It automatically
checks data for IRT consistency, generates Conquest syntax, label, anchor and data files or
corresponding TAM call for a single model specified by several arguments in R. Finally, an
R object is created which contain the required input for Conquest or TAM. To start the estimation,
call \code{\link{runModel}} with the argument returned by \code{defineModel}.}
\usage{
defineModel (dat, items, id, splittedModels = NULL,
   irtmodel = c("1PL", "2PL", "PCM", "PCM2", "RSM", "GPCM", "2PL.groups",
   "GPCM.design", "3PL"), qMatrix=NULL, DIF.var=NULL, HG.var=NULL, group.var=NULL,
   weight.var=NULL, anchor = NULL, domainCol=NULL, itemCol=NULL, valueCol=NULL,
   check.for.linking = TRUE, minNperItem = 50, removeMinNperItem = FALSE,
   boundary = 6, remove.boundary = FALSE, remove.no.answers = TRUE,
   remove.no.answersHG = TRUE, remove.missing.items = TRUE,
   remove.constant.items = TRUE, remove.failures = FALSE,
   remove.vars.DIF.missing = TRUE, remove.vars.DIF.constant = TRUE, 
   verbose=TRUE, software = c("conquest","tam"), dir = NULL, analysis.name, 
   schooltype.var = NULL, model.statement = "item",  compute.fit = TRUE,
   pvMethod = c("regular", "bayesian"), fitTamMmlForBayesian = TRUE,
   n.plausible=5, seed = NULL,
   conquest.folder= system.file("exec", "console_Feb2007.exe", package = "eatModel"),
   constraints=c("cases","none","items"), std.err=c("quick","full","none"),
   distribution=c("normal","discrete"),
   method=c("gauss", "quadrature", "montecarlo", "quasiMontecarlo"),
   n.iterations=2000, nodes=NULL, p.nodes=2000, f.nodes=2000,converge=0.001,
   deviancechange=0.0001, equivalence.table=c("wle","mle","NULL"), use.letters=FALSE,
   allowAllScoresEverywhere = TRUE, guessMat = NULL, est.slopegroups = NULL,
   fixSlopeMat = NULL, slopeMatDomainCol=NULL, slopeMatItemCol=NULL,
   slopeMatValueCol=NULL, progress = FALSE, Msteps = NULL, increment.factor=1 ,
   fac.oldxsi=0, export = list(logfile = TRUE, systemfile = FALSE, history = TRUE,
   covariance = TRUE, reg_coefficients = TRUE, designmatrix = FALSE))}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{dat}{
%%     ~~Describe \code{file} here~~
A data frame containing all variables necessary for analysis.
}
  \item{items}{
%%     ~~Describe \code{dif.term} here~~
Names or column numbers of variables with item responses. Item response values must 
be numeric (i.e. 0, 1, 2, 3 ... ). Character values (i.e. A, B, C ... or a, b, c, ...) 
are not allowed. Class of item columns are expected to be numeric or integer. 
Columns of class \code{character} will be transformed. 
}
  \item{id}{
%%     ~~Describe \code{split.dif} here~~
Name or column number of the identifier (ID) variable.
}
  \item{splittedModels}{
%%     ~~Describe \code{dif.term} here~~
Optional: Object returned by \code{\link{splitModels}}. Definition for multiple model handling.
}
  \item{irtmodel}{
%%     ~~Describe \code{abs.dif.bound} here~~
Specification of the IRT model. The argument corresponds to the \code{irtmodel} 
argument of \code{\link[TAM]{tam.mml}}. See the help page of \code{\link[TAM]{tam.mml}} for further details.
}
  \item{qMatrix}{
%%     ~~Describe \code{abs.dif.bound} here~~
Optional: A named data frame indicating how items should be grouped to dimensions. The
first column contains the unique names of all items and should be named ``item''. The other
columns contain dimension definitions and should be named with the respective
dimension names. A positive value (e.g., 1 or 2 or 1.4) indicates the loading weight
with which an item loads on the dimension, a value of 0 indicates that the respective
item does not load on this dimension. If no q matrix is specified by the user, an
unidimensional structure is assumed.
}
  \item{DIF.var}{
%%     ~~Describe \code{sig.dif.bound} here~~
Name or column number of one grouping variable for which differential item
functioning analysis is to be done.
}
  \item{HG.var}{
Optional: Names or column numbers of one or more context variables (e.g., sex, school).
These variables will be used for latent regression model in Conquest or TAM.
}
  \item{group.var}{
Optional: Names or column numbers of one or more grouping variables. Descriptive
statistics for WLEs and Plausible Values will be computed separately for each
group in Conquest.
}
  \item{weight.var}{
%%     ~~Describe \code{sig.dif.bound} here~~
Optional: Name or column number of one weighting variable.
}
  \item{anchor}{
%%     ~~Describe \code{sig.dif.bound} here~~
Optional: A named data frame with anchor parameters. The first column contains the
names of all items which are used to be anchor items and may be named item.
The second column contains anchor parameters. Anchor items can be a subset of the
items in the dataset and vice versa. If the data frame contains more than two 
columns, columns must be named explicitly using the following arguments 
\code{domainCol}, \code{itemCol}, and \code{valueCol}.
}
  \item{domainCol}{
%%     ~~Describe \code{sig.dif.bound} here~~
Optional: Only necessary if the \code{anchor} argument was used to define
anchor parameters. Moreover, specifying \code{domainCol} is only necessary, if the
item identifiers in \code{anchor} are not unique---for example, if a specific item
occurs with two parameters, one domain-specific item parameter and one additional
``global'' item parameter. The domain column than must specify which parameter 
belongs to which domain. 
}
  \item{itemCol}{
%%     ~~Describe \code{sig.dif.bound} here~~
Optional: Only necessary if the \code{anchor} argument was used to define
anchor parameters. Moreover, specifying \code{itemCol} is only necessary, if the
\code{anchor} data frame has more than two columns. The \code{itemCol} column than 
must specify which column contains the item identifier. 
}
  \item{valueCol}{
%%     ~~Describe \code{sig.dif.bound} here~~
Optional: Only necessary if the \code{anchor} argument was used to define
anchor parameters. Moreover, specifying \code{valueCol} is only necessary, if the
\code{anchor} data frame has more than two columns. The \code{valueCol} column than 
must specify which column contains the item parameter values. 
}
  \item{check.for.linking}{
%%     ~~Describe \code{sig.dif.bound} here~~
A logical value indicating whether the items in dataset are checked for being
connected with each other via design.
}
  \item{minNperItem}{
%%     ~~Describe \code{sig.dif.bound} here~~
Numerical: A message is printed on console if an item has less valid values than the number 
defined in \code{minNperItem}.
}
  \item{removeMinNperItem}{
%%     ~~Describe \code{sig.dif.bound} here~~
Logical: Remove items with less valid responses than defined in \code{minNperItem}?
}
  \item{boundary}{
%%     ~~Describe \code{sig.dif.bound} here~~
Numerical: A message is printed on console if a subject has answered less than the number of items 
defined in boundary. 
}
  \item{remove.boundary}{
%%     ~~Describe \code{sig.dif.bound} here~~
Logical: Remove subjects who have answered less items than defined in the \code{boundary} argument?
}
  \item{remove.no.answers}{
%%     ~~Describe \code{sig.dif.bound} here~~
Logical: Should persons without any item responses being removed prior to analysis?
}
  \item{remove.no.answersHG}{
%%     ~~Describe \code{sig.dif.bound} here~~
Logical: Should persons without any responses on any background variable being removed prior to analysis?
}
  \item{remove.missing.items}{
%%     ~~Describe \code{sig.dif.bound} here~~
Logical: Should items without any item responses being removed prior to analysis?
}
  \item{remove.constant.items}{
Logical: Should items without variance being removed prior to analysis?
}
  \item{remove.failures}{
%%     ~~Describe \code{sig.dif.bound} here~~
Logical: Should persons without any correct item response (i.e., only \dQuote{0} responses) being removed prior to analysis?
}
  \item{remove.vars.DIF.missing}{
Logical: Applies only in DIF analyses. Should items without any responses in at least one 
DIF group being removed prior to analyses? Note: Conquest may crash if these items
remain in the data. 
}
  \item{remove.vars.DIF.constant}{
Logical: Applies only in DIF analyses. Should items without variance in at least one 
DIF group being removed prior to analyses? Note: Conquest may crash if these items 
remain in the data. 
}
  \item{verbose}{
A logical value indicating whether messages are printed on the R console.
}
  \item{software}{
%%     ~~Describe \code{dif.term} here~~
The desired estimation software for the analysis.
}
  \item{dir}{
%%     ~~Describe \code{dif.term} here~~
The directory in which the output will be written to. If \code{software = "conquest"}, 
\code{dir} must be specified. If \code{software = "tam"}, \code{dir} is not mandatory.
}
  \item{analysis.name}{
%%     ~~Describe \code{dif.term} here~~
A character string specifying the analysis name. If \code{software = "conquest"}, 
\code{analysis.name} must be specified. All Conquest input and output files will 
named \code{analysis.name} with their corresponding extensions. If \code{software = "tam"}, 
\code{analysis.name} is not mandatory. In the case of multiple models estimation, 
\code{split.models} automatically defines \code{analysis.name} for each model.
}
  \item{schooltype.var}{
%%     ~~Describe \code{dif.term} here~~
Optional: Name or column number of the variable indicating the school type (e.g.
academic track, non-academic track). Only necessary if \emph{p} values should be 
computed for each school type separately. 
}
  \item{model.statement}{
%%     ~~Describe \code{dif.term} here~~
Optional: Applies only if \code{software = "conquest"}. A character string given the model
statement in the Conquest syntax. If omitted, the statement is generated automatically
with respect to the defined model.
}
  \item{compute.fit}{
%%     ~~Describe \code{dif.term} here~~
Applies only if \code{software = "conquest"}. Compute item fit statistics?
}
  \item{pvMethod}{
%%     ~~Describe \code{dif.term} here~~
Applies only if \code{software = "tam"}: Specifies whether PVs should be drawn regularly
or using a Bayesian algorithm.
}
  \item{fitTamMmlForBayesian}{
%%     ~~Describe \code{dif.term} here~~
Logical, applies only if \code{software = "tam"}: If PVs are drawn using a Bayesian
algorithm, it is not necessary to fit the model via \code{\link[TAM]{tam.mml}} before. \code{fitTamMmlForBayesian}
specifies whether the model should be fitted before though. See the help page of \code{tam.pv.mcmc}
for further details.
}
  \item{n.plausible}{
%%     ~~Describe \code{dif.term} here~~
The number of plausible values which are to be drawn from the conditioning model.
}
  \item{seed}{
%%     ~~Describe \code{dif.term} here~~
Optional: Set seed value for analysis.
}
  \item{conquest.folder}{
%%     ~~Describe \code{dif.term} here~~
Applies only if \code{software = "conquest"}. A character string with path and name
of the Conquest console, for example \code{"c:/programme/conquest/console_Feb2007.exe"}.
Beginning from version 0.7.30, conquest executable file is chosen when the paclage is
loaded for the first time, so the user needn't to specify this argument afterwards.
}
  \item{constraints}{
%%     ~~Describe \code{dif.term} here~~
A character string specifying how the scale should be constrained. Possible options 
are \code{"cases"} (default), \code{"items"} and \code{"none"}. When anchor parameter are specified in 
anchor, constraints will be set to \code{"none"} automatically. In \code{TAM} the option
\code{"none"} is not allowed. (See the help file of \code{\link[TAM]{tam.mml}} for further details.)
}
  \item{std.err}{
%%     ~~Describe \code{dif.term} here~~
Applies only if \code{software = "conquest"}. A character string specifying which
type of standard error should be estimated. Possible options are \code{"full"}, \code{"quick"}
(default) and \code{"none"}. See Conquest manual pp.167 for details on standard error estimation.
}
  \item{distribution}{
%%     ~~Describe \code{dif.term} here~~
Applies only if \code{software = "conquest"}. A character string indicating the
a priori trait distribution. Possible options are \code{"normal"} (default) and \code{"discrete"}.
See Conquest manual pp.167 for details on population distributions.
}
  \item{method}{
%%     ~~Describe \code{dif.term} here~~
A character string indicating which method should be used for analysis. Possible 
options are \code{"gauss"} (default), \code{"quadrature"} and \code{"montecarlo"}. See Conquest manual 
pp.225 for details on these methods. When using \code{software = "tam"}, \code{"gauss"} and 
\code{"quadrature"} essentially leads to numerical integration, i.e TAM is called with
\code{control$snodes = 0} and with \code{control$nodes = seq(-6,6,len=nn)}, where
\code{nn} equals the number of nodes specified in the \code{nodes} argument of
\code{defineModel} (see below). When using \code{software = "tam"}, \code{"montecarlo"}
leads to calling TAM with \code{control$QMC = FALSE} and \code{snodes = nn}, where
\code{nn} equals the number of nodes specified in the \code{nodes} argument of
\code{defineModel}. When using \code{software = "tam"}, \code{"quasiMontecarlo"}
leads to calling TAM with \code{control$QMC = TRUE} and \code{snodes = nn}, where
\code{nn} equals the number of nodes specified in the \code{nodes} argument of
\code{defineModel}.
}
  \item{n.iterations}{
%%     ~~Describe \code{dif.term} here~~
An integer value specifying the maximum number of iterations for which estimation
will proceed without improvement in the deviance. 
}
  \item{nodes}{
%%     ~~Describe \code{dif.term} here~~
An integer value specifying the number of nodes to be used in the analysis. The
default value is 20. When using \code{software = "tam"}, the value specified here
leads to calling TAM with \code{nodes = 20} AND \code{snodes = 0} if \code{"gauss"} or 
\code{"quadrature"} was used in the \code{method} argument. If \code{"montecarlo"} or \code{"quasiMontecarlo"}
was used in the \code{method} argument, the value specified here leads to calling TAM with
\code{control$snodes = 20}. For numerical integration, for example,
\code{method = "gauss"} and \code{nodes = 21} (TAM default) may be appropriate. 
For quasi monte carlo integration, \code{method = "quasiMontecarlo"} and \code{nodes = 1000}
may be appropriate (TAM authors recommend to use at least 1000 nodes). 
}
  \item{p.nodes}{
%%     ~~Describe \code{dif.term} here~~
Applies only if \code{software = "conquest"}. An integer value specifying the
number of nodes that are used in the approximation of the posterior distributions,
which are used in the drawing of plausible values and in the calculation of EAP
estimates. The default value is 2000.
}
  \item{f.nodes}{
%%     ~~Describe \code{dif.term} here~~
Applies only if \code{software = "conquest"}. An integer value specifying the
number of nodes that are used in the approximation of the posterior distributions
in the calculation of fit statistics. The default value is 2000.
}
  \item{converge}{
%%     ~~Describe \code{dif.term} here~~
An integer value specifying the convergence criterion for parameter estimates.
The estimation will terminate when the largest change in any parameter estimate
between successive iterations of the EM algorithm is less than converge. The
default value is 0.001.
}
  \item{deviancechange}{
%%     ~~Describe \code{dif.term} here~~
An integer value specifiying the convergence criterion for the deviance. The
estimation will terminate when the change in the deviance between successive
iterations of the EM algorithm is less than deviancechange. The default value
is 0.0001.
}
  \item{equivalence.table}{
%%     ~~Describe \code{dif.term} here~~
Applies only if \code{software = "conquest"}. A character string specifying the
type of equivalence table to print. Possible options are \code{"wle"} (default), \code{"mle"}
and NULL.
}
  \item{use.letters}{
%%     ~~Describe \code{dif.term} here~~
Applies only if \code{software = "conquest"}. A logical value indicating whether
item response values should be coded as letters. This option can be used in partial
credit models comprising items with more than 10 categories to avoid response columns
with width 2 in Conquest.
}
  \item{allowAllScoresEverywhere}{
%%     ~~Describe \code{dif.term} here~~
Applies only if \code{software = "Conquest"}. Defines score statement generation 
in multidimensional polytomous models. Consider two dimensions, `reading' and `listening'.
In `reading', values 0, 1, 2, 3 occur. In `listening', values 1, 2, 3, 4 occur. If \code{TRUE},
values 0, 1, 2, 3, 4 are defined for both dimensions. Otherwise, values 0, 1, 2, 3
are defined for `reading', values 1, 2, 3, 4 are defined for `listening'.
}
  \item{guessMat}{
%%     ~~Describe \code{dif.term} here~~
Applies only if \code{software = "tam"} for 3PL models. A named data frame
with two columns indicating for which items a common guessing parameter should
be estimated. The first column contains the names of all items in the analysis
and should be named \code{"item"}. The second column is numerical (integer values
recommended) and allocates the items to groups. For each group of items, a
separate guessing parameter is estimated. If the value in the second columns equals
zero, the guessing parameter is fixed to zero.
}
  \item{est.slopegroups}{
%%     ~~Describe \code{dif.term} here~~
Applies only if \code{software = "tam"} for 2PL models. Optionally, a named data frame
with two columns indicating for which items a common discrimination parameter should
be estimated. The first column contains the names of all items in the analysis
and should be named \code{"item"}. The second column is numerical (integer values
recommended) and allocates the items to groups. For each group of items, a
separate discrimination parameter is estimated. Without specifying \code{est.slopegroups}, 
a discrimination parameter for each item is estimated.
}
  \item{fixSlopeMat}{
%%     ~~Describe \code{dif.term} here~~
Applies only if \code{software = "tam"} for 2PL models. Optionally, a named data frame
with two columns indicating for which items a fixed discrimination should be assumed.
The first column contains the names of the items which discrimination should be fixed. 
Note that item indicators should be unique---if not, use further arguments \code{slopeMatDomainCol}, 
\code{slopeMatItemCol} and \code{slopeMatValueCol}. The second column is numerical and contains 
the discrimination value. Note: To date, this works only for between item dimensionality models. 
Within item dimensionality models must be specified directly in TAM, using the \code{B.fixed} 
argument of \code{\link[TAM]{tam.mml}}. Items which discrimation should be estimated should not occur in this data frame.
}
  \item{slopeMatDomainCol}{
%%     ~~Describe \code{dif.term} here~~
Optional: Only necessary if the \code{fixSlopeMat} argument was used to define fixed slope
parameters. Moreover, specifying \code{slopeMatDomainCol} is only necessary, if the item 
identifiers in \code{fixSlopeMat} are not unique---for example, if a specific item occurs 
with two slope parameters, one domain-specific item slope parameter and one additional 
``global'' item parameter. The domain column than must specify which parameter belongs to which domain. 
}
  \item{slopeMatItemCol}{
%%     ~~Describe \code{dif.term} here~~
Optional: Only necessary if the \code{fixSlopeMat} argument was used to define fixed slope 
parameters. Moreover, specifying \code{itemCol} is only necessary, if the \code{fixSlopeMat} 
data frame has more than two columns. The \code{itemCol} column than must specify which column 
contains the item identifier. 
}
  \item{slopeMatValueCol}{
%%     ~~Describe \code{dif.term} here~~
Optional: Only necessary if the \code{fixSlopeMat} argument was used to define slope parameters. 
Moreover, specifying \code{valueCol} is only necessary, if the \code{fixSlopeMat} data frame has 
more than two columns. The \code{valueCol} column than must specify which column contains the item parameter values. 
}
  \item{progress}{
%%     ~~Describe \code{dif.term} here~~
Applies only if \code{software = "tam"}. Print estimation progress messages on console?
}
  \item{Msteps}{
Number of M steps for item parameter estimation. A high value of M steps could be helpful in cases of non-convergence.
The default value is 4; the default for 3pl models is set to 10.
}
  \item{increment.factor}{
%%     ~~Describe \code{dif.term} here~~
Applies only if \code{software = "tam"}. Should only be varied if the model does not converge.
See help page of \code{\link[TAM]{tam.mml}} for further details.
}
  \item{fac.oldxsi}{
%%     ~~Describe \code{dif.term} here~~
Applies only if \code{software = "tam"}. Should only be varied if the model does not converge.
See help page of \code{\link[TAM]{tam.mml}} for further details.
}
  \item{export}{
%%     ~~Describe \code{dif.term} here~~
Applies only if \code{software = "conquest"}. Specifies which additional files should be written
on hard disk.
}
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
A list which contains information about the desired estimation. The list is intended for 
further processing via \code{\link{runModel}}. Structure of the list varies depending on
whether multiple models were called using \code{\link{splitModels}} or not. If
\code{\link{splitModels}} was called, the number of elements in the list equals
the number of models defined via \code{\link{splitModels}}. Each element in the list is
a list with various elements:
  \item{software}{
Character string of the software which is intended to use for the further estimation,
i.e. \code{"conquest"} or \code{"tam"}
}
  \item{qMatrix}{
The Q matrix allocating items to dimensions.
}
  \item{all.Names}{
Named list of all relevant variables of the data set.
}
  \item{dir}{
Character string of the directory the results are to be saved. 
}
  \item{analysis.name}{
Character string of the analysis' name. 
}
  \item{deskRes}{
Data frame with descriptives (e.g., p values) of the test items. 
}
  \item{discrim}{
Data frame with item discrimination values. 
}
  \item{perNA}{
The person identifiers of examinees which are excluded from the analysis due to solely missing values.
}
  \item{per0}{
The person identifiers of examinees which have solely false responses. if \code{remove.failues} was set 
to be TRUE, these persons are excluded from the data set. 
}
  \item{perA}{
The person identifiers of examinees which have solely correct responses. 
}
  \item{perExHG}{
The person identifiers of examinees which are excluded from the analysis due to missing values on explicit variables.
}
  \item{itemsExcluded}{
Character string of items which were excluded, for example due to zero variance or solely missing values. 
}
If \code{software == "conquest"}, the output additionally includes the following elements:
  \item{input}{
Character string of the path with Conquest input (cqc) file. 
}
  \item{conquest.folder}{
Character string of the path of the conquest executable file. 
}
  \item{model.name}{
Character string of the model name. 
}
If \code{software == "tam"}, the output additionally includes the following elements:
  \item{anchor}{
Optional: data frame of anchor parameters (if anchor parameters were defined).
}
  \item{daten}{
The prepared data for TAM analysis. 
}
  \item{irtmodel}{
Character string of the used IRT model. 
}
  \item{est.slopegroups}{
Applies for 2pl modeling. Information about which items share a common slope parameter. 
}
  \item{guessMat}{
Applies for 3pl modeling. Information about which items share a common guessing parameter. 
}
  \item{control}{
List of control parameters for TAM estimation.
}
  \item{n.plausible}{
Desired number of plausible values.
}
}
\author{
Sebastian Weirich
}
\examples{
################################################################################
###               Preparation: necessary for all examples                    ###
################################################################################

# load example data
# (these are simulated achievement test data)
data(sciences)

# first reshape the data set into wide format
datW <- reshape2::dcast(sciences, id+grade+sex~variable, value.var="value")

# second, create the q matrix from the long format data frame
qMat <- sciences[ which( sciences[,"subject"] == "biology") ,c("variable","domain")]
qMat <- qMat[!duplicated(qMat[,1]),]
qMat <- data.frame ( qMat[,1,drop=FALSE],
        knowledge  = as.numeric(qMat[,"domain"] == "knowledge"),
        procedural = as.numeric(qMat[,"domain"] == "procedural"))


################################################################################
###                Example 1: Unidimensional Rasch Model                     ###
################################################################################

# Example 1: define and run a unidimensional Rasch model with all variables in dataset
# using "Conquest".

# defining the model: specifying q matrix is not necessary
mod1 <- defineModel(dat=datW, items= -c(1:3), id="id", analysis.name = "unidim",
        dir = tempdir())

# run the model
run1 <- runModel(mod1)

# get the results
res1 <- getResults(run1)

# extract the item parameters from the results object
item <- itemFromRes ( res1 ) 


################################################################################
###       Example 1a: Unidimensional Rasch Model with DIF estimation         ###
################################################################################

# nearly the same procedure as in example 1. Using 'sex' as DIF variable
# note that 'sex' is a factor variable here. Conquest needs all explicit variables
# to be numeric. Variables will be automatically transformed to numeric by 
# 'defineModels'. However, it might be the better idea to transform the variable
# manually. 
datW[,"sexNum"] <- car::recode ( datW[,"sex"] , "'male'=0; 'female'=1",
                   as.factor = FALSE)
                   
# as we have defined a new variable ('sexNum') in the data, it is a good idea 
# to explicitly specify item columns ... instead of saying 'items= -c(1:3)' which
# means: Everything except column 1 to 3 are item columns
items<- grep("^Bio|^Che|^Phy", colnames(datW))

# Caution: two items ("ChePro48", "PhyPro01") are excluded because they are 
# constant in one of the DIF groups
mod1a<- defineModel(dat=datW, items= items, id="id", DIF.var = "sexNum", 
        analysis.name = "unidimDIF", dir = tempdir())

# run the model
run1a<- runModel(mod1a)

# get the results
res1a<- getResults(run1a)


################################################################################
###        Example 2a: Multidimensional Rasch Model with anchoring           ###
################################################################################

# Example 2a: running a multidimensional Rasch model on a subset of items with latent
# regression (sex). Use item parameter from the first model as anchor parameters
# use only biology items from both domains (procedural/knowledge)

# read in anchor parameters from the results object of the first example
aPar <- itemFromRes ( res1 )
aPar <- aPar[,c("item", "est")]

# defining the model: specifying q matrix now is necessary.
# Please note that all latent regression variables have to be of class numeric.
# If regression variables are factors, dummy variables automatically will be used.
# (This behavior is equivalent as in lm() for example.)
mod2a<- defineModel(dat=datW, items= qMat[,1], id="id", analysis.name = "twodim",
        qMatrix = qMat, HG.var = "sex", anchor = aPar, n.plausible = 20,
        dir = tempdir())

# run the model
run2a<- runModel(mod2a)

# get the results
res2a<- getResults(run2a)


################################################################################
###        Example 2b: Multidimensional Rasch Model with equating            ###
################################################################################

# Example 2b: running a multidimensional Rasch model on a subset of items
# defining the model: specifying q matrix now is necessary.
mod2b<- defineModel(dat=datW, items= qMat[,1], id="id", analysis.name = "twodim2",
        qMatrix = qMat, n.plausible = 20, dir = tempdir())

# run the model
run2b<- runModel(mod2b)

# get the results
res2b<- getResults(run2b)

### equating (wenn nicht verankert)
eq2b <- equat1pl( results = res2b, prmNorm = aPar)

### transformation to the 'bista' metric: needs reference population definition
ref  <- data.frame ( domain = c("knowledge", "procedural"), m = c(0.078, -0.175),
        sd= c(1.219, 0.799))
cuts <- list ( knowledge = list ( values = c(380,540)),
               procedural = list ( values = c ( 410, 550)))
tf2b <- transformToBista ( equatingList = eq2b, refPop = ref, cuts = cuts)


################################################################################
###            Example 3: Multidimensional Rasch Model in TAM                ###
################################################################################

# Example 3: the same model in TAM
# we use the same anchor parameters from example 1

# estimate model 2 with latent regression and anchored parameters in TAM
# specification of an output folder (via 'dir' argument) no longer necessary 
mod2T<- defineModel(dat=datW, items= qMat[,1], id="id", qMatrix = qMat,
        HG.var = "sex", anchor = aPar, software = "tam")

# run the model
run2T<- runModel(mod2T)

# Object 'run2T' is of class 'tam.mml'
class(run2T)

# the class of 'run2T' corresponds to the class defined by the TAM package; all
# functions of the TAM package intended for further processing (e.g. drawing
# plausible values, plotting deviance change etc.) work, for example:
wle  <- tam.wle(run2T)

# Finally, the model result are collected in a single data frame
res2T<- getResults(run2T)


################################################################################
###    Example 4: define und run multiple models defined by 'splitModels'    ###
################################################################################

# Example 4: define und run multiple models defined by 'splitModels'
# Model split is possible for different groups of items (i.e. domains) and/or
# different groups of persons (for example, federal states within Germany)

# define person grouping
pers  <- data.frame ( idstud = datW[,"id"] , group1 = datW[,"sex"], 
         group2 = datW[,"grade"], stringsAsFactors = FALSE )

# define 18 models, splitting according to person groups and item groups separately
# by default, multicore processing is applied
l1    <- splitModels ( qMatrix = qMat, person.groups = pers, nCores = 1)

# apply 'defineModel' for each of the 18 models in 'l1'
modMul<- defineModel(dat = datW, items = qMat[,1], id = "id", 
         check.for.linking = TRUE, splittedModels = l1, software = "tam")

# run all models 
runMul<- runModel(modMul)

# get results of all models 
resMul<- getResults(runMul)


################################################################################
###          Example 5: Linking and equating for multiple models             ###
################################################################################

# Example 5: define und run multiple models according to different domains (item groups)
# and further linking/equating. This example mimics the routines necessary for the 
# 'Vergleichsarbeiten' at the Institute of Educational Progress (IQB)

# specify two models according to the two domains 'knowledge' and 'procedural' 
l2    <- splitModels ( qMatrix = qMat, nCores = 1)

# define 2 models
mods  <- defineModel(dat = datW, id = "id", check.for.linking = TRUE, 
         splittedModels = l2, software = "tam")

# run 2 models 
runs  <- runModel(mods)

# get the results 
ress  <- getResults(runs)

# only for illustration, we create arbitrary 'normed' parameters for anchoring
prmNrm<- itemFromRes(ress)[ sample ( 1:56, 31,FALSE) ,c("item", "est")]
prmNrm[,"est"] <- prmNrm[,"est"] - 0.6 + rnorm ( 31, 0, 0.75)

# anchoring without exclusion of linking DIF items (DIF items will only be identified)
anch  <- equat1pl ( results = ress, prmNorm = prmNrm, excludeLinkingDif = FALSE, 
         difBound = 0.6)

# anchoring with exclusion of linking DIF items
anch2 <- equat1pl ( results = ress, prmNorm = prmNrm, excludeLinkingDif = TRUE, 
         difBound = 0.6, iterativ = FALSE)

# anchoring with iterative exclusion of linking DIF items
anch3 <- equat1pl ( results = ress, prmNorm = prmNrm, excludeLinkingDif = TRUE, 
         difBound = 0.6, iterativ = TRUE)

# transformation to the Bista metric
# first we arbitrarily define mean and standard deviation of the reference 
# population according to both dimensions (defined in the Q matrix): 
# procedural and knowledge
# Note that the the first column of the 'refPop' data frame must include the 
# domain names. Domain names must match the names defined in the Q matrix
refPop<- data.frame ( domain = c("procedural", "knowledge"), m = c(0.122, -0.047), 
         sd = c(0.899, 1.121))

# second, we specify a list with cut scores. Values must be in ascending order.
# Labels of the competence stages are optional. If no labels are specified, 
# the will be defaulted to 1, 2, 3 ... etc.
# Note: if labels are specified, there must be one label more than cut scores. 
# (i.e. 4 cut scores need 5 labels, etc.)
cuts  <- list ( procedural = list ( values = c(380, 420, 500, 560)) , 
         knowledge = list ( values = 400+0:2*100, labels = c("A1", "A2", "B1", "B2")))

# transformation
dfr   <- transformToBista ( equatingList = anch3, refPop = refPop, cuts=cuts ) 
head(dfr$itempars)
head(dfr$personpars)


################################################################################
###      Example 5a: Linking for multiple models, including global domain    ###
################################################################################

# Example 5a: define und run multiple models according to different domains (item groups)
# and further linking/equating. Same as example 5, but extended for the 'global' 
# domain. 

# add the 'global' domain in the Q matrix
qMat2 <- qMat
qMat2[,"global"] <- 1

# specify two models according to the two domains 'knowledge' and 'procedural' 
l3    <- splitModels ( qMatrix = qMat2, nCores = 1)

# define 2 models
mods3 <- defineModel(dat = datW, id = "id", check.for.linking = TRUE, 
         splittedModels = l3, software = "tam")

# run 2 models 
runs3 <- runModel(mods3)

# get the results 
res3  <- getResults(runs3)

# only for illustration, we create arbitrary 'normed' parameters for anchoring.
# Each item now has to item parameter: one is domain-specific, one is the global
# item parameter. Hence, each item occurs two times in 'prmNrm'
prmNrm<- itemFromRes(ress)[ sample ( 1:56, 31,FALSE) ,c("dimension", "item", "est")]
prmNrm[,"est"] <- prmNrm[,"est"] - 0.6 + rnorm ( 31, 0, 0.75)
prmGlo<- prmNrm
prmGlo[,"dimension"] <- "global"
prmNrm<- rbind ( prmNrm, prmGlo)

# if the item identifier in 'prmNrm' is not unique, 'equat1pl' has to know which 
# parameter in 'prmNrm' belongs to which dimension/domain. Hence, the dimension
# is added to 'prmNrm'.
 
# anchoring: if 'prmNrm' has more than 2 columns, the columns of 'prmNrm' must be 
# specified in 'equat1pl'
anch3 <- equat1pl ( results = res3, prmNorm = prmNrm, item = "item", value = "est", 
         domain = "dimension", excludeLinkingDif = FALSE, difBound = 0.6)

# transformation to the Bista metric
# first we arbitrarily define mean and standard deviation of the reference 
# population according to the three dimensions (defined in the Q matrix): 
# procedural, knowledge, and global
# Note that the the first column of the 'refPop' data frame must include the 
# domain names. Domain names must match the names defined in the Q matrix
refPop<- data.frame ( domain = c("procedural", "knowledge", "global"), 
         m = c(0.122, -0.047, 0.069), sd = c(0.899, 1.121, 1.015))

# second, we specify a list with cut scores. Values must be in ascending order.
# Labels of the competence stages are optional. If no labels are specified, 
# the will be defaulted to 1, 2, 3 ... etc.
# Note: if labels are specified, there must be one label more than cut scores. 
# (i.e. 4 cut scores need 5 labels, etc.)
cuts  <- list ( procedural = list ( values = c(380, 420, 500, 560)) , 
         knowledge = list ( values = 400+0:2*100, labels = c("A1", "A2", "B1", "B2")),
         global = list ( values = 400+0:2*100, labels = c("A1", "A2", "B1", "B2")))

# transformation
dfr   <- transformToBista ( equatingList = anch3, refPop = refPop, cuts=cuts ) 
head(dfr$itempars)
head(dfr$personpars)


################################################################################
###        Example 6: Linking and equating for multiple models (II)          ###
################################################################################

# Example 6 and 6a: define und run multiple models according to different domains 
# (item groups) and different person groups. This example mimics the routines 
# necessary for the 'Laendervergleich/Bildungstrend' at the Institute for 
# Educational Progress (IQB). Example 6 demonstrates routines without trend 
# estimation. Example 6a demonstrates routines with trend estimation---hence,
# example 6 mimics time of measurement 't1', example 6a mimics time of measurement
# 't2'.

# Preparation: assume time of measurement 't1' corresponds to the year 2003. 
datT1<- reshape2::dcast(subset ( sciences, year == 2003), 
        formula = id+grade+sex+country~variable, value.var="value")

# First step: item calibration in separate unidimensional models for each domain
modsT1<- splitModels ( qMatrix = qMat, nCores = 1)

# define 2 models. Note: not all items of the Q matrix are present in the data.
# Items which occur only in the Q matrix will be ignored. 
defT1 <- defineModel(dat = datT1, id = "id", check.for.linking = TRUE, 
         splittedModels = modsT1, software = "tam")

# run 2 models 
runT1 <- runModel(defT1)

# get the results 
resT1 <- getResults(runT1)

# extract item parameters from the 'results' object
itemT1<- itemFromRes(resT1)

# Second step: drawing plausible values separately for each group (= each country).
# The two-dimensional model is specified for each person group with fixed item
# parameters. Moreover, a latent regression model is used (in the actual
# 'Laendervergleich', regressors are principal components). We only use 'sex'
# and 'grade' as regressors

# define person grouping
pers  <- data.frame ( idstud = datT1[,"id"] , country = datT1[,"country"])

# Running second step: split models according to person groups
# ('all.persons' must be FALSE, otherwise the whole group would be treated as
# a separate distinct group.)
modT1P<- splitModels ( person.groups = pers , all.persons = FALSE, nCores = 1)

# define the 2 country-specific 2-dimensional models, specifying latent regression 
# model and fixed item parameters.
defT1P<- defineModel(dat = datT1, items = itemT1[,"item"], id = "id", 
         check.for.linking = TRUE, splittedModels = modT1P, qMatrix = qMat, 
         anchor = itemT1[,c("item", "est")], HG.var = c("sex", "grade"),
         software = "tam")

# run the 2 models 
runT1P<- runModel(defT1P)

# get the results 
resT1P<- getResults(runT1P)

# equating is not necessary, as the models run with fixed item parameters
# However, to prepare for the transformation on the 'bista' metric, run
# 'equat1pl' with empty arguments
ankT1P<- equat1pl ( results = resT1P)

# transformation to the 'bista' metric
# Note: if the sample was drawn from the reference population, mean and SD
# are not yet known. So we ignore the 'refPop' argument in 'transformToBista'
# and simply define the cut scores. 
cuts  <- list ( procedural = list ( values = c(380, 500, 620)) , 
         knowledge = list ( values = 400+0:2*100, labels = c("A1", "A2", "B1", "B2")))

# transformation
dfrT1P<- transformToBista ( equatingList = ankT1P, cuts=cuts ) 


################################################################################
###           Example 6a: Extend example 6 with trend estimation             ###
################################################################################

# Example 6a needs the objects created in example 6
# Preparation: assume time of measurement 't2'.
datT2<- reshape2::dcast(subset ( sciences, year == 2013),
        formula = id+grade+sex+country~variable, value.var="value")

# First step: item calibration in separate unidimensional models for each domain
modsT2<- splitModels ( qMatrix = qMat, nCores = 1)

# define 2 models. Items which occur only in the Q matrix will be ignored.
defT2 <- defineModel(dat = datT2, id = "id", check.for.linking = TRUE,
         splittedModels = modsT2, software = "tam")

# run 2 models
runT2 <- runModel(defT2)

# get the results
resT2 <- getResults(runT2)

# collect item parameters
itemT2<- itemFromRes(resT2)

# Second step: compute linking constant between 't1' and 't2' with the iterative
# exclusion of linking DIF items and computation of linking error. We use the
# 'itemT1' object created in example 6. The linking procedure is executed
# consecutively for procedural and knowledge.
L.t1t2<- equat1pl ( results = resT2, prmNorm = itemT1[,c("item", "est")],
         excludeLinkingDif = TRUE, difBound = 0.64, iterativ = TRUE)

# Third step: transform item parameters of 't2' to the metric of 't1'
# We now need to specify the 'refPop' argument. We use the values from 't1' which
# serves as the reference.
ref   <- dfrT1P[["refPop"]]
T.t1t2<- transformToBista ( equatingList = L.t1t2, refPop=,ref, cuts = cuts)

# The object 'T.t1t2' now contains transformed person and item parameters with
# original and transformed linking errors. See for example:
head(T.t1t2$personpars)

# Fourth step: drawing plausible values for 't2'. We use the transformed item
# parameters (captured in 'T.t1t2') for anchoring

# define person grouping
persT2<- data.frame ( idstud = datT2[,"id"] , country = datT2[,"country"])

# Running second step: split models according to person groups (countries)
# ('all.persons' must be FALSE, otherwise the whole group would be treated as
# a separate distinct group.)
modT2P<- splitModels ( person.groups = persT2 , all.persons = FALSE, nCores = 1)

# define the 2 country-specific 2-dimensional models, specifying latent regression
# model and fixed item parameters. We used the transformed item parameters (captured
# in 'T.t1t2[["itempars"]]' --- using the 'estTransf' column) for anchoring.
defT2P<- defineModel(dat = datT2, items = itemT2[,"item"], id = "id",
         check.for.linking = TRUE, splittedModels = modT2P, qMatrix = qMat,
         anchor = T.t1t2[["itempars"]][,c("item", "estTransf")],
         HG.var = c("sex", "grade"), software = "tam")

# run the 2 models
runT2P<- runModel(defT2P)

# get the results
resT2P<- getResults(runT2P)

# equating is not necessary, as the models run with fixed item parameters
# However, to prepare for the transformation on the 'bista' metric, run
# 'equat1pl' with empty arguments
ankT2P<- equat1pl ( results = resT2P)

# transformation to the 'bista' metric, using the previously defined cut scores
dfrT2P<- transformToBista ( equatingList = ankT2P, refPop=ref, cuts=cuts )

# prepare data for jackknifing and trend estimation via 'eatRep'
dTrend<- prepRep ( calibT2 = T.t1t2, bistaTransfT1 = dfrT1P, bistaTransfT2 = dfrT2P,
         makeIdsUnique = FALSE)


################################################################################
###                   Example 6b: trend analyses (repMean)                   ###
################################################################################

# Example 6b needs the objects created in example 6a
# We use the 'dTrend' object to perform some trend analyses.

# load the 'eatRep' package ... note: needs eatRep version 0.9.2 or higher
library(eatRep)

# merge background variables from original data to the 'dTrend' frame
# first reshape 'sciences' into wide format and create 'class' variable
sw    <- reshape2::dcast(sciences, id+year+wgt+jkzone+jkrep+country+grade+sex~1,
         value.var="value")
dTrend<- merge(sw, dTrend, by = "id", all.x = FALSE, all.y = TRUE)
dTrend[,"idclass"] <- substr(as.character(dTrend[,"id"]),1,2)

# compute means for both countries without trend, only for domain 'knowledge'
# create subsample
subSam<- dTrend[intersect(which(dTrend[,"dimension"] == "knowledge"),
         which(dTrend[,"year"] == 2003)),]
m01   <- repMean(datL = subSam, ID="id", imp = "imp", groups = "model",
         dependent = "valueTransfBista")
r01   <- report(m01, add = list(domain = "knowledge"))

# same example as before, now additionally using weights
m02   <- repMean(datL = subSam, ID="id", imp = "imp", groups = "model",
         wgt = "wgt", dependent = "valueTransfBista")
r02   <- report(m02, add = list(domain = "knowledge"))

# now additionally using replication methods (jk2)
m03   <- repMean(datL = subSam, ID="id", imp = "imp", groups = "model", type = "jk2",
         wgt = "wgt", PSU = "jkzone", repInd = "jkrep", dependent = "valueTransfBista")
r03   <- report(m03, add = list(domain = "knowledge"))

# additionally: sex differences in each country, using 'group.differences.by' argument
m04   <- repMean(datL = subSam, ID="id", imp = "imp", groups = c("sex", "model"),
         group.differences.by = "sex", type = "jk2",wgt = "wgt", PSU = "jkzone",
         repInd = "jkrep", dependent = "valueTransfBista")
r04   <- report(m04, add = list(domain = "knowledge"))

# additionally: differ the sex-specific means in each country from the sex-specific
# means in the whole population? Are the differences (male vs. female) in each
# country different from the difference (male vs. female) in the whole population?
m05   <- repMean(datL = subSam, ID="id", imp = "imp", groups = c("sex", "model"),
         group.differences.by = "sex", group.splits = 0:1, cross.differences = TRUE,
         type = "jk2",wgt = "wgt", PSU = "jkzone", repInd = "jkrep",
         dependent = "valueTransfBista", crossDiffSE.engine= "lm")
r05   <- report(m05, add = list(domain = "knowledge"))

# additionally: trend estimation for each country- and sex-specific mean, each
# country-specific sex differences and each difference between country-specific
# sex difference and the sex difference in the whole population

# create a new sub sample with both---the data of 2003 and 2013 ... only for domain
# 'knowledge'. Note: if no linking error is defined, linking error of 0 is assumed.
# (Due to unbalanced sample data, we switch to 'jk1' method for the remainder of 6b.)
subS2 <- dTrend[which(dTrend[,"dimension"] == "knowledge"),]
m06   <- repMean(datL = subS2, ID="id", imp = "imp", groups = c("sex", "model"),
         group.differences.by = "sex", group.splits = 0:1, cross.differences = TRUE,
         type = "jk1",wgt = "wgt", PSU = "idclass", trend = "year",
         crossDiffSE.engine= "lm", linkErr = "trendErrorTransfBista",
         dependent = "valueTransfBista")
r06   <- report(m06, trendDiffs = TRUE, add = list(domain = "knowledge"))

# additionally: repeat this analysis for both domains, 'knowledge' and 'procedural',
# using a 'by'-loop. Now we use the whole 'dTrend' data instead of subsamples
m07   <- by ( data = dTrend, INDICES = as.character(dTrend[,"dimension"]),
         FUN = function ( subdat ) {
         m07a <- repMean(datL = subdat, ID="id", imp = "imp",
                 groups = c("sex", "model"), group.differences.by = "sex",
                 cross.differences = TRUE, group.splits = 0:1, type = "jk1",
                 wgt = "wgt", PSU = "idclass", trend = "year",
                 linkErr = "trendErrorTransfBista",
                 dependent = "valueTransfBista", crossDiffSE.engine= "lm")
         return(m07a)})
r07   <- lapply(names(m07), FUN = function (domain) {report(m07[[domain]],
         trendDiffs = TRUE, add = list(domain = domain))})
r07   <- do.call("rbind", r07)


################################################################################
###                  Example 6c: trend analyses (repTable)                   ###
################################################################################

# Example 6c needs the objects created in example 6a. Additionally, the merged
# 'dTrend' frame created in Example 6a and augmented in 6b is necessary.

# load the 'eatRep' package ... note: needs eatRep version 0.9.2 or higher
library(eatRep)

# compute frequencies for trait levels, only for domain 'knowledge', without trend
# create 'knowledge' subsample
subSam<- dTrend[intersect(which(dTrend[,"dimension"] == "knowledge"),
         which(dTrend[,"year"] == 2003)),]
freq01<- repTable(datL = subSam, ID="id", imp = "imp", groups = "model",
         dependent = "traitLevel")
res01 <- report(freq01, add = list(domain = "knowledge"))

# same example as before, now additionally using weights
freq02<- repTable(datL = subSam, ID="id", imp = "imp", groups = "model",
         wgt = "wgt", dependent = "traitLevel")
res02 <- report(freq02, add = list(domain = "knowledge"))

# now additionally using replication methods (jk2)
freq03<- repTable(datL = subSam, ID="id", imp = "imp", groups = "model", type = "jk2",
         wgt = "wgt", PSU = "jkzone", repInd = "jkrep", dependent = "traitLevel")
res03 <- report(freq03, add = list(domain = "knowledge"))

# additionally: sex differences in each country, using 'group.differences.by' argument
# Note: for frequency tables group differences may result in a chi square test or in
# a difference of each categories' frequency.
# first: request chi square test
freq04<- repTable(datL = subSam, ID="id", imp = "imp", groups = c("model", "sex"),
         type = "jk2", group.differences.by = "sex", chiSquare = TRUE, wgt = "wgt",
         PSU = "jkzone", repInd = "jkrep", dependent = "traitLevel")
res04 <- report(freq04, add = list(domain = "knowledge"))

# now request differences for each trait level category
freq05<- repTable(datL = subSam, ID="id", imp = "imp", groups = c("model", "sex"),
         type = "jk2", group.differences.by = "sex", chiSquare = FALSE, wgt = "wgt",
         PSU = "jkzone", repInd = "jkrep", dependent = "traitLevel")
res05 <- report(freq05, add = list(domain = "knowledge"))

# additionally: differ the sex-specific means in each country from the sex-specific
# means in the whole population? Are the differences (male vs. female) in each
# country different from the difference (male vs. female) in the whole population?
freq06<- repTable(datL = subSam, ID="id", imp = "imp", groups = c("model", "sex"),
         type = "jk2", group.differences.by = "sex", cross.differences = TRUE,
         chiSquare = FALSE, wgt = "wgt", PSU = "jkzone", repInd = "jkrep",
         dependent = "traitLevel")
res06 <- report(freq06, add = list(domain = "knowledge"))

# additionally: trend estimation for each country- and sex-specific mean, each country-
# specific sex differences and each difference between country-specific sex difference
# and the sex difference in the whole population

# create a new sub sample with both---the data of 2003 and 2013 ... only for domain
# 'knowledge'. Note: if no linking error is defined, linking error of 0 is assumed.
# (Due to unbalanced sample data, we switch to 'jk1' method for the remainder of 6c.)
subS2 <- dTrend[which(dTrend[,"dimension"] == "knowledge"),]
freq07<- repTable(datL = subS2, ID="id", imp = "imp", groups = c("model", "sex"),
         type = "jk1", group.differences.by = "sex", cross.differences = TRUE,
         chiSquare = FALSE, wgt = "wgt", PSU = "idclass", trend = "trend",
         linkErr = "trendErrorTraitLevel", dependent = "traitLevel")
res07 <- report(freq07, add = list(domain = "knowledge"))

# additionally: repeat this analysis for both domains, 'knowledge' and 'procedural',
# using a 'by'-loop. Now we use the whole 'dTrend' data instead of subsamples
freq08<- by ( data = dTrend, INDICES = as.character(dTrend[,"dimension"]),
         FUN = function ( subdat ) {
         f08 <- repTable(datL = subdat, ID="id", imp = "imp",
                groups = c("model", "sex"), type = "jk1", group.differences.by = "sex",
                cross.differences = TRUE, chiSquare = FALSE, wgt = "wgt",
                PSU = "idclass", trend = "trend", linkErr = "trendErrorTraitLevel",
                dependent = "traitLevel")
         return(f08)})
res08 <- lapply(names(freq08), FUN = function (domain) { report(freq08[[domain]],
         add = list(domain = domain))})
res08 <- do.call("rbind", res08)


################################################################################
###                   Example 6d: trend analyses (repGlm)                    ###
################################################################################

# Example 6c needs the objects created in example 6a. Additionally, the merged
# 'dTrend' frame created in Example 6a and augmented in 6b is necessary.

# load the 'eatRep' package ... note: needs eatRep version 0.9.2 or higher
library(eatRep)

# regress procedural compentence on knowledge competence ... it's necessary to
# reshape the data
datGlm<- reshape2::dcast(dTrend, value.var = "valueTransfBista",
         formula = id+imp+wgt+jkzone+jkrep+idclass+model+trend+sex~dimension)

# first example: only for year 2003
dat03 <- datGlm[which(datGlm[,"trend"] == "T1"),]
m08   <- repGlm(datL = dat03, ID="id", imp="imp", wgt="wgt", PSU="jkzone",
         repInd = "jkrep", type = "jk2", formula = procedural~knowledge)
res08 <- report(m08)

# compute regression with two regressors separately for each country
m09   <- repGlm(datL = dat03, ID="id", imp="imp", wgt="wgt", PSU="jkzone",
         repInd = "jkrep", type = "jk2", groups = "model",
         formula = procedural~sex+knowledge)
res09 <- report(m09)

# differ country-specific regression coefficients from the regression coefficents
# in the whole population?
m10   <- repGlm(datL = dat03, ID="id", imp="imp", wgt="wgt", PSU="jkzone",
         repInd = "jkrep", type = "jk2", groups = "model", group.splits = 0:1,
         cross.differences = TRUE, formula = procedural~sex+knowledge)
res10 <- report(m10)

# differ country-specific regression coefficients from the regression coefficents
# in the whole population? Are these differences different for 2003 vs. 2013?
m11   <- repGlm(datL = datGlm, ID="id", imp="imp", wgt="wgt", PSU="jkzone",
         repInd = "jkrep", type = "jk2", groups = "model", group.splits = 0:1,
         cross.differences = TRUE, trend = "trend", formula = procedural~sex+knowledge)
res11 <- report(m11, trendDiffs = TRUE)


################################################################################
###        Example 7: Linking and equating for multiple models (III)         ###
################################################################################

# For the purpose of illustration, this example repeats analyses of example 6,
# using a 2pl estimation now. Example 7 demonstrates routines without trend
# estimation.

# Preparation: assume time of measurement 't1' corresponds to the year 2003.
datT1<- reshape2::dcast(subset ( sciences, year == 2003),
        formula = id+grade+sex+country~variable, value.var="value")

# First step: item calibration in separate unidimensional models for each domain
# split 2 models. Note: not all items of the Q matrix are present in the data.
# Items which occur only in the Q matrix will be ignored.
modsT1<- splitModels ( qMatrix = qMat, nCores = 1)

# lets specify a 2pl model with constraints: a common discrimination for all
# knowledge items, and a common discrimination for procedural items
slopes<- data.frame ( variable = qMat[,"variable"],
         slope = as.numeric(as.factor(substr(as.character(qMat[,"variable"]),4,6))))

# prepare 2pl model
defT1 <- defineModel(dat = datT1, id = "id", check.for.linking = TRUE,
         splittedModels = modsT1, irtmodel = "2PL.groups", est.slopegroups = slopes,
         software = "tam")

# run 2 models
runT1 <- runModel(defT1)

# get the results
resT1 <- getResults(runT1)

# extract item parameters from the 'results' object
itemT1<- itemFromRes(resT1)

# Second step: drawing plausible values. Two-dimensional model is specified for
# each person group with fixed item parameters. Moreover, a latent regression
# model is used (in the actual 'Laendervergleich', regressors are principal
# components).

# create arbitrary principal components
for ( i in c("PC1", "PC2", "PC3") ) {
      datT1[,i] <- rnorm( n = nrow(datT1), mean = 0, sd = 1.2)
}

# number of extracted principal components vary: three components for Berlin,
# two for Bavaria. Hence, Bavaria has no valid values on 'PC3'.
datT1[which(datT1[,"country"] == "Bavaria"),"PC3"] <- NA

# define person grouping
pers  <- data.frame ( idstud = datT1[,"id"] , country = datT1[,"country"])

# Running second step: split models according to person groups
# ('all.persons' must be FALSE, otherwise the whole group would be treated as
# a separate distinct group.)
modT1P<- splitModels ( person.groups = pers , all.persons = FALSE, nCores = 1)

# define the 2 country-specific 2-dimensional models, specifying latent regression
# model and fixed item and fixed slope parameters.
defT1P<- defineModel(dat = datT1, items = itemT1[,"item"], id = "id", irtmodel = "2PL",
         check.for.linking = TRUE, splittedModels = modT1P, qMatrix = qMat,
         anchor = itemT1[,c("item", "est")],
         fixSlopeMat = itemT1[,c("item", "estSlope")],
         HG.var = c("PC1", "PC2", "PC3"), software = "tam")

# run the 2 models
runT1P<- runModel(defT1P)

# get the results
resT1P<- getResults(runT1P, Q3 = FALSE)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
