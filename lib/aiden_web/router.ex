defmodule AidenWeb.Router do
  use AidenWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", AidenWeb do
    pipe_through :api

    resources "/schools", SchoolController
    resources "/students", StudentController, except: [:index]
    get "/schools/:school_id/students", StudentController, :index

    resources "/attendances", AttendanceController
    get "/attendances_query", AttendanceController, :attendance_query

    post "/attendances/new", AttendanceController, :create_attendance
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:aiden, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: AidenWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
