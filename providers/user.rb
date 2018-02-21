action :manage do
  manage_user
end

action :remove do
  manage_user
end

def manage_user
  name = new_resource.name

  execute "#{splunk_action.capitalize} splunk user: #{name}" do
    command [
        node[:splunk][:bin],
        splunk_action,
        "user #{name}",
        password,
        full_name,
        email,
        roles,
        auth
      ].join(' ')
  end

  file name do
    path    admin_edited_file
    only_if { name == "admin" && !admin_edited? }
  end
end

def password
 "-password '#{new_resource.password}'" if new_resource.password
end

def roles
  "-role " << new_resource.roles.join(" -role ") if new_resource.roles.any? && !user_exists?
end

def full_name
  "-full-name '#{new_resource.full_name}'" if new_resource.full_name
end

def email
  "-email '#{new_resource.email}'" if new_resource.email
end

def auth
  "-auth #{splunk[:admin][:name]}:#{admin_password}"
end

def admin_password
  admin_edited? ? splunk[:admin][:password] : splunk[:admin][:default_password]
end

def splunk_action
  case new_resource.action
  when :manage
    user_exists? ? "edit" : "add"
  when :remove
    "remove"
  end
end

def user_exists?(name=new_resource.name)
  ::File.read(passwd_file).include?(name)
end

def admin_edited?
  ::File.exist?(admin_edited_file)
end

def admin_edited_file
  ::File.join(splunk[:dir], "etc", ".admin_edited")
end

def admin_edited!
  ::FileUtils.touch(admin_edited_file)
end

def passwd_file
  ::File.join(splunk[:dir], "etc", "passwd")
end

def splunk
  new_resource.node[:splunk]
end
