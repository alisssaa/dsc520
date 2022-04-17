baseball$sf[baseball$year < 1954] <- 0
baseball$hbp[is.na(baseball$hbp)] <- 0
baseball <- baseball[baseball$ab >= 50, ]

baseball$OBP <- with(baseball, (h + bb + hbp) / (ab + bb + hbp + sf))

obp <- function(data)
  {
   c(OBP=with(data, sum(h + bb + hbp) / sum(ab + bb + hbp + sf)))
}

careerOBP <- ddply(baseball, .variables="id", .fun=obp)
