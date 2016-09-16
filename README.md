# README
## Sample Ticketing System

This is a coding challenge and my first time to use Ember.js.
This app is a basic customer support ticket platform, wherein customers can create and view the status of their tickets.
Agents can see all opened tickets, and can view monthly report of closed tickets. Admins can manage mostly everything.

## Prerequisites
----
You will need the following things properly installed on your computer.

* [Ruby](http://ruby-lang.org) (with RubyGems and Bundler)
* [MySQL](https://www.mysql.com/)
* [Git](http://git-scm.com/)
* [Node.js](http://nodejs.org/) (with NPM)
* [Bower](http://bower.io/)
* [Ember CLI](http://ember-cli.com/)
* [PhantomJS](http://phantomjs.org/)

## Installation
___
Clone the repository or download and uncompress the code
```
$ git clone git@github.com:warrenchaudhry/ticketing.git
$ cd ticketing
```
There are two folders for this application.
 0. [**ticketing_backend**](https://github.com/warrenchaudhry/ticketing/tree/master/ticketing_backend) -  Ruby on Rails API backend
 1. [**ticketing_frontend**](https://github.com/warrenchaudhry/ticketing/tree/master/ticketing_frontend) - Ember.js frontend application


###### Rails application installation
```
$ cd ticketing_backend
```
0. Install the Rubygems dependencies  
  ```
  $ bundle install
  ```
  It is highly recommended for you to use a virtual environment with user-based libraries instead of system-based. Check out https://rvm.io , for example.

0. Be sure to change the credentials in `.env` file and please check the configuration in `config/database.yml` for any modifications before creating the database.
  ###### sample content of `.env` file
  ```
  DATABASE_USERNAME=mysqlusername
  DATABASE_PASSWORD=mysqlpassword
  ```
1. Create database and migration
  ```
  $ rails db:create
  $ rails db:migrate
  ```  
1. Seed the tables  
  ```
  $ rails db:seed
  ```  
0. The project should work from here on, but if it has been updated with new dependencies, pull the code again, and run `$ bundle install`.
0. Run the tests
```
$ rake
```
0. Start the application
```
$ rails server
```
---
###### Ember.js application installation
```
$ cd ticketing_frontend
$ npm install
$ bower install
```
Start the application
```
$ ember server
```
Visit your app at [http://localhost:4200](http://localhost:4200).


## Test data

Once both applications are running, you can access the application with the following data.

There should be given users:

| Email                 | Type     |
| -------------------   | -------  |
| admin1@email.com      | Admin    |
| agent@email.com       | Support  |
| customer1@example.com | Customer |

For each account password is `password2016`.

----
### Upcoming Features
* PDF report for closed tickets
* Users management (add/update/delete)
* Search functionalities
* Lack of tests
* Comments for tickets

----
### Bugs
* Page should redirect to `/` or `/login` after logout
* Select tags not selecting option equivalent to model value

----
### Author's Info
##### Software
* Darwin  14.5.0 `Darwin Kernel Version 14.5.0: Mon Aug 29 21:14:16 PDT 2016; root:xnu-2782.50.6~1/RELEASE_X86_64 x86_64`
* Ruby `ruby 2.3.0p0 (2015-12-25 revision 53290) [x86_64-darwin14]`
* Rails `5.0.0.1`
* Gem `2.6.6`
* Bundler `Bundler version 1.13.0`
* ember-cli `2.8.0`
* Node `6.5.0`
