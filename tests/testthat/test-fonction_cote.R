context("test-fonction_cote")

test_that("Cote of Paris Montparnasse / Nantes is 7.03", {
  expect_equal(round(fonction_cote("PARIS MONTPARNASSE", "NANTES", 12),2), round(7.032455,2))
})
