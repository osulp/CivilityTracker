class HomeController < ApplicationController
  respond_to :html, :json

  def index
    @civil_entries = reviewed_entries.order("created_at DESC").decorate
    respond_with @civil_entries
  end

  private

  def reviewed_entries
    CivilEntry.where(:reviewed => true)
  end
end
