class ReleasesController < ApplicationController
  def index
    @releases = Release.order(:kind => :asc, :cover_url => :desc)
    @columns = 3
  end

  def show
    @release = Release.find_by(:slug => params[:id]) || Release.find(params[:id])
    @songs = @release.songs    
  end
end
