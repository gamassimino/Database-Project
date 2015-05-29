drop schema connect4_chino cascade;
create schema connect4_chino;
	set search_path = connect4_chino;
--******--******--******--******--
/*
THIS DOMAIN WAS CREATED FOR MODELING THE RESULT OF A GAME
IF THE PLAYER 1 WINS SO THE RESULT WILL BE 'PLAYER_1'
IF THE PLAYER 2 WINS SO THE RESULT WILL BE 'PLAYER_2'
IF THE GAME DOESN'T FINISHED SO THE RESULT WILL BE 'IN GAME'
IF THE GAME FINISHED BUT NO BODY WINS SO THE RESULT WILL BE 'DEAD_HEAT'
*/
--******--******--******--******--
create domain resultDomain as varchar(20)
	default 'in_game'
	check ((value='player_1')or(value='player_2')or(value='dead_heat')or(value='in_game'))
	not null;
--******--******--******--******--
/*
THIS DOMAIN WAS CREATED FOR MODELING THE VALUES POSIBLE IN THE COLUMNS
*/
--******--******--******--******--
create domain columnDomain as integer
	default 7
	check ((value>=1)and(value<=10))
	not null;
--******--******--******--******--
/*
THIS DOMAIN WAS CREATED FOR MODELING THE VALUES POSIBLE IN THE ROWS
*/
--******--******--******--******--
create domain rowDomain as integer
	default 6
	check ((value>=1)and(value<=8))
	not null;
--******--******--******--******--
/*
THIS TABLE MODELING AN USER WITH HER PERSONAL INFORMATION
*/
--******--******--******--******--
drop table if exists users;
create table users(
	email varchar(50) not null,
	first_name varchar(50),
	last_name varchar(50),
	id integer,
	primary key (email)
);
--******--******--******--******--
/*
THIS TABLE STORAGE THE DELETED USERS 
*/
--******--******--******--******--
drop table if exists deleteUsers;
create table deleteUsers(
 	email varchar(50) not null,
	first_name varchar(50),
	last_name varchar(50),
	admin varchar(50),
	primary key (email),
	foreign KEY (email) references users (email) on delete cascade
);
--******--******--******--******--
/*
THIS TABLE MODELING A GAME OF TWO USERS
*/
--******--******--******--******--
drop table if exists games;
create table games(
	code integer not null,
	aDate date,
	hour_begin time,
	hour_end time,
	result resultDomain,
	player1 varchar(50) not null,
	player2 varchar(50) not null,
	rows rowDomain,
	columns columnDomain,
	primary key (code),
	foreign key (player1) references users (email) on delete cascade,
	foreign key (player2) references users (email) on delete cascade
);
--******--******--******--******--
/*
THIS TABLE MODELING A CELLS (PIECE) IN THE BOARD
*/
--******--******--******--******--
drop table if exists cells;
create table cells(
	id integer not null,
	pos_x columnDomain,
	pos_y rowDomain,
	primary key (pos_x,pos_y),
	foreign key (id) references games (code) on delete cascade
);
--******--******--******--******--
/*
THIS TABLE REPRESENTS THE ASOSIATIONS ONE TO MANY(1..N) BETWEEN THE TABLE CELLS WITH THE TABLE GAMES
*/
--******--******--******--******--
drop table if exists composed;
create table composed(
	pos_x integer not null,
	pos_y integer not null,
	code integer not null,
	play_order varchar(50) not null,
	primary key (code,pos_x,pos_y),
	foreign key (pos_x,pos_y) references cells (pos_x,pos_y) on delete cascade,
	foreign key (code) references games (code) on delete cascade
);
--******--******--******--******--
/*
THIS TRIGGER VERIFY THE DATE OF THE USERS IF THEY HAVE GAMES INITIALIZADE TODAY, THEN THIS GAME NOT BE CREATED
*/
--******--******--******--******--
create function function_start_new_game() returns trigger as $trigger_start_new_game$
	begin
		if exists(select null from games where ((aDate=new.aDate)and((player1=new.player1)or(player2=new.player2))))then 
			raise exception 'there is a started game';
		else
			return new;
		end if; 
	end;

	$trigger_start_new_game$
	language 'plpgsql';

create trigger trigger_start_new_game before insert on games
	for each row 
	execute procedure function_start_new_game();
--******--******--******--******--
/*
THIS TRIGGER VERIFI IF THE POSITION EXISTS IN THE BOARD AND IF THIS POSITION NO ARE OCUPATED
*/
--******--******--******--******--
create or replace function checkPosCells() returns trigger as $checkPosCells$
  begin
  	if not exists(select * from cells where cells.id = new.id and new.pos_x = cells.pos_x and new.pos_y = cells.pos_y) then
   		if ((new.pos_x <= (select games.rows from games where new.id = games.code)) and (new.pos_x >= 1)) then
				if ((new.pos_y <= (select columns from games where new.id = games.code)) and(new.pos_y >= 1)) then
					return new;
				else
					raise exception 'the position is invalid';
				end if;
  		else
  			raise exception 'the position is invalid';
  		end if;
   	else
   		raise exception 'the position is invalid';
   	end if; 
  end;

  $checkPosCells$ 
  language 'plpgsql';

create trigger checkPosCells before insert on cells 
	for each row
	execute procedure checkPosCells();
--******--******--******--******--
/*
THIS TRIGGER VERIFY THE SIZE OF THE BOARD BE A CORRECT SIZE
*/
--******--******--******--******--
create or replace function checkSizeBoard() returns trigger as $checkSizeBoard$
  begin
  	if(((new.rows = 6 or new.rows = 8 or new.rows = 9 or new.rows = 10) and new.columns = 7) or (new.rows = 8 and new.columns = 8))then
  		return new;
   	else
   		raise exception 'the size is invalid';
   	end if; 
  end;

  $checkSizeBoard$ 
  language 'plpgsql';

create trigger checkSizeBoard before insert on games 
	for each row
	execute procedure checkSizeBoard();
--******--******--******--******--
/*
THIS TRIGGER IS LAUNCHED AT THE MOMENT THAT A USER IS ELIMINATED, THIS INSERT THAT USER IN AN OTHER TABLE
*/
--******--******--******--******--
create or replace function users_down() returns trigger as $users_down$
  begin
   insert into deleteUsers(email,first_name,last_name) values
  	(old.email,old.first_name,old.last_name,current_user);
   return new;
  end;

  $users_down$ 
  language 'plpgsql';

create trigger users_down after delete on users 
	for each row
	execute procedure users_down();
--******--******--******--******--
/*
HERE WE INSERTS A VALUES IN THE DB
*/
--******--******--******--******--
insert into users values
	('gamassimino01@gmail.com','gaston','massimino',1),
	('ezedepetris@gmail.com','ezequiel','depetris',2);
--******--******--******--******--
insert into games values
	(1,now(),now(),now(),'player_1','gamassimino01@gmail.com','ezedepetris@gmail.com',6,7);
--******--******--******--******--
insert into cells values
	(1,1,1),
	(1,1,2),
	(1,1,3),
	(1,1,4),
	(1,2,1),
	(1,2,2),
	(1,2,3);
--******--******--******--******--
insert into composed values
	(1,1,1,1),
	(1,2,1,2),
	(1,3,1,3),
	(1,4,1,4),
	(2,1,1,5),
	(2,2,1,6),
	(2,3,1,7);