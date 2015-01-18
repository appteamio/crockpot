# create www directory
directory "/var/www" do
  user node['user']['name']
  group node['group']
  mode 0755
end

execute "mkdir -p /var/www/#{node['app']}/current" do
  user node['user']['name']
  group node['group']
  creates path
end
# create shared directory structure for app
path = "/var/www/#{node['app']}/shared/config"
execute "mkdir -p #{path}" do
  user node['user']['name']
  group node['group']
  creates path
end

# create database.yml file
template "#{path}/database.yml" do
  source "database.yml.erb"
  mode 0640
  owner node['user']['name']
  group node['group']
end

# set unicorn config

# create unicorn directory
directory "/var/www/unicorn" do
  user node['user']['name']
  group node['group']
  mode 0755
end
# create unicorn log folder
unilog = "/var/www/unicorn/log"
execute "mkdir -p #{unilog}" do
  user node['user']['name']
  group node['group']
  creates unilog
end
execute "touch /var/www/unicorn/log/unicorn_err.log"do
  user node['user']['name']
  group node['group']
end
execute "touch /var/www/unicorn/log/unicorn_out.log"do
  user node['user']['name']
  group node['group']
end

# create unicorn pid folder
unipid = "/var/www/unicorn/pids" 
execute "mkdir -p #{unipid}" do
  user node['user']['name']
  group node['group']
  creates unipid
end
execute "touch /var/www/unicorn/pids/unicorn.pid" do
  user node['user']['name']
  group node['group']
end

template "/etc/init.d/unicorn" do
  source "unicorn.erb"
  mode 0755
  owner node['user']['name']
  group node['group']
end

template "/var/www/unicorn/unicorn.conf" do
  source "unicorn.conf.erb"
  mode 0755
  owner node['user']['name']
  group node['group']
end

# add init script link
execute "update-rc.d unicorn defaults" do
  not_if "ls /etc/rc2.d | grep unicorn"
end

# copy authorized ssh key
bash "append_authorized_keys" do
   user "#{node['user']['name']}"
   code <<-EOF
      cat /data/auth_key >> /home/#{node['user']['name']}/.ssh/authorized_keys
      rm /data/auth_key
   EOF
   not_if "grep -q #{node['user']['email']} /home/#{node['user']['name']}/.ssh/authorized_keys"
end