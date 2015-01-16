package "php5-fpm"
package "php5-mysql"

service 'php5-fpm' do
  provider Chef::Provider::Service::Upstart
  supports [:status, :restart]
end

bash "modify cgi.fix_pathinfo" do
  code <<-EOH
    sed -i '/cgi\.fix_pathinfo.*/d' /etc/php5/fpm/php.ini
    echo 'cgi.fix_pathinfo=0  #working!!!!!' >> /etc/php5/fpm/php.ini
  EOH
  notifies :restart, "service[php5-fpm]", :delayed
  not_if "grep -xq 'cgi\.fix_pathinfo=0' /etc/php5/fpm/php.ini"
end


# Not needed since the valu is already the correct one
# bash "make php listen to a socket" do
#   code <<-EOH
#     sed -i '/listen.*/d' /etc/php5/fpm/pool.d/www.conf
#     echo 'listen = /var/run/php5-fpm.sock  #working!!!!!' >> /etc/php5/fpm/pool.d/www.conf
#   EOH
#   notifies :restart, "service[php5-fpm]", :delayed
#   not_if "grep -xq 'listen = /var/run/php5-fpm.sock' /etc/php5/fpm/pool.d/www.conf"
# end