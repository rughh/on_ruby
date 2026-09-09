# How to contribute?

1. Fork the project to your own GitHub account
2. Clone your fork
3. Set up your environment, either by:
   - Installing everything locally, by following steps 4-5 below, or
   - using docker directly (skip to step 6)
   - Opening the project in a [Dev Container](readme.md#install-using-dev-containers) then skipping to step 6
4. Make sure that you have Ruby installed (you can check the supported Ruby
versions in `.ruby-version`) and run `bundle install`. If you see failures
related to compiling native extensions you need to follow a
[tutorial for setting up Ruby on Rails](https://gorails.com/setup)
5. Make sure that you have PostgreSQL installed and a `postgres` role that
does not require a password to connect, then run `rake db:setup`
6. Run the test suite with `rake` and check if all the tests pass
7. Switch to a feature branch - `git checkout -b my-new-feature`
8. Write the code and make sure that the tests are still passing
9. Push your branch and submit a pull request
