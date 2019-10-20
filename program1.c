void program1() {
    int i;                          // loop: mov r7, 0
    for (i = 0; i < 15; i++) {
        char temp = 2;              // mov r0, 2
        temp = temp * i;            // mul r0, r7
        char lsw = *(temp);         // lw r1, r0

        temp += 1;                  // mov r2, 1
                                    // add r0, r2
        char msw = *(temp);         // lw r2, r0

        // r1, r2, r7 in use

        // calculate p1 ^(b11,b9,b7,b5,b4,b2,b1)
        // calculate p2 ^(b11,b10,b7,b6,b4,b3,b1)
        // calculate p4 ^(b11,b10,b9,b8,b4,b3,b2)
        // calculate p8 ^(b11,b10,b9,b8,b7,b6,b5)

        // temp = _ _ _ _ _ _ _ b1
        temp = 0;                   // mov r0, 0
        temp += lsw;                // add r0, r1

        char p1 = 0;                // mov r3, 0
        char p2 = 0;                // mov r4, 0
        char p4 = 0;                // mov r5, 0
        char p8 = 0;                // mov r6, 0

        // p1 = _ _ _ _ _ _ _ b1
        // p2 = _ _ _ _ _ _ _ b1
        p1 = p1^temp;                // xor r3, r0
        p2 = p2^temp;                // xor r4, r0
        // temp = _ _ _ _ _ _ _ b2
        temp = temp >> 1;           // lsr r0, 1
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
        temp = temp >> 1;           // lsr r0, 1
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

        temp = 0;                   // mov r0, 0
        temp += msw;                // add r0, r2

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

        // p2 = 0 0 0 0 0 0 p2 0
        // p4 = 0 0 0 0 p4 0 0 0
        // p8 = p8 0 0 0 0 0 0 0
        p2 = p2 << 1;               // lsl r4, 1
        p4 = p4 << 3;               // lsl r5, 3
        p8 = p8 << 3;               // lsl r6, 3
        p8 = p8 << 3;               // lsl r6, 3
        p8 = p8 << 1;               // lsl r6, 1

        char LSW = 0;               // mov r2, 0
        LSW += p1;                  // add r2, r3
        LSW += p2;                  // add r2, r4
        LSW += p4;                  // add r2, r5
        LSW += p8;                  // add r2, r6

        // r3, r4, r5, r6 freed!!!!!!
        temp = 1;                   // mov r0, 1
        temp = temp & lsw;          // and r0, r1
        temp = temp << 2;           // lsl r0, 2
        LSW += temp;                // add r2, r0

        temp = 2;                   // mov r0, 2
        temp = temp & lsw;          // and r0, r1
        temp = temp << 3;           // lsl r0, 3
        LSW += temp;                // add r2, r0

        temp = 4;                   // mov r0, 4
        temp = temp & lsw;          // and r0, r1
        temp = temp << 3;           // lsl r0, 3
        LSW += temp;                // add r2, r0

        temp = 4;                   // mov r0, 4
        temp = temp << 1;           // lsl r0, 1
        temp = temp & lsw;          // and r0, r1
        temp = temp << 3;           // lsl r0, 3
        LSW += temp;                // and r2, r0
        // LSW = p8 b4 b3 b2 p4 b1 p2 p1

        temp = 2;                   // mov r0, 2
        temp *= i;                  // mul r0, r7
        temp += 1;                  // mov r4, 1
                                    // add r0, r4
        msw = *(temp);              // ld r3, r0
        char MSW = 0;               // mov r4, 0

        // r0 -> temp
        // r1 -> lsw
        // r2 -> LSW
        // r3 -> msw
        // r4 -> MSW
        // r5 -> free
        // r6 -> free
        // r7 -> i

        temp = 4;                   // mov r0, 4
        temp = temp << 2;           // lsl r0, 2
        temp = temp & lsw;          // and r0, r1
        temp = temp >> 2;           // lsr r0, 2
        temp = temp >> 2;           // lsr r0, 2
        MSW += temp;                // add r4, r0

        temp = 4;                   // mov r0, 4
        temp = temp << 3;           // lsl r0, 3
        temp = temp & lsw;          // and r0, r1
        temp = temp >> 2;           // lsr r0, 2
        temp = temp >> 2;           // lsr r0, 2
        MSW += temp;                // add r4, r0

        temp = 4;                   // mov r0, 4
        temp = temp << 2;           // lsl r0, 2
        temp = temp << 2;           // lsl r0, 2
        temp = temp & lsw;          // and r0, r1
        temp = temp >> 2;           // lsr r0, 2
        temp = temp >> 2;           // lsr r0, 2
        MSW += temp;                // add r4, r0

        temp = 4;                   // mov r0, 4
        temp = temp << 3;           // lsl r0, 3
        temp = temp << 2;           // lsl r0, 2
        temp = temp & lsw;          // and r0, r1
        temp = temp >> 2;           // lsr r0, 2
        temp = temp >> 2;           // lsr r0, 2
        MSW += temp;                // add r4, r0
        // MSW = 0 0 0 0 b8 b7 b6 b5

        temp = 1;                   // mov r0, 1
        temp = temp & msw;          // and r0, r3
        temp = temp << 2;           // lsl r0, 2
        temp = temp << 2;           // lsl r0, 2
        MSW += temp;                // add r4, r0

        temp = 2;                   // mov r0, 2
        temp = temp & msw;          // and r0, r3
        temp = temp << 2;           // lsl r0, 2
        temp = temp << 2;           // lsl r0, 2
        MSW += temp;                // add r4, r0

        temp = 4;                   // mov r0, 4
        temp = temp & msw;          // and r0, r3
        temp = temp << 2;           // lsl r0, 2
        temp = temp << 2;           // lsl r0, 2
        MSW += temp;                // add r4, r0
        // MSW = 0 b11 b10 b9 b8 b7 b6 b5

        char p16 = 0;               // mov r6, 0
        temp = 0;                   // mov r0, 0
        temp += LSW;                // add r0, r2
        p16 = p16^temp;             // xor r6, r0
        
        temp = temp >> 1;           // lsr r0, 1
        p16 = p16^temp;             // xor r6, r0

        temp = temp >> 1;           // lsr r0, 1
        p16 = p16^temp;             // xor r6, r0

        temp = temp >> 1;           // lsr r0, 1
        p16 = p16^temp;             // xor r6, r0

        temp = temp >> 1;           // lsr r0, 1
        p16 = p16^temp;             // xor r6, r0

        temp = temp >> 1;           // lsr r0, 1
        p16 = p16^temp;             // xor r6, r0

        temp = temp >> 1;           // lsr r0, 1
        p16 = p16^temp;             // xor r6, r0

        temp = temp >> 1;           // lsr r0, 1
        p16 = p16^temp;             // xor r6, r0

        temp = 0;                   // mov r0, 0
        temp += MSW;                // add r0, r4
        p16 = p16^temp;             // xor r6, r0

        temp = temp >> 1;           // lsr r0, 1
        p16 = p16^temp;             // xor r6, r0

        temp = temp >> 1;           // lsr r0, 1
        p16 = p16^temp;             // xor r6, r0

        temp = temp >> 1;           // lsr r0, 1
        p16 = p16^temp;             // xor r6, r0

        temp = temp >> 1;           // lsr r0, 1
        p16 = p16^temp;             // xor r6, r0

        temp = temp >> 1;           // lsr r0, 1
        p16 = p16^temp;             // xor r6, r0

        temp = temp >> 1;           // lsr r0, 1
        p16 = p16^temp;             // xor r6, r0

        temp = temp >> 1;           // lsr r0, 1
        p16 = p16^temp;             // xor r6, r0

        p16 = p16 << 3;             // lsl r6, 3
        p16 = p16 << 3;             // lsl r6, 3
        p16 = p16 << 1;             // lsl r6, 1
        MSW += p16;                 // add r4, r6

        // r2 -> LSW
        // r4 -> MSW
        // r1 -> free
        // r3 -> free
        // r5 -> free
        // r6 -> free
        // r0 -> free
        // r7 -> i

        char thirty = 7;            // mov r0, 0
        thirty = thirty << 2;       // lsl r0, 2

        temp = 2;                   // mov r1, 2
        thirty += temp;             // add r0, r1

        temp *= i;                  // mul r1, r7
        temp += thirty;             // add r1, r0
        *(temp) = LSW;              // sw r2, r1
        
        char one = 1;               // mov r0, 1
        temp += one;                // add r1, r0
        *(temp) = MSW;              // sw r4, r1

        char shiwu = 7;             // mov r0, 7
        shiwu = shiwu << 1;         // lsl r0, 1
        shiwu += 1;                 // add r0, 1

        // bne r7, r0
        // jump loop
    }
}