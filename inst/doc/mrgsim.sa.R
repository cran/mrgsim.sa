## ----setup, message = FALSE---------------------------------------------------
library(dplyr)
library(mrgsim.sa)
library(patchwork)

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(fig.height = 4, comment = ".")

## -----------------------------------------------------------------------------
mod <- house(outvars = "CP,RESP")

## -----------------------------------------------------------------------------
param(mod)

## -----------------------------------------------------------------------------
outvars(mod)

## -----------------------------------------------------------------------------
out <- 
  mod %>% 
  ev(amt = 100) %>% 
  parseq_fct(CL, VC, .factor = 2, .n = 5) %>% 
  sens_each()

## -----------------------------------------------------------------------------
param(mod)[c("CL", "VC")]

## -----------------------------------------------------------------------------
out
class(out)

## -----------------------------------------------------------------------------
count(out, p_name, dv_name)

## -----------------------------------------------------------------------------
sens_plot(out, "RESP")

## -----------------------------------------------------------------------------
mod %>% 
  ev(amt = 100) %>% 
  parseq_cv(CL, .cv = 50, .nsd = 2) %>% 
  sens_each() %>% 
  sens_plot("CP")

## ----fig.height = 4-----------------------------------------------------------
out <- 
  mod %>% 
  ev(amt = 100, ii = 24, addl = 10) %>%
  update(end = 240) %>% 
  parseq_manual(VC = seq(10,100,20)) %>% 
  sens_each()

sens_plot(out, "CP")

## -----------------------------------------------------------------------------
out <- 
  mod %>% 
  ev(amt = 100) %>%
  parseq_fct(CL, KA, .n = 3) %>% 
  sens_each(end = 36)

## ----fig.height = 5-----------------------------------------------------------
sens_plot(out, layout = "facet_wrap")

## ----fig.height = 5-----------------------------------------------------------
sens_plot(out, layout = "facet_grid")

## -----------------------------------------------------------------------------
sens_plot(out, dv_name = "CP", grid = TRUE)

## ----fig.height = 6-----------------------------------------------------------
out %>% 
  select_sens(dv_name = "RESP,CP") %>% 
  sens_plot(grid = TRUE) %>% 
  patchwork::wrap_plots(ncol = 1)

