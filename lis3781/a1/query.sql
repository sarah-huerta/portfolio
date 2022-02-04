
    -- #1
    select emp_id, emp_fname, emp_lname,
    CONCAT(emp_street, ",",emp_city, ", ", emp_state, " ", substring(emp_zip,1,5),'-',substring(emp_zip,6,4)) as address,
    CONCAT('(',substring(emp_phone,1,3),')', substring(emp_phone,4,3),'-', substring(emp_phone,7,4)) as phone_num,
    CONCAT(substring(emp_ssn,1,3),'-', substring(emp_ssn,4,2),'-', substring(emp_ssn,6,4)) as emp_ssn, job_title
    from job as j, employee as e
    where j.job_id = e.job_id
    order by emp_lname desc;

    -- #2
    select e.emp_id, emp_fname, emp_lname, eht_date, eht_job_id, j.job_title, eht_emp_salary, eht_notes
    from employee as e, emp_hist as h, job as j
    where h.emp_id = e.emp_id AND e.job_id = j.job_id
    order by e.emp_id;


    -- #3
    select emp_fname, emp_lname, emp_dob, TIMESTAMPDIFF(YEAR, emp_dob, CURDATE()) AS emp_age, dep_fname, dep_lname, dep_relation, dep_dob, TIMESTAMPDIFF(YEAR, dep_dob, CURDATE()) AS dep_age
    from employee as e
    natural join dependent as d;


    -- #4
    START transaction;
    Update job
    set job_title='owner'
    where job_id =1;
    COMMIT;


    -- #5
      delimiter //
     CREATE PROCEDURE `AddBenefit`()
      BEGIN
      INSERT into benefit(ben_names, ben_notes)
      VALUES ('new benefit', 'testing');
    	END //

      DELIMITER ;
      CALL AddBenefit();

    -- #6
      select CONCAT (emp_lname, ', ', emp_fname) as employee, CONCAT(substring(emp_ssn,1,3),'-', substring(emp_ssn,4,2),'-', substring(emp_ssn,6,4)) as emp_ssn, emp_email, CONCAT(dep_lname, ', ', dep_fname) as dependent, CONCAT(substring(dep_ssn,1,3),'-', substring(dep_ssn,4,2),'-', substring(dep_ssn,6,4)) as dep_ssn, CONCAT(dep_street, ",",dep_city, ", ", dep_state, " ", substring(dep_zip,1,5),'-',substring(dep_zip,6,4)) as dep_address, CONCAT('(',substring(dep_phone,1,3),') ', substring(dep_phone,4,3),'-', substring(dep_phone,7,4)) as dep_phone_num from dependent as d, employee as e where d.emp_id = e.emp_id;

      -- #7
      delimiter //

      Create trigger audit
      after insert
    	on employee
        for each row
        begin
    	insert into emp_hist(emp_id,eht_date, eht_type, eht_job_id, eht_emp_salary, eht_usr_changed, eht_reason, eht_notes)
        values (new.emp_id,CURDATE(), 'i',new.job_id, new.emp_salary, 'test','new employee', 'testing trigger');
    	end //
    delimiter ;

    insert into employee(job_id,emp_fname, emp_lname, emp_street, emp_city, emp_state, emp_zip, emp_phone, emp_email, emp_ssn, emp_dob, emp_start_date, emp_end_date, emp_salary, emp_notes)
    values
    (3, 'chip', 'dale', '123 park ave', 'orlando', 'FL', 336271234, 3849182934, 'chipdale@magic.com', 483928394, '2005-03-04', '2019-10-20', '2020-09-25',2300.23, 'test trigger');
