-- Keep a log of any SQL queries you execute as you solve the mystery.

-- The initial information that we're given is that the theft took place on/in:
-- 1. 28th July 2. Chamberlin street

-- Main goals: 1. discover who the thief is 2. find out where the thief escaped to 3. find the accomplice who helped the thief escape from town.

-- when running:  SELECT description FROM crime_scene_reports WHERE month = 7 AND day= 28 AND street = "Chamberlin Street"; -- this resulted in:
-- Theft of the CS50 duck took place at 10:15am at the Chamberlin Street courthouse. Interviews were conducted today with three witnesses who were present at the time — each of their interview transcripts mentions the courthouse.

-- When running : SELECT teranscript FROM interviws WHERE month = 7 AND day = 28;
-- transcript:
-- “Ah,” said he, “I forgot that I had not seen you for some weeks. It is a little souvenir from the King of Bohemia in return for my assistance in the case of the Irene Adler papers.”
-- “I suppose,” said Holmes, “that when Mr. Windibank came back from France he was very annoyed at your having gone to the ball.”
-- “You had my note?” he asked with a deep harsh voice and a strongly marked German accent. “I told you that I would call.” He looked from one to the other of us, as if uncertain which to address.
-- Sometime within ten minutes of the theft, I saw the thief get into a car in the courthouse parking lot and drive away. If you have security footage from the courthouse parking lot, you might want to look for cars that left the parking lot in that time frame.
-- I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at the courthouse, I was walking by the ATM on Fifer Street and saw the thief there withdrawing some money.
-- As the thief was leaving the courthouse, they called someone who talked to them for less than a minute. In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow. The thief then asked the person on the other end of the phone to purchase the flight ticket.

-- Goal : 1. have a look at courthouse footage in parking lot, where there are cars left ten minutes within the theft. 2. Before arriving at the courthouse the guy in the transcript was walking on "Fifer street", where the thief was withdrawing money by the ATM.
--
--
-- 1.SELECT * FROM courthouse_security_logs WHERE year = 2020 AND day = 28 AND month = 7; --
-- this will help in order to find the license plate of the vehicles which have left the parking of the premises 10 minutes within the theft.
-- OUTPUT:

258 | 2020 | 7 | 28 | 10 | 8 | entrance | R3G7486
259 | 2020 | 7 | 28 | 10 | 14 | entrance | 13FNH73
260 | 2020 | 7 | 28 | 10 | 16 | exit | 5P2BI95
261 | 2020 | 7 | 28 | 10 | 18 | exit | 94KL13X
262 | 2020 | 7 | 28 | 10 | 18 | exit | 6P58WS2
263 | 2020 | 7 | 28 | 10 | 19 | exit | 4328GD8
264 | 2020 | 7 | 28 | 10 | 20 | exit | G412CB7
265 | 2020 | 7 | 28 | 10 | 21 | exit | L93JTIZ
266 | 2020 | 7 | 28 | 10 | 23 | exit | 322W7JE
267 | 2020 | 7 | 28 | 10 | 23 | exit | 0NTHK55
268 | 2020 | 7 | 28 | 10 | 35 | exit | 1106N58
269 | 2020 | 7 | 28 | 10 | 42 | entrance | NRYN856
270 | 2020 | 7 | 28 | 10 | 44 | entrance | WD5M8I6
271 | 2020 | 7 | 28 | 10 | 55 | entrance | V47T75I
272 | 2020 | 7 | 28 | 11 | 6 | entrance | 4963D92
273 | 2020 | 7 | 28 | 11 | 13 | entrance | C194752
274 | 2020 | 7 | 28 | 11 | 52 | entrance | 94MV71O
--
-- 2. SELECT * FROM atm_transactions WHERE atm_location = "Fifer Street" AND year = 2020 AND day = 28 AND month = 7;
--OUTPUT:
 id | account_number | year | month | day | atm_location | transaction_type | amount
246 | 28500762 | 2020 | 7 | 28 | Fifer Street | withdraw | 48
264 | 28296815 | 2020 | 7 | 28 | Fifer Street | withdraw | 20
266 | 76054385 | 2020 | 7 | 28 | Fifer Street | withdraw | 60
267 | 49610011 | 2020 | 7 | 28 | Fifer Street | withdraw | 50
269 | 16153065 | 2020 | 7 | 28 | Fifer Street | withdraw | 80
275 | 86363979 | 2020 | 7 | 28 | Fifer Street | deposit | 10
288 | 25506511 | 2020 | 7 | 28 | Fifer Street | withdraw | 20
313 | 81061156 | 2020 | 7 | 28 | Fifer Street | withdraw | 30
336 | 26013199 | 2020 | 7 | 28 | Fifer Street | withdraw | 35
--
-- Now we have the account numbers and the transaction_type which = either withdraw or deposit, from the trancript above we know that the thief was seen withdrawing money...
-- We're going to see what are the names of the people who withdrew money in Fifer Street on the 28th of the 07 2020.
--
-- SELECT *FROM bank_accounts JOIN people ON bank_accounts.person_id = people.id WHERE account_number = (account number);
-- Used the same command for all account numbers where the transaction_type = withdraw.
--
account_number | person_id | creation_year | id | name | phone_number | passport_number | license_plate
28500762 | 467400 | 2014 | 467400 | Danielle | (389) 555-5198 | 8496433585 | 4328GD8
account_number | person_id | creation_year | id | name | phone_number | passport_number | license_plate
28296815 | 395717 | 2014 | 395717 | Bobby | (826) 555-1652 | 9878712108 | 30G67EN
account_number | person_id | creation_year | id | name | phone_number | passport_number | license_plate
76054385 | 449774 | 2015 | 449774 | Madison | (286) 555-6063 | 1988161715 | 1106N58
account_number | person_id | creation_year | id | name | phone_number | passport_number | license_plate
49610011 | 686048 | 2010 | 686048 | Ernest | (367) 555-5533 | 5773159633 | 94KL13X
account_number | person_id | creation_year | id | name | phone_number | passport_number | license_plate
16153065 | 458378 | 2012 | 458378 | Roy | (122) 555-4581 | 4408372428 | QX4YZN3
account_number | person_id | creation_year | id | name | phone_number | passport_number | license_plate
25506511 | 396669 | 2014 | 396669 | Elizabeth | (829) 555-5269 | 7049073643 | L93JTIZ
account_number | person_id | creation_year | id | name | phone_number | passport_number | license_plate
81061156 | 438727 | 2018 | 438727 | Victoria | (338) 555-6650 | 9586786673 | 8X428L0
account_number | person_id | creation_year | id | name | phone_number | passport_number | license_plate
26013199 | 514354 | 2012 | 514354 | Russell | (770) 555-1861 | 3592750733 | 322W7JE
-- In the transcript, the thief called someone for less than a minute <= 60 seconds, planning to take the earliest flight tomorrow (aka: 29/07/2020) on day after the theft.
--
--
-- SELECT *FROM phone_calls WHERE year = 2020 AND day = 28 AND month  = 7 AND duration <= 60;
-- OUTPUT:
id | caller | receiver | year | month | day | duration
221 | (130) 555-0289 | (996) 555-8899 | 2020 | 7 | 28 | 51
224 | (499) 555-9472 | (892) 555-8872 | 2020 | 7 | 28 | 36
233 | (367) 555-5533 | (375) 555-8161 | 2020 | 7 | 28 | 45
234 | (609) 555-5876 | (389) 555-5198 | 2020 | 7 | 28 | 60
251 | (499) 555-9472 | (717) 555-1342 | 2020 | 7 | 28 | 50
254 | (286) 555-6063 | (676) 555-6554 | 2020 | 7 | 28 | 43
255 | (770) 555-1861 | (725) 555-3243 | 2020 | 7 | 28 | 49
261 | (031) 555-6622 | (910) 555-3251 | 2020 | 7 | 28 | 38
279 | (826) 555-1652 | (066) 555-9701 | 2020 | 7 | 28 | 55
281 | (338) 555-6650 | (704) 555-2131 | 2020 | 7 | 28 | 54
--
-- We have 8 possible suspects, however we must check which phone numbers match the people who withdrew money the day of the theft
--
-- After checking the logs, essentially we are left with three suspects... That is:
--
76054385 | 449774 | 2015 | 449774 | Madison | (286) 555-6063 | 1988161715 | 1106N58
26013199 | 514354 | 2012 | 514354 | Russell | (770) 555-1861 | 3592750733 | 322W7JE
49610011 | 686048 | 2010 | 686048 | Ernest | (367) 555-5533 | 5773159633 | 94KL13X
--
-- From these results, it would be interesting to find out who these people called...
-- The code I ran is the following... SELECT *FROM people WHERE phone_number = "(where here I insterted the phone call...)";
-- Madison called the following person...
250277 | James | (676) 555-6554 | 2438825627 | Q13SVG6
-- Russell called the following person...
847116 | Philip | (725) 555-3243 | 3391710505 | GW362R6
-- Ernest called the following person...
864400 | Berthold | (375) 555-8161 |  | 4V16VO0
--
-- Now it would be intereseting to check the airplane flights where the possible thief and possibly the suspect might have been in.
-- SELECT * FROM airports WHERE city = "Fiftyville";
--
--OUTPUT:
 8 | CSF | Fiftyville Regional Airport | Fiftyville
--
-- Finally...
-- SELECT * FROM flights JOIN airports ON flights.origin_airport_id = airports.id WHERE year = 2020 AND day = 29 AND month = 7 AND origin_airport_id = 8;
--
id | origin_airport_id | destination_airport_id | year | month | day | hour | minute | id | abbreviation | full_name | city
18 | 8 | 6 | 2020 | 7 | 29 | 16 | 0 | 8 | CSF | Fiftyville Regional Airport | Fiftyville
23 | 8 | 11 | 2020 | 7 | 29 | 12 | 15 | 8 | CSF | Fiftyville Regional Airport | Fiftyville
36 | 8 | 4 | 2020 | 7 | 29 | 8 | 20 | 8 | CSF | Fiftyville Regional Airport | Fiftyville
43 | 8 | 1 | 2020 | 7 | 29 | 9 | 30 | 8 | CSF | Fiftyville Regional Airport | Fiftyville
53 | 8 | 9 | 2020 | 7 | 29 | 15 | 20 | 8 | CSF | Fiftyville Regional Airport | Fiftyville
--
-- We now have the interesting information that we were looking for, that is, we have the information of the flights of the 29th of July 2020.
-- The only thing that we have to do now, is to find the earliest flights on that day, therefore... that yields...
36 | 8 | 4 | 2020 | 7 | 29 | 8 | 20 | 8 | CSF | Fiftyville Regional Airport | Fiftyville
43 | 8 | 1 | 2020 | 7 | 29 | 9 | 30 | 8 | CSF | Fiftyville Regional Airport | Fiftyville
--
-- Now, since we have our three suspects + the earliest flights on the 29/07/2020, we only have to check who went in which flight...
--
-- We know the exact passport numbers of our suspects, so now we can check exactly who went in which flight...
--
-- SELECT * FROM passengers JOIN flights ON passengers.flight_id = flights.id WHERE passport_number = 1988161715; --> MADISON
flight_id | passport_number | seat | id | origin_airport_id | destination_airport_id | year | month | day | hour | minute
36 | 1988161715 | 6D | 36 | 8 | 4 | 2020 | 7 | 29 | 8 | 20
--
-- SELECT * FROM passengers JOIN flights ON passengers.flight_id = flights.id WHERE passport_number = 3592750733; --> Russell
flight_id | passport_number | seat | id | origin_airport_id | destination_airport_id | year | month | day | hour | minute
18 | 3592750733 | 4C | 18 | 8 | 6 | 2020 | 7 | 29 | 16 | 0
24 | 3592750733 | 2C | 24 | 7 | 8 | 2020 | 7 | 30 | 16 | 27
54 | 3592750733 | 6C | 54 | 8 | 5 | 2020 | 7 | 30 | 10 | 19
--
-- SELECT * FROM passengers JOIN flights ON passengers.flight_id = flights.id WHERE passport_number = 5773159633; --> Ernest
flight_id | passport_number | seat | id | origin_airport_id | destination_airport_id | year | month | day | hour | minute
36 | 5773159633 | 4A | 36 | 8 | 4 | 2020 | 7 | 29 | 8 | 20
--
 It is made evident that our two suspect are MADISON and ERNEST because their origin_airport_id and destination_airport_id both correspond to one of the earliest flights on the 29/07/20
--
-- Now it would be interesting to check the passport information of the people which the suspects called...
--
-- SELECT * FROM  people WHERE name = "Berthold";
id | name | phone_number | passport_number | license_plate  --> this is kinda skectchy, because this dude doesn't have a passport number:(
864400 | Berthold | (375) 555-8161 |  | 4V16VO0
--
-- SELECT * FROM  people WHERE name = "James";
id | name | phone_number | passport_number | license_plate
250277 | James | (676) 555-6554 | 2438825627 | Q13SVG6
--
-- SELECT * FROM  people WHERE name = "Philip";
id | name | phone_number | passport_number | license_plate
847116 | Philip | (725) 555-3243 | 3391710505 | GW362R6
--
-- Now we want to find out to which flight these people went to...
--
-- SELECT * FROM passengers JOIN flights ON passengers.flight_id = flights.id WHERE passport_number = 2438825627;
flight_id | passport_number | seat | id | origin_airport_id | destination_airport_id | year | month | day | hour | minute --> James' passport number
10 | 2438825627 | 7C | 10 | 8 | 4 | 2020 | 7 | 30 | 13 | 55
21 | 2438825627 | 6A | 21 | 3 | 8 | 2020 | 7 | 26 | 17 | 58
47 | 2438825627 | 9B | 47 | 4 | 8 | 2020 | 7 | 30 | 9 | 46
--
-- SELECT * FROM passengers JOIN flights ON passengers.flight_id = flights.id WHERE passport_number = 3391710505; --> Philip's passport number
flight_id | passport_number | seat | id | origin_airport_id | destination_airport_id | year | month | day | hour | minute
10 | 3391710505 | 2A | 10 | 8 | 4 | 2020 | 7 | 30 | 13 | 55
28 | 3391710505 | 2A | 28 | 3 | 8 | 2020 | 7 | 26 | 22 | 49
47 | 3391710505 | 4D | 47 | 4 | 8 | 2020 | 7 | 30 | 9 | 46
--
We can see that for Philip and James, their flight day is irrelevant to us because non of them two flew ON the 29/07/2020, hence we can conclude
that the possible accomplice is BERTHOLD because he doesn't have a passport number.

-- Now of course the last thing we have to check is the city where the thief and the accomplice escaped to... Fortunately
-- we have the destination_airport_id which = 4, hence we can find the city...
--
-- SELECT * FROM flights JOIN airports ON destination_airport_id = airports.id WHERE destination_airport_id = 4;
id | origin_airport_id | destination_airport_id | year | month | day | hour | minute | id | abbreviation | full_name | city
10 | 8 | 4 | 2020 | 7 | 30 | 13 | 55 | 4 | LHR | Heathrow Airport | London
17 | 8 | 4 | 2020 | 7 | 28 | 20 | 16 | 4 | LHR | Heathrow Airport | London
35 | 8 | 4 | 2020 | 7 | 28 | 16 | 16 | 4 | LHR | Heathrow Airport | London
36 | 8 | 4 | 2020 | 7 | 29 | 8 | 20 | 4 | LHR | Heathrow Airport | London
55 | 8 | 4 | 2020 | 7 | 26 | 21 | 44 | 4 | LHR | Heathrow Airport | London
--
-- The city we were looking for is London.
City : London
Accomplice : Berthold
Thief : Ernest
