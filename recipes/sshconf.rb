execute "generate ssh key for #{node['user']['name']}." do
    user node['user']['name']
    creates "/home/#{node['user']['name']}/.ssh/id_rsa.pub"
    command "ssh-keygen -t rsa -C \"#{node['git']['email']}\" -q -f /home/#{node['user']['name']}/.ssh/id_rsa -P \"\""
end
execute "Getting the ssh-agent on login" do
	user node['user']['name']
	command "echo 'eval \"$(ssh-agent -s)\"' >> \"/home/#{node['user']['name']}/.bash_profile\""
	# not_if "ssh-add -l | grep .ssh", :user => 'vagrant'
end
execute "Adding the ssh-agent on login" do
	user node['user']['name']
	command "echo 'ssh-add' >> \"/home/#{node['user']['name']}/.bash_profile\""
	# not_if "ssh-add -l | grep .ssh", :user => 'vagrant'
end
template "/home/#{node['user']['name']}/.ssh/config" do
  source "sshconfig.erb"
  owner "#{node['user']['name']}"
  group "#{node['group']}"
end
execute "Copying public key to shared folder" do
	user node['user']['name']
	command "cp /home/#{node['user']['name']}/.ssh/id_rsa.pub /data/pub_key "
	# not_if "ssh-add -l | grep .ssh", :user => 'vagrant'
end