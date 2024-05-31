library(targets)


# Run the R scripts in the R/ folder with your custom functions:
targets::tar_option_set(
  packages = c("dplyr", "lubridate",
               "ggplot2", "scales")
)
targets::tar_source(here::here("R/functions.R"))


# Replace the target list below with your own:
list(
  # Point to data file (not loaded)
  targets::tar_target(
    name = data_file,
    command = here::here("_data/raw/1_absence_3term_nat_reg_la.csv"),
    format = "file"
    ),

  # Pull the national absence
  targets::tar_target(
    name = nat_data,
    command = get_nat_absence_data(data_file)
    ),

  # Format the date
  targets::tar_target(
    name = nat_data_clean,
    command = format_time_period(nat_data)
    ),

  # Fit a linear model
  targets::tar_target(
    name = model,
    command = fit_model(nat_data_clean)
  ),

  # Plot the data and model
  targets::tar_target(
    name = plot,
    command = plot_model(model = model,
                         data = nat_data_clean),
    format = "file"
  )
)
