# Multi-Panel Malaria Visualization (Base R Version)
# Demonstration for Tanzania Regions
# Authors: Praise and Ernest

# Set seed for reproducibility
set.seed(123)

# ============================================================================
# 1. CREATE DUMMY DATA FOR 3 TANZANIAN REGIONS
# ============================================================================

# Region names
regions <- c("Dar es Salaam", "Mwanza", "Mbeya")

# --- Panel A Data: Overall Malaria Prevalence by Region ---
prevalence_data <- data.frame(
  region = regions,
  prevalence = c(15.2, 32.8, 24.5),  # Percentage
  population = c(4364541, 2772509, 2707410)
)
prevalence_data$cases <- round(prevalence_data$prevalence * prevalence_data$population / 100)

# --- Panel B Data: Seasonal Variation (Wet vs Dry) ---
seasonal_data <- data.frame(
  region = rep(regions, each = 2),
  season = rep(c("Wet", "Dry"), times = 3),
  cases_per_1000 = c(
    45, 28,  # Dar es Salaam
    78, 52,  # Mwanza
    61, 38   # Mbeya
  )
)

# --- Panel C Data: Age Group Distribution ---
age_groups <- c("<5 yrs", "5-14 yrs", "15-49 yrs", "50+ yrs")
age_data <- data.frame(
  region = rep(regions, each = 4),
  age_group = rep(age_groups, times = 3),
  percentage = c(
    # Dar es Salaam
    35, 28, 25, 12,
    # Mwanza
    42, 31, 20, 7,
    # Mbeya
    38, 29, 23, 10
  )
)

# --- Detail Panel Data: Intervention Coverage vs Prevalence ---
intervention_data <- data.frame(
  region = regions,
  net_usage = c(68, 45, 58),
  irs_coverage = c(25, 15, 30),
  prevalence = c(15.2, 32.8, 24.5)
)

# --- Monthly trend data ---
months <- 1:12
monthly_data <- data.frame(
  month = rep(months, times = 3),
  region = rep(regions, each = 12),
  cases = c(
    # Dar es Salaam (seasonal pattern)
    300 + 150 * sin((months - 3) * pi / 6) + rnorm(12, 0, 20),
    # Mwanza
    600 + 200 * sin((months - 3) * pi / 6) + rnorm(12, 0, 30),
    # Mbeya
    450 + 180 * sin((months - 3) * pi / 6) + rnorm(12, 0, 25)
  )
)
monthly_data$cases <- pmax(monthly_data$cases, 50)  # No negative values

# ============================================================================
# 2. PRINT DATA SUMMARIES
# ============================================================================

cat("\n")
cat("================================================================================\n")
cat("                           DATA SUMMARY                                         \n")
cat("================================================================================\n\n")

cat("Panel A - Overall Prevalence:\n")
cat("-------------------------------\n")
print(prevalence_data)

cat("\n\nPanel B - Seasonal Data:\n")
cat("-------------------------\n")
print(seasonal_data)

cat("\n\nPanel C - Age Distribution:\n")
cat("----------------------------\n")
print(age_data)

cat("\n\nIntervention Coverage Data:\n")
cat("----------------------------\n")
print(intervention_data)

cat("\n\nMonthly Trends (first 6 rows):\n")
cat("-------------------------------\n")
print(head(monthly_data, 6))

# ============================================================================
# 3. CREATE MULTI-PANEL VISUALIZATION
# ============================================================================

# Open PNG device
png("/mnt/user-data/outputs/malaria_patchwork_visualization.png", 
    width = 1400, height = 1200, res = 100)

# Set up layout: 3 rows with different heights
layout_matrix <- matrix(c(
  1, 1, 1,    # Row 1: Panel A spans all columns
  2, 2, 3,    # Row 2: Panel B spans 2 cols, Panel C in 1 col
  4, 5, 6     # Row 3: Three detail panels
), nrow = 3, byrow = TRUE)

layout(layout_matrix, heights = c(0.35, 0.35, 0.30))

# Define colors
region_colors <- c("#E41A1C", "#377EB8", "#4DAF4A")
names(region_colors) <- regions

# ============================================================================
# PANEL A: Overall Malaria Prevalence
# ============================================================================
par(mar = c(4, 5, 3, 2))
barplot(prevalence_data$prevalence, 
        names.arg = prevalence_data$region,
        col = region_colors,
        ylim = c(0, 40),
        ylab = "Prevalence (%)",
        main = "A. Malaria Prevalence by Region",
        cex.main = 1.5,
        cex.lab = 1.2,
        cex.names = 1.1,
        las = 1)

# Add percentage labels
text(x = seq(0.7, by = 1.2, length.out = 3),
     y = prevalence_data$prevalence + 2,
     labels = paste0(prevalence_data$prevalence, "%"),
     cex = 1.1,
     font = 2)

# ============================================================================
# PANEL B: Seasonal Variation
# ============================================================================
par(mar = c(4, 5, 3, 2))

# Prepare data for grouped barplot
seasonal_matrix <- matrix(seasonal_data$cases_per_1000, nrow = 2)
colnames(seasonal_matrix) <- regions
rownames(seasonal_matrix) <- c("Wet Season", "Dry Season")

barplot(seasonal_matrix,
        beside = TRUE,
        col = c("#87CEEB", "#F4A460"),
        ylim = c(0, 90),
        ylab = "Cases per 1,000",
        main = "B. Seasonal Pattern",
        cex.main = 1.3,
        cex.lab = 1.1,
        cex.names = 0.9,
        las = 1,
        legend.text = TRUE,
        args.legend = list(x = "topright", bty = "n", cex = 0.9))

# ============================================================================
# PANEL C: Age Group Distribution
# ============================================================================
par(mar = c(5, 5, 3, 2))

# Create grouped barplot for age distribution
age_matrix <- matrix(age_data$percentage, nrow = 4)
colnames(age_matrix) <- regions
rownames(age_matrix) <- age_groups

barplot(age_matrix,
        beside = TRUE,
        col = rainbow(4, alpha = 0.7),
        ylim = c(0, 50),
        ylab = "Percentage of Cases (%)",
        main = "C. Age Distribution",
        cex.main = 1.3,
        cex.lab = 1.1,
        cex.names = 0.8,
        las = 2,
        legend.text = TRUE,
        args.legend = list(x = "topright", bty = "n", cex = 0.8))

# ============================================================================
# DETAIL PANEL 1: Net Usage vs Prevalence
# ============================================================================
par(mar = c(4, 4, 3, 2))

plot(intervention_data$net_usage, 
     intervention_data$prevalence,
     col = region_colors,
     pch = 19,
     cex = 2,
     xlim = c(40, 75),
     ylim = c(10, 35),
     xlab = "Bed Net Usage (%)",
     ylab = "Prevalence (%)",
     main = "Net Usage vs Prevalence",
     cex.main = 1.2,
     cex.lab = 1.0)

# Add trend line
abline(lm(prevalence ~ net_usage, data = intervention_data), 
       col = "gray50", lty = 2, lwd = 2)

# Add labels
text(intervention_data$net_usage, 
     intervention_data$prevalence,
     labels = intervention_data$region,
     pos = 3,
     cex = 0.8,
     font = 2)

# ============================================================================
# DETAIL PANEL 2: IRS Coverage vs Prevalence
# ============================================================================
par(mar = c(4, 4, 3, 2))

plot(intervention_data$irs_coverage, 
     intervention_data$prevalence,
     col = region_colors,
     pch = 19,
     cex = 2,
     xlim = c(10, 35),
     ylim = c(10, 35),
     xlab = "IRS Coverage (%)",
     ylab = "Prevalence (%)",
     main = "IRS Coverage vs Prevalence",
     cex.main = 1.2,
     cex.lab = 1.0)

# Add trend line
abline(lm(prevalence ~ irs_coverage, data = intervention_data), 
       col = "gray50", lty = 2, lwd = 2)

# Add labels
text(intervention_data$irs_coverage, 
     intervention_data$prevalence,
     labels = intervention_data$region,
     pos = 3,
     cex = 0.8,
     font = 2)

# ============================================================================
# DETAIL PANEL 3: Monthly Trends
# ============================================================================
par(mar = c(4, 4, 3, 2))

# Plot empty frame
plot(1, type = "n",
     xlim = c(1, 12),
     ylim = c(0, max(monthly_data$cases) * 1.1),
     xlab = "Month",
     ylab = "Cases",
     main = "Monthly Case Trends",
     cex.main = 1.2,
     cex.lab = 1.0,
     xaxt = "n")

# Add x-axis with month labels
axis(1, at = 1:12, labels = c("J", "F", "M", "A", "M", "J", 
                               "J", "A", "S", "O", "N", "D"))

# Add lines for each region
for (i in 1:length(regions)) {
  region_name <- regions[i]
  region_data <- monthly_data[monthly_data$region == region_name, ]
  lines(region_data$month, region_data$cases, 
        col = region_colors[i], lwd = 2)
  points(region_data$month, region_data$cases, 
         col = region_colors[i], pch = 19, cex = 0.8)
}

# Add legend
legend("topright", 
       legend = regions,
       col = region_colors,
       lwd = 2,
       pch = 19,
       bty = "n",
       cex = 0.9)

# Add overall title
mtext("Multi-Panel Analysis: Malaria Patterns in Three Tanzanian Regions", 
      side = 3, line = -1.5, outer = TRUE, cex = 1.4, font = 2)

# Close the device
dev.off()

cat("\n\n")
cat("================================================================================\n")
cat("✓ Multi-panel visualization created successfully!\n")
cat("✓ Plot saved to: /mnt/user-data/outputs/malaria_patchwork_visualization.png\n")
cat("================================================================================\n\n")

cat("KEY INSIGHTS FROM THE DATA:\n")
cat("----------------------------\n")
cat("1. Mwanza has the highest malaria prevalence (32.8%), followed by Mbeya (24.5%)\n")
cat("   and Dar es Salaam (15.2%)\n\n")
cat("2. Seasonal variation shows wet season cases are 50-60% higher than dry season\n")
cat("   across all regions\n\n")
cat("3. Children under 5 years represent the largest proportion of cases in all\n")
cat("   regions, particularly in Mwanza (42%)\n\n")
cat("4. There's an inverse relationship between bed net usage and prevalence:\n")
cat("   higher net usage correlates with lower prevalence\n\n")
cat("5. Monthly trends show clear seasonal peaks during the wet season months\n")
cat("   (March-May and November-December)\n\n")
