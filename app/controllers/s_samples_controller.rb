class SSamplesController < InheritedResources::Base

  private

    def s_sample_params
      params.require(:s_sample).permit(:oid, :s1, :s2, :s3, :s4, :s5, :s6, :s7, :s8, :s9, :s10, :rssi1, :rss2, :lmrv1, :lmrv2, :hmu1s, :hmu2s, :numoflinks, :deviceID, :ipaddr)
    end
end

