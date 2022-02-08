package 'Install Apache' do
		  case node[:platform]
		  when 'redhat', 'centos'
		    package_name 'httpd'
		  when 'ubuntu', 'debian'
		    package_name 'apache2'
		  end
		end

		# Do something

		service 'Service' do
		  case node[:platform]
		  when 'redhat' , 'centso'
		   service_name 'httpd'
		        action [:enable, :start]
		  when 'ubuntu' , 'debian'
		   service_name 'apache2'
		        action [:enable, :start]
		  end
		end
		file '/var/www/html/index.html' do
		content 'Ciaoooooo'

		end
