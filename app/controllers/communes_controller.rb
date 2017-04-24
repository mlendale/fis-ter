class CommunesController < ApplicationController
  def index
    begin
      @communes = Commune.all
      respond_to :json
    rescue ActionController::UnknownFormat
      head :not_acceptable
    end
  end

  def create
    head :forbidden
  end

  def show
    @commune = Commune.find_by(code_insee: params[:id])
    if @commune.nil?
      head :not_found
    end
  end

  def update
    @commune = Commune.find_by(code_insee: params[:id])
    if @commune.nil?
      head :not_found
    else
      if params[:commune]
        @commune.update(filtered_params)
      else
        head :bad_request
      end
    end
  end

  private

  def filtered_params
    params.require(:commune).permit(:name)
  end
end
