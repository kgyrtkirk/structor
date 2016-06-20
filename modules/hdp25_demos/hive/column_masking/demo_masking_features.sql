!echo Our base data;
select * from masking_demo limit 5;

!echo;
!echo Demonstrate the basics: mask, mask_first_n, mask_last_n, mask_show_last_n;
!echo select mask(name), mask_first_n(ssn, 4), mask_last_n(ssn, 4), mask_show_last_n(ssn, 4) from masking_demo limit 5;
!echo Write to FIFO to continue;
!cat /tmp/fifo;
select mask(name), mask_first_n(ssn, 4), mask_last_n(ssn, 4), mask_show_last_n(ssn, 4) from masking_demo limit 5;

!echo;
!echo See the definition of the view created to mask sensitive information;
!echo Write to FIFO to continue;
!cat /tmp/fifo;
describe extended masking_view;
!echo;
!echo Now we run select * from masking_view limit 5;
!echo Write to FIFO to continue;
!cat /tmp/fifo;
select * from masking_view limit 5;
!echo;
!echo Write to FIFO to continue;
!cat /tmp/fifo;

!echo;
!echo mask_hash allows us to join / group-by without revealing exact values. First let's see the unamsked counts by zip code;
!echo select count(*) c, zipcode from masking_demo group by zipcode order by c desc limit 5;
!echo Write to FIFO to continue;
!cat /tmp/fifo;
select count(*) c, zipcode from masking_demo group by zipcode order by c desc limit 5;
!echo;
!echo Now let's see the same groups after masking. The counts will match.
!echo select count(*) c, zipcode from masking_view group by zipcode order by c desc limit 5;
!echo Write to FIFO to continue;
!cat /tmp/fifo;
select count(*) c, zipcode from masking_view group by zipcode order by c desc limit 5;

