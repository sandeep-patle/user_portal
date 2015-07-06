# User Portal

This application is providing platform for users to do sign up and access their dashboard page.

For accessing this application user need to login.

This application build around the REST API's. Using rest-client gem for calling the API's.

For this we have created lib which is responsible for calling APIs and we are parsing JSON response and creating ruby class objects to access them at view label. This application do not need any database support.


For UI we are using Bootstrap v3.3.4 (http://getbootstrap.com).

## Setup

1. Clone the repository
2. Bundle install
3. Set API_URL(API server) and CLIENT_ID in environment files(development, production etc)

## Environment
Ruby - 1.9.3
Rails - 3.2.12
