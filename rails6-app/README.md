# devise

```
bundle install
```

```
rails g devise:install

rails g devise User
rails g devise:controllers users
rails g devise:views
```

# migrate

```
rails db:create
rails db:migrate
```

# webpack

Edit Gemfile

```
gem 'webpacker', '~> 5.0'
```

```
rails webpacker:install
NODE_OPTIONS=--openssl-legacy-provider rails webpacker:compile
```

