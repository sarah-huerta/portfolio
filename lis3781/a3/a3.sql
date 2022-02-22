 SET DEFINE OFF

DROP SEQUENCE seq_cus_id;
Create SEQUENCE seq_cus_id
start with 1
increment by 1
minvalue 1
maxvalue 10000;

drop table customer CASCASE CONSTRAINTS PURGE;
Create TABLE customer
(
  cus_id number(3,0) not null,
  cus_fname varchar2(15) not null,
  cus_lname varchar2(30) not null,
  cus_street varchar2(30) not null,
  cus_city varchar2(30) not null,
  cus_state char(2) not null,
  cus_zip number(9) not null,
  cus_phone number(10) not null,
  cus_balance number(9,2),
  cus_notes varchar2(255),
  CONSTRAINT pk_customer PRIMARY KEY(cus_id)
);

DROP SEQUENCE seq_com_id;
create SEQUENCE seq_com_id
  start with 1
  increment by 1
  minvalue 1
  maxvalue 10000;

drop table commodity CASCADE CONSTRAINTS PURGE;
Create table commodity
(
  com_id number not null,
  com_name varchar2(20)
  com_price number(8,2) not null,
  cus_notes varchar2(255),
  CONSTRAINT pk_commodity PRIMARY KEY(com_id),
  CONSTRAINT uq_com_name UNIQUE(com_name)
);


DROP SEQUENCE SEQUENCE seq_ord_id;
Create sequence seq_ord_id
start with 1
increment by 1
minvalue 1
maxvalue 10000;

drop table order CASCADE CONSTRAINTS PURGE;
Create table order
(
  ord_id number (4,0) not null,
  cus_id number,
  com_id number,
  order_num_units number(5,0) not null,
  ord_total_cost number(8,2) not null,
  order_notes varchar2(255),
  CONSTRAINT pk_order PRIMARY KEY(ord_id),
  CONSTRAINT fk_order_customer
  foreign key(cus_id)
  references customer(cus_id),
  CONSTRAINT fk_order_commodity
  foreign key(com_id)
  references commodity(com_id),
  CONSTRAINT check_unit CHECK(order_num_units > 0),
  CONSTRAINT check_total CHECK(ord_total_cost > 0)
);

insert into customer valyes (seq_cus_id.nextval, 'Minnie','Mouse', '123 Main st','Orlando', 'FL',32310,8508960561,'minnie@magic.com', 12323.99, 'Purchaser for Company');
insert into customer valyes (seq_cus_id.nextval, 'Mickey','Mouser', '234 Pixar Dr', 'Orlando', 'FL',32311,1234567890,'mickey@magic.com', 232.99,NULL);
insert into customer valyes (seq_cus_id.nextval, 'Daisy','Duck', '345 Sunset Blvd', 'Orlando', 'FL', 32312,8970695843,'daisy@magic.com',433.48, 'Repeat Cusomter');
insert into customer valyes (seq_cus_id.nextval, 'Donlad','Ducker', '456 Muppets Dr', 'Orlando', 'FL',32313,9384738345,'donlad@magic.com',342.99, NULL);
insert into customer valyes (seq_cus_id.nextval, 'Goofy','Goof', '567 Castle Ln ', 'Orlando', 'FL',32314,2839405943, 'goofy@magic.com', 35439.39, 'Reckless spender');
commit;


insert into commodity values (seq_com_id.nextval, 'Popcorn', 2.00, NULL);
insert into commodity values (seq_com_id.nextval, 'Pretzel', 5.00,'Salt or Sugar');
insert into commodity values (seq_com_id.nextval, 'Ice Cream Pop', 9.00, 'Vanilla');
insert into commodity values (seq_com_id.nextval, 'Coke', 3.00, NULL);
insert into commodity values (seq_com_id.nextval, 'Cookies', 7.50, 'Chocolate Chip');
commit;

insert into order values (seq_ord_id.nextval, 2, 2, 12, 24, NULL);
insert into order values (seq_ord_id.nextval, 4, 3, 32, 160, NULL);
insert into order values (seq_ord_id.nextval, 5, 4, 3, 27, NULL);
insert into order values (seq_ord_id.nextval, 2, 1, 12, 36.00, NULL);
insert into order values (seq_ord_id.nextval, 1, 5, 4, 30.00, NULL);
commit;

select * from customer;
select * from commodity;
select * from order;
