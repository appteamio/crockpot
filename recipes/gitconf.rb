template "/home/#{node['user']['name']}/.gitconfig" do
  source "gitconfig.erb"
  mode '0664'
  owner "#{node['user']['name']}"
  group "#{node['user']['name']}"
  variables({
     :name => node['git']['name'],
     :email => node['git']['email']
  })
end