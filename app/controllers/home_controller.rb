class HomeController < ApplicationController
  def index
    @civil_entries = CivilEntry.all.order("created_at DESC").decorate
  end
end
