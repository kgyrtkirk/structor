!echo Our base data;
select * from masking_demo limit 5;

!echo;
!echo Demonstrate the basics: mask, mask_first_n, mask_last_n, mask_show_last_n;
!sleep 10;
select mask(name), mask_first_n(ssn, 4), mask_last_n(ssn, 4), mask_show_last_n(ssn, 4) from masking_demo limit 5;

!echo;
!echo View created to mask sensitive information;
!sleep 10;
show create table masking_view;
select * from masking_view limit 5;

!echo;
!echo mask_hash allows us to join / group-by without revealing exact values;
!sleep 10;
select count(*) c, zipcode from masking_demo group by zipcode order by c desc limit 5;
select count(*) c, zipcode from masking_view group by zipcode order by c desc limit 5;
