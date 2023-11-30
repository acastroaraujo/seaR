
<!-- README.md is generated from README.Rmd. Please edit that file -->

# seaR

<!-- badges: start -->

[![R-CMD-check](https://github.com/acastroaraujo/seaR/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/acastroaraujo/seaR/actions/workflows/R-CMD-check.yaml)

<!-- badges: end -->

**Structural Event Analysis**

## Installation

You can install the development version of seaR from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("acastroaraujo/seaR")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(seaR)

gender <- c("F", "M")
occupation <- c("P", "A", "O", "U")
risk_set_size(1:8, gender, occupation)
#> Total: 12,869
#>    1    2    3    4    5    6    7    8 
#>    8   36  120  330  792 1716 3432 6435

geography <- c("S", "N")
risk_set_size(1:8, gender, occupation, geography)
#> Total: 735,470
#>      1      2      3      4      5      6      7      8 
#>     16    136    816   3876  15504  54264 170544 490314
```

And:

``` r
grid <- risk_set(1:8, gender, occupation)
glimpse(grid)
#> Rows: 12,869
#> Columns: 2
#> $ id   <chr> "FP", "MP", "FA", "MA", "FO", "MO", "FU", "MU", "FP|FP", "FP|MP",…
#> $ size <int> 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,…

i <- sample(nrow(grid), size = 10)
grid[i, ]
#> # A tibble: 10 × 2
#>    id                       size
#>    <chr>                   <int>
#>  1 MP|MP|FA|MA|MA|FO|FU|FU     8
#>  2 MP|FA|MA|FO|FO|FO|MO|MO     8
#>  3 MA|FO|MO|FU|MU|MU|MU        7
#>  4 MP|MP|FA|MA|FO|MO|MO        7
#>  5 MP|MP|MP|MA|FO|MO|MO        7
#>  6 FP|MP|MP|FA|MO|FU|MU        7
#>  7 FP|MP|FU|MU|MU              5
#>  8 MP|MP|MP|FO|MO|MO|MU|MU     8
#>  9 FP|FP|FO|MU                 4
#> 10 FP|FP|FP|FA|FA|FA|FA|FO     8
```

## References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-ruef2002" class="csl-entry">

Ruef, Martin. 2002. “A Structural Event Approach to the Analysis of
Group Composition.” *Social Networks* 24 (2): 135160.

</div>

<div id="ref-ruef2003" class="csl-entry">

Ruef, Martin, Howard E. Aldrich, and Nancy M. Carter. 2003. “The
Structure of Founding Teams: Homophily, Strong Ties, and Isolation Among
US Entrepreneurs.” *American Sociological Review*, 195222.

</div>

</div>
