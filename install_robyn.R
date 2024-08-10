#' Install Robyn and its dependencies
#'
#' This function installs Robyn and all necessary dependencies.
#' @export
install_robyn <- function() {
  # Install and load reticulate
  if (!requireNamespace("reticulate", quietly = TRUE)) {
    install.packages("reticulate")
  }
  library(reticulate)

  # Create and use a virtual environment
  virtualenv_name <- "robyn-env"
  if (!virtualenv_exists(virtualenv_name)) {
    virtualenv_create(virtualenv_name)
  }
  use_virtualenv(virtualenv_name, required = TRUE)

  # Set Python path
  python_path <- file.path(virtualenv_path(virtualenv_name), "bin", "python")
  Sys.setenv(RETICULATE_PYTHON = python_path)

  # Install required Python packages
  py_install(c("numpy", "nevergrad"), pip = TRUE)

  # Install Robyn
  if (!requireNamespace("Robyn", quietly = TRUE)) {
    install.packages("Robyn")
  }

  # Verify installation
  if (requireNamespace("Robyn", quietly = TRUE)) {
    message("Robyn has been successfully installed!")
  } else {
    stop("There was an error installing Robyn. Please check the error messages above.")
  }
}