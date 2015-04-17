#require "awesome_print"
class WeathersController < InheritedResources::Base
  layout false
  
def show
 @resp= Weather.order("id desc").find_by_woeid("116545") || Weather.new
 if @resp.fordate.nil? 
    @resp = Weather.new
	@resp.fordate = Date.today
 end 

 begin
 @client = YahooWeather::Client.new
 # look up WOEID via http://weather.yahoo.com; enter location by city
 # name or zip and WOEID is at end of resulting page url.  herein we use
 # the WOEID for Mexico City, MX.
 # <img src="#{response.image.url}"><br/>
 #{response.condition.temp} degrees #{response.units.temperature}<br/>
 #{response.condition.text}<br>
 # Forecast:<br/>
 #{response.forecasts[0].day} - #{response.forecasts[0].text}.  High: #{response.forecasts[0].high} Low: #{response.forecasts[0].low}<br/>
 #{response.forecasts[1].day} - #{response.forecasts[1].text}.  High: #{response.forecasts[1].high} Low: #{response.forecasts[1].low}<br/>
  
 
 response = @client.lookup_by_woeid(116545 , units = 'c')
 #puts ("response= #{response.condition.code}")
 @resp.woeid="116545"
 @resp.title = "#{response.title}"
 @resp.temp = "#{response.condition.temp}"
 @resp.condText =  "#{response.condition.text}"
 @resp.tempHigh = "#{response.forecasts[0].high}"
 @resp.tempLow =  "#{response.forecasts[0].low}"
 @resp.name = "/images/weather/#{response.condition.code||3200}.gif" 
 @resp.iconID =  "#{response.condition.code}".to_i
 @imgSrc = @resp.name
 @resp.save
 rescue
   puts $!
  # offline or error
  @imgSrc = @resp.name
 ensure
  #render show
  # render layout: false
 end

 end



  private

    def weather_params
      params.require(:weather).permit(:woeid, :tempHigh, :tempLow, :name, :fordate, :iconID, :title, :temp, :condText)
    end
end
