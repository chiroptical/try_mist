import gleam/erlang/process
import handler.{add_header, handler}
import mist

pub fn main() {
  let middleware =
    handler
    |> add_header("EXAMPLE", "EXAMPLE")

  let assert Ok(_) = mist.serve(8080, mist.handler_func(middleware))
  process.sleep_forever()
}
