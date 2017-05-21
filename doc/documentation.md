## Overview

Here you will find the resources that make up the App Tracker API v1.

If you have any problems or issues please leave an issue or contact the [owner](http://yechiel.me/contact).

## Schema

All API access is over HTTPS, and accessed through the endpoint
```
https://app-tracker-api.herokuapp.com/api/v1/
```
All data is sent and received as JSON.

## Authentication

Certain resources are only available to authenticated users. Authentication is verified by sending an Authentication Token with the header for the request:
```
Authorization: Bearer [TOKEN]
```
Sending a request without a token will return a status of `403` and the error:
```
{
  errors: [
    {message: "You must include a JWT token"}
  ]
}
```
Sending an invalid token will return the error `{message: "Token is invalid"}`


## Routes

The App Tracker API uses standard RESTful routing, hee is an overview of the available routes:

#### Authentication

Logging in is accomplished via `POST` request to `/auth`
```
{
  user: {
    username: [USERNAME],
    password: [PASSOWRD]
  }
}
```
The response will be a user object with a token that can be used for future authentication:
```
{
  user: {
    id: [USER_ID],
    username: [USERNAME],
    name: [NAME]
  },
  token: [TOKEN]
}
```
Sending a bad username/password will return a `403` with an error:
```
{
  errors: [ERROR_MESSAGES]
}
```
#### Refresh
If you already have a token and want to retrieve the user information, send an authenticated `POST` request to `/auth/refresh`. The response will be the same as for the login request.
