# [Crossover Tickets](https://github.com/ThomasMarcel/crossover-tickets)
_Coding Challenge_  

## Functional Requirements

The system allows customers to be able to place support request and the support agents to process the requests. The system implements the following specifications.

0. For customers
 * A web portal to create support requests and to view status of previous requests.

0. For support agents

 * A web portal to find and process support requests.

 * One report, on requests data, with all tickets closed in the last one month; Should be PDF exportable.

Other functional requirements
0. Users should be able to authentication normally

0. An admin user should be able to manage other users and any other system objects.

Assume any functional details required to achieve the above requirements based on logic and your experience.

## Other Technical and Non-functional Requirements


The following list of technical specifications must be adhered to

0. Use MySQL server, Ruby on Rails on back end, Bootstrap and Ember.js on front end. Use latest versions if possible.

0. On back-end : REST API, db migrations, ActiveRecord, rspec tests

0. On front-end : SPA pattern web-app, MVVM pattern with Ember.js, responsive design, testing with Qunit.

0. Enough coverage of proofing automated tests on both back and front end (coverage > 30%).

0. Secure the applications and services.

## User Stories
* As a customer I should be able to
  * Log in
  * See tickets I created
  * See the status of the tickets I created
  * Create a new ticket


* as a support agent I should be able to
  * Log in
  * See open tickets
  * Complete open tickets
  * Get a monthly report of my performance (tickets closed)


*  as an admin, I should be able to
  * See all registered users
  * Edit user's information
  * Delete users
