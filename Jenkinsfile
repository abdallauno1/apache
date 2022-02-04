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
			git credentialsId: 'github-creds', url: 'git@github.com:abdallauno1/apache.git'
		}
	}	
	stage ('Install Docker') {
		steps {
			script {
				def dockerExists = fileExists 'usr/bin/docker'
				if (dockerExists)
					echo 'Skipping Docker install...already installed'
				else{
					sh 'wget https://download.docker.com/linux/ubuntu/dists/xenial/pool/stable/amd64/containerd.io_1.2.0-1_amd64.deb'
					sh 'wget https://download.docker.com/linux/ubuntu/dists/xenial/pool/stable/amd64/docker-ce-cli_18.09.0~3-0~ubuntu-xenial_amd64.deb'
					sh 'wget https://download.docker.com/linux/ubuntu/dists/xenial/pool/stable/amd64/docker-ce-rootless-extras_20.10.0~3-0~ubuntu-xenial_amd64.deb'
					sh 'sudo dpkg -i containerd.io_1.2.0-1_amd64.deb'
					sh 'sudo dpkg -i docker-ce-cli_18.09.0~3-0~ubuntu-xenial_amd64.deb'
					sh 'sudo dpkg -i docker-ce-rootless-extras_20.10.0~3-0~ubuntu-xenial_amd64.deb'
					sh 'sudo usermod -aG root,docker vagrant'
				 }
				 /* check if docker is installed correctly */
				 sh 'sudo docker run hello-worl'	
			}
		}	
	}
	stage('Install Ruby and Test Kitchen'){
		steps{
			sh 'sudo apt-get install -y rubygems ruby-dev'
			sh 'chef gem install kitchen-docker' 
		}
	}
	stage ('Run test kitchen'){
		steps{
			sh 'sudo kitchen test'
		}
	}
	stage('Bootstrap the node'){
	steps{
	 withCredentials ([sshUserPrivateKey(credentialsId: 'vagrant-test', keyFileVariable: 'AGENT_SSHKEY', passphraseVariable: '',usernameVariable:'')]){
		 sh "knife bootstrap 192.168.1.70 -x vagrant -P vagrant --node-name test  --sudo"
		 }	
	 }
	}
	stage('Upload Cookbook to Chef Server, Converge Nodes'){
		steps{
			withCredentials([zip(credentialsId: 'chef-server-creds' , varibale: 'CHEFREPO')]){

			  sh 'mkdir -p $CHEFREPO/chef-repo/cookbooks/apache'

			  sh 'sudo rm -rf $WORKSPACE/Berksfile.lock'

			  sh 'mv $WORKSPACE/* $CHEFREPO/chef-repo/cookbooks/apache'

			  sh "kinfe cookbook upload apache --force -o $CHEFREPO/chef-repo/cookbooks -c $CHEFREPO/chef-repo/.chef/knife.rb"

			withCredentials ([sshUserPrivateKey(credentialsId: 'vagrant-test', keyFileVariable: 'AGENT_SSHKEY', passphraseVariable: '',usernameVariable:'')]){

			  sh "kinfe ssh 'role:webserver' -x vagrant -i $AGENT_SSHKEY 'sudo chef-client' -c $CHEFREPO/chef-repo/.chef/knife.rb"

			 }  
		   }
		}
	 }
  }
}
