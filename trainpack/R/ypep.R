#' ypep function
#'
#' @param char a string
#'
#' @import magick
#'
#' @return pepy
#' @export
#'
#' @examples ypep("test")
ypep <- function (char) {
  answers <- c("You did not find the secret recipe","Try again my friend","Think SNCF PDG", "Why don't you try verlan ?", "Oops, wrong answer", "Ok i'll give you an advice try pepy")
  if (char == "pepy") {
    pepy <- image_read("http://h16free.com/wp-content/uploads/2011/02/pepy.jpg")
    return (print(pepy))
    return (print("Well done my bruuu !"))
  } else {
    print(answers[floor(runif(1)*6)+1])
  }
}
