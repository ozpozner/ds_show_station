class Icon < ActiveRecord::Base
  has_attached_file :icon, :styles => { :small => "200x200>",:medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :icon, :content_type => /\Aimage\/.*\Z/
  
end

# 
#has_attached_file :avatar
# Validate content type
#validates_attachment_content_type :avatar, :content_type => /\Aimage/
# Validate filename
#validates_attachment_file_name :avatar, :matches => [/png\Z/, /jpe?g\Z/]
# Explicitly do not validate
#do_not_validate_attachment_file_type :avatar
