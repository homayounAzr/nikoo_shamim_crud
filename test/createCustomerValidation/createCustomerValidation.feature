Feature: Submit Customer Form

  Scenario: Invalid submission
    Given the app is running
    When I tap the "Create Customer" button
    And I enter an empty value into the "First Name" field
    And I enter empty into the "Last Name" field
    And I select "2023-09-24" as the "Date Of Birth"
    And I enter empty or number that does not start with '09' into the "Phone Number" field
    And I enter "homayoun.azarnia.gmail.com" that does not contain '@' into the "Email" field
    And I enter an invalid bank account number that does not start with '6037' into the "Bank Account Number" field
    And I tap the "Create Customer" button
    Then I should see an error message indicating that the "Invalid Parameter"
    And I should not see the "All Customers" page

  Scenario: Valid submission
    Given the app is running
    When I tap the "Create Customer" button
    And I enter "Homayoun" into the "First Name" field
    And I enter "Azarnia" into the "Last Name" field
    And I select "2023-09-24" as the "Date Of Birth"
    And I enter "09916547011" into the "Phone Number" field
    And I enter "homayoun.azarnia@gmail.com" into the "Email" field
    And I enter "6037831055114069" into the "Bank Account Number" field
    And I tap the "Create Customer" button
    Then I should see the "All Customers" page

