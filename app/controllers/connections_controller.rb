class ConnectionsController < InheritedResources::Base

  private

    def connection_params
      params.require(:connection).permit(:stationID, :logoID)
    end
end

