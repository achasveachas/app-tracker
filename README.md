## App Tracker API

### Overview

This is an API for a job tracking application I created (can be found [here](https://app-tracker-react.herokuapp.com/), GitHub repo can be found [here](https://github.com/achasveachas/app-tracker-react)), where job applicants can keep track of the different applications they've submitted, and the various actions they've taken in regards to said applications (e-mails, communications, meetings, interviews, etc.)

### Technical Specs

The API was built using Rails V. 5.0.2

It uses a PostgreSQL database.

The test suite was built using [RSpec](http://rspec.info/about/).

### Usage

* [Documentation](doc/documentation.md)

This root API endpoint can be found at https://app-tracker-api.herokuapp.com/api/v1/

Detailed instructions will be added once the app is finished. Until then a brief overview is provided below:

The API uses RESTful patterns to access users through `/users`. Users' applications can be accessed by nesting `/applications` routes under the `/users` routes like this: `/users/:id/applications`.

User authentication is accomplished through a token that is sent back when a user signs in using their username and password via a `POST` request to `/auth`.

On refresh, the user's information can be retrieved by sending the token via a `POST` request to `/auth/refresh`.

### Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/achasveachas/app-tracker or by email to [projects@yechiel.me](mailto:projects@yechiel.me). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

### License

The app is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

### Contact

Yechiel Kalmenson can be contacted by email at [contact@yechiel.me](mailto:contact@yechiel.me), or through his website [Yechiel.me](http://yechiel.me). Links to his social media can be found on the site as well.
