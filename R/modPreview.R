#' Preview MODIS satellite images
#'
#' \code{modPreview} shows a preview of the \code{n}-th image from a set of 
#' search results on an interactive map. 
#'
#' The function shows a preview of the \code{n}-th output image from a search
#' in the MODIS archives (\code{\link{modSearch}}, with 
#' \code{resType = "browseurl"}). The preview is downloaded from the
#' \href{https://earthdata.nasa.gov}{`EarthData' Platform}.
#' Please, be aware that only some images may have a preview.
#'
#' @param searchres a vector with the results from \code{\link{modSearch}}.
#' @param dates a vector with the dates being considered
#'   for previewing. This argument is mandatory if 
#'   \code{n} is not defined.
#' @param n a \code{numeric} argument identifying the location of the image in
#' \code{searchres}.
#' @param lpos vector argument. Defines the position of the red-green-blue
#' layers to enable false color visualization.
#' @param add.Layer logical argument. If \code{TRUE}, the function plots the 
#' image on an existing map. Allows combinations of images on a map using 
#' \code{\link{lsPreview}} and \code{\link{senPreview}} functions.
#' @param verbose logical argument. If \code{TRUE}, the function prints the 
#' running steps and warnings.
#' @param ... arguments for nested functions:
#'  \itemize{
#'   \item arguments allowed by the \code{viewRGB} function from \code{mapview}
#'    packages are valid arguments.
#' }
#' @return this function does not return anything. It displays a preview of one
#' of the search results.
#' @examples
#' \dontrun{
#' # load a spatial polygon object of Navarre
#' data(ex.navarre)
#' # retrieve jpg images covering Navarre region between 2011 and 2013
#' sres <- modSearch(product = "MOD09GA",
#'                   startDate = as.Date("01-01-2011", "%d-%m-%Y"),
#'                   endDate = as.Date("31-12-2013", "%d-%m-%Y"),
#'                   collection = 6,
#'                   extent = ex.navarre)
#'                       
#' modPreview(sres,n=1)
#' modPreview(sres,2,add.Layer=T)
#' }
modPreview<-function(searchres,n,dates,lpos=c(3,2,1),add.Layer=FALSE,verbose = FALSE,...){
  if(class(searchres)!="modres"){stop("A response from modis search function is needed.")}
  searchres<-searchres$jpg
  if(missing(dates)){
    return(.modPreviewRecursive(searchres=searchres,n=n,lpos=lpos,add.Layer=add.Layer,verbose=verbose,...))
  }else{
    searchres<-searchres[modGetDates(searchres)%in%dates]
    if(length(searchres)>0){
      .modPreviewRecursive(searchres=searchres,n=1,lpos=lpos,add.Layer=add.Layer,verbose=verbose,...)
      if(length(searchres)>1){
        for(x in 2:length(searchres)){
          .modPreviewRecursive(searchres=searchres,n=x,lpos=lpos,add.Layer=TRUE,verbose=verbose,...)
        }
      }
      return(getRGISToolsOpt("GMapView"))
    }else{
      stop("There is no image for preview in ")
    }
    
  }
}
.modPreviewRecursive<-function(searchres,n,lpos=c(3,2,1),add.Layer=FALSE,verbose = FALSE,...){
  ser<-searchres[n]
  tmp <- tempfile()
  if(verbose){
    download.file(ser,tmp,mode="wb")
  }else{
    download.file(ser,tmp,mode="wb",quiet = TRUE)
  }
  pic<-stack(tmp)
  
  pr<-modGetPathRow(ser)
  ho<-as.numeric(substr(pr,2,3))
  ve<-as.numeric(substr(pr,5,6))
  
  extent(pic)<-extent(st_transform(mod.tiles[mod.tiles$Name==paste0("h:",ho," v:",ve),],crs=st_crs(54008)))
  projection(pic)<-st_crs(54008)$proj4string
  
  if(verbose){
    return(genMapViewSession(pic,lpos,lname=paste0("MOD_",ho,"_",ve,"_D",format(modGetDates(ser),"%Y%j")),add.Layer=add.Layer,...))
  }else{
    return(suppressWarnings(genMapViewSession(pic,lpos,lname=paste0("MOD_",ho,"_",ve,"_D",format(modGetDates(ser),"%Y%j")),add.Layer=add.Layer,...)))
  }
}
