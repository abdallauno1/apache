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
				<style>
				p { color: #333333; font-family: "Helvetica Neue",Arial,sans-serif; font-size: 16px; font-weight: 300; line-height: 1.5625; margin-bottom: 15px; }
				</style>
					<body>
					<p>Hello Steve, There is Mady fro DevOps</p><br><br>
					<p>Current Date and Time is <span id="datetime"></span>.</p>
						<script>
							var dt = new Date();
							document.getElementById("datetime").innerHTML=dt;
						</script>
					</body>
				</html>
				
                  '

		end
