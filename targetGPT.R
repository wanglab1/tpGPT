#' Generate a Target Gene Panel using GPT
#'
#' This function uses GPT (via the openai R package) to generate a gene panel based on tissue type, cancer type, and cell type.
#'
#' @param data_gn A vector of gene names in your dataset.
#' @param api_key Your OpenAI API key.
#' @param tissue_type A string specifying the tissue type.
#' @param cancer_type A string specifying the cancer type.
#' @param cell_type A string specifying cell types (comma-separated).
#' @param model The GPT model to use (default: "gpt-4-turbo").
#' @param mock Logical. If TRUE, bypasses API calls and returns mock data for testing or documentation purposes.
#' @return A vector of gene names that match the generated marker panel and your dataset.
#' @examples
#' data_gn <- c("TP53", "BRCA1", "MYC")
#' # Example with mock mode
#' target_genes <- targetGPT(data_gn, "mock_api_key", mock = TRUE)
#' print(target_genes)
#'
#' @export
targetGPT <- function(data_gn, api_key, tissue_type = NULL, cancer_type = NULL, cell_type = NULL, model = 'gpt-4-turbo', mock = FALSE) {
  if (mock) {
    message("Mock mode enabled: Returning example gene panel.")
    return(c("GENE1", "GENE2", "GENE3", "GENE4"))
  }

  if (is.null(api_key) || api_key == "Your api key") {
    stop("Invalid or missing OpenAI API key. Please set a valid API key.")
  }

  Sys.setenv(OPENAI_API_KEY = api_key)

  # Default marker genes
  base_gene <- create_chat_completion(
    model = model,
    messages = list(
      list("role" = "system", "content" = "You are a highly knowledgeable genomics research assistant."),
      list("role" = "user", "content" = "Generate a list of total 400 marker genes in immunology.\nOnly provide the gene list.\nEnsure each gene is listed on a new line without any prefixes such as numbers.")
    )
  )

  res_base <- strsplit(base_gene$choices[, 'message.content'], '\n')[[1]]

  # Cancer-tissue-specific marker genes
  can_tis_gene <- create_chat_completion(
    model = model,
    messages = list(
      list("role" = "system", "content" = "You are a highly knowledgeable genomics research assistant."),
      list("role" = "user", "content" = paste0(
        'Generate a list of total 400 marker genes in ', cancer_type,
        ' associated with ', tissue_type, '.\n',
        'Only provide the gene list.\n',
        'Ensure each gene is listed on a new line without any prefixes such as numbers.'
      ))
    )
  )

  res_can <- strsplit(can_tis_gene$choices[, 'message.content'], '\n')[[1]]

  # Cell type-specific marker genes
  cellty_gene <- create_chat_completion(
    model = model,
    messages = list(
      list("role" = "system", "content" = "You are a highly knowledgeable genomics research assistant."),
      list("role" = "user", "content" = paste0(
        'Generate a list of marker genes for the following cell types: ', cell_type, '.\n',
        'Each cell type should contain at least 50 genes.\n',
        'Only provide the gene list.\n',
        'Ensure each gene is listed on a new line without any prefixes such as numbers.'
      ))
    )
  )

  res_cell <- strsplit(cellty_gene$choices[, 'message.content'], '\n')[[1]]

  # Combine all genes and filter
  res_all <- c(res_base, res_can, res_cell)
  match_id <- match(res_all, data_gn)
  match_id <- na.omit(match_id)
  target_gene <- data_gn[match_id]

  return(target_gene)
}

