Generalised assignment problem
 There are 16 data files.
  
 The first 12 data files are gap1, gap2, ..., gap12.
  
 The problems in these data files were used in:

      I.H. Osman, "Heuristics for the Generalised Assignment Problem:
      Simulated Annealing and Tabu Search Approaches", OR Spektrum, Volume
      17, 211-225, 1995

      D. Cattrysse, M. Salomon and L.N. Van Wassenhove, "A
      set partitioning heuristic for the generalized
      assignment problem", European Journal of Operational Research, Volume
      72, 167-174, 1994

 The format for each of these data files is:
  
 number of different problem sets (P)
 for each problem set p (p=1,...,P) in turn:
 number of agents (m), number of jobs (n)
 for each agent i (i=1,...,m) in turn:
     cost of allocating job j to agent i (j=1,...,n)
 for each agent i (i=1,...,m) in turn:
     resource consumed in allocating job j to agent i (j=1,...,n)
 resource capacity of agent i (i=1,...,m)
  
 The problems in each data file have an associated notation as
 follows:
  
 c515-1    :    denotes a problem of type c with 5-agents and
                15-jobs, problem number 1 in a group of
                problems of the same size.
  
 The optimal solution values are given below for these 
 problems when solved as maximisation problems.

  
 gap1           gap2           gap3           gap4
 c515-1  336    c520-1  434    c525-1  580    c530-1  656
 c515-2  327    c520-2  436    c525-2  564    c530-2  644
 c515-3  339    c520-3  420    c525-3  573    c530-3  673
 c515-4  341    c520-4  419    c525-4  570    c530-4  647
 c515-5  326    c520-5  428    c525-5  564    c530-5  664
  
 gap5           gap6           gap7           gap8
 c824-1  563    c832-1  761    c840-1  942    c848-1  1133
 c824-2  558    c832-2  759    c840-2  949    c848-2  1134
 c824-3  564    c832-3  758    c840-3  968    c848-3  1141
 c824-4  568    c832-4  752    c840-4  945    c848-4  1117
 c824-5  559    c832-5  747    c840-5  951    c848-5  1127
  
 gap9            gap10           gap11           gap12
 c1030-1  709    c1040-1  958    c1050-1  1139   c1060-1  1451
 c1030-2  717    c1040-2  963    c1050-2  1178   c1060-2  1449
 c1030-3  712    c1040-3  960    c1050-3  1195   c1060-3  1433
 c1030-4  723    c1040-4  947    c1050-4  1171   c1060-4  1447
 c1030-5  706    c1040-5  947    c1050-5  1171   c1060-5  1446

The largest file is gap12 of size 20Kb (approximately).



The final four data files are gapa, gapb, gapc and gapd.

The problems in these data files were used in:
P C Chu and J E Beasley "A genetic algorithm for the generalised
assignment problem", Computers and Operations Research, Volume 24,
pages 17-23, 1997.

The format of these data files is as given above.

File gapa contains type A problems 
File gapb contains type B problems
File gapc contains type C problems
File gapd contains type D problems

The problems in these files are minimisation problems.

The largest file is gapd of size 67Kb (approximately).

The entire set of 16 files is of size 400Kb (approximately).