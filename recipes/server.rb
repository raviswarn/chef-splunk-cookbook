src_filename = [
  "splunk",
  node[:splunk][:version],
  node[:splunk][:build],
  "linux-2.6",
  ((node['kernel']['machine'] == "x86_64") ? "amd64.deb" : "intel.deb")
].join("-")

src_url = [
  "http://download.splunk.com/releases",
  node[:splunk][:version],
  "splunk/linux",
  src_filename
].join("/")

src_filepath = "#{Chef::Config['file_cache_path']}#{src_filename}"

remote_file src_filepath do
  source src_url
  not_if { ::File.exists?(src_filepath) }
end

package src_filepath do
  provider Chef::Provider::Package::Dpkg
end

template "/etc/init.d/splunk" do
  mode "0755"
  owner "root"
  group "root"
end

service "splunk" do
  supports :status => true, :restart => true, :reload => true
  action [:start, :enable]
end
