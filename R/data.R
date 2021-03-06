#' A Digital Elevation Model (DEM) of the region of Navarre (Spain)
#'
#' Geographically projected \code{RasterStack} with the digital elevation model
#'(DEM) of the region of Navarre (Spain). The DEM was obtained from the
#' \href{http://centrodedescargas.cnig.es/CentroDescargas/locale?request_locale=en#}{National Center for Geographic Information}
#' of Spain. The DEM is used as a covariable in the Image Mean Anomaly (IMA)
#' algorithm (\code{\link{genSmoothingCovIMA}}).
#'
#' @format The \code{RasterStack} contains 6 layers with the same DEM, one for
#' every image in the time series of the \code{\link{genSmoothingCovIMA}} example.
#' The \code{RasterStack} coordinates are in the Sinusoidal projection:
#' 
#' \describe{
#'   \item{name}{layer names contain the capturing date of the corresponding image in the format "\code{YYYYJJJ}"}.
#'   \item{size}{113 rows by 105 columns and 6 layers}.
#' }
#' @name ex.dem.navarre
#' @docType data
#' @keywords data
NULL

#' A time series of NDVI of Navarre (Spain)
#'
#' Geographically projected \code{RasterBrick} object of the normalized 
#' difference vegetation index (NDVI) of Navarre.
#'
#' @format The \code{RasterBrick} contains 6 images, from the 2nd to the 4th of
#' August in 2017 and 2018. The \code{RasterBrick} coordinates are in the
#' Sinusoidal projection:
#' 
#' \describe{
#'   \item{name}{layer names contain the date of the image in the format "\code{YYYYJJJ}"}.
#'   \item{size}{each layer contains 113 rows and 105 columns}.
#' }
#' @name ex.ndvi.navarre
#' @docType data
#' @keywords data
NULL

#' A polygon with the border of Navarre (Spain)
#'
#' Spatial feature (\code{sf}) representing the border of Navarre with
#' coordinates in the longitude/latitude format.
#' @name ex.navarre
#' @docType data
#' @keywords data
NULL


#' @docType package
#' @bibliography system.file("REFERENCES.bib", package = "RGISTools")