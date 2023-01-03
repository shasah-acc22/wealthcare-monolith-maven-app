--    This schema file is for MySQL

	drop table IF EXISTS WCUSERS;
	create table WCUSERS (
        id INT NOT NULL AUTO_INCREMENT,
        UserName varchar(40),
        Password varchar(40),
        EmailId varchar(40),
        role varchar(40),
        PRIMARY KEY (id)
    );
    ALTER TABLE WCUSERS AUTO_INCREMENT = 10001;

	drop table IF EXISTS WCBUSINESSMANAGER;
    create table WCBUSINESSMANAGER (
        id INT NOT NULL AUTO_INCREMENT,
        WcUserId INT,
        FirstName varchar(40),
        LastName varchar(40),
        StartDate date,
        PRIMARY KEY (id)
    );
    ALTER TABLE WCBUSINESSMANAGER AUTO_INCREMENT = 20001;

    drop table IF EXISTS WCWEALTHMANAGER;
    create table WCWEALTHMANAGER (
        id INT NOT NULL AUTO_INCREMENT,
        WcUserId INT,
        FirstName varchar(40),
        LastName varchar(40),
        Gender varchar(10),
        City varchar(40),
        Phone varchar(10),
        EmailId varchar(40),
        StartDate date,
        Country varchar (20),
        ZipCode varchar (20),
        PRIMARY KEY (id)
    );
    ALTER TABLE WCWEALTHMANAGER AUTO_INCREMENT = 30001;

    drop table IF EXISTS WCCUSTOMER;
    create table WCCUSTOMER (
        id INT NOT NULL AUTO_INCREMENT,
        WcUserId INT,
        WCWEALTHMANAGERId INT,

        FirstName varchar(40),
        LastName varchar(40),
        Gender varchar(10),
        Age INT,
        AvgIncome double,

        Married BOOLEAN,

        SpouseFirstName varchar(40),
        SpouseLastName varchar(40),
        SpouseGender varchar(10),
        SpouseAge INT,
        SpouseAvgIncome double,

        NoOfChildren INT,

        Child1FirstName varchar(40),
        Child1LastName varchar(40),
        Child1Gender varchar(10),
        Child1Age INT,

        Child2FirstName varchar(40),
        Child2LastName varchar(40),
        Child2Gender varchar(10),
        Child2Age INT,

        City varchar(40),
        Phone varchar(10),
        EmailId varchar(40),
        StartDate date,
        Country varchar (20),
        ZipCode varchar (20),
        PRIMARY KEY (id)
    );
    ALTER TABLE WCCUSTOMER AUTO_INCREMENT = 40001;

    drop table IF EXISTS WCGOAL;
    create table WCGOAL (
        id INT NOT NULL AUTO_INCREMENT,

       WCCUSTOMERId INT,

       WCWEALTHMANAGERId INT,
       GoalReference varchar(80),
       GoalDesc varchar(80),
       StartDate date,
       TargetDate date,
       TargetAmount double,
        PRIMARY KEY (id)
    );
    ALTER TABLE WCGOAL AUTO_INCREMENT = 50001;

    drop table IF EXISTS WCINVESTMENT;
    create table WCINVESTMENT(
        id INT NOT NULL AUTO_INCREMENT,
       WCGOALId INT,
       InvestmentDate date,
       InvestmentAmount double,
       StockAmount double,
       MutualFundAmount double,
       FixedDepositAmount double,
        PRIMARY KEY (id)
    );
    ALTER TABLE WCINVESTMENT AUTO_INCREMENT = 60001;
