--hutan altered data types to allow proper loading of data, date data types have been replaced with char, this shouldn't be an issue 
--we basically changed number data types to strings for simplicity

CREATE TABLE CALENDAR_T (
    Dates varchar2(15) NOT NULL,
    Year varchar2(4),
    Month varchar2(2),
    DayOfMonth varchar2(2),
    DayOfWeek char(3),
    Weekday char(7),
    CONSTRAINT DATE_PK primary key (Dates)
);

-- alter table 
--      table_name
-- modify
--  (
--      column_name varchar2(30)
--  );

CREATE TABLE CATEGORY_T (   
    CategoryID  varchar(4) NOT NULL,
    MainCategory varchar2(12),
    Subcategory number(50),
    CONSTRAINT CATEGORY_PK primary key (CategoryID)
) ;

CREATE TABLE COUNTRY_T (   
    CountryCode  varchar(4) NOT NULL,
    CountryName varchar2(44),
    CONSTRAINT COUNTRY_PK primary key (CountryCode)
) ;

CREATE TABLE PROJECT_T (
    ProjectID varchar2(10) NOT NULL,
    ProjectName varchar2(200),
    CategoryID varchar2(10),
    CountryCode varchar(11),
    OriginalCurrency char(16),
    LaunchDate varchar2(25),
    Deadline varchar2(25),
    ActiveDays number(10,0),
    GoalAmount number(11,2),
    PledgedAmount number(13,2),
    ProportionReached number(17,2),
    Backers number(7,0),
    ProjectState char(12),
    CONSTRAINT PROJECT_PK primary key (ProjectID),
    CONSTRAINT LAUNCHDATE_FK foreign key (LaunchDate) references CALENDAR_T(Dates),
    CONSTRAINT DEADLINE_FK foreign key (Deadline) references CALENDAR_T(Dates),
    CONSTRAINT CATEGORY_FK foreign key (CategoryID) references CATEGORY_T(CategoryID),
    CONSTRAINT COUNTRY_FK foreign key (CountryCode) references COUNTRY_T(CountryCode)
);
