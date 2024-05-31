
source(here::here("R/functions.R"))

# Path to absence data
absence_data_file_path <- here::here("_data/raw/1_absence_3term_nat_reg_la.csv")

# Extract national absence and format date
df_nat_absence <- get_nat_absence_data(absence_data_file_path) |>
  format_time_period()

# Fit a linear model
model <- fit_model(df_nat_absence)

# Plot the data and model
plot_model(model, df_nat_absence)
