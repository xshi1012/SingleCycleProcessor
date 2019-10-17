int main() {
    int i;                      // r7
    for (i = 0; i < 15; i++) {
        char temp = 2;          // r0 = 2
        temp = temp * i;        // r0 = r0 * r7
        char lsw = *(temp);      // ld r1, (r0)
        temp = temp + 1;         // r0 = r0 + 1
        char msw = *(temp);  // ld r2, (r0)

        char MSW = 0;           // r6 = 0
        char p16 = 0;           // r5 = 0


        char p1 = 0;                // r3                                
        char p2 = 0;                // r4

        /* p1 = b11^b9^b7^b5^b4^b2^b1*/
        char and_value;         // r0

        // b1 (p1, p2)
        and_value = 1;          // r0 = 1  
        char b1 = lsw & 1;      // r0 = r0 & r1
        p1 += b1;               // r3 += r0
        p2 += b1;               // r4 += r0
        p16 += b1;              // r5 += r0

        // b2 (p1)
        and_value = 2;          // r0 = 2
        char b2 = lsw & 2;      // r0 = r0 & r1
        b2 = b2 >>> 1;          // r0 = r0 >>> 1
        p1 += b2;               // r3 += r0;
        p16 += b2;              // r5 += r0
        
        // b3 (p2)
        and_value = 1;              // r0 = 1
        and_value and_value <<< 2;  // r0 = r0 <<< 2
        char b3 = lws & and_value;  // r0 =  r0 & r1
        b3 = b3 >>> 2;              // r0 = r1 >>> 2
        p2 += b3;                   // r4 += r0
        p16 += b3;              // r5 += r0

        // b4 (p1, p2)
        and_value = 1;          // r0 = 1
        and_value = and_value <<< 3; // r0 = r0 <<< 3
        char b4 = lsw & and_value;  // r0 = r0 & r1
        b4 = b4 >>> 3;              // r0 = r0 >>> 3
        p1 += b4;               // r3 += r0
        p2 += b4;               // r4 += r0
        p16 += b4;              // r5 += r0

        // b5 (p1)
        and_value = 1;          // r0 = 1
        and_value = and_value <<< 2; // r0 = r0 <<< 2
        and_value = and_value <<< 2; // r0 = r0 <<< 2
        char b5 = lsw & and_value;  // r0 = r0 & r1
        b5 = b5 >>> 2;              // r0 = r0 >>> 2
        b5 = b5 >>> 2;              // r0 = r0 >>> 2
        p1 += b5;                   // r3 = r3 + r0
        p16 += b5;              // r5 += r0
        MSW += b5;              // r6 = r6 + r0

        // b6 (p2)
        and_value = 1;                  // r0 = 1
        and_value = and_value <<< 2;    // r0 = r0 <<< 2
        and_value = and_value <<< 3;    // r0 = r0 <<< 3
        char b6 = lsw & and_value;      // r0 = r0 & r1
        b6 = b6 >>> 3;                  // r0 = r0 >>> 3
        b6 = b6 >>> 2;                  // r0 = r0 >>> 2
        p2 += b6;                       // r4 += r0
        p16 += b6;              // r5 += r0
        b6 = b6 <<< 1;          // r0 = r0 <<< 1
        MSW += b6;              // r6 = r6 + r0

        // b7 (p1, p2)
        and_value = 1;          // r0 = 1
        and_value = and_value <<< 3; // r0 = r0 <<< 3
        and_value = and_value <<< 3; // r0 = r0 <<< 3
        char b7 = lsw & and_value;  // r0 = r0 & r1
        b7 = b7 >>> 3;              // r0 = r0 >>> 3
        b7 = b7 >>> 3;              // r0 = r0 >>> 3
        p1 += b7;                   // r3 = r3 + r0
        p2 += b7;                   // r4 += r0
        p16 += b7;              // r5 += r0
        b7 = b7 << 2;           // r0 = r0 <<< 2
        MSW += b7;              //  r6 = r6 + r0

        // b9 (p1)
        and_value = 1;          // r0 = 1
        char b9 = msw & and_value;      // r0 = r0 & r2
        p1 += b9;               // r3 += r0
        p16 += b9;              // r5 += r0
        b9 = b9 <<< 2;          // r0 = r0 <<< 2
        b9 = b9 <<< 2;          // r0 = r0 <<< 2
        MSW += b9;              // r6 = r6 + r0

        // b10 (p2)
        and_value = 2;              // r0 = 2
        char b10 = msw & and_value; // r0 = r0 & r2
        b10 = b10 >>> 1;            // r0 = r0 >>> 1
        p2 += b10;                  // r4 += r0
        p16 += b10;              // r5 += r0
        b10 = b10 <<< 2;         // r0 = r0 <<< 2
        b10 = b10 <<< 3;         // r0 = r0 <<< 3
        MSW += b10;                 // r6 = r6 + r0

        // b11 (p1, p2)
        and_value = 1;                  // r0 = 1
        and_value = and_value <<< 2;    // r0 = r0 <<< 2
        char b11 = msw & and_value;     // r0 = r0 & r2
        b11 = b11 >>> 2;                // r0 = r0 >>> 2
        p1 += b11;                      // r3 += r0
        p2 += b11;                      // r4 += r0
        p16 += b11;              // r5 += r0
        b11 = b11 <<< 3;                // r0 = r0 <<< 3
        b11 = b11 <<< 3;                // r0 = r0 <<< 3
        MSW += b11;                     // r6 = r6 + r0

        // calculate p1 and p2 with XOR
        p1 = p1 & 1;            // r3 = r3 & 1
        p2 = p2 & 1;            // r4 = r4 & 1

        // p16
        p16 += p1;              // r5 = r5 + r3
        p16 += p2;              // r5 = r5 + r4
        
        // save p1, p2
        p1 = p1 <<< 2;          // r3 = r3 <<< 2
        p1 = p1 <<< 2;
        msw += p1;              // r2 = r2 + r3
        p2 = p2 <<< 3;          // r4 = r4 <<< 3
        p2 = p2 <<< 2;          // r4 = r4 <<< 2
        msw += p2;              // r2 = r2 + r4















        // begin calculating p4 and p8
        char p4 = 0;            // r3 = 0
        char p8 = 0;            // r4 = 0

        // b2 (p4)
        and_value = 2;          // r0 = 2
        b2 = lsw & 2;           // r0 = r0 & r1
        b2 = b2 >>> 1;          // r0 = r0 >>> 1
        p4 += b2;               // r3 += r0;

        // b3 (p4)
        and_value = 1;              // r0 = 1
        and_value and_value <<< 2;  // r0 = r0 <<< 2
        b3 = lws & and_value;  // r0 =  r0 & r1
        b3 = b3 >>> 2;              // r0 = r1 >>> 2
        p4 += b3;                   // r3 += r0

        // b4 (p4)
        and_value = 1;          // r0 = 1
        and_value = and_value <<< 3; // r0 = r0 <<< 3
        b4 = lsw & and_value;  // r0 = r0 & r1
        b4 = b4 >>> 3;              // r0 = r0 >>> 3
        p4 += b4;               // r3 = r3 + r0
        
        // b5 (p8)
        and_value = 1;          // r0 = 1
        and_value = and_value <<< 2; // r0 = r0 <<< 2
        and_value = and_value <<< 2; // r0 = r0 <<< 2
        b5 = lsw & and_value;  // r0 = r0 & r1
        b5 = b5 >>> 2;              // r0 = r0 >>> 2
        b5 = b5 >>> 2;              // r0 = r0 >>> 2
        p8 += b5;                   // r4 = r4 + r0

        // b6 (p8)
        and_value = 1;                  // r0 = 1
        and_value = and_value <<< 2;    // r0 = r0 <<< 2
        and_value = and_value <<< 3;    // r0 = r0 <<< 3
        char b6 = lsw & and_value;      // r0 = r0 & r1
        b6 = b6 >>> 3;                  // r0 = r0 >>> 3
        b6 = b6 >>> 2;                  // r0 = r0 >>> 2
        p8 += b6;                   // r4 = r4 + r0

        // b7 (p8)
        and_value = 1;          // r0 = 1
        and_value = and_value <<< 3; // r0 = r0 <<< 3
        and_value = and_value <<< 3; // r0 = r0 <<< 3
        char b7 = lsw & and_value;  // r0 = r0 & r1
        b7 = b7 >>> 3;              // r0 = r0 >>> 3
        b7 = b7 >>> 3;              // r0 = r0 >>> 3
        p8 += b7;                   // r4 = r4 + r0

        // b8 (p4, p8)
        and_value = 1;                  // r0 = 1
        and_value = and_value <<< 3;    // r0 = r0 <<< 3
        and_value = and_value <<< 3;    // r0 = r0 <<< 3
        and_value = and_value <<< 1;    // r0 = r0 <<< 1
        char b8 = lsw & and_value;      // r0 = r0 & r1
        b8 = b8 >>> 3;                  // r0 = r0 >>> 3
        b8 = b8 >>> 3;                  // r0 = r0 >>> 3
        b8 = b8 >>> 1;                  // r0 = r0 >>> 1
        p4 += b8;                       // r3 = r3 + r0
        p4 += b8;                       // r4 = r4 + r0
        p16 += b8;                      // r5 = r5 + r0
        b8 = b8 <<< 3;                  // r0 = r0 <<< 3
        MSW += b8;                      // r6 = r6 + r0

        // b9 (p4, p8)
        and_value = 1;                  // r0 = 1
        char b9 = msw & and_value;      // r0 = r0 & r2
        p4 += b9;                       // r3 += r0
        p8 += b9;                       // r4 += r0

        // b10 (p4, p8)
        and_value = 2;              // r0 = 2
        char b10 = msw & and_value; // r0 = r0 & r2
        b10 = b10 >>> 1;            // r0 = r0 >>> 1
        p4 += b10;                  // r3 += r0
        p8 += b10;                  // r4 += r0

        // b11 (p4, p8)
        and_value = 1;                  // r0 = 1
        and_value = and_value <<< 2;    // r0 = r0 <<< 2
        b11 = msw & and_value;          // r0 = r0 & r2
        b11 = b11 >>> 2;                // r0 = r0 >>> 2
        p4 += b11;                      // r3 += r0
        p8 += b11;                      // r4 += r0

        // calculate p16
        p4 = p4 & 1;                    // r3 = r3 & 1
        p8 = p8 & 1;                    // r4 = r4 & 1
        p16 += p4;                      // r5 = r5 + r3
        p16 += p8;                      // r5 = r5 + r4

        p16 = p16 & 1;                  // r5 = r5 & 1
        p16 = p16 <<< 3;                // r5 = r5 <<< 3
        p16 = p16 <<< 3;                // r5 = r5 <<< 3
        p16 = p16 <<< 1;                // r5 = r5 <<< 1
        MSW += p16;                     // r6 = r6 + r5

        char LSW = 0;                   // r5 = 0
        p4 = p4 <<< 3;                  // r3 = r3 <<< 3
        p8 = p8 <<< 3;                  // r4 = r4 <<< 3
        p8 = p8 <<< 3;
        p8 = p8 <<< 1;                  
        LSW += p4;                      // r5 = r5 + r3
        LSW += p8;                      // r5 = r5 + r4

        and_value = 1;                  // r0 = 0
        and_value = and_value <<< 2;    // r0 <<< 2
        and_value = and_value <<< 2;    // r0 <<< 2
        p1 = and_value & msw;           // r0 = r0 & r2
        p1 = p1 >>> 2;                  // r0 = r0 >>> 2
        p1 = p1 >>> 2;                  // r0 = r0 >>> 2
        LSW += p1;                      // r5 = r5 + r0

        and_value = 1;
        and_value = and_value <<< 2;    // r0 <<< 2
        and_value = and_value <<< 2;    // r0 <<< 2
        and_value = and_value <<< 1;    // r0 <<< 1
        p2 = and_value & msw;           // r0 = r0 & r2
        p2 = p2 >>> 2;                  // r0 = r0 >>> 2
        p2 = p2 >>> 2;                  // r0 = r0 >>> 2
        LSW += p2;                      // r5 = r5 + r0


        // b1 (p1, p2)
        and_value = 1;          // r0 = 1  
        b1 = lsw & 1;      // r0 = r0 & r1
        b1 = b1 <<< 2;      // r0 = r0 <<< 2
        LSW += b1;

        // b2 (p1)
        and_value = 2;          // r0 = 2
        b2 = lsw & 2;      // r0 = r0 & r1
        b2 = b2 <<< 3;          // r0 = r0 <<< 3
        LSW += b2;

        // b3 (p2)
        and_value = 1;              // r0 = 1
        and_value and_value <<< 2;  // r0 = r0 <<< 2
        b3 = lws & and_value;  // r0 =  r0 & r1
        b3 = b3 <<< 3;              // r0 = r1 <<< 3
        LSW += b3;

        // b4 (p1, p2)
        and_value = 1;          // r0 = 1
        and_value = and_value <<< 3; // r0 = r0 <<< 3
        b4 = lsw & and_value;  // r0 = r0 & r1
        b4 = b4 <<< 3;          // r0 = r0 <<< 3
        LSW += b4;              // r5 = r5 + r0

        thirty = 1;               // r3 = 1
        thirty *= 2;              // r3 = r3 <<< 1;
        thirty += 1;              // r3 = r3 + 1;
        thirty *= 2;              // r3 = r3 <<< 1;
        thirty += 1;              // r3 = r3 + 1, r0 = 111
        thirty *= 2;              // r3 = r3 <<< 1, ro = 1110
        thirty += 1;              // r3 = r3 + 1, r0 = 1111
        thirty *= 2;              // r3 = r3 <<< 1, ro = 11110
        temp = 2;                 // r0 = 2
        temp = temp * i;          // r0 = r0 * r7
        temp += thirty;           // r0 = r0 + r3
        *(temp) = LSW;            // sw r5, (r0)
        temp += 1;                // r0 = r0 + 1
        *(temp) = MSW;            // sw r6, (r0)
    }
}