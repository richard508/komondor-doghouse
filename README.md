# Komondor | Dog House

An auth-providing app used in conjuction with the [Komondor gem](https://github.com/richard508/komondor) to allow for single sign on.

## Installation

1. `git clone https://github.com/Infosurv/komondor-doghouse.git`
2. `cd komondor-doghouse`
3. `bundle install`
4. `rake db:migrate`

## Usage

The migration will create a default admin Account and User. To login, use:

**Email:** `admin@example.com`
**Password:** `password`

1. **Add Accounts** These are just named groups for Users.
  * Apps are associated with Accounts. This is to allow different levels of access to different Accounts.
2. **Add Apps** Details about attached Rails Apps are added in this step. You will need a name, the domain for the App, and you can select the Accounts that can access this app.
  * A secret key will be generated for the App when it is added. To see the secret key, click on the App's name. Copy the generated key to the App's environment variables (details found in Komondor gem's [readme](insert link)).
3. **Add Users** To add a User, add a name, email, and password. Also specify the Account the User should be a member of. New admin users can be created as well.
  * When a User is created, their identity is distributed to all the Apps they have access to through the Account.
  * An App will need to be fully setup before it will accept new Users.Instructions for setting up an App are included in the Komondor gem's [readme](insert link)
  * To add an existing User to a new App, simply update the User.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
