---------------------------- MODULE Centralizer ----------------------------
EXTENDS Integers
VARIABLES player1, points1, player2, points2, player3, points3, player4, points4
VARIABLES ponE, chiE, kanE, pairE, ponS, chiS, kanS, pairS, ponW, pairW, chiW, kanW, ponN, chiN, kanN, pairN
VARIABLES pc, dealer, playingWall, deadWall, end, wind

Init == /\ player1 = 1 /\ points1 = 25000
        /\ player2 = 2 /\ points2 = 25000
        /\ player3 = 3 /\ points3 = 25000
        /\ player4 = 4 /\ points4 = 25000
        /\ dealer = "east"
        /\ pc = "east"
        /\ end = 1
        /\ playingWall = 70
        /\ deadWall = 14
        /\ wind = "east"
        
east == \/ pc' = "eastBuy"
        \/ pc' = "eastKan"

eastBuy == /\ wind' = "east"
           /\ playingWall' = playingWall - 1
           /\ \/ ponE' = ponE + 1
              \/ chiE' = chiE + 1
              \/ /\ kanE' = kanE + 1
                 /\ deadWall' = deadWall - 1
              \/ ponE' = ponE
              \/ IF (((ponE + chiE + kanE) = 4) /\ (pairE = 1)) THEN pc' = "tsumo" ELSE ponE' = ponE
           /\ deadWall' = deadWall + 1
           /\ IF playingWall = 0 THEN pc' = "tsumo" ELSE pc' = "south"
           
eastKan == /\ kanE' = kanE + 1
           /\ deadWall' = deadWall - 1
           /\ pc' = "eastBuy"
           
south == \/ pc' = "southBuy"
         \/ pc' = "southKan"

southBuy == /\ wind' = "south"
            /\ playingWall' = playingWall - 1
            /\ \/ ponS' = ponS + 1
               \/ chiS' = chiS + 1
               \/ /\ kanS' = kanS + 1
                  /\ deadWall' = deadWall - 1
               \/ ponS' = ponS
               \/ IF (((ponS + chiS + kanS) = 4) /\ (pairS = 1)) THEN pc' = "tsumo" ELSE ponS' = ponS
            /\ deadWall' = deadWall + 1
            /\ IF playingWall = 0 THEN pc' = "tsumo" ELSE pc' = "west"
           
southKan == /\ kanS' = kanS + 1
            /\ deadWall' = deadWall - 1
            /\ pc' = "southBuy"
            
west == \/ pc' = "westBuy"
        \/ pc' = "westKan"

westBuy == /\ wind' = west
           /\ playingWall' = playingWall - 1
           /\ \/ ponW' = ponW + 1
              \/ chiW' = chiW + 1
              \/ /\ kanW' = kanW + 1
                 /\ deadWall' = deadWall - 1
              \/ ponW' = ponW
              \/ IF (((ponW + chiW + kanW) = 4) /\ (pairW = 1)) THEN pc' = "tsumo" ELSE ponW' = ponW
           /\ deadWall' = deadWall + 1
           /\ IF playingWall = 0 THEN pc' = "tsumo" ELSE pc' = "north"
           
westKan == /\ kanW' = kanW + 1
           /\ deadWall' = deadWall - 1
           /\ pc' = "westBuy"
           
north == \/ pc' = "northBuy"
         \/ pc' = "northKan"

northBuy == wind' = "north"
            /\ playingWall' = playingWall - 1
            /\ \/ ponN' = ponN + 1
               \/ chiN' = chiN + 1
               \/ /\ kanN' = kanN + 1
                  /\ deadWall' = deadWall - 1
               \/ ponN' = ponN
               \/ IF (((ponN + chiN + kanN) = 4) /\ (pairN = 1)) THEN pc' = "tsumo" ELSE ponN' = ponN
            /\ deadWall' = deadWall + 1
            /\ IF playingWall = 0 THEN pc' = "tsumo" ELSE pc' = "east"
           
northKan == /\ kanN' = kanN + 1
            /\ deadWall' = deadWall - 1
            /\ pc' = "northBuy"    

tsumo == /\ IF wind = dealer THEN pc' = dealer ELSE /\ player1' = (player1 % 4) + 1
                                                    /\ player2' = (player2 % 4) + 1
                                                    /\ player3' = (player3 % 4) + 1
                                                    /\ player4' = (player4 % 4) + 1
                                                    /\ end' = end + 1
                                                    /\ pc' = dealer
         /\ IF end = 5 THEN dealer' = "south" ELSE dealer' = dealer
         /\ playingWall' = 70
         /\ deadWall' = 14
                                

Termination == <>(\/ player1 = 0 
                  \/ player2 = 0 
                  \/ player3 = 0 
                  \/ player4 = 0 
                  \/ end = 10)


=============================================================================
\* Modification History
\* Last modified Thu Apr 19 19:33:53 BRT 2018 by Dragleer
\* Created Thu Apr 19 14:19:48 BRT 2018 by Dragleer
