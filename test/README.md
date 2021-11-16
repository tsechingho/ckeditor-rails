# Manually Test Rails Application

## Rbenv

```sh
brew install ruby-build rbenv
```

## Rails 4

```sh
rbenv install 2.6.8
rbenv rehash 2.6.8
rbenv local 2.6.8
gem install rails -v 4.2.11.3
rails _4.2.11.3_ new rails4 --skip-git --skip-test --skip-keeps
cd rails4
bundle install
bundle exec spring stop && bundle exec rails server
open http://127.0.0.1:3000/
```

## Rails 5

```sh
rbenv install 2.7.4
rbenv rehash 2.7.4
rbenv local 2.7.4
gem install rails -v 5.2.6
rails _5.2.6_ new rails5 --skip-git --skip-test --skip-keeps
cd rails5
bundle install
yarn install
bundle exec spring stop && bundle exec rails server
open http://127.0.0.1:3000/
```

## Rails 6

```sh
rbenv install 3.0.2
rbenv rehash 3.0.2
rbenv local 3.0.2
gem install rails -v 6.1.4.1
rails _6.1.4.1_ new rails6 --skip-git --skip-test --skip-keeps
cd rails6
bundle install
yarn install
bundle exec spring stop && bundle exec rails server
open http://127.0.0.1:3000/
```
