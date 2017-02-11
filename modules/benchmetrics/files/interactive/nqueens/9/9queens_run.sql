use nqueens;
set hive.vectorized.execution.enabled=${VECTORIZATION_ON};

SELECT A.z as a, B.z as b, C.z as c, D.z as d, E.z as e, F.z as f, G.z as g, H.z as h, I.z as i
  FROM nine_orc as A JOIN nine_orc as B JOIN nine_orc as C JOIN nine_orc as D
  JOIN nine_orc as E JOIN nine_orc as F JOIN nine_orc as G JOIN nine_orc as H
  JOIN nine_orc as I
   where B.z <> A.z
   and (B.z - A.z) NOT IN (-1, +1)
   AND (C.z <> A.z AND C.z <> B.z)
   AND (C.z - A.z) NOT IN (-2, +2) AND (C.z - B.z) NOT IN (-1, +1)
   AND (D.z <> A.z AND D.z <> B.z AND D.z <> C.z)
   AND (D.z - A.z) NOT IN (-3, +3) AND (D.z - B.z) NOT IN (-2, +2) AND (D.z - C.z) NOT IN (-1, +1)
   AND (E.z <> A.z AND E.z <> B.z AND E.z <> C.z AND E.z <> D.z)
   AND (E.z - A.z) NOT IN (-4, +4) AND (E.z - B.z) NOT IN (-3, +3) AND (E.z - C.z) NOT IN (-2, +2)
   AND (E.z - D.z) NOT IN (-1, +1)
   AND (F.z <> A.z AND F.z <> B.z AND F.z <> C.z AND F.z <> D.z AND F.z <> E.z)
   AND (F.z - A.z) NOT IN (-5, +5) AND (F.z - B.z) NOT IN (-4, +4) AND (F.z - C.z) NOT IN (-3, +3)
   AND (F.z - D.z) NOT IN (-2, +2) AND (F.z - E.z) NOT IN (-1, +1)
   AND (G.z <> A.z AND G.z <> B.z AND G.z <> C.z AND G.z <> D.z AND G.z <> E.z AND G.z <> F.z)
   AND (G.z - A.z) NOT IN (-6, +6) AND (G.z - B.z) NOT IN (-5, +5) AND (G.z - C.z) NOT IN (-4, +4)
   AND (G.z - D.z) NOT IN (-3, +3) AND (G.z - E.z) NOT IN (-2, +2) AND (G.z - F.z) NOT IN (-1, +1)
   AND (H.z <> A.z AND H.z <> B.z AND H.z <> C.z AND H.z <> D.z AND H.z <> E.z AND H.z <> F.z AND H.z <> G.z)
   AND (H.z - A.z) NOT IN (-7, +7) AND (H.z - B.z) NOT IN (-6, +6) AND (H.z - C.z) NOT IN (-5, +5)
   AND (H.z - D.z) NOT IN (-4, +4) AND (H.z - E.z) NOT IN (-3, +3) AND (H.z - F.z) NOT IN (-2, +2)
   AND (H.z - G.z) NOT IN (-1, +1)
   AND (I.z <> A.z AND I.z <> B.z AND I.z <> C.z AND I.z <> D.z AND I.z <> E.z AND I.z <> F.z AND I.z <> G.z AND I.z <> H.z)
   AND (I.z - A.z) NOT IN (-8, +8) AND (I.z - B.z) NOT IN (-7, +7) AND (I.z - C.z) NOT IN (-6, +6)
   AND (I.z - D.z) NOT IN (-5, +5) AND (I.z - E.z) NOT IN (-4, +4) AND (I.z - F.z) NOT IN (-3, +3)
   AND (I.z - G.z) NOT IN (-2, +2) AND (I.z - H.z) NOT IN (-1, +1)
 ORDER BY a, b, c, d, e, f, g, h;
