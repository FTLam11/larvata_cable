web: bundle exec rails s
rpc: bundle exec anycable --debug -r ./spec/dummy/config/environment.rb
ws:  anycable-go --host localhost --port 3334 --cookies=header,origin,authorization
worker: bundle exec sidekiq -r spec/dummy
