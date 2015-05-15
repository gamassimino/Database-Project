drop table if exists users;
create table users(
    id int(11) not null auto_increment,
    email varchar(60) unique,
    first_name varchar(56),
    last_name varchar(56),
  constraint users_pk primary key (id)
);


drop table if exists grids;
create table grids(
	codigo integer not null unique,
	fecha date,
	hora_inicio varchar(50),
	hora_fin varchar(50),
	ganador varchar(50),
	email varchar(50) not null,
	constraint codigo_pk primary key (codigo)
);

drop table if exists cells;
create table cells(
	pos_x integer not null,
	pos_y integer not null,
	constraint pos_pk primary key (pos_x,pos_y)
);

drop table if exists composed;
create table composed(
	pos_x integer not null,
	pos_y integer not null,
	codigo integer not null,
	orden_jugada varchar(50) not null,
	constraint ps_codigo_pk primary key (pos_x,pos_y,codigo)
);


