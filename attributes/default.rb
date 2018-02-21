set[:splunk][:dir] = "/opt/splunk"
set[:splunk][:bin] = "#{splunk[:dir]}/bin/splunk"

default[:splunk][:version] = "5.0.4"
default[:splunk][:build]   = "172409"

# Anything else will completely remove splunk from the system
default[:splunk][:action] = "install"

default[:splunk][:admin] = {
  :default_password => "changeme",
  :email            => "admin@changeme.com",
  :full_name        => "Administrator",
  :name             => "admin",
  :roles            => ['admin'],
  :password         => "changeme",
}

# same as the admin user
default[:splunk][:users] = {}
