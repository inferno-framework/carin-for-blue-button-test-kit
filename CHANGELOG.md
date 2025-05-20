# 0.15.1
* FI-3995 Fix search template input description and regenerate by @Shaumik-Ashraf in https://github.com/inferno-framework/carin-for-blue-button-test-kit/pull/72
* FI-3813: Use core MustSupport features by @dehall in https://github.com/inferno-framework/carin-for-blue-button-test-kit/pull/70
* FI-3662: verifies_requirements annotations by @elsaperelli in https://github.com/inferno-framework/carin-for-blue-button-test-kit/pull/74
* FI-3973: Client Auth by @karlnaden in https://github.com/inferno-framework/carin-for-blue-button-test-kit/pull/73

# 0.15.0
##Breaking Change
This release updates the CARIN IG for Blue Button® Test Kit to use AuthInfo
rather than OAuthCredentials for storing auth information. As a result of this
change, any test kits which rely on this test kit will need to be updated to use
AuthInfo rather than OAuthCredentials inputs.

* FI-3746: Use AuthInfo by @Jammjammjamm in https://github.com/inferno-framework/carin-for-blue-button-test-kit/pull/68

# 0.14.0

* **Ruby Version Update:** Upgraded Ruby to `3.3.6`.
* **Inferno Core Update:** Bumped to version `0.6`.
* **Gemspec Updates:**
  * Switched to `git` for specifying files.
  * Added `presets` to the gem package.
  * Updated any test kit dependencies
* **Test Kit Metadata:** Implemented Test Kit metadata for Inferno Platform.
* **Environment Updates:** Updated Ruby version in the Dockerfile and GitHub Actions workflow.
* Add Group IDs to Each Group in the CARIN Client Test Suite by @emichaud998 in https://github.com/inferno-framework/carin-for-blue-button-test-kit/pull/61
* Endpoint Suite ID Fix by @emichaud998 in https://github.com/inferno-framework/carin-for-blue-button-test-kit/pull/62
* FI-3404: Add SMART on FHIR Workflow Support to CARIN Client tests by @emichaud998 in https://github.com/inferno-framework/carin-for-blue-button-test-kit/pull/63
* Fix Metadata File Path by @emichaud998 in https://github.com/inferno-framework/carin-for-blue-button-test-kit/pull/64
* FI-3648: Add Spec for Shared Tests and Implement Features for the Failing Tests by @vanessuniq in https://github.com/inferno-framework/carin-for-blue-button-test-kit/pull/65

# 0.13.3

* Deployment fixes by @karlnaden in https://github.com/inferno-framework/carin-for-blue-button-test-kit/pull/59

# 0.13.2

* Fix: Made Carin Wait Test ID Unique by @vanessuniq in https://github.com/inferno-framework/carin-for-blue-button-test-kit/pull/57

# 0.13.1

* add documentation markdown files to the gem
* move demonstration postman collection out of the preset directory

# 0.13.0

* FI-3271/FI-3272: Implement Mock Server and CARIN tests for required/must-support elements for Client-Based CARIN Testing by @emichaud998 in https://github.com/inferno-framework/carin-for-blue-button-test-kit/pull/47

# 0.12.1

* move roo to a development dependency in the gemfile by @karlnaden in https://github.com/inferno-framework/carin-for-blue-button-test-kit/pull/51

# 0.12.0

* FI-3086: Add the Ability to Map Requirements to Test into the CARIN Test Kit by @emichaud998 in https://github.com/inferno-framework/carin-for-blue-button-test-kit/pull/46
* FI-3410: Update inferno core requirement by @Jammjammjamm in https://github.com/inferno-framework/carin-for-blue-button-test-kit/pull/49

# 0.11.2

* Dependency Updates 2024-07-03 by @Jammjammjamm in https://github.com/inferno-framework/carin-for-blue-button-test-kit/pull/42

# 0.11.1

* Dependency Updates 2024-06-05 by @Jammjammjamm in https://github.com/inferno-framework/carin-for-blue-button-test-kit/pull/40
* FI-2429: Additional changes for HL7 validator transition by @dehall in https://github.com/inferno-framework/carin-for-blue-button-test-kit/pull/39

# 0.11.0

* FI-2395: Add data rights legend by @bmath10 in
  https://github.com/inferno-framework/carin-for-blue-button-test-kit/pull/34
* Dependency Updates 2024-03-19 by @Jammjammjamm in
  https://github.com/inferno-framework/carin-for-blue-button-test-kit/pull/35
* Dependency Updates 2024-04-05 by @Jammjammjamm in
  https://github.com/inferno-framework/carin-for-blue-button-test-kit/pull/36
* FI-2429: Migrate to HL7 validator wrapper by @dehall in
  https://github.com/inferno-framework/carin-for-blue-button-test-kit/pull/37

# 0.10.0

* FI-2191 Reorganize tests into SMART group and Carin group
* FI-2285 Rearrange test sequence based on the reference linkages between resources
* FI-2286 Combine ExplainOfBenefit tests into one test group
* FI-2298 Simplify input fields
* FI-2232 Use FHIR Modle for FHIR JSON parsing
* FI-2189 Add test for SMART Scopes
* FI-2190 Add test for SMART Capabilities
* FI-2184 Fix _include search test to check the included resources match the _include search criteria
* FI-2186 Change _lastUpdated search test to optional
