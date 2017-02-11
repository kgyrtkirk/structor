use nqueens;
SELECT A.z as a, B.z as b, C.z as c
  FROM nine_orc as A JOIN nine_orc as B JOIN nine_orc as C
   where B.z <> A.z
  LIMIT 1;
