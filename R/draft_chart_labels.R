library(dplyr)
library(tidyr)
library(stringr)
library(nflreadr)

# Data-----

YEAR <- get_current_season(roster = TRUE)

baldwin_charts <- nflreadr::csv_from_url(
  "https://github.com/nflverse/open-source-football/raw/master/_posts/2023-02-23-nfl-draft-value-chart/osf_draft_chart.csv"
)

reg_charts <- nflreadr::csv_from_url(
  "https://github.com/nflverse/nfldata/raw/master/data/draft_values.csv"
)

charts <- left_join(
  reg_charts,
  select(baldwin_charts, draft_overall, baldwin = osf_surplus),
  by = c("pick" = "draft_overall")
) |>
  mutate(across(everything(), ~ replace_na(.x, 0)))

# -----------------------------
# Draft pick structure
# -----------------------------

draft_picks <- load_draft_picks(seasons = (YEAR - 4):YEAR) |>
  select(season, round, pick) |>
  distinct()

round_info <- draft_picks |>
  group_by(round) |>
  summarise(
    round_start = min(pick),
    round_end = max(pick),
    .groups = "drop"
  ) |>
  mutate(
    round_picks = round_end - round_start + 1,
    round_early = round_start + floor(round_picks / 3) - 1,
    round_late = round_end - floor(round_picks / 3) + 1
  )

# -----------------------------
# Apply labels to every pick
# -----------------------------

charts_labeled <- charts |>
  rowwise() |>
  mutate(
    round = round_info$round[
      which(
        pick >= round_info$round_start &
          pick <= round_info$round_end
      )[1]
    ],

    round_start = round_info$round_start[round],
    round_end = round_info$round_end[round],
    round_early = round_info$round_early[round],
    round_late = round_info$round_late[round],

    round_label = case_when(
      pick <= round_early ~ paste0("Early ", round),
      pick >= round_late ~ paste0("Late ", round),
      TRUE ~ paste0("Mid ", round)
    ),

    pick_label = coalesce(round_label, as.character(pick))
  ) |>
  ungroup() |>
  select(pick, johnson, stuart, hill, otc, pff, baldwin, pick_label)
