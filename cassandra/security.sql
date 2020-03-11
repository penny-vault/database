CREATE TABLE IF NOT EXISTS pennyvault.security (
       id int,
       ticker varchar,
       name varchar,
       corporation int,
       cusip ascii,
       isin ascii,
       sedol ascii,
       kind ascii,
       currency ascii,
       exchange ascii,
       active boolean,
       time_start date,
       time_end date,
       PRIMARY KEY (ticker, id)      
);
