/*********************************************
 * OPL 12.9.0.0 Model
 * Author: Zhifeng Guo
 * Creation Date: 19 May 2022 at 19:34:07
 *********************************************/

//number of clusters;
int k = ...;

//percentage of points involved in clustering;
float p=...;

//number of samples;
int n=1000;

//index of points;
range I=1..1000;

//index of cluster candidate;
range J=1..1000;


//index of high income household;
{int} H1= ...;

//index of middle income household;
{int} M1 = ...;

//index of low income household;
{int} L1=...;

//distance matrix betwenn point i and j;
float Distance[I][J] = ...;

//boolean variable q[j], point j is selected as cluster center if q[j]==1;
dvar boolean q[J];

//boolean variable z[i], point i is involved in cluster process if z[i]==1;
dvar boolean z[I];

//boolean variable w[i][j], ponit i belong to point j if w[i][j]==1
dvar boolean w[I][J];


//set objective function, which minimize all pairs of distance between point i and cluster j
minimize
  sum( i in I , j in J )  w[i][j]*Distance[i][j];

//subject to 5 constraints
subject to {
  //constraint 1: w[i][j]<=q[j], which indicates if point j is not a cluster center(q[j]==0), no point will belong to it(w[i][j]==0)
  forall( i in I, j in J ){
      w[i][j]<=q[j];
      }
 
  //constraint 2: total k points are selected as cluster center.
  sum( j in J )  q[j] == k;

  //constraint 3: if point i is not involed in cluster process(z[i]==0), this point will not belong to any cluster center j(w[i][j]==0). 
  forall( i in I ){
    sum( j in J )  w[i][j] == z[i];
    }
      
  //constraint 4: total points involved in cluster process is p*n
  sum( i in I ) z[i] == p*n;
  
  //constraint 5: must-not link, do not allow high income household and low income household to be the same cluster. 
  forall( i1 in H1, i2 in L1, j in J ){
    w[i1][j]+w[i2][j]<=q[j];
    }
      
  //constraint 6: must-not link,  do not allow middle income household and low income household to be the same cluster 
//  forall( i1 in M1, i2 in L1, j in J ){
//    w[i1][j]+w[i2][j]<=q[j];
//   } 
     
 }       
           
 