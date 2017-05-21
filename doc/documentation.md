### Overview

Here you will find the resources that make up the App Tracker API v1.

If you have any problems or issues please leave an issue or contact the [owner](http://yechiel.me/contact).

### Schema

All API access is over HTTPS, and accessed through the `https://app-tracker-api.herokuapp.com/api/v1/` endpoint.
All data is sent and received as JSON.

### Authentication

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
