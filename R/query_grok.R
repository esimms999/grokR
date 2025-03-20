#' Query the Grok AI API
#'
#' Sends a question to the Grok AI API by xAI and returns the response.
#'
#' @param question A character string containing the question to ask Grok.
#' @param api_key A character string with your xAI API key.
#' @param endpoint A character string specifying the API endpoint URL. Defaults to "https://api.x.ai/v1/chat/completions".
#' @param model A character string specifying the Grok model to use. Defaults to "grok-2-1212".
#' @param debug_flag A logical value indicating whether to print debug information (status code and raw response). Defaults to FALSE.
#'
#' @return A character string containing Grok's answer.
#' @export
#'
#' @examples
#' \dontrun{
#'   api_key <- "your_api_key_here"
#'   answer <- query_grok("What is the meaning of life?", api_key)
#'   print(answer)
#' }
#'
#' @importFrom httr POST add_headers content
#' @importFrom jsonlite toJSON fromJSON
query_grok <- function(question, api_key, endpoint = "https://api.x.ai/v1/chat/completions", model = "grok-2-1212", debug_flag = FALSE) {
  # Prepare the request body
  body <- list(
    messages = list(
      list(
        role = "user",
        content = question
      )
    ),
    model = model
  )

  # Send POST request
  response <- httr::POST(
    url = endpoint,
    body = jsonlite::toJSON(body, auto_unbox = TRUE),
    httr::add_headers(
      "Authorization" = paste("Bearer", api_key),
      "Content-Type" = "application/json"
    ),
    encode = "json"
  )

  # Optionally print status and raw response based on debug_flag
  raw_text <- httr::content(response, "text", encoding = "UTF-8")
  if (debug_flag) {
    cat("Status Code:", httr::status_code(response), "\n")
    cat("Raw Response:", raw_text, "\n")
  }

  # Handle response
  if (httr::status_code(response) == 200) {
    # Parse JSON without simplifying vectors
    result <- jsonlite::fromJSON(raw_text, simplifyVector = FALSE)
    # Extract the answer from choices[0].message.content
    answer <- result$choices[[1]]$message$content
    return(answer)
  } else {
    stop("Error: ", httr::status_code(response), " - ", raw_text)
  }
}
