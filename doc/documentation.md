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

## Users
#### Sign Up
Creating a new user is accomplished via `POST` request to `/users`:
```
{
  user: {
    username: [USERNAME],
    name: [NAME] (optional),
    password: [PASSOWRD]
  }
}
```
The response will be the new User with a token:
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
Sending invalid credentials will return a `500` status and array of errors:
```
{
  errors: [ERROR_MESSAGES]
}
```
#### Show User
To get the informationfor an (unauthenticated) user, send a `GET` request to `/users/:user_id`, the server will respond with a User object:
```
{
  user: {
    id: [USER_ID],
    username: [USERNAME],
    name: [NAME]
  }
}
```
## Applications
Application routes are nested under the User they belong to (`/users/:user_id/applications`)
#### index
To see all of the Applications belonging to a User send a `GET` request to `/users/:user_id/applications`. The response will be an array of Application objects:
```
{
  applications: [
    {
      "id": [APPLICATION_ID],
      "user_id": [USER_ID],
      "company": [COMPANY],
      "contact_name": [CONTACT_NAME],
      "contact_title": [CONTACT_TITLE],
      "date": [DATE],
      "action": [ACTION],
      "first_contact": [FIRST_CONTACT],
      "job_title": [JOB_TITLE],
      "job_url": [URL],
      "notes": [NOTES],
      "complete": [COMPLETE],
      "next_step": [NEXT_STEP],
      "status": [STATUS],
      "created_at": [TIMESTAMP],
      "updated_at": [TIMESTAMP]
    }
  ]
}
```
#### Show
To see an individual application send a `GET` request to `/users/:user_id/applications/:application_id`. The response will be an Application object:
```
{
  application: {
    "id": [APPLICATION_ID],
    "user_id": [USER_ID],
    "company": [COMPANY],
    "contact_name": [CONTACT_NAME],
    "contact_title": [CONTACT_TITLE],
    "date": [DATE],
    "action": [ACTION],
    "first_contact": [FIRST_CONTACT],
    "job_title": [JOB_TITLE],
    "job_url": [URL],
    "notes": [NOTES],
    "complete": [COMPLETE],
    "next_step": [NEXT_STEP],
    "status": [STATUS],
    "created_at": [TIMESTAMP],
    "updated_at": [TIMESTAMP]
  }
}
```
#### Create/Update
To Create a new Application send an authenticated `POST` request to `/users/:user_id/applications`.
To update an existing Application send an authenticated `PATCH` request to `/users/:user_id/applications/:application_id`.

```
{
  application: {
    "company": [COMPANY],
    "contact_name": [CONTACT_NAME],
    "contact_title": [CONTACT_TITLE],
    "date": [DATE],
    "action": [ACTION],
    "first_contact": [FIRST_CONTACT],
    "job_title": [JOB_TITLE],
    "job_url": [URL],
    "notes": [NOTES],
    "complete": [COMPLETE],
    "next_step": [NEXT_STEP],
    "status": [STATUS]
  }
}
```
In both cases, the response will be the created/updated Application object:
```
{
  application: {
    "id": [APPLICATION_ID],
    "user_id": [USER_ID],
    "company": [COMPANY],
    "contact_name": [CONTACT_NAME],
    "contact_title": [CONTACT_TITLE],
    "date": [DATE],
    "action": [ACTION],
    "first_contact": [FIRST_CONTACT],
    "job_title": [JOB_TITLE],
    "job_url": [URL],
    "notes": [NOTES],
    "complete": [COMPLETE],
    "next_step": [NEXT_STEP],
    "status": [STATUS],
    "created_at": [TIMESTAMP],
    "updated_at": [TIMESTAMP]
  }
}
```
#### Delete
To delete an Application send an authenticated `DELETE` request to `/users/:user_id/applications/:application_id`. The response will be a `204` status.
