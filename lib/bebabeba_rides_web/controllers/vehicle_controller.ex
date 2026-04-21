# lib/bebabeba_backend/web/controllers/vehicle_controller.ex

defmodule BebabebaBcakend.Web.VehicleController do
  use BebabebaBcakend.Web, :controller

  alias BebabebaBcakend.Vehicles
  alias BebabebaBcakend.Schemas.Vehicle

  action_fallback BebabebaBcakend.Web.FallbackController

  def list_vehicles(conn, _params) do
    vehicles = Vehicles.list_vehicles()
    render(conn, "vehicles.json", vehicles: vehicles)
  end

  def get_vehicle(conn, %{"id" => id}) do
    vehicle = Vehicles.get_vehicle!(id)
    render(conn, "vehicle.json", vehicle: vehicle)
  end

  def create_vehicle(conn, %{"vehicle" => vehicle_params}) do
    with {:ok, %Vehicle{} = vehicle} <- Vehicles.create_vehicle(vehicle_params) do
      conn
      |> put_status(:created)
      |> render("vehicle.json", vehicle: vehicle)
    end
  end

  def update_vehicle(conn, %{"id" => id, "vehicle" => vehicle_params}) do
    vehicle = Vehicles.get_vehicle!(id)

    with {:ok, %Vehicle{} = vehicle} <- Vehicles.update_vehicle(vehicle, vehicle_params) do
      render(conn, "vehicle.json", vehicle: vehicle)
    end
  end

  def delete_vehicle(conn, %{"id" => id}) do
    vehicle = Vehicles.get_vehicle!(id)

    with {:ok, _vehicle} <- Vehicles.delete_vehicle(vehicle) do
      send_resp(conn, :no_content, "")
    end
  end
end
