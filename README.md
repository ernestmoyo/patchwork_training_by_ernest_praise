# Multi-Panel Malaria Visualization with Patchwork
## Demonstration for Tanzania Regions

**Authors:** Praise and Ernest  
**Date:** November 25, 2025

---

## Overview

This demonstration showcases how to use the patchwork package (or base R) to create 
publication-quality multi-panel visualizations for epidemiological data. We use 
simulated malaria data from three Tanzanian regions: Dar es Salaam, Mwanza, and Mbeya.

---

## Visualization Structure

Following the layout sketch provided, our multi-panel figure consists of:

### **Top Row (Panel A):**
- **Overall Malaria Prevalence by Region**
- Main overview showing comparative prevalence across the three regions
- Mwanza shows highest prevalence (32.8%), Dar es Salaam lowest (15.2%)

### **Middle Row (Panels B & C):**
- **Panel B: Seasonal Pattern**
  - Compares malaria cases during wet vs dry seasons
  - Shows wet season cases are 50-60% higher across all regions
  
- **Panel C: Age Distribution of Cases**
  - Breaks down cases by age group (<5, 5-14, 15-49, 50+ years)
  - Children under 5 represent the largest proportion in all regions

### **Bottom Row (Detail Panels 1-3):**
- **Detail Panel 1: Net Usage vs Prevalence**
  - Scatter plot showing inverse relationship
  - Higher bed net usage correlates with lower prevalence
  
- **Detail Panel 2: IRS Coverage vs Prevalence**
  - Indoor Residual Spraying coverage relationship with prevalence
  - Shows intervention effectiveness patterns
  
- **Detail Panel 3: Monthly Case Trends**
  - Time series showing seasonal patterns throughout the year
  - Clear peaks during wet season months (Mar-May, Nov-Dec)

---

## Data Summary

### Panel A - Regional Prevalence
| Region         | Prevalence (%) | Population | Cases   |
|---------------|----------------|------------|---------|
| Dar es Salaam | 15.2           | 4,364,541  | 663,410 |
| Mwanza        | 32.8           | 2,772,509  | 909,383 |
| Mbeya         | 24.5           | 2,707,410  | 663,315 |

### Panel B - Seasonal Variation
| Region         | Wet Season | Dry Season |
|---------------|------------|------------|
| Dar es Salaam | 45/1,000   | 28/1,000   |
| Mwanza        | 78/1,000   | 52/1,000   |
| Mbeya         | 61/1,000   | 38/1,000   |

### Panel C - Age Distribution (% of total cases)
| Age Group  | Dar es Salaam | Mwanza | Mbeya |
|-----------|---------------|--------|-------|
| <5 years  | 35%           | 42%    | 38%   |
| 5-14 yrs  | 28%           | 31%    | 29%   |
| 15-49 yrs | 25%           | 20%    | 23%   |
| 50+ years | 12%           | 7%     | 10%   |

### Intervention Coverage
| Region         | Net Usage (%) | IRS Coverage (%) | Prevalence (%) |
|---------------|---------------|------------------|----------------|
| Dar es Salaam | 68            | 25               | 15.2           |
| Mwanza        | 45            | 15               | 32.8           |
| Mbeya         | 58            | 30               | 24.5           |

---

## Key Insights

1. **Regional Disparities:** Mwanza has more than double the prevalence of Dar es Salaam, 
   indicating need for targeted interventions in high-burden areas.

2. **Seasonal Impact:** Wet season shows 50-60% increase in cases across all regions, 
   suggesting importance of pre-seasonal intervention campaigns.

3. **Vulnerable Populations:** Children under 5 years represent 35-42% of cases, 
   highlighting need for pediatric-focused prevention strategies.

4. **Intervention Effectiveness:** Clear inverse relationship between bed net usage 
   and prevalence, demonstrating effectiveness of preventive measures.

5. **Temporal Patterns:** Monthly trends show predictable seasonal peaks, enabling 
   better resource allocation and preparedness.

---

## Files Included

1. **malaria_patchwork_visualization.png** - Final multi-panel figure
2. **malaria_patchwork_demo.R** - Original script using tidyverse/patchwork
3. **malaria_base_r_demo.R** - Base R version (no external packages needed)
4. **README.md** - This documentation file

---

## How to Use the Scripts

### Option 1: With Patchwork (Recommended)
```r
# Install required packages (one time only)
install.packages(c("tidyverse", "patchwork", "sf", "scales"))

# Run the script
source("malaria_patchwork_demo.R")
```

### Option 2: Base R (No packages needed)
```r
# Run the script directly
source("malaria_base_r_demo.R")
```

Both scripts will:
- Generate the multi-panel visualization
- Print data summaries to console
- Save the figure as a PNG file
- Provide key insights from the data

---

## Patchwork Benefits

The patchwork package provides several advantages for creating multi-panel figures:

1. **Intuitive Syntax:** Use `+`, `/`, and `|` operators to combine plots
   - `plot1 + plot2` = side by side
   - `plot1 / plot2` = stacked vertically
   - `(plot1 | plot2) / plot3` = complex layouts

2. **Flexible Layouts:** Easy control over relative sizes and arrangements

3. **Professional Output:** Automatic alignment and spacing

4. **Publication Ready:** Built-in support for panel labels (A, B, C...)

5. **Annotation Support:** Add titles, subtitles, and captions to entire composition

---

## Learning Objectives

By studying this example, students will learn:

1. How to structure complex data for multi-panel visualizations
2. Techniques for combining different plot types (bar, scatter, line)
3. Creating hierarchical panel arrangements
4. Color scheme consistency across panels
5. Adding informative labels and legends
6. Telling a complete data story through integrated visualizations

---

## Applications

This approach is valuable for:

- **Research Papers:** Creating publication-quality figures
- **Reports:** Comprehensive data summaries
- **Presentations:** Clear visual communication
- **Policy Briefs:** Evidence-based recommendations
- **Thesis/Dissertation:** Professional data visualization

---

## Contact

For questions about this demonstration:
- Praise and Ernest
- Lesson Presentation: Friday

---

## References

- Patchwork package: https://patchwork.data-imaginist.com/
- ggplot2 documentation: https://ggplot2.tidyverse.org/
- R Graphics Cookbook: https://r-graphics.org/

---

**Note:** All data in this demonstration is simulated for educational purposes. 
Real malaria surveillance data should be obtained from official sources such as 
the Tanzania National Malaria Control Program or WHO.
