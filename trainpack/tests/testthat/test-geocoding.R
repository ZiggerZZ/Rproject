context("test-geocoding")

test_that("longitude of Paris montparnasse is 2.321847", {
  expect_equal(geocoding("PARIS MONTPARNASSE")$lon, 2.321847)
})
