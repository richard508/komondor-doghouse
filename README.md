# Komondor | Dog House

An auth-providing app used in conjuction with the [Komondor gem](insert link) to allow for single sign on.

## Installation

1. `git clone https://github.com/Infosurv/komondor-doghouse.git`
2. `cd komondor-doghouse`
2. `bundle install`
3. `rake db:migrate`
4. create first admin user

## Usage

1. Add accounts
  * Apps are associated with accounts. This is to allow different levels of access to different accounts.
2. Add apps
  * copy generated secret key to app's environment variables (`SSO_SECRET_KEY`)
3. Add users
  * To add an existing user to a new app simply edit the user and update them.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
