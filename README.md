# WiseAlbum API

This serves as the API layer for WiseAlbum, a multi-tenant media sharing application.

This application runs on Ruby 3.1.1, and as configured, a PostgreSQL database. It uses JSON Web Tokens (JWTs) and devise to manage authentication

## Dependencies / Environment Variables

WiseAlbum uses AWS for media uploads and sending email (though email sending may work with other services as well). If you are installing this to run on your own, you'll need to provide the following environment variables:

### For Devise

- `DEVISE_JWT_SECRET_KEY` - Generated by running `bundle exec rake secret`, used to sign generated JWTs

### For Media

See https://elliott-king.github.io/2020/09/s3-heroku-rails/ for instructions on setting up AWS for direct uploading

- `AWS_ACCESS_KEY_ID` - The AWS IAM generated account access key
- `AWS_SECRET_ACCESS_KEY` - The AWS IAM generated account secret access key
- `AWS_REGION` - The AWS region where your S3 buckets are located
- `S3_BUCKET` - The name of the S# bucket for your media

### For Email

See https://davidmles.medium.com/setting-up-rails-to-send-emails-with-amazon-ses-ce4806faff94 for instructions on setting up AWS's Simple Email Service

- `MAILER_SENDER` - The FROM address for emails
- `SES_SENDFROM_HOST` - The host for the email sender
- `SES_ENDPOINT` - The SES endpoint for communication with AWS SES
- `SES_USER_NAME` - The generated AWS SES Username
- `SES_SMTP_PASSWORD` - The generated AWS SES Password
- `SES_SMTP_PORT` - The port to be used to communicate with SES

### For General Use

- `FRONTEND_HOST` - The host for the application's frontend
- `FRONTEND_PORT` - (Optional in production) The port for the application's frontend
- `PORT` - (Optional) The port for the backend to run on, will default to 3000

## Setup Instructions

1. Clone the repo and run `bundle install`
2. Run `bundle exec figaro install` to generate an `application.yml` file in the `/config` folder
3. Add the environment variables as described above
4. Start the Postgres server
5. Run `rails db:create`, `rails db:migrate`, and `rails db:seed`
6. Run `rails s` to start the rails server
7. Clone the [frontend repo](https://github.com/joedietrich-dev/wisealbum-frontend) and follow any instructions there to get set up
8. Start the frontend and have fun!

## Notes

- If you want to use SES for mail delivery while you're developing, comment out line 44 in `/config/environments/development.rb` and uncomment lines 47-60. Otherwise, your emails will be captured by the `letter_opener` gem, which will generate html files in the `tmp` folder whenever the system sends an email - great for low-volume development and testing!
