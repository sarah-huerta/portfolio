-- P2 a --
use sah16m;
go

begin transaction;

select pat_fname, pat_lname, pat_notes, med_name, med_price, med_shelf_life, pre_dosage, pre_num_refills
from medication m
  join prescription pr on pr.med_id = m.med_id
  join patient p on pr.pat_id = p.pat_id
  order by med_price desc;
commit;
