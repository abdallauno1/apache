pipeline {
	agent {label 'vagrant-worker'}
stages{
    stage ('Update machine'){
	 steps {
		sh 'sudo apt-get update'
	    }
	  }
	stage('Install ChefDK'){
	  steps{
			script{
				def chefDKexists  = fileExists '/usr/bin/chef-client'
				if (chefDKexists) {
					echo 'Skipping Chef install...already installed'
				}else{
					sh '''#!/bin/bash

				    		  wget wget https://packages.chef.io/files/stable/chefdk/4.13.3/ubuntu/18.04/chefdk_4.13.3-1_amd64.deb
				   		  sudo dpkg -i chefdk_4.13.3-1_amd64.deb
               				    '''
					/* sh 'wget wget https://packages.chef.io/files/stable/chefdk/4.13.3/ubuntu/18.04/chefdk_4.13.3-1_amd64.deb'
					   sh 'sudo dpkg -i chefdk_4.13.3-1_amd64.deb' */
				}
			}
		}
	}
	
	stage('Download Cookbook'){
		steps{
			sh 'git clone https://github.com/abdallauno1/apache.git'
			
		}
	}	
	


	stage ('Creating directory for the configuration...'){
		steps{
			sh 'mkdir ~/chef-repo/ &&  mkdir ~/chef-repo/.chef '
		}
	}

	stage('Copy server credentials'){
		steps{
			withCredentials([file(credentialsId: 'CHEF-USER-KEY', variable: 'chef-user-key'),
                 			 file(credentialsId: 'CHEF-ORG-KEY', variable: 'chef-org-key'),
					 file(credentialsId: 'CHEF-CONFIG-KEY', variable: 'chef-org-config')]) {
					         writeFile file: '~/chef-repo/.chef/abdallauno1.pem', text: readFile(chef-user-key)
        					 writeFile file: '~/chef-repo/.chef/uno.pem', text: readFile(chef-org-key)
						 writeFile file: '~/chef-repo/.chef/config.rb', text: readFile(chef-org-config)
        		/*			 
			  sh "cp $chef-user-key ~/chef-repo/.chef"
			  sh "cp $chef-org-key ~/chef-repo/.chef"
			  sh "cp $chef-org-config ~/chef-repo/.chef"		
				*/
		   }
		}
	 }
  }
}
