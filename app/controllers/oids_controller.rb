class OidsController < InheritedResources::Base

  private

    def oid_params
      params.require(:oid).permit(:oid, :deviceID, :numRV, :returnType)
    end
end

