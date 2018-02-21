# Admin user must always be edited first
users = [node[:splunk][:admin]] + node[:splunk][:users]

users.each do |user|
  user = user.to_hash # not always a hash... Chef::Node::Attribute

  splunk_user user[:name] do
    user.each do |attribute, value|
      instance_variable_set("@#{attribute}", value)
    end
  end
end
