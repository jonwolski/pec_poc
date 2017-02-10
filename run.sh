#!
bin/rake db:reset
bin/rake replay_transitions &
sleep 1
bin/rake load_transitions
bin/rake replay_transitions

