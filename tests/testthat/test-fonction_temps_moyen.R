context("test-fonction_temps_moyen")

test_that("Average time of train to go to Nantes from Paris is 133.66 minutes", {
  expect_equal(round(fonction_temps_moyen("PARIS MONTPARNASSE", "NANTES")$Mean_Time,2), round(133.6605,2))
})
