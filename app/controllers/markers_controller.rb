class MarkersController < InheritedResources::Base

  private

    def marker_params
      params.require(:marker).permit(:name, :lat, :lon, :zoom, :iconID, :href)
    end
end

