class CivilEntriesController < ApplicationController
  respond_to :html, :json

  def index
    @civil_entries = CivilEntry.all.order("created_at DESC")
    respond_with(@civil_entries)
  end

  def update
    @civil_entry = CivilEntry.find(params[:id])
    @civil_entry.attributes = civil_entries_params
    @civil_entry.save
    respond_with @civil_entry, :location => register_civil_entries_path(:serial => @civil_entry.serial)
  end

  def register
    @card = CivilEntry.new(:serial => params[:serial])
    unless previously_stored_serial?
      @card.save
      store_serial
    else
      @card = CivilEntry.find(session[:stored_serial][params[:serial]])
    end
  end

  def nothing

  end


  private

  def civil_entries_params
    if @civil_entry && !@civil_entry.latitude.blank?
      params[:civil_entry][:longitude] = @civil_entry.longitude
      params[:civil_entry][:latitude] = @civil_entry.latitude
    end
    params.require(:civil_entry).permit(:latitude, :longitude, :reason)
  end

  def previously_stored_serial?
    session[:stored_serial] && session[:stored_serial].has_key?(params[:serial])
  end

  def store_serial
    session[:stored_serial] ||= {}
    session[:stored_serial][params[:serial]] = @card.id
  end
end
