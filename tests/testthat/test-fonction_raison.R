context("test-fonction_raison")

test_that("late for external reason in % is 0.37", {
  expect_equal(round(fonction_raison("PARIS MONTPARNASSE", "NANTES", 12)$cause_externe,2), round(0.375646,2))
})
