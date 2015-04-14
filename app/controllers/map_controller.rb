class MapController < ApplicationController
  def index
  #  @current_station="Garibaldi"
    @next_station="Bellas Artes"
    @current_station="San Juan de LetrÃ¡n"
	@online=true
	@st=Station.all
	@timeOutToNextStation = 1000 #ms
	if params[:current_station_id]
	   if params[:trainDirection]
	   else
	   end
	else
	  
	end
	
	
	#get current_station
	#get direction
	#get timeout
	
  end
  
  def weather
  end
  
end
