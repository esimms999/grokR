test_that("query_grok handles mock API response correctly", {
  # Mock API response (simplified)
  mock_response <- list(
    status = 200,
    content = charToRaw('{"choices":[{"message":{"content":"Test answer"}}]}')
  )

  # Mock httr functions using with_mocked_bindings
  with_mocked_bindings(
    POST = function(...) mock_response,
    content = function(x, ...) rawToChar(x$content),
    status_code = function(x) x$status,
    {
      result <- query_grok("Test question", "mock_key", debug_flag = FALSE)
      expect_equal(result, "Test answer")
    },
    .package = "httr"
  )
})

test_that("query_grok errors on bad status", {
  mock_response <- list(
    status = 400,
    content = charToRaw('{"error":"Bad request"}')
  )

  # Mock httr functions using with_mocked_bindings
  with_mocked_bindings(
    POST = function(...) mock_response,
    content = function(x, ...) rawToChar(x$content),
    status_code = function(x) x$status,
    {
      expect_error(query_grok("Test question", "mock_key"), "Error: 400")
    },
    .package = "httr"
  )
})
