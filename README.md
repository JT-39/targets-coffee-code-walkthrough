# README

## {targets} coffee & code walkthrough

This repository contains all the files and data needed to follow the code walkthrough of the {targets} package presented at the DfE coffee and code.

## Getting Started
Clone the repository:

1. Click on the green `<> Code` button just below (right) of the repository
name.
2. Copy the HTTPS path.
3. Head over to your favoured command line tool (PowerShell or GitBash).
4. Navigate to the folder you want to store this project.
5. Run the code below:

```bash
git clone https://github.com/JT-39/ofsted-mi-push.git
```

6. Voila!

When in the RStudio project, use `renv::restore()` to load the correct
packages.

## Files

The main files are below:

```
├── analysis.R
├── _targets_analysis.R
├── _data/
│   ├── raw_data.csv
├── R/
│   ├── functions.R
│   ├── plot_styles.R
```

The plot_styles.R script contains some functions taken from the
[KASStylesR](https://github.com/wgdsu/KASStylesR) repository.
These are styling additions designed for producing charts and figures that meet publication guidance.

# Contribute
Create an issue or branch off the main and start a pull request!
