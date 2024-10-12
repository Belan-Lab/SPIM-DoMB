// based on https://www.davidpilling.com/wiki/index.php/XYP

//Disable $fn and $fa, do not change these
$fn=0;
$fa=0.01;
$fs=0.5;

motorthrow=61;
bearingdistance=80;



//basey=motorthrow+bearingdistance;

baset=2;
basemidx=28;

basecornery=8;
basecornert=8;
basecornerfromtop=3;
basecornerfromside=5;


basey=150+basecornery*2;

raild=3.3;

boltd=3;


motorshift=52;

motorsupportd=6;
motorsupporth=10;   
motorholed=2;
motorholeh=10;   


module motorbase(sd,sh)
{
 
 translate([14,-1,0])cube([5,12,baset]);
    
 cylinder(d=sd,h=sh);
 translate([0.5,10,0])cylinder(d=sd,h=sh);    
 translate([-5-0.5,10,0])cylinder(d=sd,h=sh);    
    
 translate([-57,0,0])cylinder(d=sd,h=sh);    
    
 translate([-57-5-0.5,0,0])cylinder(d=sd,h=sh);    

}











module motorbasemaker()
{
union()
{
    
 difference()
 {
  union()
  {
   cube([basemidx,basey,baset]);
      
   translate([0,baset,baset])cube([basemidx,basecornery,basecornert]);
      
   translate([0,baset+basecornery,baset])cube([basecornert,basecornery,basecornert]);
      
   translate([0,baset,baset+basecornery])cube([basecornert,basecornery,basecornert]);
      

   translate([basemidx-8+1.5,basey-motorshift,0])rotate([0,0,90])motorbase(motorsupportd,motorsupporth);
  }
  
  translate([basemidx-8+1.5,basey-motorshift,0])rotate([0,0,90])motorbase(motorholed,motorholeh);


// chamfer
  
  rotate([45,0,0])cube([basemidx,1.4*baset,1.4*baset]);
  
  translate([0,basey,0])rotate([45,0,0])cube([basemidx,1.4*baset,1.4*baset]);  
  
// hole to hold together  
  
  translate([basemidx/2,basey-baset-basecornery/2,0])cylinder(h=baset+basecornery,d=boltd);
  

  translate([basemidx/2,baset+basecornery,baset+basecornery/2])rotate([90,0,0])cylinder(h=baset+basecornery,d=boltd);

// rail holes

   translate([basecornerfromtop,basecornerfromside+baset,basecornery])cylinder(d=raild,h=basecornery+baset);

   translate([basecornerfromtop,2*basecornery+baset,basecornerfromside+baset])rotate([90,0,0])cylinder(d=raild,h=basecornery+baset);


  
 }
}
}

motorbasemaker();

