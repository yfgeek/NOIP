procedure Prim(n: integer; w: TGraph; var low: TArrOfInt);
var
  InSetT: array[1..MaxN]of boolean;
  i,j,k,min: integer;
begin 
  {初始化}
  fillchar(InSetT,sizeof(InSetT),true); 
  InSetT[1]:=false;  // 初始时所有节点除了节点1都在T集合中
  low[1]:=0;
  for i:=2 to n do low[i]:=1; // 初始时T集合中所有节点的low值都是1
  {开始寻找}
  for i:=1 to n-1 do begin 
    j:=0;          // j用于记录权最小的边连接的T集合中的节点
    min:=Maxint;   // min用于记录最小的边的权
    for k:=1 to n do 
      if (InSetT[k]) and (w[low[k],k]<min) then begin 
        min:=w[low[k],k];
        j:=k;
      end;
    InSetT[j]:=false;  // 把选出的节点转移至S集合中
    for k:=1 to n do   // 维护low数组
      if w[j,k]<w[low[k],k] then low[k]:=j;
  end;
end;