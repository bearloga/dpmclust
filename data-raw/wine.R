wine <- read.csv("data-raw/wine.csv", header = FALSE)

colnames(wine) <- c(
  "class",
  "alcohol",
  "malic_acid",
  "ash",
  "ash_alcalinity",
  "magnesium",
  "total_phenols",
  "flavanoids",
  "nonflavanoid_phenols",
  "proanthocyanins",
  "color_intensity",
  "hue",
  "protein_concentration", # OD280/OD315 of diluted wines
  "proline"
)

wine$class <- factor(wine$class)

devtools::use_data(wine, overwrite = TRUE)
