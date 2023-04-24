# CARIN IG for Blue Button® Test Kit

This is an [Inferno](https://inferno-framework.github.io/inferno-core/) test kit
for the CARIN IG for Blue Button®
[v1.1.0](http://hl7.org/fhir/us/carin-bb/STU1.1), and
[v2.0.0](http://hl7.org/fhir/us/carin-bb/STU2).

## Instructions

It is highly recommended that you use [Docker](https://www.docker.com/) to run
these tests so that you don't have to configure ruby and the FHIR validator
service. For more information on how to run Inferno, visit [Inferno's
documentation](https://inferno-framework.github.io/inferno-core/getting-started.html)

- Clone this repo.
- Run `setup.sh` in this repo.
- Run `run.sh` in this repo.
- Navigate to `http://localhost`. The US Core test suite will be available.

## TEST GENERATION
The CARIN IG for Blue Button® Test Kit has an implemeneted test generator. It
extracts necessarry data elements from CARIN for Blue Button Implementation
Guide archive files and generates tests accordingly. The repo currently contains
suites for IG versions 1.1.0 and 2.0.0.

To generate a test suite for a different CARIN for Blue Button IG version:
- Navigate to
  `CARIN-for-Blue-Button-Test-Kit/lib/carin_for_blue_button_test_kit/igs/`
- Drop your package.tgz file for the IG version into this folder. You may want
  to rename it before hand.
- Run the command `bundle exec rake carin4bb:generate` to run the generator.
- Run Inferno and verify that your new suite was generated and is available as
  an option
