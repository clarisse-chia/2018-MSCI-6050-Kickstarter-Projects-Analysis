CREATE TABLE CALENDAR_T (
    Dates date NOT NULL,
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
    Subcategory number(18),
    CONSTRAINT CATEGORY_PK primary key (CategoryID)
) ;

CREATE TABLE COUNTRY_T (   
    CountryCode  varchar(2) NOT NULL,
    CountryName varchar2(44),
    CONSTRAINT COUNTRY_PK primary key (CountryCode)
) ;

CREATE TABLE PROJECT_T (
    ProjectID varchar2(7) NOT NULL,
    ProjectName varchar2(100),
    CategoryID varchar2(4),
    CountryCode varchar(2),
    OriginalCurrency char(30),
    LaunchDate date,
    Deadline date,
    ActiveDays number(2),
    GoalAmount number(9,2),
    PledgedAmount number(8,2),
    ProportionReached number(6,2),
    Backers number(6),
    ProjectState char(10),
    CONSTRAINT PROJECT_PK primary key (ProjectID),
    CONSTRAINT LAUNCHDATE_FK foreign key (LaunchDate) references CALENDAR_T(Dates),
    CONSTRAINT DEADLINE_FK foreign key (Deadline) references CALENDAR_T(Dates),
    CONSTRAINT CATEGORY_FK foreign key (CategoryID) references CATEGORY_T(CategoryID),
    CONSTRAINT COUNTRY_FK foreign key (CountryCode) references COUNTRY_T(CountryCode)
);