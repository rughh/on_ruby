# How to contribute?

1. Fork the project to your own GitHub account
2. Clone your fork
3. Make sure that you have Ruby installed (you can check the supported Ruby
versions in `.travis.yml`)
4. Run `bundle install`. If you see failures related to compiling native
extensions you need to follow a
[tutorial for setting up Ruby on Rails](https://gorails.com/setup)
5. Make sure that you have PostgreSQL installed and `postgres` role that does
not require password to connect.
6. Run `rake db:setup`
7. Run the test suite with `rake` and check if all the tests pass
8. Switch to a feature branch - `git checkout -b my-new-feature`
9. Write the code and make sure that the tests are still passing
10. Push your branch and submit a pull request
