class DashboardController < ApplicationController
  inertia_share flash: -> { flash.to_hash }

  def index
    render inertia: "Dashboard/Index", props: {}
  end
end
