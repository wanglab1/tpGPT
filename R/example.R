#' @examples
#' data_gn <- c("TP53", "BRCA1", "MYC")
#' # Example with mock mode
#' cancer_type='head and neck cancer'
#' tissue_type='epithelial tissue, connective tissue and muscle tissue'
#' api_key='Your api key'
#' cell_type='B cells, T cells,malignant cells, and Monocytes'
#' target_genes <- targetGPT(data_gn, "mock_api_key", mock = TRUE)
#' print(target_genes)
