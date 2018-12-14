context("test-rev_geocoding")

test_that("postcode of montparnasse is 75014", {
  expect_equal(rev_geocoding(48.84081,2.321847)$postcode, 75014)
})
