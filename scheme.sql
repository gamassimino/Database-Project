drop database connect4_chino;
create database if not exists connect4_chino;
	use connect4_chino;

drop table if exists users;
create table users(
	email varchar(50) not null,
	first_name varchar(50),
	id varchar(50),
	last_name varchar(50),
	primary key (email)
);

drop table if exists deleteUsers;
create table deleteUsers(
 	email varchar(50) not null,
	first_name varchar(50),
	last_name varchar(50),
	admin varchar(50),
	primary key (email),
	foreign KEY (email) references users (email),
	foreign KEY (admin) references users (email)
);

drop table if exists games;
create table games(
	code integer not null,
	aDate date,
	hour_begin dateTime,
	hour_end dateTime,
	result varchar(50) not null,
	email varchar(50) not null,
	rows integer not null,
	columns integer not null,
	winner varchar(50), -- if winner is null so no body wins o the game are not finished -- REVIEW --
	primary key (code), 
	foreign key (email) references users (email),
	foreign key (winner) references users (email)
);

drop table if exists cells;
create table cells(
	pos_x integer not null,
	pos_y integer not null,
	primary key (pos_x,pos_y)
);

drop table if exists composed;
create table composed(
	pos_x integer not null,
	pos_y integer not null,
	code integer not null,
	play_order varchar(50) not null,
	primary key (code,pos_x,pos_y),
	foreign key (pos_x,pos_y) references cells (pos_x,pos_y),
	foreign key (code) references games (code)
);


create trigger trigger_baja_usuarios				
	after delete on users 
	for each row
	insert into deleteUsers values (
		old.email,
		old.first_name,
		old.last_name,
		current_user(),
		now() 
	); 