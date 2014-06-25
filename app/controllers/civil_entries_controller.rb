class CivilEntriesController < ApplicationController
  respond_to :html, :json

  def new
  end

  def create
  end

  def update
    @civil_entry = CivilEntry.where(:serial => params[:id]).first!
    @civil_entry.attributes = civil_entries_params
    @civil_entry.save
    respond_with @civil_entry
  end

  def register
    @card = CivilEntry.new(:serial => params[:serial])
    unless previously_stored_serial?
      @card.save
      store_serial
    end
  end


  private

  def civil_entries_params
    params.require(:civil_entry).permit(:latitude, :longitude)
  end

  def previously_stored_serial?
    session[:stored_serial] && session[:stored_serial].include?(params[:serial])
  end

  def store_serial
    session[:stored_serial] ||= []
    session[:stored_serial] << params[:serial]
  end
end
