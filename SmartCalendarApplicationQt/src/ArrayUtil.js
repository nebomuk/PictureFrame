.pragma library

function range(start, stop){
   if(start >= stop)
   {
       return [];
   }

  var a=[start], b=start;
  while(b<stop){b+=1;a.push(b)}
  return a;
}

function sortNumber(a,b) {
    return a - b;
}
