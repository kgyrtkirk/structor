use nqueens;
set hive.vectorized.execution.enabled=${VECTORIZATION_ON};

SELECT A.z as a, B.z as b, C.z as c, D.z as d, E.z as e, F.z as f, G.z as g, H.z as h, I.z as i, J.z as j, K.z as k, L.z as l, M.z as m, N.z as n
  FROM fourteen_orc as A JOIN fourteen_orc as B JOIN fourteen_orc as C JOIN fourteen_orc as D
  JOIN fourteen_orc as E JOIN fourteen_orc as F JOIN fourteen_orc as G JOIN fourteen_orc as H
  JOIN fourteen_orc as I JOIN fourteen_orc as J JOIN fourteen_orc as K JOIN fourteen_orc as L
  JOIN fourteen_orc as M JOIN fourteen_orc as N
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
   AND (J.z <> A.z AND J.z <> B.z AND J.z <> C.z AND J.z <> D.z AND J.z <> E.z AND J.z <> F.z AND J.z <> G.z AND J.z <> H.z AND J.z <> I.z)
   AND (J.z - A.z) NOT IN (-9, +9) AND (J.z - B.z) NOT IN (-8, +8) AND (J.z - C.z) NOT IN (-7, +7)
   AND (J.z - D.z) NOT IN (-6, +6) AND (J.z - E.z) NOT IN (-5, +5) AND (J.z - F.z) NOT IN (-4, +4)
   AND (J.z - G.z) NOT IN (-3, +3) AND (J.z - H.z) NOT IN (-2, +2) AND (J.z - I.z) NOT IN (-1, +1)
   AND (K.z <> A.z AND K.z <> B.z AND K.z <> C.z AND K.z <> D.z AND K.z <> E.z AND K.z <> F.z AND K.z <> G.z AND K.z <> H.z AND K.z <> I.z AND K.z <> J.z)
   AND (K.z - A.z) NOT IN (-10, +10) AND (K.z - B.z) NOT IN (-9, +9) AND (K.z - C.z) NOT IN (-8, +8)
   AND (K.z - D.z) NOT IN (-7, +7) AND (K.z - E.z) NOT IN (-6, +6) AND (K.z - F.z) NOT IN (-5, +5)
   AND (K.z - G.z) NOT IN (-4, +4) AND (K.z - H.z) NOT IN (-3, +3) AND (K.z - I.z) NOT IN (-2, +2)
   AND (K.z - J.z) NOT IN (-1, +1)
   AND (L.z <> A.z AND L.z <> B.z AND L.z <> C.z AND L.z <> D.z AND L.z <> E.z AND L.z <> F.z AND L.z <> G.z AND L.z <> H.z AND L.z <> I.z AND L.z <> J.z AND L.z <> K.z)
   AND (L.z - A.z) NOT IN (-11, +11) AND (L.z - B.z) NOT IN (-10, +10) AND (L.z - C.z) NOT IN (-9, +9)
   AND (L.z - D.z) NOT IN (-8, +8) AND (L.z - E.z) NOT IN (-7, +7) AND (L.z - F.z) NOT IN (-6, +6)
   AND (L.z - G.z) NOT IN (-5, +5) AND (L.z - H.z) NOT IN (-4, +4) AND (L.z - I.z) NOT IN (-3, +3)
   AND (L.z - J.z) NOT IN (-2, +2) AND (L.z - K.z) NOT IN (-1, +1)
   AND (M.z <> A.z AND M.z <> B.z AND M.z <> C.z AND M.z <> D.z AND M.z <> E.z AND M.z <> F.z AND M.z <> G.z AND M.z <> H.z AND M.z <> I.z AND M.z <> J.z AND M.z <> K.z AND M.z <> L.z)
   AND (M.z - A.z) NOT IN (-12, +12) AND (M.z - B.z) NOT IN (-11, +11) AND (M.z - C.z) NOT IN (-10, +10)
   AND (M.z - D.z) NOT IN (-9, +9) AND (M.z - E.z) NOT IN (-8, +8) AND (M.z - F.z) NOT IN (-7, +7)
   AND (M.z - G.z) NOT IN (-6, +6) AND (M.z - H.z) NOT IN (-5, +5) AND (M.z - I.z) NOT IN (-4, +4)
   AND (M.z - J.z) NOT IN (-3, +3) AND (M.z - K.z) NOT IN (-2, +2) AND (M.z - L.z) NOT IN (-1, +1)
   AND (N.z <> A.z AND N.z <> B.z AND N.z <> C.z AND N.z <> D.z AND N.z <> E.z AND N.z <> F.z AND N.z <> G.z AND N.z <> H.z AND N.z <> I.z AND N.z <> J.z AND N.z <> K.z AND N.z <> L.z AND N.z <> M.z)
   AND (N.z - A.z) NOT IN (-13, +13) AND (N.z - B.z) NOT IN (-12, +12) AND (N.z - C.z) NOT IN (-11, +11)
   AND (N.z - D.z) NOT IN (-10, +10) AND (N.z - E.z) NOT IN (-9, +9) AND (N.z - F.z) NOT IN (-8, +8)
   AND (N.z - G.z) NOT IN (-7, +7) AND (N.z - H.z) NOT IN (-6, +6) AND (N.z - I.z) NOT IN (-5, +5)
   AND (N.z - J.z) NOT IN (-4, +4) AND (N.z - K.z) NOT IN (-3, +3) AND (N.z - L.z) NOT IN (-2, +2)
   AND (N.z - M.z) NOT IN (-1, +1)
 ORDER BY a, b, c, d, e, f, g, h, i, j, k, l, m
 LIMIT 10;
