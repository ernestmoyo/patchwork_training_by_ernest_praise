# Multi-Panel Malaria Visualization with Patchwork
# Demonstration for Tanzania Regions
# Authors: Praise and Ernest

# Load required packages
library(tidyverse)
library(patchwork)
library(sf)
library(scales)

# Set seed for reproducibility
set.seed(123)

# ============================================================================
# 1. CREATE DUMMY DATA FOR 3 TANZANIAN REGIONS
# ============================================================================

# Region names
regions <- c("Dar es Salaam", "Mwanza", "Mbeya")

# --- Panel A Data: Overall Malaria Prevalence by Region ---
prevalence_data <- tibble(
  region = regions,
  prevalence = c(15.2, 32.8, 24.5),  # Percentage
  population = c(4364541, 2772509, 2707410),
  cases = round(c(15.2, 32.8, 24.5) * c(4364541, 2772509, 2707410) / 100)
)

# --- Panel B Data: Seasonal Variation (Wet vs Dry) ---
seasonal_data <- tibble(
  region = rep(regions, each = 2),
  season = rep(c("Wet Season", "Dry Season"), times = 3),
  cases_per_1000 = c(
    45, 28,  # Dar es Salaam
    78, 52,  # Mwanza
    61, 38   # Mbeya
  )
)

# --- Panel C Data: Age Group Distribution ---
age_data <- expand_grid(
  region = regions,
  age_group = c("<5 years", "5-14 years", "15-49 years", "50+ years")
) %>%
  mutate(
    percentage = case_when(
      region == "Dar es Salaam" & age_group == "<5 years" ~ 35,
      region == "Dar es Salaam" & age_group == "5-14 years" ~ 28,
      region == "Dar es Salaam" & age_group == "15-49 years" ~ 25,
      region == "Dar es Salaam" & age_group == "50+ years" ~ 12,
      
      region == "Mwanza" & age_group == "<5 years" ~ 42,
      region == "Mwanza" & age_group == "5-14 years" ~ 31,
      region == "Mwanza" & age_group == "15-49 years" ~ 20,
      region == "Mwanza" & age_group == "50+ years" ~ 7,
      
      region == "Mbeya" & age_group == "<5 years" ~ 38,
      region == "Mbeya" & age_group == "5-14 years" ~ 29,
      region == "Mbeya" & age_group == "15-49 years" ~ 23,
      region == "Mbeya" & age_group == "50+ years" ~ 10
    )
  ) %>%
  mutate(age_group = factor(age_group, levels = c("<5 years", "5-14 years", 
                                                    "15-49 years", "50+ years")))

# --- Detail Panels Data: Intervention Coverage vs Prevalence ---
intervention_data <- tibble(
  region = regions,
  net_usage = c(68, 45, 58),  # Percentage of households using bed nets
  irs_coverage = c(25, 15, 30),  # Indoor residual spraying coverage
  prevalence = c(15.2, 32.8, 24.5)
)

# Monthly trend data for detailed time series
monthly_data <- expand_grid(
  region = regions,
  month = month.name
) %>%
  mutate(
    month = factor(month, levels = month.name),
    month_num = as.numeric(month),
    # Create seasonal pattern with peak in wet season (Mar-May, Nov-Dec)
    cases = case_when(
      region == "Dar es Salaam" ~ 300 + 150 * sin((month_num - 3) * pi / 6) + rnorm(n(), 0, 20),
      region == "Mwanza" ~ 600 + 200 * sin((month_num - 3) * pi / 6) + rnorm(n(), 0, 30),
      region == "Mbeya" ~ 450 + 180 * sin((month_num - 3) * pi / 6) + rnorm(n(), 0, 25)
    )
  ) %>%
  mutate(cases = pmax(cases, 50))  # Ensure no negative values

# ============================================================================
# 2. CREATE INDIVIDUAL PLOTS
# ============================================================================

# Define consistent color palette
region_colors <- c("Dar es Salaam" = "#E41A1C", 
                   "Mwanza" = "#377EB8", 
                   "Mbeya" = "#4DAF4A")

# --- PANEL A: Overall Malaria Prevalence (Main Map Substitute) ---
plot_a <- ggplot(prevalence_data, aes(x = reorder(region, -prevalence), 
                                       y = prevalence, 
                                       fill = region)) +
  geom_col(width = 0.7) +
  geom_text(aes(label = paste0(prevalence, "%")), 
            vjust = -0.5, size = 5, fontface = "bold") +
  scale_fill_manual(values = region_colors) +
  labs(title = "A. Malaria Prevalence by Region",
       subtitle = "Overall prevalence across three Tanzanian regions",
       x = NULL,
       y = "Prevalence (%)") +
  theme_minimal(base_size = 12) +
  theme(legend.position = "none",
        plot.title = element_text(face = "bold", size = 14),
        plot.subtitle = element_text(size = 10, color = "gray40"),
        axis.text.x = element_text(angle = 0, hjust = 0.5, size = 11),
        panel.grid.major.x = element_blank()) +
  ylim(0, 40)

# --- PANEL B: Seasonal Variation ---
plot_b <- ggplot(seasonal_data, aes(x = season, y = cases_per_1000, fill = region)) +
  geom_col(position = position_dodge(width = 0.8), width = 0.7) +
  scale_fill_manual(values = region_colors) +
  labs(title = "B. Seasonal Pattern",
       x = NULL,
       y = "Cases per 1,000",
       fill = "Region") +
  theme_minimal(base_size = 11) +
  theme(plot.title = element_text(face = "bold", size = 12),
        legend.position = "bottom",
        axis.text.x = element_text(size = 10))

# --- PANEL C: Age Group Distribution ---
plot_c <- ggplot(age_data, aes(x = age_group, y = percentage, fill = region)) +
  geom_col(position = position_dodge(width = 0.8), width = 0.7) +
  scale_fill_manual(values = region_colors) +
  labs(title = "C. Age Distribution of Cases",
       x = "Age Group",
       y = "Percentage of Cases (%)",
       fill = "Region") +
  theme_minimal(base_size = 11) +
  theme(plot.title = element_text(face = "bold", size = 12),
        legend.position = "bottom",
        axis.text.x = element_text(angle = 45, hjust = 1, size = 9))

# --- DETAIL PANEL 1: Net Usage vs Prevalence ---
detail_plot_1 <- ggplot(intervention_data, aes(x = net_usage, y = prevalence)) +
  geom_point(aes(color = region), size = 4) +
  geom_smooth(method = "lm", se = FALSE, color = "gray50", linetype = "dashed") +
  geom_text(aes(label = region, color = region), 
            vjust = -1, size = 3, fontface = "bold") +
  scale_color_manual(values = region_colors) +
  labs(title = "Net Usage vs Prevalence",
       x = "Bed Net Usage (%)",
       y = "Prevalence (%)") +
  theme_minimal(base_size = 10) +
  theme(legend.position = "none",
        plot.title = element_text(face = "bold", size = 11))

# --- DETAIL PANEL 2: IRS Coverage vs Prevalence ---
detail_plot_2 <- ggplot(intervention_data, aes(x = irs_coverage, y = prevalence)) +
  geom_point(aes(color = region), size = 4) +
  geom_smooth(method = "lm", se = FALSE, color = "gray50", linetype = "dashed") +
  geom_text(aes(label = region, color = region), 
            vjust = -1, size = 3, fontface = "bold") +
  scale_color_manual(values = region_colors) +
  labs(title = "IRS Coverage vs Prevalence",
       x = "IRS Coverage (%)",
       y = "Prevalence (%)") +
  theme_minimal(base_size = 10) +
  theme(legend.position = "none",
        plot.title = element_text(face = "bold", size = 11))

# --- DETAIL PANEL 3: Monthly Trends ---
detail_plot_3 <- ggplot(monthly_data, aes(x = month_num, y = cases, color = region, group = region)) +
  geom_line(linewidth = 1) +
  geom_point(size = 2) +
  scale_color_manual(values = region_colors) +
  scale_x_continuous(breaks = 1:12, labels = month.abb) +
  labs(title = "Monthly Case Trends",
       x = "Month",
       y = "Cases",
       color = "Region") +
  theme_minimal(base_size = 10) +
  theme(legend.position = "bottom",
        plot.title = element_text(face = "bold", size = 11),
        axis.text.x = element_text(angle = 45, hjust = 1, size = 8))

# ============================================================================
# 3. COMBINE PLOTS WITH PATCHWORK
# ============================================================================

# Layout design following the sketch:
# - Top row: Large Panel A spanning full width
# - Middle row: Panel B and Panel C side by side
# - Bottom row: Three detail panels side by side

final_plot <- (plot_a) / 
              (plot_b | plot_c) / 
              (detail_plot_1 | detail_plot_2 | detail_plot_3) +
  plot_layout(heights = c(2, 2, 1.5)) +
  plot_annotation(
    title = "Multi-Panel Analysis: Malaria Patterns in Three Tanzanian Regions",
    subtitle = "Comprehensive visualization combining prevalence, seasonality, demographics, and interventions",
    caption = "Data: Simulated for demonstration purposes | Created with patchwork",
    theme = theme(
      plot.title = element_text(size = 16, face = "bold"),
      plot.subtitle = element_text(size = 12, color = "gray40"),
      plot.caption = element_text(size = 9, color = "gray50", hjust = 1)
    )
  )

# Display the final combined plot
print(final_plot)

# Save the plot
ggsave("malaria_patchwork_visualization.png", 
       plot = final_plot, 
       width = 14, 
       height = 12, 
       dpi = 300,
       bg = "white")

cat("\n✓ Multi-panel visualization created successfully!\n")
cat("✓ Plot saved as 'malaria_patchwork_visualization.png'\n\n")

# ============================================================================
# 4. PRINT DATA SUMMARIES
# ============================================================================

cat("=" ,"=", rep("=", 70), "\n", sep = "")
cat("DATA SUMMARY\n")
cat("=" ,"=", rep("=", 70), "\n\n", sep = "")

cat("Panel A - Overall Prevalence:\n")
print(prevalence_data)

cat("\n\nPanel B - Seasonal Data:\n")
print(seasonal_data)

cat("\n\nPanel C - Age Distribution (first 6 rows):\n")
print(head(age_data))

cat("\n\nIntervention Data:\n")
print(intervention_data)

cat("\n\nMonthly Trends (first 6 rows):\n")
print(head(monthly_data))
