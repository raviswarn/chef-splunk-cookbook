actions :manage, :remove
default_action :manage

attribute :name,               :kind_of => String, :name_attribute => true
attribute :password,           :kind_of => String
attribute :previous_password,  :kind_of => String
attribute :email,              :kind_of => String
attribute :full_name,          :kind_of => String
attribute :roles,              :kind_of => Array, :default => ['user']
