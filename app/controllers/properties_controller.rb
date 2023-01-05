class PropertiesController < ApplicationController
  before_action :set_property, only: %i[ show edit update destroy ]
  before_action :set_nearest_stations, only: [:show, :edit, :update]

  def index
    @Properties = Property.all
  end

  def new
    @property = Property.new
    2.times { @property.nearest_stations.build }
  end

  def create
    @property = Property.new(property_params)
    respond_to do |format|
      if @property.save
        format.html { redirect_to @property, notice: "物件を登録しました" }
        format.json { render :show, status: :created, location: @property }
      else
        2.times { @property.nearest_stations.build }
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @nearest_stations = @property.nearest_stations
  end

  def edit
    @property.nearest_stations.build
  end

  def update
    respond_to do |format|
      if @property.update(property_params)
        format.html { redirect_to @property, notice: "編集をしました" }
        format.json { render :show, status: :ok, location: @property }
      else
        @property.nearest_stations.build
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @property.destroy
    respond_to do |format|
      format.html { redirect_to properties_url, notice: "物件を削除しました" }
      format.json { head :no_content }
    end
  end

  private

  def set_property
    @property = Property.find(params[:id])
  end

  def set_nearest_stations
    @nearest_stations = @property.nearest_stations
  end

  def property_params
    params.require(:property).permit(:property_name, :rent, :address, :age, :note, nearest_stations_attributes: [:id, :route_name, :station_name, :on_foot])
  end
end