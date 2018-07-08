Get["models/NUHMSSMNoFVHimalaya/NUHMSSMNoFVHimalaya_librarylink.m"];
Get["model_files/NUHMSSMNoFVHimalaya/NUHMSSMNoFVHimalaya_uncertainty_estimate.m"];

Get["models/HSSUSY/HSSUSY_librarylink.m"];
Get["model_files/HSSUSY/HSSUSY_uncertainty_estimate.m"];

Mtpole = 173.34;

settings = {
    precisionGoal -> 1.*^-5,
    maxIterations -> 100,
    betaFunctionLoopOrder -> 4,
    poleMassLoopOrder -> 4,
    ewsbLoopOrder -> 4,
    thresholdCorrectionsLoopOrder -> 3,
    thresholdCorrections -> 123111321
};

smpars = {
    alphaEmMZ -> 1/127.916, (* SMINPUTS[1] *)
    GF -> 1.166378700*^-5,  (* SMINPUTS[2] *)
    alphaSMZ -> 0.1184,     (* SMINPUTS[3] *)
    MZ -> 91.1876,          (* SMINPUTS[4] *)
    mbmb -> 4.18,           (* SMINPUTS[5] *)
    Mt -> Mtpole,           (* SMINPUTS[6] *)
    Mtau -> 1.777,          (* SMINPUTS[7] *)
    Mv3 -> 0,               (* SMINPUTS[8] *)
    MW -> 80.385,           (* SMINPUTS[9] *)
    Me -> 0.000510998902,   (* SMINPUTS[11] *)
    Mv1 -> 0,               (* SMINPUTS[12] *)
    Mm -> 0.1056583715,     (* SMINPUTS[13] *)
    Mv2 -> 0,               (* SMINPUTS[14] *)
    md2GeV -> 0.00475,      (* SMINPUTS[21] *)
    mu2GeV -> 0.0024,       (* SMINPUTS[22] *)
    ms2GeV -> 0.104,        (* SMINPUTS[23] *)
    mcmc -> 1.27,           (* SMINPUTS[24] *)
    CKMTheta12 -> 0,
    CKMTheta13 -> 0,
    CKMTheta23 -> 0,
    CKMDelta -> 0,
    PMNSTheta12 -> 0,
    PMNSTheta13 -> 0,
    PMNSTheta23 -> 0,
    PMNSDelta -> 0,
    PMNSAlpha1 -> 0,
    PMNSAlpha2 -> 0,
    alphaEm0 -> 1/137.035999074,
    Mh -> 125.09
};

HSSUSYCalcMh[MS_, TB_, Xtt_] :=
    CalcHSSUSYDMh[
        fsSettings -> settings,
        fsSMParameters -> smpars,
        fsModelParameters -> {
            TanBeta -> TB,
            MEWSB -> Mtpole,
            MSUSY -> MS,
            M1Input -> MS,
            M2Input -> MS,
            M3Input -> MS,
            MuInput -> MS,
            mAInput -> MS,
            AtInput -> (Xtt + 1/TB) MS,
            AbInput -> 0,
            AtauInput -> 0,
            msq2 -> MS^2 IdentityMatrix[3],
            msu2 -> MS^2 IdentityMatrix[3],
            msd2 -> MS^2 IdentityMatrix[3],
            msl2 -> MS^2 IdentityMatrix[3],
            mse2 -> MS^2 IdentityMatrix[3],
            LambdaLoopOrder -> 3,
            TwoLoopAtAs -> 1,
            TwoLoopAbAs -> 1,
            TwoLoopAtAb -> 1,
            TwoLoopAtauAtau -> 1,
            TwoLoopAtAt -> 1,
            ThreeLoopAtAsAs -> 1
        }
   ];

NUHMSSMNoFVHimalayaCalcMh[MS_, TB_, Xtt_] :=
    CalcNUHMSSMNoFVHimalayaDMh[
        fsSettings -> settings,
        fsSMParameters -> smpars,
        fsModelParameters -> {
            TanBeta -> TB,
            Qin -> MS,
            M1 -> MS,
            M2 -> MS,
            M3 -> MS,
            AtIN -> MS/TB + Xtt MS,
            AbIN -> 0,
            AtauIN -> 0,
            AcIN -> 0,
            AsIN -> 0,
            AmuonIN -> 0,
            AuIN -> 0,
            AdIN -> 0,
            AeIN -> 0,
            MuIN -> MS,
            mA2IN -> MS^2,
            ml11IN -> MS,
            ml22IN -> MS,
            ml33IN -> MS,
            me11IN -> MS,
            me22IN -> MS,
            me33IN -> MS,
            mq11IN -> MS,
            mq22IN -> MS,
            mq33IN -> MS,
            mu11IN -> MS,
            mu22IN -> MS,
            mu33IN -> MS,
            md11IN -> MS,
            md22IN -> MS,
            md33IN -> MS
        }
   ];

Xtt = 0;
TBX = 5;

range = LogRange[500, 10^4, 100];

data = ParallelMap[
    { N[#],
      Sequence @@ NUHMSSMNoFVHimalayaCalcMh[#, TBX, Xtt],
      Sequence @@ HSSUSYCalcMh[#, TBX, Xtt] }&,
    range];
Export["FS_TB-5_Xt-0.dat", data];

Xtt = -Sqrt[6];
TBX = 5;

data = ParallelMap[
    { N[#],
      Sequence @@ NUHMSSMNoFVHimalayaCalcMh[#, TBX, Xtt],
      Sequence @@ HSSUSYCalcMh[#, TBX, Xtt] }&,
    range];
Export["FS_TB-5_Xt--sqrt6.dat", data];

Xtt = 0;
TBX = 10;

data = ParallelMap[
    { N[#],
      Sequence @@ NUHMSSMNoFVHimalayaCalcMh[#, TBX, Xtt],
      Sequence @@ HSSUSYCalcMh[#, TBX, Xtt] }&,
    range];
Export["FS_TB-10_Xt-0.dat", data];

Xtt = -Sqrt[6];
TBX = 10;

data = ParallelMap[
    { N[#],
      Sequence @@ NUHMSSMNoFVHimalayaCalcMh[#, TBX, Xtt],
      Sequence @@ HSSUSYCalcMh[#, TBX, Xtt] }&,
    range];
Export["FS_TB-10_Xt--sqrt6.dat", data];

Xtt = 0;
TBX = 20;

data = ParallelMap[
    { N[#],
      Sequence @@ NUHMSSMNoFVHimalayaCalcMh[#, TBX, Xtt],
      Sequence @@ HSSUSYCalcMh[#, TBX, Xtt] }&,
    range];
Export["FS_TB-20_Xt-0.dat", data];

Xtt = -Sqrt[6];
TBX = 20;

data = ParallelMap[
    { N[#],
      Sequence @@ NUHMSSMNoFVHimalayaCalcMh[#, TBX, Xtt],
      Sequence @@ HSSUSYCalcMh[#, TBX, Xtt] }&,
    range];
Export["FS_TB-20_Xt--sqrt6.dat", data];

Xtt = -Sqrt[6];
TBX = 30;

data = ParallelMap[
    { N[#],
      Sequence @@ NUHMSSMNoFVHimalayaCalcMh[#, TBX, Xtt],
      Sequence @@ HSSUSYCalcMh[#, TBX, Xtt] }&,
    range];
Export["FS_TB-30_Xt--sqrt6.dat", data];
