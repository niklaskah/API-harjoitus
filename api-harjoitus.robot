*** Settings ***
Library  RequestsLibrary
Library  Collections
Variables    variables.json
Variables    auth.json

*** Variables ***


*** Test Cases ***  
Create a Booking
    TRY
        ${response}    POST    https://restful-booker.herokuapp.com/booking    json=${new booking}
        Status Should Be  200
        Log    ${response.json()}[bookingid]
        Log Dictionary  ${response.json()}[booking]
        ${id}    Set Variable    ${response.json()}[bookingid]
        Set Suite Variable    ${ID}    
    EXCEPT
        Fatal Error
    END
    Should Be Equal    Pekka    ${response.json()}[booking][firstname]

Get Bookings By Name
    ${name}    Create Dictionary    firstname=Pekka    lastname=Pouta
    ${response}  GET  https://restful-booker.herokuapp.com/booking    ${name}
    Status Should Be  200
    Log List  ${response.json()}

Update Booking
    Authenticate As Admin
    ${header}    Create Dictionary    Cookie=token=${TOKEN}
    ${bookingdates}    Create Dictionary    checkin=2018-01-01    checkout=2019-01-01
    ${update}    Create Dictionary    firstname=Pekka    lastname=Pouta    totalprice=100    depositpaid=true    bookingdates=${bookingdates}    additionalneeds=breakfast
    ${response}    PUT    https://restful-booker.herokuapp.com/booking/${ID}    headers=${header}    json=${updated booking}
    Status Should Be  200
    Log Dictionary  ${response.json()}

Delete Booking
    Authenticate As Admin
    ${header}    Create Dictionary    Cookie=token=${TOKEN}
    ${response}  DELETE  https://restful-booker.herokuapp.com/booking/${ID}    headers=${header}
    Status Should Be  201

*** Keywords ***
Authenticate As Admin
    ${body}    Create Dictionary    username=${username}   password=${password}
    ${response}    POST    https://restful-booker.herokuapp.com/auth    ${body}
    Status Should Be  200
    ${token}    Set Variable     ${response.json()}[token]
    Set Suite Variable    ${TOKEN}    ${token}
