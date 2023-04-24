# CARIN IG for Blue Button® Test Kit

## Running Locally
INSTALLATION\
Install [Docker](https://docs.docker.com/get-started/).\
Install Ruby. It is highly recommended that you install ruby via a [ruby version manager](https://www.ruby-lang.org/en/documentation/installation/#managers).\
Run `bundle install` to install dependencies.\
Run `gem install inferno_core` to install inferno.\
Run `gem install foreman` to install foreman, which will be used to run the Inferno web and worker processes.\
Run `bundle exec inferno migrate` to set up the database.\

RUNNING INFERNO\
Run `bundle exec inferno services start` to start the background services. By default, these include nginx, redis, the FHIR validator service, and the FHIR validator UI. Background services can be added/removed/edited in docker-compose.background.yml.\
Run `inferno star`t to start Inferno.\
Navigate to http://localhost:4567 to access Inferno, where your test suite will be available. To access the FHIR resource validator, navigate to http://localhost/validator.\
When you are done, `run bundle exec inferno services` stop to stop the background services.\

TEST GENERATION\
The CARIN IG for Blue Button® Test Kit has an implemeneted test generator. It extracts necessarry data elements from CARIN for Blue Button Implementation Guide archive files and generates tests accordingly. The repo currently contains suites for IG versions 1.1.0 and 2.0.0.\
To generate a test suite for a different CARIN for Blue Button IG version:\
Navigate to `CARIN-for-Blue-Button-Test-Kit/lib/carin_for_blue_button_test_kit/igs/`\
Drop your package.tgz file for the IG version into this folder. You may want to rename it before hand.\
run the command `rake carin4bb:generate` to run the generator.\
Run Inferno and verify that your new suite was generated and is available as an option
