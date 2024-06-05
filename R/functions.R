
source(here::here("R/plot_styles.R"))

# Pull national absence from file
get_nat_absence_data <- function(file_path) {
  read.csv(file = file_path) |>
    dplyr::filter(geographic_level == "National")
}

# Extract the start year from academic year
extract_year <- function(date) {
  paste0("01-01-",substr(date, 1, 2),substr(date, 5, 6))
}

# Format the year as a date
format_time_period <- function(data) {
  data |>
    dplyr::mutate(Date = as.Date(extract_year(time_period),
                                 format = "%d-%m-%Y"),
                  .after=time_period)
}


# Fit the model and pull coefficients
fit_model <- function(data) {
  lm(sess_overall_percent_pa_10_exact ~ Date, data) |>
    coefficients()
}

# Round to the nearets multiple of five
round_to_multiple_five <- function(x) {
  ceiling((x + 1)/5)*5
}

# Plot the data and model
plot_model <- function(model, data) {
  plot <- ggplot2::ggplot(data) +
    ggplot2::geom_point(ggplot2::aes(x = Date,
                                     y = sess_overall_percent_pa_10_exact,
                                     colour = school_type)) +
    ggplot2::geom_line(ggplot2::aes(x = Date,
                                     y = sess_overall_percent_pa_10_exact,
                                     colour = school_type)) +
    ggplot2::scale_colour_manual(values = color_picker(4), #kasstylesr
                                 breaks = c("Total", "State-funded primary",
                                            "State-funded secondary", "Special")) +
    ggplot2::geom_abline(intercept = model[1],
                         slope = model[2],
                         show.legend = T,
                         colour="red",
                         linetype="dashed") +
    ggplot2::annotate("text",
                      x = max(data$Date),
                      y = lm(sess_overall_percent_pa_10_exact ~ Date,
                             data) |>
                        fitted.values() |>
                        max(),
                      hjust = -0.45,
                      label = "Line of best fit",
                      colour = "red") +
    ggplot2::scale_y_continuous(breaks = scales::pretty_breaks(),
                                limits = function(x) {
                                  c(0, round_to_multiple_five(max(x)))
                                }) +
    ggplot2::coord_cartesian(clip = 'off') +
    ggplot2::theme_minimal() +
    kas_style() + #kasstylesr
    ggplot2::labs(
      title = "Average persistent absence over time in England",
      subtitle = "Split by school type. Only includes persistent absentees.",
      x = "",
      y = "Overall absence rate (%)",
      colour = "School type:"
    )

  ggplot2::ggsave(here::here("_outputs/ab_plot.png"),
                  plot = plot)

  "_outputs/ab_plot.png"
}
