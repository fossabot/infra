name 'webapp'
description 'Setup main webapp.'
run_list 'recipe[common::default]', 'recipe[webapp::default]'
