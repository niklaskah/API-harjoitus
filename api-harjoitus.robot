*** Settings ***
Library  SeleniumLibrary
Library  RequestsLibrary
Test Timeout    2 minutes

*** Test Cases ***
Check geolocation of connection
    Locate my ip

Check weather of location

*** Keywords ***