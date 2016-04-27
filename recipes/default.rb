#
# Cookbook Name:: chef-domains
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

package 'curl'

myip = `curl https://domains.google.com/checkip`

puts myip
 
execute 'call the google domains api with curl and update the desired dynamic dns record' do 
  command "curl -o /tmp/output.txt https://#{ node[:domains][:username]}:#{ node[:domains][:password]}@domains.google.com/nic/update?hostname=#{ node[:domains][:hostname] }&myip=#{myip}"
  user 'root'
  group 'root'
  not_if node[:domains][:lastresponse].include? "nochg" 
end


