
<!-- README.md is generated from README.Rmd. Please edit that file -->

# seaR

<!-- badges: start -->
<!-- badges: end -->

Structural Event Analysis (Ruef 2002; Ruef, Aldrich, and Carter 2003)

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
#>  1 FP|MP|FA|FA|FO|FO|FU|MU     8
#>  2 MP|MP|MP|FU|FU|MU|MU        7
#>  3 FP|FA|MO|MO|MO|MO|MO|FU     8
#>  4 FU|FU|FU|FU|MU|MU           6
#>  5 FP|FP|FP|MP|FA|FA|FO|MU     8
#>  6 FA|FA|FO|FO|MO|MO|MO|MU     8
#>  7 FP|MA|MA|MA|MO|MO|MO|MU     8
#>  8 FP|FP|FP|FP|FA|MA|FO|MU     8
#>  9 FP|FP|MP|MP|MP              5
#> 10 FP|MP|MA|MA|MA|FO|FO|MU     8
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
