Run multiple tasks concurrently and see if you get state transition errors

Run sidekiq with a single thread:

```sh
bundle exec sidekiq -c 1
```

Reset the data and run the task to replay_transitions:

```sh
bin/rake db:reset && bin/rake replay_transitions ; bin/rake replay_transitions
```

Verify that all transitions completed successfully

```sh
bin/rails console
pry(main)> VendingMachine.group(:state).count
  (7.9ms)  SELECT COUNT(*) AS count_all, "vending_machines"."state" AS vending_machines_state FROM "vending_machines" GROUP BY "vending_machines"."state"
=> {"f"=>50}
```

View the sidekiq dashbaord for errors, retries, etc.

```
bin/rails server
```

Navigate to http://localhost:3000/sidekiq

