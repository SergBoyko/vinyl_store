class DiscsController < ApplicationController
  def index
    @discs = Disc.includes(:artist).all
  end

  def show
    @disc = Disc.includes(:tracks).find(params[:id])
  end


  def search
    if params[:q].present?
      @discs = Disc.joins(:artist).where(
        "discs.title ILIKE :query OR artists.name ILIKE :query OR ARRAY_TO_STRING(discs.genres, ',') ILIKE :query",
        query: "%#{params[:q]}%"
      )
    else
      @discs = Disc.none
    end

    render :index
  end
end
