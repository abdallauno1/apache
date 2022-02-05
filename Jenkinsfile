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
	
	stage('Clone github repo & download Cookbook'){
		steps{
			script{
				def repoCloned  = fileExists '/home/vagrant/jenkins-agent/workspace/chef-conf-pipeline/apache'
				if (repoCloned){
					echo 'Skipping clone repo ... repo cloned'
			}else{
				sh 'git clone https://github.com/abdallauno1/apache.git'
			  }
			}		
		   }
		 }	
		
	   


	stage ('Creating directory for the configuration...'){
		steps{
			script{
		       	  def dirExists  = fileExists '/home/vagrant/chef-repo'
				  if (dirExists) {
					echo 'Skipping creating directory ...directory present'
				}else{
				    sh 'mkdir ~/chef-repo/ &&  mkdir ~/chef-repo/.chef'
				}			
			}
    	  }
    	}
	stage('Copy server credentials'){
		steps{
			withCredentials([file(credentialsId: 'CHEF-USER-KEY', variable: 'chef-user-key')]) {
					         writeFile file: '~/chef-repo/.chef/abdallauno1.pem', text: readFile(chef-user-key)

		   }
		}
	 }
   }
  }
