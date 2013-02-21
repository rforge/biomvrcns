\name{biomvRhsmm}
\alias{biomvRhsmm}
\title{
	Estimating the most likely state sequence using Hidden Semi Markov Model
}
\description{
	Estimating the most likely state sequence using Hidden Semi Markov Model, and needs more from the application note ....
}
\usage{
biomvRhsmm(x, maxk=NULL, maxbp=NULL, J=3, xPos=NULL, xRange=NULL, usePos='start', emis.type='norm', xAnno=NULL, soj.type='gamma', q.alpha=0.05, r.var=0.75, maxit=1000, maxgap=Inf, tol=1e-06, grp=NULL, clusterm=NULL, na.rm=TRUE)
}

\arguments{
  \item{x}{
	input data matrix, or a \code{GRanges} object with input stored in the meta \code{DataFrame}
}
  \item{maxk}{
	maximum length of stay for the sojourn distribution 
}
  \item{maxbp}{
	maximum length of stay in bp for the sojourn distribution, given positional information specfied in \code{xPos} / \code{xRange}
}
  \item{J}{
	number of states
}
  \item{xPos}{
	a vecter of positons for each \code{x} row
}
  \item{xRange}{
	a \code{IRanges}/\code{GRanges} obejct, same length as \code{x} rows
}
  \item{usePos}{
	character value to indicate whether the 'start', 'end' or 'mid' point position should be used to estimate the sojourn distribution
}
  \item{emis.type}{
	type of the emission distribution, only the following types are supported: 'norm', 'mvnorm', 'pois'
}
  \item{xAnno}{
	a optional \code{TranscriptDb} / \code{GRanges} / \code{GRangesList} object used in \code{\link{sojournAnno}} to infer parameters for the sojourn distribution 
}
  \item{soj.type}{
	type of the sojourn distribution, only the following types are supported: 'nonpara', 'gamma', 'pois', 'nbinom'
}
  \item{q.alpha}{
	a quantile factor controlling the estimated prior for the mean of the emission of each states, \code{seq(from=q.alpha, to=1-q.alpha, length.out=J)}
}
  \item{r.var}{
	a ratio factor controlling the estimated prior for the variance / covariance structure of each states. 
	A value larger than 1 tend to allow larger variation in extreme states;  a value smaller than 1 will decrease the probablity of having extreme state
}
  \item{maxit}{
	max iteration of the EM run with Forward-Backward algorithm
}
  \item{maxgap}{
	max distance between neighbouring feature to consider a split
}
  \item{tol}{
	tolerance level of the likelihood change to determining the termination of the EM run
}
  \item{grp}{
	vector of group assignment for each sample, with a length the same as columns in the data matrix, samples within each group would be processed simutaneously if a multivariate emission distribution is avaliable
}
  \item{clusterm}{
	clusting method for prior grouping, possible values are 'ward','single','complete','average','mcquitty','median','centroid'
}
  \item{na.rm}{
	\code{TRUE} if \code{NA} value should be ignored 
}
}
\details{
	from ApplicationNote and Poster
}
\value{
	A \code{\link{biomvRCNS}} object:
    \item{\code{x}:}{Object of class \code{"GRanges"}, with range information either from real positional data or just indices, with input data matrix stored in the meta columns.
    		 Additional meta columns for the estimated states for each sampe will also be appended following the input data matrix.} 
    \item{\code{res}:}{Object of class \code{"GRanges"} , each range represent one continous segment identified, with sample name slot 'SAMPLE', estimated state slot 'STATE' and segment mean slot 'MEAN' stored in the meta columns  }
    \item{\code{param}:}{Object of class \code{"list"}, list of all parameters used in the model run. }
}

\author{
Yang Du
}

\references{
	Guedon, Y. (2003). Estimating hidden semi-Markov chains from discrete sequences. Journal of Computational and Graphical Statistics, 12(3), 604-639.
}

\seealso{
\code{\link{biomvRseg}}
}
\examples{
	data(coriell)
	xgr<-GRanges(seqnames=paste('chr', coriell[,2], sep=''), IRanges(start=coriell[,3], width=1, names=coriell[,1]))
	values(xgr)<-DataFrame(coriell[,4:5], row.names=NULL)
	xgr<-xgr[order(xgr)]
	reshsmm<-biomvRhsmm(x=xgr, maxbp=5E4, J=3, soj.type='gamma', emis.type='norm', maxit=1, grp=c(1,2))
}

\keyword{ hsmm }