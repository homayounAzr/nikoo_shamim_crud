Feature: Create Customer Page

  Scenario: Page contains input fields
    Given the create customer page is displayed
    Then I should see the "First Name" input field
    And I should see the "Last Name" input field
    And I should see the "Date of Birth" input field
    And I should see the "Phone Number" input field
    And I should see the "Email" input field
    And I should see the "Bank Account Number" input field