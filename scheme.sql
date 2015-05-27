drop database connect4_chino;
create database if not exists connect4_chino;
	use connect4_chino;

drop table if exists users;
create table users(
 email varchar(50) not null,
 first_name varchar(50),
 id varchar(50),
 last_name varchar(50),
primary key (email));

drop table if exists deleteUsers;
create table deleteUsers(
 email varchar(50) not null,
 first_name varchar(50),
 id varchar(50),
 last_name varchar(50),
primary key (email));

drop table if exists games;
create table games(
 code integer not null,
 aDate date,
 hour_begin datetime,
 hour_end datetime,
 size varchar(50),-- CAMBIAR POR LAS DIMENSIONES
 result varchar(50),
 email varchar(50) not null,
 foreign key (email) references users (email),
 primary key (code)
);

drop table if exists cells;
create table cells(
 pos_x integer not null,
 pos_y integer not null,
primary key (pos_x,pos_y));

drop table if exists composed;
create table composed(
 pos_x integer not null,
 pos_y integer not null,
 code integer not null,
 play_order varchar(50) not null,
 primary key (code),
 foreign key (pos_x,pos_y) references cells (pos_x,pos_y),
 foreign key (code) references games (code)
);











