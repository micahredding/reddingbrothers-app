class ReleasesController < ApplicationController
  def index
    @releases = Release.order(:cover_url => :desc, :kind => :asc)
    @columns = 3
  end

  def show
    @release = Release.find_by(:slug => params[:id]) || Release.find(params[:id])
  end
end
