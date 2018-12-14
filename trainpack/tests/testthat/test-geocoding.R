context("test-geocoding")

test_that("longitude of Paris montparnasse is 2.321847", {
  expect_equal(round(geocoding("PARIS MONTPARNASSE")$lon,2), round(2.321847,2))
})
