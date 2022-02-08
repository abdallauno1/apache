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
		# FileUtils.cp_r 'src/.', 'dest'
		file '/var/www/html/index.html' do
		content '
			<!DOCTYPE html>
				<html>
				<head>
				</head>
					<body>
					<p>Hello Steve, There is Mady fro DevOps</p><br><br>
					<p>Current Date and Time is <span id=\t'date-time'></span>.</p>
						<script>
							var dt = new Date();
							document.getElementById(\t'date-time').innerHTML=dt;
						</script>
					</body>
				</html>
				
                  EOF '

		end
