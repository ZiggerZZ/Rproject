context("test-delay_propr")

test_that("function renders the right proportion of train late for more than 15 minutes", {
  expect_equal(delay_propr("PARIS MONTPARNASSE", "NANTES", 12)$proportion_trains_en_retard_15min, 0.5206186)
})

