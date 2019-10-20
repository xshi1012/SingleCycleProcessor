void main() {
    int i;                          // mov r7, 0
    for (i = 0; i < 15; i ++) {     // loop1:
        char LSW = *(64 + 2*i);     // ld r1,
        char MSW = *(65 + 2*i);     // ld r2

        char temp = LSW;            // r0
        char p1 = 0;                // r3
        char p2 = 0;                // r4
        char p4 = 0;                // r5
        char p8 = 0;                // r6

        // temp = _ _ _ _ _ _ _ b1
        temp = temp >> 2;
        // p1 = _ _ _ _ _ _ _ b1
        // p2 = _ _ _ _ _ _ _ b1
        p1 = p1^temp;                // xor r3, r0
        p2 = p2^temp;                // xor r4, r0
        // temp = _ _ _ _ _ _ _ b2
        temp = temp >> 2;
        // p1 = _ _ _ _ _ _ _ b2^b1
        // p4 = _ _ _ _ _ _ _ b2
        p1 = p1^temp;               // xor r3, r0
        p4 = p4^temp;               // xor r5, r0
        // temp = _ _ _ _ _ _ _ b3
        temp = temp >> 1;           // lsr r0, 1
        // p2 = _ _ _ _ _ _ _ b3^b1
        // p4 = _ _ _ _ _ _ _ b3^b2
        p2 = p2^temp;               // xor r4, r0
        p4 = p4^temp;               // xor r5, r0
        // temp = _ _ _ _ _ _ _ b4
        temp = temp >> 1;           // lsr r0, 1
        // p1 = _ _ _ _ _ _ _ b4^b2^b1
        // p2 = _ _ _ _ _ _ _ b4^b3^b1
        // p4 = _ _ _ _ _ _ _ b4^b3^b2
        p1 = p1^temp;               // xor r3, r0
        p2 = p2^temp;               // xor r4, r0
        p4 = p4^temp;               // xor r5, r0

        // temp = _ _ _ _ _ _ _ b5
        temp = MSW;
        // p1 = _ _ _ _ _ _ _ b5^b4^b2^b1
        // p8 = _ _ _ _ _ _ _ b5
        p1 = p1^temp;               // xor r3, r0
        p8 = p8^temp;               // xor r6, r0
        // temp = _ _ _ _ _ _ _ b6
        temp = temp >> 1;           // lsr r0, 1
        // p2 = _ _ _ _ _ _ _ b6^b4^b3^b1
        // p8 = _ _ _ _ _ _ _ b6^b5
        p2 = p2^temp;               // xor r4, r0
        p8 = p8^temp;               // xor r6, r0
        // temp = _ _ _ _ _ _ _ b7
        temp = temp >> 1;           // lsr r0, 1
        // p1 = _ _ _ _ _ _ _ b7^b5^b4^b2^b1
        // p2 = _ _ _ _ _ _ _ b7^b6^b4^b3^b1
        // p8 = _ _ _ _ _ _ _ b7^b6^b5
        p1 = p1^temp;               // xor r3, r0
        p2 = p2^temp;               // xor r4, r0
        p8 = p8^temp;               // xor r6, r0
        // temp = _ _ _ _ _ _ _ b8
        temp = temp >> 1;           // lsr r0, 1
        // p4 = _ _ _ _ _ _ _ b8^b4^b3^b2
        // p8 = _ _ _ _ _ _ _ b8^b7^b6^b5
        p4 = p4^temp;               // xor r5, r0
        p8 = p8^temp;               // xor r6, r0
        // temp = _ _ _ _ _ _ _ b9
        temp = temp >> 1;           // lsr r0, 1
        // p1 = _ _ _ _ _ _ _ b9^b7^b5^b4^b2^b1
        // p4 = _ _ _ _ _ _ _ b9^b8^b4^b3^b2
        // p8 = _ _ _ _ _ _ _ b9^b8^b7^b6^b5
        p1 = p1^temp;               // xor r3, r0
        p4 = p4^temp;               // xor r5, r0
        p8 = p8^temp;               // xor r6, r0
        // temp = _ _ _ _ _ _ _ b10
        temp = temp >> 1;           // lsr r0, 1
        // p2 = _ _ _ _ _ _ _ b10^b7^b6^b4^b3^b1
        // p4 = _ _ _ _ _ _ _ b10^b9^b8^b4^b3^b2
        // p8 = _ _ _ _ _ _ _ b10^b9^b8^b7^b6^b5
        p2 = p2^temp;               // xor r4, r0
        p4 = p4^temp;               // xor r5, r0
        p8 = p8^temp;               // xor r6, r0
        // temp = _ _ _ _ _ _ _ b11
        temp = temp >> 1;           // lsr r0, 1
        // p1 = _ _ _ _ _ _ _ b11^b9^b7^b5^b4^b2^b1
        // p2 = _ _ _ _ _ _ _ b11^b10^b7^b6^b4^b3^b1
        // p4 = _ _ _ _ _ _ _ b11^b10^b9^b8^b4^b3^b2
        // p8 = _ _ _ _ _ _ _ b11^b10^b9^b8^b7^b6^b5
        p1 = p1^temp;               // xor r3, r0
        p2 = p2^temp;               // xor r4, r0
        p4 = p4^temp;               // xor r5, r0
        p8 = p8^temp;               // xor r6, r0

        temp = 1;                   // mov r0, 1
        p1 = p1&temp;               // and r3, r0
        p2 = p2&temp;               // and r4, r0
        p4 = p4&temp;               // and r5, r0
        p8 = p8&temp;               // and r6, r0

        temp = 0;
        p2 = p2 << 1;
        p4 = p4 << 2;
        p8 = p4 << 3;
        temp += p1;
        temp += p2;
        temp += p4;
        temp += p8;                     

        char calculated_p1248 = temp;   // mov r3, 0; add r3, r0
        char received_p1248 = 0;        // mov r4, 0

        temp = LSW;                     // mov r0, 0; add r0, r1
        char temp2 = 1;                 // mov r5, 1
        // temp2 = p1
        temp2 &= temp;                  // and r5, r0
        received_p1248 += temp2;        // add r4, r5

        // temp2 = p2
        temp2 = 2;                      // mov r5, 2
        temp2 &= temp;                  // and r5, r0
        received_p1248 += temp2;        // add r4, r5

        // temp2 = p4
        temp2 = 7;                      // mov r5, 7
        temp2 &= temp;                  // and r5, r0
        temp2 = temp2 >> 1;             // lsr r5, 1
        received_p1248 += temp2;        // add r4, r5

        // temp2 = p8
        temp2 = 7;                      // mov r5, 7
        temp2 = temp2 << 2;             // lsl r5, 2
        temp2 = temp2 << 2;             // lsl r5, 2
        temp2 &= temp;                  // and r5, r0
        temp2 = temp2 >> 2;             // lsr r5, 2
        temp2 = temp2 >> 2;             // lsr r5, 2
        received_p1248 += temp2;        // add r4, r5
        
        // r0 -> free
        // r1 -> LSW
        // r2 -> MSW
        // r3 -> calculated_1248
        // r4 -> received_1245
        // r5 -> free
        // r6 -> free
        // r7 -> i

        temp = LSW;                     // mov r0, 0; add r0, r1
        char p16 = 0;                   // mov r5, 0
        p16 ^= temp;                    // xor r5, r0
        temp = temp >> 1;               // lsr r0, 1
        p16 ^= temp;
        temp = temp >> 1;
        p16 ^= temp;
        temp = temp >> 1;
        p16 ^= temp;
        temp = temp >> 1;
        p16 ^= temp;
        temp = temp >> 1;
        p16 ^= temp;
        temp = temp >> 1;
        p16 ^= temp;
        temp = temp >> 1;
        p16 ^= temp;

        temp = MSW;                     // mov r0, 0; add r0, r2
        p16 ^= temp;                    // xor r5, r0
        temp = temp >> 1;               // lsr r0, 1
        p16 ^= temp;
        temp = temp >> 1;
        p16 ^= temp;
        temp = temp >> 1;
        p16 ^= temp;
        temp = temp >> 1;
        p16 ^= temp;
        temp = temp >> 1;
        p16 ^= temp;
        temp = temp >> 1;
        p16 ^= temp;
        temp = temp >> 1;
        p16 ^= temp;

        // temp = received p16
        temp = temp >> 1;               // lsr r0, 1
        // p16 = calculated p16
        p16 &= 1;                       // mov r6, 1; and r5, r6

        // r6 -> free

        // bne r5, r0
        // jump loop2
        char lsw;
        char msw;
        if (p16 != temp) {              // onebit:
            // 1 - bit error correction
            temp = calculated_p1248;    // mov r0, 0; add r0, r3
            temp ^= received_p1248;     // xor r0, r4
            // temp = the index of wrong bit

            temp2 = 0;                  // mov r6, 0
            
            // bne r6, r0
            // jump p16
            if (temp == temp2) {
                temp2 = 7;          // mov r6, 7
                temp2 = temp2 << 2; // lsl r6, 2
                temp2 = temp2 << 2; // lsl r6, 2

                // r0 -> temp -> index
                // r3 -> free
                // r4 -> free
                // r5 -> free
                // r6 -> temp2 -> position

                char temp3 = 0;     // mov r5, 0
                while (temp3 < temp) {
                    // loop4:
                    temp2 = temp2 << 1;
                    temp3++;
                    // bne r5, r0
                    // jump loop4
                }

                char temp3 = -1;    // mov r5, 3
                                    // lsr r5, 1

                temp += temp3;      // add r0, r5
                temp = temp >> 3;   // lsr r0, 3
                temp3 = 0;

                // bne r0, r5
                // jump msw
                if (temp != temp3) {
                    // msw:
                    MSW ^= temp2;   // xor r2, r6

                    temp = 1;       // mov r0, 1
                    temp2 = 0;      // mov r6, 0
                    msw = 0;        // mov r4, 0
                    // bne r0, r6
                    // jump save
                } else {
                    LSW ^= temp2;   // xor r1, r6

                    temp = 1;       // mov r0, 1
                    temp2 = 0;      // mov r6, 0
                    msw = 0;        // mov r4, 0
                    // bne r0, r6
                    // jump save
                }
            } else {    // p16:
                // p16 wrong

                temp = 1;           // mov r0, 1
                temp2 = 0;          // mov r6, 0
                msw = 0;            // mov r4, 0
                // bne r0, r6
                // jump save
            }
        } else {
            // 2 - bit error detection or correct
            temp = received_p1248;          // r0 <- r4
            msw = 0;                        // mov r4, 0
            if (calculated_p1248 != temp) {
                // bne r0, r3
                // jump twobit

                // twobit:
                msw = 1;                    // mov r4, 1
                msw = msw >> 1;             // lsr r4, 1
            }

            temp = 1;           // mov r0, 1
            temp2 = 2;          // mov r6, 2
            // bne r0, r6
            // jump save
        }
        // save:

        lsw = 0;                            // mov r3, 0

        // r0 free
        // r1 LSW
        // r2 MSW
        // r3 lsw
        // r4 msw
        // r5 free
        // r6 free
        // r7 i

        // lsw = b1 0 0 0 0 0 0 0
        LSW = LSW >> 2;                     // lsr r1, 2
        temp = 1;                           // mov r0, 1
        temp &= LSW;                        // and r0, r1
        lsw += temp;                        // add r3, r0
        lsw = lsw >> 1;                     // lsr r3, 1

        // lsw = b4 b3 b2 b1 0 0 0 0
        LSW = LSW >> 2;                     // lsr r1, 2
        temp = 7;                           // mov r0, 7
        temp &= LSW;                        // and r0, r1
        lsw += temp;                        // add r3, r0
        lsw = lsw >> 3;

        // temp = 0 0 0 0 1 1 1 1
        temp = 7;                           // mov r0, 7
        temp = temp << 1;                   // lsl r0, 1
        temp2 = 1;                          // mov r5, 1
        temp += temp2;                      // add r0, r5
        // temp = 0 0 0 0 b8 b7 b6 b5
        temp &= MSW;                        // and r0, r2
        // lsw = b4 b3 b2 b1 b8 b7 b6 b5
        lsw += temp;                        // add r3, r0
        // lsw = b8 b7 b6 b5 b4 b3 b2 b1
        lsw = lsw >> 2;                     // lsr r3, 2
        lsw = lsw >> 2;                     // lsr r3, 2

        MSW = MSW >> 2;                     // lsr r2, 2
        MSW = MSW >> 2;                     // lsr r2, 2
        temp = 7;                           // mov r0, 7
        temp &= MSW;                        // and r0, r2
        msw += temp;

        // r0 free
        // r1 free
        // r2 free
        // r3 lsw
        // r4 msw
        // r5 free
        // r6 free
        // r7 i
        *(94 + 2*i) = lsw;
        *(95 + 2*i) = msw;

        char shiwu = 7;             // mov r0, 7
        shiwu = shiwu << 1;         // lsl r0, 1
        shiwu += 1;                 // add r0, 1
        // bne r7, r0
        // jump loop1
    }
}