class Device < ActiveRecord::Base
  has_many :device_commands
end
