drop database connect4_chino;
create database if not exists connect4_chino;
	use connect4_chino;

drop table if exists users;
create table users(
 email varchar(50) NOT NULL,
 first_name varchar(50),
 id varchar(50),
 last_name varchar(50),
PRIMARY KEY (email));

drop table if exists deleteUsers;
create table deleteUsers(
 email varchar(50) NOT NULL,
 first_name varchar(50),
 id varchar(50),
 last_name varchar(50),
PRIMARY KEY (email));

drop table if exists games;
create table games(
 code integer NOT NULL,
 aDate date,
 hour_begin datetime,
 hour_end datetime,
 size varchar(50),-- CAMBIAR POR LAS DIMENSIONES
 result varchar(50),
 email varchar(50) NOT NULL,
 FOREIGN KEY (email) REFERENCES users (email),
 PRIMARY KEY (code)
);

drop table if exists cells;
CREATE TABLE cells(
 pos_x integer NOT NULL,
 pos_y integer NOT NULL,
PRIMARY KEY (pos_x,pos_y));

drop table if exists composed;
CREATE TABLE composed(
 pos_x integer NOT NULL,
 pos_y integer NOT NULL,
 code integer NOT NULL,
 play_order varchar(50) NOT NULL,
 PRIMARY KEY (code),
 FOREIGN KEY (pos_x,pos_y) REFERENCES cells (pos_x,pos_y),
 FOREIGN KEY (code) REFERENCES games (code)
);











