name 'webserver'
description 'Setup webserver for reverse proxy, ssl termination and serving static files.'
run_list 'recipe[common::default]', 'recipe[webserver::default]'
