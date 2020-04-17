# SEIR Analysis for COVID-19

This R script uses the [SEIR](https://en.wikipedia.org/wiki/Compartmental_models_in_epidemiology#The_SEIR_model) compartmental model to generate an epidemiological analysis of COVID-19.

## Requirements

You must have the `SimInf` R package installed.

## Usage

You may generate a default model by not passing any parameters to the `runSEIR()` function:

    source("seir.R", chdir = TRUE)
	model <- runSEIR()

If you would like a visual representation of the model, you may simply plot it. The `trajectory(model)` and `prevalence(model, expression)` functions may also be of analytical use; see the SimInf documentation for info on those functions.

## Why was this made?

I made this out of boredom, and also to submit into a research contest run by Creighton University's Center for Undergraduate Research and Scholarship. Accompanying it is a video I created to help others better understand the impact that people can have on the spread of COVID-19. A link will be inserted into this document when the video is released.
