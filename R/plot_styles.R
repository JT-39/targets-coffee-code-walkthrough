#' Add KAS theme to ggplot chart
#'
#' This function allows you to add the KAS theme to your ggplot graphics.
#' @keywords kas_style
#' @import ggplot2
#' @examples
#' example_chart <- ggplot2::ggplot(data = iris) +
#'   ggplot2::aes(x = Petal.Length, y = Petal.Width) +
#'   ggplot2::geom_point(ggplot2::aes(color = Species, shape = Species)) +
#'   kas_style()
#' @export

kas_style <- function() {
  font <- "sans"
  base_size <- 12
  half_line <- base_size / 2
  
  ggplot2::theme(
    
    # Text format:
    # This sets the font, size, type and colour of text for the chart's title
    plot.title = ggplot2::element_text(
      family = font,
      size = 18,
      face = "bold",
      color = "#000000"
    ),
    plot.title.position = "panel",
    
    # This sets the font, size, type and colour of text for the chart's
    # subtitle, as well as setting a margin between the title and the subtitle
    plot.subtitle = ggplot2::element_text(
      family = font,
      size = 12,
      margin = ggplot2::margin(9, 0, 9, 0)
    ),
    plot.caption = ggplot2::element_blank(),
    plot.margin = ggplot2::margin(half_line, half_line, half_line, half_line),
    
    
    # This leaves the caption text element empty, because it is set elsewhere
    # in the finalise plot function
    text = ggplot2::element_text(
      face = "plain", # Can be plain, italic, bold, bold.italic
      colour = "black",
      lineheight = 0.9,
      hjust = 0.5, # Determine x-axis label position
      vjust = 0.5, # determines y-axis label position
      angle = 0,
      margin = ggplot2::margin(),
      debug = FALSE
    ),
    
    # Legend format
    # This sets the position and alignment of the legend, removes a title
    # and backround for it and sets the requirements for any text within the
    # legend. The legend may often need some more manual tweaking when it comes
    # to its exact position based on the plot coordinates.
    legend.position = "right",
    legend.background = ggplot2::element_blank(),
    legend.key = ggplot2::element_blank(),
    legend.text = ggplot2::element_text(
      hjust=0,
      family = font,
      size = 12,
      color = "#000000"
    ),
    
    # Axis format
    # This sets the text font, size and colour for the axis test,
    # as well as setting the margins and removes lines and ticks.
    # In some cases, axis lines and axis ticks are things we would want to
    # have in the chart - the cookbook shows examples of how to do so.
    axis.text = ggplot2::element_text(
      family = font,
      size = 12,
      color = "#000000"
    ),
    axis.text.x = ggplot2::element_text(
      margin = ggplot2::margin(t = 0.8 * half_line / 4),
      vjust = 1
    ),
    axis.text.x.top = ggplot2::element_text(
      margin = ggplot2::margin(b = 0.8 * half_line / 4),
      vjust = 0
    ),
    axis.text.y = ggplot2::element_text(
      margin = ggplot2::margin(r = 0.8 * half_line / 4),
      hjust = 1
    ),
    axis.text.y.right = ggplot2::element_text(
      margin = ggplot2::margin(l = 0.8 * half_line / 4),
      hjust = 0
    ),
    
    # now setting small ticks for x axis
    axis.ticks = ggplot2::element_line(colour = "black"), # "grey85"
    axis.ticks.length = ggplot2::unit(half_line / 2, "pt"),
    
    
    axis.line = ggplot2::element_blank(),
    axis.title.x = ggplot2::element_text(
      margin = ggplot2::margin(t = half_line / 2),
      vjust = 1, face = "bold"
    ),
    axis.title.x.top = ggplot2::element_text(
      margin = ggplot2::margin(b = half_line / 2),
      vjust = 0
    ),
    axis.title.y = ggplot2::element_text(
      angle = 90, margin = ggplot2::margin(r = half_line / 2),
      vjust = 1, face = "bold"
    ),
    axis.title.y.right = ggplot2::element_text(
      angle = -90,
      margin = ggplot2::margin(l = half_line / 2),
      vjust = 0
    ),
    
    # Grid lines
    # This removes all minor gridlines and adds major y gridlines.
    # In many cases you will want to change this to remove y gridlines and
    # add x gridlines. The cookbook shows you examples for doing so
    panel.grid.minor = ggplot2::element_blank(),
    panel.grid.major.y = ggplot2::element_line(
      linewidth = ggplot2::rel(0.5),
      color = "gray85"
    ),
    panel.grid.major.x = ggplot2::element_blank(),
    panel.spacing = ggplot2::unit(half_line, "pt"),
    panel.ontop = FALSE,
    
    # Blank background
    # This sets the panel background as blank,
    # removing the standard grey ggplot background colour from the plot
    panel.background = ggplot2::element_rect(fill = "white", colour = NA),
    
    # Strip background (This sets the panel background for
    # facet-wrapped plots to white, removing the standard grey ggplot background
    # colour and sets the title size of the facet-wrap title to font size 22)
    strip.background = ggplot2::element_rect(fill = "grey85", colour = NA),
    strip.text = ggplot2::element_text(
      size = 12, hjust = 0,
      margin = ggplot2::margin(0.8 * half_line, 0.8 * half_line, 0.8 * half_line, 0.8
                      * half_line)
    ),
    strip.text.y = ggplot2::element_text(angle = -90),
    strip.text.y.left = ggplot2::element_text(angle = 90),
    strip.placement = "inside",
    strip.switch.pad.grid = ggplot2::unit(half_line / 2, "pt"),
    strip.switch.pad.wrap = ggplot2::unit(half_line / 2, "pt"),
    plot.background = ggplot2::element_rect(colour = "white"),
  )
}

#' Function returns a list of colors to use in a chart bound to a category. With
#' error handling to warn users if too many colours are
#' being used with a certain
#' palette.
#' @param categories The list of categories in to assign colors to for the chart
#' @param primary_palette Boolean indicator of whether to use the primary colour
#' palette or not (T/F)
#' @return list of colours matched to a category
#' @examples
#' color_picker(3)
#' color_picker(c("series1", "series2", "series3"), primary_palette = TRUE)
#' @export

color_picker <- function(categories, primary_palette = FALSE) {
  multi_colors <- list(
    "#003D6B",
    "#D67D00",
    "#850018",
    "#57A0A2",
    "#310B4A",
    "#B154AC",
    "#18150C",
    "#89966D"
  )
  primary_colors <- list(
    "#003D6B",
    "#5D99C6",
    "#071527"
  )
  
  # matches categories, whether integer or actual categories passed, to the
  # number of colours required
  to <- ifelse(is.numeric(categories), categories, length(categories))
  
  
  # error handle more than 8 categories
  if (to > 8) {
    print("Error only 8 categories can be used in accordance with best practice.
          To override this more colours need to be added to the color_picker.R
          script and used manually. Alternatively, visualisations using facet
          columns/rows could be more accessible.")
    stop()
  }
  
  colors <- if (primary_palette == FALSE) {
    # Give warning (not an error) if more than 3 categories selected
    # (best practice), still returns colours
    if (to > 4) {
      warning("Best practice warning: More than 4 colours selected.
              Colours still added")
    }
    multi_colors[1:to]
  } else {
    # If primary colour theme and more than 3 items to colour, output switches
    # to multicolour theme
    if (to > 3) {
      warning("More than 3 items selected with Primary theme,
              returning chart with the multicolour theme")
      multi_colors[1:to]
    } else {
      # Primary colour theme is used
      primary_colors[1:to]
    }
  }
  
  return(unlist(colors))
}