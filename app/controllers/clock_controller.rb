class ClockController < ApplicationController
 layout false;
 
 def show
 respond_to do |format|
      format.html do
        if request.xhr?
          render :partial => "show", :locals => { :data => Time.now().to_s }, :layout => false, :status => :ok
        else
          render "show"
        end
      end
    end
  end

  
  end
