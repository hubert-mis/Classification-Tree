library(tidyverse)
library(data.tree)

entropy <- function(x){
  sapply(x/sum(x), function(x){
    if(x == 0) 0 
    else -x * log2(x)
  }) %>% sum()
}

entropy_cond <- function(x, rows){
  mean(rows) * entropy(colSums(x[rows, ]))
}

binary_tree <- function(independent, dependent, node, conditionResult = NULL){
  if(nrow(independent) != nrow(dependent)){
    stop("Datasets have different number of observations!", call. = F)
  } else observations <- nrow(independent)
  
  #dodawanie galezi przedstawiajacej spelnienie lub niespelnienie poprzedniego warunku
  child <- node$AddChild(conditionResult)
  
  ### jezeli wszystkie obserwacje naleza do tego samego
  categories = colSums(dependent)
  if(max(categories) == observations){
    child$AddChild(colnames(dependent)[which.max(categories)])
    return(list(decision = T,
                answer = colnames(dependent)[which.max(categories)]))
  }
  
  ### usuwam kategorie gdzie wszystkie obserwacje to 0 lub 1
  independent <- independent[, sapply(independent, function(x){
    sum(x) > 0 & sum(x) < observations
  })]
  
  # wyznaczam warunek najlepszy do dokonania podzialu
  best_cond <- entropy(categories) -
    sapply(1:ncol(independent), function(x){
      rows = independent[x] == 1
      entropy_cond(dependent, rows) + entropy_cond(dependent, !rows)
    })
  
  # wybrany warunek dzielacy podzbior
  cond = which.max(best_cond)
  # obserwacje spelniajace wybrany warunek
  rows = independent[cond] == 1
  
  #dodanie galezi z warunkiem
  nextChild <- child$AddChild(colnames(independent)[cond])
  
  # zwracam wybrany warunek, przy czym rekurencyjnie wywoluje funkcje
  # dla podzielonych podzbiorow
  return(list(decision = F,
              condition = colnames(independent)[cond],
              yes = binary_tree(independent[rows, ], dependent[rows, ], nextChild, "Yes"),
              no = binary_tree(independent[!rows, ], dependent[!rows, ], nextChild, "No")))
}


