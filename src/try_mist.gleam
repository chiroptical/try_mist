import gleam/erlang/process
import handler.{handler}
import mist

pub fn main() {
  let assert Ok(_) = mist.serve(8080, mist.handler_func(handler))
  process.sleep_forever()
}
