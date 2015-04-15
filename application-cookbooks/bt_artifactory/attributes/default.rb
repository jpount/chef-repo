# Instruct this cookbook to install Java for you. Default true
# No need because installing it directly
default['artifactory']['install_java'] = false

# Runit seems to have issues with RHEL loading glibc-static
#default['runit']['use_package_from_yum'] = true

########################
# Artifactory Settings #
########################

# Artifactory home directory. Artifacts are kept here
#default['artifactory']['home'] = '/var/lib/artifactory'
# Artifactory/tomcat logs 
#default['artifactory']['log_dir'] = '/var/log/artifactory'
# Artifactory http port, default is 8081
#default['artifactory']['port'] = 8081
# Artifactory http port, default is 8015
#default['artifactory']['shutdown_port'] = 8015
# java Xmx (max heap size)
#default['artifactory']['java']['xmx'] = '1g'
# java Xms (initial heap size)
#default['artifactory']['java']['xms'] = '512m'
# Extra java options, default is '-XX:+UseG1GC'
#default['artifactory']['java']['extra_opts'] = '-XX:+UseG1GC'
# Artifactory download link
#default['artifactory']['zip_url'] = 'http://dl.bintray.com/content/jfrog/artifactory/artifactory-3.4.1.zip?direct'
# Checksum
#default['artifactory']['zip_checksum'] = '5019e4a4cac7936b3d4e1fc457d36fff60cdf27de42886184b0b5a844f43f0b0'
# Catalina directory
#default['artifactory']['catalina_base'] = ::File.join(artifactory['home'], 'tomcat')
# Artifactory user
#default['artifactory']['user'] = 'artifactory'

