# Presentation Outline: Multi-Panel Visualizations with Patchwork
**Presenters:** Praise and Ernest  
**Duration:** 40 minutes  
**Date:** Friday

---

## SLIDE 1: Title Slide (1 min)
**Visual:** Clean title slide with course logo

**Content:**
- Creating Multi-Panel Visualizations with Patchwork in R
- A Case Study: Malaria Patterns in Tanzania
- Presenters: Praise and Ernest

**Say:**
"Good morning everyone. Today we're going to demonstrate how to create publication-quality 
multi-panel visualizations using the patchwork package in R. We'll use malaria data from 
three Tanzanian regions to show how you can tell a complete data story in a single figure."

---

## SLIDE 2: The Challenge (2 min)
**Visual:** Show 3-4 separate individual plots looking disconnected

**Content:**
- Research often produces multiple related visualizations
- Presenting them separately loses the connections
- Combining them manually in PowerPoint/Illustrator is tedious
- Hard to maintain consistency

**Say:**
"How many of you have created multiple plots for a project and struggled to present them 
together? Maybe you copy-pasted them into PowerPoint, tried to align them manually, and 
every time you updated your data, you had to start over? There's a better way."

---

## SLIDE 3: The Solution - Patchwork (2 min)
**Visual:** Patchwork logo and key features

**Content:**
- R package for combining ggplot2 plots
- Intuitive syntax: +, /, |
- Programmatic = reproducible
- Publication-ready output

**Code Example:**
```r
plot1 + plot2  # side by side
plot1 / plot2  # stacked
```

**Say:**
"Patchwork lets you combine plots using simple operators. Plus sign for side-by-side, 
forward slash for stacking. It's that simple. And because it's code, it's reproducible—
update your data, re-run your script, done."

---

## SLIDE 4: Our Tanzania Malaria Context (3 min)
**Visual:** Map of Tanzania highlighting three regions

**Content:**
- Three regions studied:
  * Dar es Salaam (coastal, urban)
  * Mwanza (lake region)
  * Mbeya (highlands)
- Multiple data dimensions:
  * Overall prevalence
  * Seasonal patterns
  * Age distribution
  * Intervention coverage

**Say:**
"For our demonstration, we're using malaria data from three diverse Tanzanian regions. 
Each has different geographic and demographic characteristics. We want to understand not 
just how much malaria there is, but when it peaks, who's most affected, and what 
interventions are working."

---

## SLIDE 5: Our Multi-Panel Layout (2 min)
**Visual:** Show the hand-drawn sketch

**Content:**
- Top: Main comparison (Panel A)
- Middle: Two supporting analyses (Panels B & C)
- Bottom: Three detail views
- Hierarchical information presentation

**Say:**
"Here's our layout plan. We want one main panel showing overall prevalence, two middle 
panels for seasonal and demographic breakdowns, and three smaller detail panels for 
intervention relationships and trends. This hierarchy guides the viewer from big picture 
to details."

---

## SLIDE 6: Building Block 1 - Individual Plots (4 min)
**Visual:** Show code for creating one plot (Panel A)

**Content:**
```r
# Panel A: Regional Prevalence
plot_a <- ggplot(prevalence_data, 
                 aes(x = region, y = prevalence, fill = region)) +
  geom_col() +
  labs(title = "A. Malaria Prevalence by Region") +
  theme_minimal()
```

**Key Points:**
- Consistent color scheme across all plots
- Same theme applied to all
- Clear titles and labels

**Say:**
"First, we create each plot individually using ggplot2. The key is consistency—same 
colors for the same regions, same theme, same style. This makes the final composition 
look professional and coherent."

---

## SLIDE 7: Building Block 2 - More Plots (3 min)
**Visual:** Show code for Panels B and C

**Content:**
```r
# Panel B: Seasonal Pattern
plot_b <- ggplot(seasonal_data, 
                 aes(x = season, y = cases, fill = region)) +
  geom_col(position = "dodge") +
  labs(title = "B. Seasonal Pattern") +
  theme_minimal()

# Panel C: Age Distribution  
plot_c <- ggplot(age_data, 
                 aes(x = age_group, y = percentage, fill = region)) +
  geom_col(position = "dodge") +
  theme_minimal()
```

**Say:**
"We create all our panels the same way. Notice how we're using the same region colors 
and the same minimal theme. This consistency is crucial for the final composition."

---

## SLIDE 8: The Magic - Combining with Patchwork (5 min)
**Visual:** Split screen - code on left, progressive build on right

**Content:**
```r
# Start simple
plot_a + plot_b  # Side by side

# Now stack
plot_a / plot_b  # Vertically stacked

# Our complex layout
(plot_a) /                          # Top row
(plot_b | plot_c) /                 # Middle row
(detail1 | detail2 | detail3) +     # Bottom row
plot_layout(heights = c(2, 2, 1.5))
```

**Demonstrate Live:**
- Type each line in RStudio
- Show the output after each step
- Build from simple to complex

**Say:**
"Watch how easy this is. First, plot_a plus plot_b gives us side by side. Change the 
plus to a slash, and they stack. Now let's build our full layout. We use parentheses to 
group things, and the pipe symbol for side-by-side within a row. The plot_layout function 
lets us adjust the relative heights. The top panels get more space than the bottom details."

---

## SLIDE 9: Adding Professional Touches (3 min)
**Visual:** Before and after with annotations

**Content:**
```r
final_plot <- [previous code] +
  plot_annotation(
    title = "Multi-Panel Analysis: Malaria Patterns in Tanzania",
    subtitle = "Comprehensive visualization of three regions",
    caption = "Data source: Simulated",
    tag_levels = 'A'  # Adds A, B, C, D, E, F labels
  )
```

**Features to highlight:**
- Overall title and subtitle
- Automatic panel labeling (A, B, C...)
- Caption for data source
- Unified theme

**Say:**
"Now we add the finishing touches. Plot_annotation adds an overall title, subtitle, and 
caption. The tag_levels parameter automatically adds A, B, C labels to each panel—perfect 
for publications where you need to reference specific panels in your text."

---

## SLIDE 10: The Final Result (4 min)
**Visual:** Full-screen view of the final visualization

**Content:**
- Show the complete multi-panel figure
- Walk through each panel briefly
- Highlight key insights:
  * Mwanza has highest burden (32.8%)
  * Clear seasonal patterns
  * Children most affected
  * Net usage inversely related to prevalence

**Say:**
"Here's our final figure. In one image, we can see the regional disparities, seasonal 
patterns, age distribution, and intervention effectiveness. Mwanza clearly has the 
highest burden at nearly 33%, more than double Dar es Salaam's 15%. The seasonal panels 
show wet season cases are 50-60% higher. Children under 5 represent 35-42% of cases. And 
look at the bottom left—regions with higher bed net usage have lower prevalence. This is 
the power of multi-panel visualizations: telling a complete, compelling story in a single 
figure."

---

## SLIDE 11: Key Patchwork Operators Summary (2 min)
**Visual:** Clean reference table

**Content:**
| Operator | Purpose | Example |
|----------|---------|---------|
| `+` | Combine plots | `p1 + p2` |
| `/` | Stack vertically | `p1 / p2` |
| `|` | Place side-by-side | `p1 | p2` |
| `( )` | Group plots | `(p1 + p2) / p3` |
| `plot_layout()` | Control dimensions | `heights = c(2, 1)` |
| `plot_annotation()` | Add labels/titles | `title = "..."` |

**Say:**
"Let's recap the key operators. Plus combines, slash stacks, pipe puts side-by-side. 
Parentheses let you group things. And these two functions give you fine control over 
sizing and annotations."

---

## SLIDE 12: When to Use Multi-Panel Figures (2 min)
**Visual:** Examples from real papers (if available) or generic examples

**Content:**
**Use multi-panel figures when:**
- Comparing multiple related analyses
- Showing the same data from different perspectives
- Presenting a workflow or progression
- Supporting a main finding with details

**Don't use them when:**
- Plots are unrelated
- One plot tells the whole story
- The figure becomes too cluttered

**Say:**
"Multi-panel figures are great for related analyses, but don't force it. If your plots 
tell separate stories, keep them separate. The goal is clarity, not complexity."

---

## SLIDE 13: Best Practices (3 min)
**Visual:** Checklist with examples

**Content:**
✅ **Do:**
- Use consistent colors and themes
- Create a visual hierarchy (important info bigger)
- Label all panels (A, B, C...)
- Include clear titles and axes
- Test at actual print/screen size

❌ **Don't:**
- Mix too many plot types without reason
- Use different color schemes across panels
- Make panels too small to read
- Forget to cite your data source
- Over-crowd with information

**Say:**
"Here are some best practices. Consistency is key—colors, themes, fonts. Create hierarchy 
by making more important panels larger. Always label your panels so you can reference 
them in text. And please, test your figure at the size it will actually be used. What 
looks good on your large monitor might be unreadable when printed small."

---

## SLIDE 14: Exporting Your Figure (2 min)
**Visual:** Code and file explorer showing output

**Content:**
```r
# High-resolution PNG
ggsave("my_figure.png", 
       plot = final_plot,
       width = 14,      # inches
       height = 12,
       dpi = 300,       # publication quality
       bg = "white")

# PDF for publications
ggsave("my_figure.pdf", 
       width = 14, 
       height = 12)
```

**Tips:**
- PNG for presentations and web
- PDF for publications (vector graphics)
- Use dpi = 300 or higher for print
- Specify white background

**Say:**
"Exporting is straightforward with ggsave. For presentations, use PNG at 300 dpi. For 
journal submissions, use PDF which gives you vector graphics that scale perfectly. Always 
specify your dimensions and make sure to set a white background if needed."

---

## SLIDE 15: Resources (2 min)
**Visual:** Links and QR codes

**Content:**
**Documentation:**
- Patchwork: https://patchwork.data-imaginist.com/
- Our demo code: [GitHub link or course site]

**Learning Resources:**
- R Graphics Cookbook
- Patchwork tutorial videos
- Our complete code and data available in course materials

**Practice Datasets:**
- Tanzania malaria data (simulated)
- Your own research data!

**Say:**
"All our code and data are available in the course materials. The patchwork documentation 
is excellent with lots of examples. I highly recommend the R Graphics Cookbook. And the 
best way to learn is by doing—take your own data and try creating a multi-panel figure."

---

## SLIDE 16: Live Demo Recap (3 min)
**Action:** Switch to RStudio

**Steps:**
1. Load the libraries
2. Load the data (already prepared)
3. Create one simple plot
4. Create another simple plot
5. Combine them with `+`
6. Show the final complex layout code
7. Generate the figure

**Say:**
"Let me show you the whole process one more time, start to finish. [Walk through the 
steps, narrating each one]. See? From raw data to publication-ready figure in just a few 
lines of code. That's the beauty of patchwork."

---

## SLIDE 17: Q&A (5 min)
**Visual:** Simple slide with "Questions?" and contact info

**Anticipated Questions:**

**Q: Can patchwork work with base R plots?**
A: Unfortunately no, patchwork only works with ggplot2 objects. However, you can convert 
some base plots using gridExtra.

**Q: How do I make sure my colors are colorblind-friendly?**
A: Use packages like viridis or ColorBrewer. Avoid red-green combinations.

**Q: Can I combine plots from different datasets?**
A: Absolutely! Each plot can use its own dataset. Just make sure they're thematically 
related.

**Q: What if I need more than 6 panels?**
A: You can, but consider whether the figure is getting too busy. Sometimes multiple 
figures are better than one overloaded figure.

---

## SLIDE 18: Thank You (1 min)
**Visual:** Thank you message and contact info

**Content:**
- Thank you for your attention!
- Questions? Contact us: [email]
- Code and data available: [link]
- Try it with your own data!

**Say:**
"Thank you all for your attention. We hope this gave you some ideas for your own work. 
Don't hesitate to reach out if you have questions when you try this yourself. Now let's 
take a few more questions if there are any."

---

## TIMING BREAKDOWN
- Introduction & motivation: 5 minutes
- Data context: 3 minutes
- Building individual plots: 7 minutes
- Combining with patchwork: 8 minutes
- Professional touches & final result: 7 minutes
- Best practices & export: 5 minutes
- Live demo: 3 minutes
- Q&A: 5 minutes
- **Total: ~43 minutes** (leaves buffer for questions)

---

## MATERIALS CHECKLIST

**Before Presentation:**
- [ ] RStudio open with script loaded
- [ ] All packages installed and tested
- [ ] Data files loaded and verified
- [ ] Presentation slides ready
- [ ] Backup base R version tested
- [ ] Example outputs generated
- [ ] Handouts printed (optional)

**During Presentation:**
- [ ] Project files on screen
- [ ] Code with large, readable font
- [ ] All plots generate successfully
- [ ] Internet connection for documentation links

**After Presentation:**
- [ ] Share code repository link
- [ ] Upload recording if available
- [ ] Respond to follow-up questions

---

## CONTINGENCY PLANS

**If packages don't install:**
→ Use the base R version we prepared

**If live coding fails:**
→ Show pre-generated plots and walk through the code

**If time runs short:**
→ Skip or shorten the live demo recap, focus on the key operators

**If time runs long:**
→ Have your final figure ready to show immediately if needed

---

## ENGAGEMENT STRATEGIES

1. **Start with a problem everyone has faced** (disconnected plots)
2. **Use real-world context** (Tanzania malaria, relatable public health issue)
3. **Show progressive complexity** (build from simple to complex)
4. **Make it interactive** (ask if they've faced this problem)
5. **Provide practical takeaways** (operators table, best practices)
6. **Give resources for further learning** (documentation links, practice data)

---

**GOOD LUCK! You've got this! 🎉**

Remember: You're not just teaching syntax, you're empowering your classmates to tell 
better data stories. Keep it practical, keep it engaging, and most importantly, show 
them how this makes their work easier and better.
