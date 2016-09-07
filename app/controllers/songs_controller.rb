class SongsController < ApplicationController
  def show
    @song = Song.find_by(:slug => params[:id]) || Song.find(params[:id])
  end
end
