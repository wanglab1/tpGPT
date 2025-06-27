# tpGPT

To improve the targeted imputation approach of SmartImpute, the selection of an informative gene panel is performed using a GPT model with the R software package tpGPT. In tpGPT, researchers can specify parameters such as cancer type, tissue type, and cell type to enrich the default panel with additional genes relevant to their particular research focus.

More refer to SmartImpute: https://github.com/wanglab1/SmartImpute. 

## Features

- **Target Gene Panel Generation**: Generate marker gene panels tailored to specific tissue, cancer, and cell types.
- **GPT Integration**: Leverages the OpenAI GPT model for intelligent and context-aware gene selection.

## Installation

To install the development version of `tpGPT` from GitHub:

```R
# Install devtools if not already installed
install.packages("devtools")

# Install tpGPT from GitHub
devtools::install_github("wanglab1/tpGPT")

```

## Usage

```R
# Load the tpGPT package
library(tpGPT)

# Example dataset of gene names
data_gn <- c("TP53", "BRCA1", "MYC", "EGFR", "CDKN2A")

# Define parameters
api_key <- "your_openai_api_key"
cancer_type <- "breast cancer"
tissue_type <- "epithelial tissue"
cell_type <- "T cells, B cells, and Monocytes"

# Generate the target gene panel
target_genes <- targetGPT(data_gn, api_key, tissue_type, cancer_type, cell_type)
print(target_genes)
```
