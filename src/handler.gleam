import mist
import gleam/http.{Get}
import gleam/http/response
import gleam/bit_builder
import gleam/http/request.{Request}
import mist/internal/handler

type MistService =
  fn(Request(mist.Body)) -> mist.Response

pub fn add_header(
  service: MistService,
  header: String,
  value: String,
) -> MistService {
  fn(req) {
    req
    |> service
    |> fn(handler_response) {
      case handler_response {
        handler.Response(resp) ->
          handler.Response(
            resp
            |> response.prepend_header(header, value),
          )
        handler.Upgrade(_) -> handler_response
      }
    }
  }
}

pub fn handler(req: Request(mist.Body)) -> mist.Response {
  case req.method, request.path_segments(req) {
    Get, ["ping"] ->
      response.new(200)
      |> mist.bit_builder_response(bit_builder.from_string("pong"))
    _, _ ->
      response.new(404)
      |> mist.empty_response
  }
}
