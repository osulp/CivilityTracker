class ReviewController < ApplicationController
  respond_to :html, :json

  def index
    @unreviewed_civil_entries = unreviewed_entries.order("created_at DESC")
    respond_with @unreviewed_civil_entries
  end

  private

  def unreviewed_entries
    CivilEntry.where(:reviewed => false)
  end
end
