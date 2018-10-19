class  Api::V1::FlightsController < ApplicationController
  before_action :set_flight, only: [:show, :update, :destroy]
  def index
    @flights = Flight.where(date: Date.today.strftime("%Y-%m-%d"))    # @flights.delete_all if @flights.present?
    render json: { total: @flights.count, flights: @flights} 
  end

  def search
	  @flights = Flight.all
	  @flights = @flights.where(from: params["from"]) if params["from"].present?
    @flights = @flights.where(number: params["number"]) if params["number"].present?
	  @flights = @flights.where(airline_company: params["airline_company"]) if params["airline_company"].present?
    @flights = @flights.where(flight_type: "ankomster")  if params[:ankomster] != params[:afgange] && params[:ankomster] == "true"
    @flights = @flights.where(flight_type: "afgange")  if params[:ankomster] != params[:afgange] && params[:afgange] == "true"
    @flights =  @flights.where(date: params[:date])
    render json: { total: @flights.count, flights: @flights}
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_flight
   @flight = Flight.find(params[:id])
  end
  # Only allow a trusted parameter “white list” through.
  def flight_params
  params.require(:flight).permit(:status, :date, :from, :number, :arline_company)
  end
end


