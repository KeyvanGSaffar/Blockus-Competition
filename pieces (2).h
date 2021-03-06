int piece_sizes[17] = {
  1, // a
  2, // b
  3, 3, // c, d
  4, 4, 4, 4, // e, f, g, h
  5, 5, 5, 5, 5, 5, 5, 5, 5  // i - q
};

int pieces[17][5][5] = {
  // a 
  { { 0, 0, 0, 0, 0 }, 
    { 0, 0, 0, 0, 0 },
    { 0, 0, 1, 0, 0 },
    { 0, 0, 0, 0, 0 },
    { 0, 0, 0, 0, 0 } },
  // b
  { { 0, 0, 0, 0, 0 }, 
    { 0, 0, 0, 0, 0 },
    { 0, 0, 1, 0, 0 },
    { 0, 0, 1, 0, 0 },
    { 0, 0, 0, 0, 0 } },
  // c
  { { 0, 0, 0, 0, 0 }, 
    { 0, 0, 1, 0, 0 },
    { 0, 0, 1, 0, 0 },
    { 0, 0, 1, 0, 0 },
    { 0, 0, 0, 0, 0 } },
  // d
  { { 0, 0, 0, 0, 0 }, 
    { 0, 0, 1, 0, 0 },
    { 0, 0, 1, 1, 0 },
    { 0, 0, 0, 0, 0 },
    { 0, 0, 0, 0, 0 } },
  // e
  { { 0, 0, 0, 0, 0 }, 
    { 0, 0, 1, 0, 0 },
    { 0, 0, 1, 0, 0 },
    { 0, 1, 1, 0, 0 },
    { 0, 0, 0, 0, 0 } },
  // f
  { { 0, 0, 0, 0, 0 }, 
    { 0, 0, 1, 0, 0 },
    { 0, 0, 1, 1, 0 },
    { 0, 0, 1, 0, 0 },
    { 0, 0, 0, 0, 0 } },
  // g
  { { 0, 0, 0, 0, 0 }, 
    { 0, 0, 0, 0, 0 },
    { 0, 0, 1, 1, 0 },
    { 0, 0, 1, 1, 0 },
    { 0, 0, 0, 0, 0 } },
  // h
  { { 0, 0, 0, 0, 0 }, 
    { 0, 0, 0, 0, 0 },
    { 0, 1, 1, 0, 0 },
    { 0, 0, 1, 1, 0 },
    { 0, 0, 0, 0, 0 } },
  // i
  { { 0, 0, 1, 0, 0 }, 
    { 0, 0, 1, 0, 0 },
    { 0, 1, 1, 0, 0 },
    { 0, 1, 0, 0, 0 },
    { 0, 0, 0, 0, 0 } },
  // j
  { { 0, 0, 0, 0, 0 }, 
    { 0, 0, 1, 0, 0 },
    { 0, 1, 1, 0, 0 },
    { 0, 1, 1, 0, 0 },
    { 0, 0, 0, 0, 0 } },
  // k
 { { 0, 0, 0, 0, 0 }, 
    { 0, 1, 1, 0, 0 },
    { 0, 0, 1, 0, 0 },
    { 0, 1, 1, 0, 0 },
    { 0, 0, 0, 0, 0 } },
  // l
  { { 0, 0, 0, 0, 0 }, 
    { 0, 0, 1, 0, 0 },
    { 0, 0, 1, 0, 0 },
    { 0, 1, 1, 1, 0 },
    { 0, 0, 0, 0, 0 } },
  // m
  { { 0, 0, 1, 0, 0 }, 
    { 0, 0, 1, 0, 0 },
    { 0, 0, 1, 1, 1 },
    { 0, 0, 0, 0, 0 },
    { 0, 0, 0, 0, 0 } },
  // n
  { { 0, 0, 0, 0, 0 }, 
    { 0, 1, 1, 0, 0 },
    { 0, 0, 1, 1, 0 },
    { 0, 0, 0, 1, 0 },
    { 0, 0, 0, 0, 0 } },
  // o
  { { 0, 0, 0, 0, 0 }, 
    { 0, 1, 0, 0, 0 },
    { 0, 1, 1, 1, 0 },
    { 0, 0, 0, 1, 0 },
    { 0, 0, 0, 0, 0 } },
  // p
  { { 0, 0, 0, 0, 0 }, 
    { 0, 1, 0, 0, 0 },
    { 0, 1, 1, 1, 0 },
    { 0, 0, 1, 0, 0 },
    { 0, 0, 0, 0, 0 } },
  // q
  { { 0, 0, 0, 0, 0 }, 
    { 0, 0, 1, 0, 0 },
    { 0, 1, 1, 1, 0 },
    { 0, 0, 1, 0, 0 },
    { 0, 0, 0, 0, 0 }  }
  
  };
