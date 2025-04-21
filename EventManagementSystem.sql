drop database IF EXISTS EventManagementSystem;
CREATE DATABASE IF NOT EXISTS EventManagementSystem;
USE EventManagementSystem;

CREATE TABLE Users (
    User_ID INT AUTO_INCREMENT PRIMARY KEY,
    FName VARCHAR(50) NOT NULL,
    LName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    Phone VARCHAR(20) NULL
);

-- Create Attendees table
CREATE TABLE Attendees (
    Attendee_ID INT AUTO_INCREMENT PRIMARY KEY,
    User_ID INT NOT NULL,
    Event_ID INT NOT NULL,
    Registration_ID INT NOT NULL,
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID)
);

-- Create Organizers table
CREATE TABLE Organizers (
    Organizer_ID INT AUTO_INCREMENT PRIMARY KEY,
    User_ID INT NOT NULL,
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID)
);

-- Create Events table
CREATE TABLE Events (
    Event_ID INT AUTO_INCREMENT PRIMARY KEY,
    Event_Name VARCHAR(100) NOT NULL,
    Date DATE NOT NULL,
    Location VARCHAR(100) NOT NULL,
    Description TEXT NULL
);

-- Create Sessions table
CREATE TABLE Sessions (
    Session_ID INT AUTO_INCREMENT PRIMARY KEY,
    Event_ID INT NOT NULL,
    Topic VARCHAR(100) NOT NULL,
    Location VARCHAR(100) NOT NULL,
    Time TIME NOT NULL,
    Performer VARCHAR(100) NULL,
    Registration_ID INT,
    FOREIGN KEY (Event_ID) REFERENCES Events(Event_ID)
);

-- Create Tickets table
CREATE TABLE Tickets (
    Ticket_ID INT AUTO_INCREMENT PRIMARY KEY,
    Session_ID INT,
    Payment_ID INT,
    Registration_ID INT,
    Price DECIMAL(10, 2) NOT NULL,
    Ticket_Type ENUM('GA', 'VIP', 'MeetAndGreet') NOT NULL,
    Ticket_Status ENUM('Active', 'Inactive') NOT NULL,
    FOREIGN KEY (Session_ID) REFERENCES Sessions(Session_ID)
);

-- Create Payments table
CREATE TABLE Payments (
    Payment_ID INT AUTO_INCREMENT PRIMARY KEY,
    Payment_Date DATE NOT NULL,
    Payment_Method ENUM('CreditCard', 'BankTransfer', 'Zelle', 'PayPal') NOT NULL,
    Payment_Status ENUM('Pending', 'Complete', 'Failed') NOT NULL,
    Payment_Amount DECIMAL(10,2) NOT NULL,
    Transaction_ID VARCHAR(255) NOT NULL UNIQUE,
    Ticket_ID INT,
    FOREIGN KEY (Ticket_ID) REFERENCES Tickets(Ticket_ID)
);

-- Create Registration table
CREATE TABLE Registration (
    Registration_ID INT AUTO_INCREMENT PRIMARY KEY,
    Registration_Date DATE NOT NULL,
    Attendee_ID INT NOT NULL,
    Session_ID INT NOT NULL,
    FOREIGN KEY (Attendee_ID) REFERENCES Attendees(Attendee_ID),
    FOREIGN KEY (Session_ID) REFERENCES Sessions(Session_ID)
);

INSERT INTO Users (FName, LName, Email, Password, Phone)
VALUES 
('Aris', 'Hill', 'aris.hill@example.com', 'password123', '555-123-4567'),
('Jordan', 'Smith', 'jordan.smith@example.com', 'securepass456', '555-987-6543'),
('Taylor', 'Lee', 'taylor.lee@example.com', 'myPa$$word', NULL),
('Morgan', 'Reed', 'morgan.reed@example.com', 'ReedStrong99', '555-555-5555'),
('Casey', 'Nguyen', 'casey.nguyen@example.com', 'casey1234', '555-321-9876');

SELECT * from Users