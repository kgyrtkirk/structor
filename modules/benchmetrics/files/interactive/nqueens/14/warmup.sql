use nqueens;
SELECT A.z as a, B.z as b, C.z as c
  FROM fourteen_orc as A JOIN fourteen_orc as B JOIN fourteen_orc as C
   where B.z <> A.z
  LIMIT 1;
