drop database connect4_chino;
create database if not exists connect4_chino;
	use connect4_chino;

-- ----------------------------------------------------------------------------------------------
drop table if exists users;
create table users(
	id varchar(50),
	email varchar(50) not null,
	first_name varchar(50),
	last_name varchar(50),
	primary key (email)
);

insert into users values
	(1,'gamassimino01@gmail.com','gaston','massimino'),
	(2,'ezedepetris@gmail.com','ezequiel','depetris');
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
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
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
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
	primary key (code), 
	foreign key (email) references users (email)
);

insert into games values
	(1,now(),null,null,'ganador','gamassimino01@gmail.com',6,7); 
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
drop table if exists cells;
create table cells(
	pos_x integer not null,
	pos_y integer not null,
	primary key (pos_x,pos_y)
);

insert into cells values
	(1,1),
	(1,2),
	(1,3),
	(1,4),
	(2,1),
	(2,2),
	(2,3);
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
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

insert into composed values
	(1,1,1,1),
	(1,2,1,3),
	(1,3,1,5),
	(1,4,1,7),
	(2,1,1,2),
	(2,2,1,4),
	(2,3,1,6);
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
create trigger trigger_insertar_ficha
	before insert on composed
	for each row
		-- if ((new.pos_x >= 1)&&(new.pos_x <= rows)&&(new.pos_y >= 1)&&(new.pos_y <= columns)) then
			insert into composed values(
				new.pos_x,
				new.pos_y,
				new.code,
				new.play_order,
				current_user(),
				now()
			);
		-- end;
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
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
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------





