# seir.R

# -----
library(SimInf)
# -----

# Parameters

## Case fatality (average percent moratlity rate)
## 		casefatality <- 0.023
## reproductive number (new infections/person)
## 		r0 <- 3.28
## days until symptoms / infectious (days)
## 		incubation <- 5
## recovery period (days)
## 		recovery <- 14
## world population (number of people, 4/13/2020)
## 		pop <- 777758300
## Time span for SEIR plot
## 		tspan <- 1:100
## Data file for worldwide deaths and confirmed cases
## 		datafile <- "./casepredict.csv"
## Factor to shrink population by (increases speed)
##		shrinker <- 1
runSEIR <- function(casefatality=0.023, r0=3.28, incubation=5, recovery=14, pop=777758300, tspan=1:100, datafile="./casepredict.csv", shrinker=1, replicants=1000) {
	pop <- pop / shrinker
	
	greeks <- getGreeks(r0, incubation, recovery)
	gamma <- greeks[[1]]
	epsilon <- greeks[[2]]
	beta <- greeks[[3]]
	
	data <- read.csv(datafile)
	recent <- tail(data[, c(3,4,5)], incubation)
	cat(paste0("Using data from ", (head(recent, 1))[,1], "\n"))
	I <- as.integer(((head(recent, 1))[,3]) / shrinker)
	newI <- ((tail(recent, 1))[,3]) / shrinker
	E <- as.integer(newI - I)
	R <- as.integer(((head(recent, 1))[,2] / casefatality * (1 - casefatality)) / shrinker)
	S <- as.integer(pop - I - E - R)
	cat("--- Parameters ---", "\n")
	cat("S: ", S, "\n")
	cat("E: ", E, "\n")
	cat("I: ", I, "\n")
	cat("R: ", R, "\n")
	
	model <- createSEIRmodel(u0=data.frame(S=rep(S, replicants),E=rep(E, replicants),I=rep(I, replicants),R=rep(R, replicants)), tspan, beta, epsilon, gamma)
	
	result <- run(model)
	return(result)
}

getGreeks <- function(r0=3.28, incubation=5, recovery=14) {
	gamma <- 1 / recovery
	epsilon <- 1 / incubation
	beta <- r0 * gamma
	
	return(list(gamma, epsilon, beta))
}

createSEIRmodel <- function(u0, tspan=1:100, beta, epsilon, gamma) {
	SEIR(u0=u0, tspan=tspan, beta=beta, epsilon=epsilon, gamma=gamma)
}