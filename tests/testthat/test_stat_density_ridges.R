context("stat_density_ridges")

test_that("no ecdf or quantiles by default", {
  df <- data.frame(x = rnorm(20))
  out <- layer_data(ggplot(df, aes(x = x, y = 0)) + stat_density_ridges())

  expect_false("ecdf" %in% names(out))
  expect_false("quantile" %in% names(out))
})

test_that("from and to arguments work", {
  df <- data.frame(x = rnorm(20))
  out <- layer_data(ggplot(df, aes(x = x, y = 0)) + stat_density_ridges(from = -2, to = 2))

  expect_equal(-2, min(out$x))
  expect_equal(2, max(out$x))
})

test_that("calculation of ecdf and quantiles can be turned on", {
  df <- data.frame(x = rnorm(20))
  out <- layer_data(ggplot(df, aes(x = x, y = 0)) + stat_density_ridges(calc_ecdf = TRUE, quantiles = 5))

  expect_true("ecdf" %in% names(out))
  expect_true("quantile" %in% names(out))
  expect_length(unique(out$quantile), 5)
})


test_that("jittered points and quantile lines can be turned on and off", {
  df <- data.frame(x = rnorm(20))

  # no point or vline data type by default
  out <- layer_data(ggplot(df, aes(x = x, y = 0)) + stat_density_ridges())
  expect_equal(unique(out$datatype), "ridgeline")

  # data points can be turned on
  out <- layer_data(ggplot(df, aes(x = x, y = 0)) + stat_density_ridges(jittered_points = TRUE))
  expect_setequal(out$datatype, c("ridgeline", "point"))
  expect_equal(out$x[out$datatype=="point"], df$x)

  # quantile lines can be turned on
  out <- layer_data(ggplot(df, aes(x = x, y = 0)) + stat_density_ridges(quantile_lines = TRUE))
  expect_setequal(out$datatype, c("ridgeline", "vline"))
  expect_equal(out$x[out$datatype=="vline"], unname(quantile(df$x)[2:4]))

  # quantile lines and data points can be turned on at once
  out <- layer_data(ggplot(df, aes(x = x, y = 0)) + stat_density_ridges(jittered_points = TRUE, quantile_lines = TRUE))
  expect_setequal(out$datatype, c("ridgeline", "vline", "point"))
  expect_equal(out$x[out$datatype=="point"], df$x)
  expect_equal(out$x[out$datatype=="vline"], unname(quantile(df$x)[2:4]))

  ## now repeat everything with geom_density_ridges and geom_density_ridges_gradient

  # no points or vlines data type by default
  out <- layer_data(ggplot(df, aes(x = x, y = 0)) + geom_density_ridges())
  expect_equal(unique(out$datatype), "ridgeline")

  # data points can be turned on
  out <- layer_data(ggplot(df, aes(x = x, y = 0)) + geom_density_ridges(jittered_points = TRUE))
  expect_setequal(out$datatype, c("ridgeline", "point"))
  expect_equal(out$x[out$datatype=="point"], df$x)

  # quantile lines can be turned on
  out <- layer_data(ggplot(df, aes(x = x, y = 0)) + geom_density_ridges(quantile_lines = TRUE))
  expect_setequal(out$datatype, c("ridgeline", "vline"))
  expect_equal(out$x[out$datatype=="vline"], unname(quantile(df$x)[2:4]))

  # quantile lines and data points can be turned on at once
  out <- layer_data(ggplot(df, aes(x = x, y = 0)) + geom_density_ridges_gradient(jittered_points = TRUE, quantile_lines = TRUE))
  expect_setequal(out$datatype, c("ridgeline", "vline", "point"))
  expect_equal(out$x[out$datatype=="point"], df$x)
  expect_equal(out$x[out$datatype=="vline"], unname(quantile(df$x)[2:4]))

  # no points or vlines data type by default
  out <- layer_data(ggplot(df, aes(x = x, y = 0)) + geom_density_ridges_gradient())
  expect_equal(unique(out$datatype), "ridgeline")

  # data points can be turned on
  out <- layer_data(ggplot(df, aes(x = x, y = 0)) + geom_density_ridges_gradient(jittered_points = TRUE))
  expect_setequal(out$datatype, c("ridgeline", "point"))
  expect_equal(out$x[out$datatype=="point"], df$x)

  # quantile lines can be turned on
  out <- layer_data(ggplot(df, aes(x = x, y = 0)) + geom_density_ridges_gradient(quantile_lines = TRUE))
  expect_setequal(out$datatype, c("ridgeline", "vline"))
  expect_equal(out$x[out$datatype=="vline"], unname(quantile(df$x)[2:4]))

  # quantile lines and data points can be turned on at once
  out <- layer_data(ggplot(df, aes(x = x, y = 0)) + geom_density_ridges_gradient(jittered_points = TRUE, quantile_lines = TRUE))
  expect_setequal(out$datatype, c("ridgeline", "vline", "point"))
  expect_equal(out$x[out$datatype=="point"], df$x)
  expect_equal(out$x[out$datatype=="vline"], unname(quantile(df$x)[2:4]))

})
