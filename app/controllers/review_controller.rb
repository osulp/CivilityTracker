class ReviewController < ApplicationController
  respond_to :html, :json

  def index
    @unreviewed_civil_entries = unreviewed_entries.order("created_at DESC")
    respond_with @unreviewed_civil_entries
  end

  def destroy
    @entry = find_entry
    if @entry.destroy
      flash[:success] = "Sucessfully deleted."
    else
      flash[:error] = "Error in deleting entry."
    end 
    respond_with @entry, :location => review_index_path
  end

  def review_card
    @entry = find_entry
    @entry.review!
    @entry.save
    respond_with @entry, :location => review_index_path
  end

  private

  def find_entry
    CivilEntry.find(params[:id])
  end

  def unreviewed_entries
    CivilEntry.where(:reviewed => false)
  end
end
