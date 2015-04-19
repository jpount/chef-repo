#################
# Ruby Settings #
#################

default[:rbenv_install_rubies][:global_version] = '2.1.4'
default[:rbenv_install_rubies][:gems] = ['bundler', 'rbenv-rehash', 'pry', 'serverspec', 'fauxhai', 'foodcritic', 'rubocop', 'rspec', 'chefspec']
default[:rbenv_install_rubies][:other_versions] = []
default[:rbenv_install_rubies][:lib_packages] = []
