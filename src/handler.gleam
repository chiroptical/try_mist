import mist
import gleam/http.{Get}
import gleam/http/response
import gleam/bit_builder
import gleam/http/request.{Request}

pub fn handler(req: Request(mist.Body)) {
  case req.method, request.path_segments(req) {
    Get, ["ping"] ->
      response.new(200)
      |> mist.bit_builder_response(bit_builder.from_string("pong"))
    _, _ ->
      response.new(404)
      |> mist.empty_response
  }
}
