name 'database'
description 'Setup main database.'
run_list 'recipe[common::default]', 'recipe[database::default]'
