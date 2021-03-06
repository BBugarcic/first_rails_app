## Bike Berlin

This is a demo Ruby On Rails application I have build during CareerFoundry's course in Web Development. I build this project from scratch.
This is a demo e-commerce website and the link to the application deployed on Heroku is [here](https://warm-journey-96233.herokuapp.com).

### Rails version
At the beginning Bike Berlin was build in Ruby On Rails 4.2 but after the release of Rails 5.0, application is upgrated to new Rails version.

#### Ruby version
ruby "2.3.1"

#### Authentication and Authorization
Authentication(register, login and logout functions) in Bike Berlin is provided with [Devise](https://github.com/plataformatec/devise). The separation of available data and actions based on the individual user is handled with [CanCanCan](https://github.com/CanCanCommunity/cancancan).

#### Comments & Reviews
User can post a review for every individual product. Average review is displayed for each product.

#### Notifications and ActionCable
Since Rails 5 is released with brand new framework for handling WebSockets in Rails, posting comments and notifications are handled with ActionCable. Only signed in users get stream updates, and actual comments are displayed to all users who are streaming from a product channel. Only the comments on the specific product get streamed and not all of them!

Active job - framework for declaring jobs and making them run on a variety of queuing backends - is used for broadcasting comment in order to improve app's performance.

Streaming and Broadcasting is running on Heroku using Postgresql as Pub/Sub adapter.

####Payments
Payments system is implemented with [Stripe](https://stripe.com/ca) - payment processing service. Because this is only a demo application payments are configured to work in test mode on Heroku. For processing payments user of this application should use only [stripe's test numbers](https://stripe.com/docs/testing).

####Testing
Unit and functional tests are done with RSpec. FactoryGirl gem is used for generating test data in functional tests.

####Security
The latest version of [Brakeman](http://brakemanscanner.org/) is used to improve and check security of the app.

####Caching
In order to demonstrate and learn about different ways of caching, in this application, data is cached using Russan Doll strategy, [Mamcached](http://memcached.org/) data story using [Dalli](https://github.com/petergoldstein/dalli), and [Redis](http://redis.io/).

####Monitoring
[New Relic](https://newrelic.com/) is used as a monitoring tool.

####Running Bike Berlin on your localhost
In order to run this project on your localhost you have to do the following

-> git clone git@github.com:BBugarcic/first_rails_app.git
->cd project
->bundle install
->rake db:migrate
->rails server
