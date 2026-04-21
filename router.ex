defmodule BebabeBaRides.Router do
  use Plug.Router

  # Define your routes here
  
  # Example route
  get "/" do
    send_resp(conn, 200, "Welcome to Bebabe Ba Rides!")
  end
end