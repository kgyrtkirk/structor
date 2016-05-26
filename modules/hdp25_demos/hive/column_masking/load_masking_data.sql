drop table if exists masking_demo;
create external table masking_demo (
	name string,
	ssn string,
	ccn string,
	zipcode string,
	rating float
) STORED AS TEXTFILE LOCATION '/user/vagrant/column_masking';

create view if not exists masking_view (name, ssn, ccn, zipcode, rating) as select
	mask(name),
	mask_show_last_n(ssn, 4),
	mask_show_last_n(ccn, 4),
	mask_hash(zipcode),
	rating
from masking_demo;
