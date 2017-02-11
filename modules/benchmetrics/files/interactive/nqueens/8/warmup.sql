use nqueens;
SELECT A.z as a, B.z as b, C.z as c
  FROM eight_orc as A JOIN eight_orc as B JOIN eight_orc as C
   where B.z <> A.z
  LIMIT 1;
