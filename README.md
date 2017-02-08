Run multiple tasks concurrently and see if you get state transition errors

```
bin/rake db:reset && bin/rake replay_transitions ; bin/rake replay_transitions
```
