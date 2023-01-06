class PropertiesController < ApplicationController
  before_action :set_property, only: %i[ show edit update destroy ]

  def index
    @Properties = Property.all
  end

  def new
    @property = Property.new
    2.times { @property.nearest_stations.build }
  end

  def create
    @property = Property.new(property_params)
    if @property.save
      redirect_to properties_path notice: "登録しました！"
    else
      render :new
    end
  end

  def show
    @nearest_stations = @property.nearest_stations
  end

  def edit
    @property.nearest_stations.build
  end

  def update
    if @property.update(property_params)
      redirect_to properties_path notice: "編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @property.destroy
    redirect_to properties_path notice:"削除しました！"
  end

  private

  def set_property
    @property = Property.find(params[:id])
  end

  def property_params
    params.require(:property).permit(
      :property_name, 
      :rent, 
      :address, 
      :age, 
      :note, 
      nearest_stations_attributes: [:id, :route_name, :station_name, :on_foot])
  end
end