% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/logViewer.R
\name{logViewerOutput}
\alias{logViewerOutput}
\title{Display app logs}
\usage{
logViewerOutput(id = "logViewer")
}
\arguments{
\item{id}{character id for the object(default = "logViewer")}
}
\value{
shiny tableOutput instance
}
\description{
Creates a shiny table with table containing logged user actions. Table contents are auto updated whenever a user action is
logged. The id must match the same id configured in \bold{server.R} file upon calling \code{fw_server_setup} method
}
\section{Table columns}{

\itemize{
\item action - the action that id logged in any place in app
\item time   - action time
}
}

\section{Example}{

\code{logViewerOutput('logViewer')}
}

\section{Shiny Usage}{

Add the log viewer box to your box list

It is paired with a call to \code{fw_server_setup} method in \bold{server.R} file
}

\examples{
# Inside ui_body add the log viewer box to your box list

logViewerOutput('logViewerId')


}
\seealso{
\link[periscope2]{downloadFile}

\link[periscope2]{downloadFile_ValidateTypes}

\link[periscope2]{downloadFile_AvailableTypes}

\link[periscope2]{downloadablePlot}

\link[periscope2]{downloadFileButton}

\link[periscope2]{downloadableTableUI}

\link[periscope2]{downloadableTable}
}
