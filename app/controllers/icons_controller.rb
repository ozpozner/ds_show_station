class IconsController < InheritedResources::Base

  def new
    @icon=Icon.new
	@icon.width= 500
	@icon.height=500
	
  end

  def update
    @icon = Icon.update( icon_params )
	@icon.save
  end
  
  
  def create
    @icon = Icon.create( icon_params )
  end
  
  private

    def icon_params
      params.require(:icon).permit(:width, :height, :altText, :url, :icon)
    end
end

