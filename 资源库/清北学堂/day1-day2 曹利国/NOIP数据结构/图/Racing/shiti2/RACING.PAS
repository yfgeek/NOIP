{$A+,B-,D+,E+,F-,G+,I-,L+,N-,O-,P-,Q-,R-,S-,T-,V+,X+}
{$M 1024,0,655360}
{为方便操作，程序中的坐标与题目的坐标稍有不同，题目中的(x,y)在程序中为(x-1,y-1)}
const maxn=100;         	{赛场的最大长度和宽度}
      st1='input.txt';		{输入文件名}
      st2='output.txt';		{输出文件名}
      b:array[1..4,1..2] of integer=((1,0),(0,1),(0,-1),(-1,0));
type node=record
                next,pred:word;
     end;
     arr1=array[0..maxn*maxn] of node;
     arr2=array[0..maxn-1,0..maxn-1] of word;
var a:array[-2..maxn+1,-2..maxn+1] of byte;	{记录赛场的信息，1表示赛道，0表示障碍物}
    max:array[1..4,0..maxn,0..maxn] of byte;	
    {max[i,x,y]表示从(x,y)出发，沿i方向可前进的最多步数(遇到障碍物终止)}
    dist:array[1..4] of ^arr2;
    {dist[i,x,y]表示上一步沿方向i到达(x,y)的从终点出发的最短路径长度}
    p:array[1..4] of ^arr1;
    {p[i,x,y]记录其对应结点(i,x,y)的前驱结点(pred)和后继结点(next)，
     其前驱结点为(pred div 10000,pred mod 10000 div 100,pred mod 100),
     其后继结点为(next div 10000,next mod 10000 div 100,next mod 100)}
    h:array[0..maxn] of word; 	{链表的头指针，h[i]对应时间time+i}
    time,min,x1,x2,y1,y2,n,m:longint;
    {time为当前时间，即当前的最短路径长度}
    {min为当前的选手反应时间}
    f:text;

procedure readp;	{读入文件并做初步的处理}
var i,j,k,l,x,y:integer;
begin
     for i:=1 to 4 do begin
         new(p[i]);new(dist[i]);
     end;
     assign(f,st1);reset(f);
     read(f,n,m,x1,y1,x2,y2);
     for i:=0 to n-1 do
         for j:=0 to m-1 do
             read(f,a[i,j]);
     dec(x1);dec(y1);dec(x2);dec(y2);
     close(f);
     {求max数组的值}
     for i:=-1 to n do
         for j:=-1 to m do
             if a[i,j]=0 then
                for k:=1 to 4 do begin
                    l:=0;x:=i+b[k,1];y:=j+b[k,2];
                    while a[x,y]=1 do begin
                          max[5-k,x,y]:=l;
                          inc(x,b[k,1]);inc(y,b[k,2]);inc(l);
                    end;
                end;
end;

procedure main;		{求选手反应时间为min时的最短路径}
var step,o,i,j,k,l,x,y,d,bx,by:word;
    can:boolean;   {是否可能存在从起点到终点的路径}
begin
     {各数组进行初始化}
     fillchar(h,sizeof(h),0);
     for i:=1 to 4 do begin
         fillchar(p[i]^,sizeof(arr1),0);
         fillchar(dist[i]^,sizeof(arr2),255);
     end;
     {将题目中的终点在求解时设为起点}
     h[0]:=(x2*100+y2)+10000;
     with p[1]^[x2*100+y2] do begin
          pred:=0;next:=(x2*100+y2)+20000;
     end;
     with p[2]^[x2*100+y2] do begin
          pred:=(x2*100+y2)+10000;next:=(x2*100+y2)+30000;
     end;
     with p[3]^[x2*100+y2] do begin
          pred:=(x2*100+y2)+20000;next:=(x2*100+y2)+40000;
     end;
     with p[4]^[x2*100+y2] do begin
          pred:=(x2*100+y2)+30000;next:=0;
     end;
     dist[1]^[x2,y2]:=0;dist[2]^[x2,y2]:=0;
     dist[3]^[x2,y2]:=0;dist[4]^[x2,y2]:=0;
     time:=0;can:=true;
     while can do begin
           i:=h[0];
           while i<>0 do begin
                 d:=i div 10000;x:=(i mod 10000) div 100;y:=i mod 100;
                 if (x=x1) and (y=y1) then begin
                    writeln(f,min,' ',time);exit   {到达了起点，输出最短路径}
                 end;
                 for o:=1 to 4 do begin   {沿四个方向对路径进行扩展}
                     if o=d then step:=1 else step:=min;  {确定最少需要移动的步数}
                     if max[o,x,y]<step then continue;    {判断中间是否存在障碍物}
                     bx:=step*b[o,1];by:=step*b[o,2];
                     if dist[d]^[x,y]+step<dist[o]^[x+bx,y+by] then begin
			{得到一条到(o,x+bx,y+by)距离更短的路径}
                        j:=(x+bx)*100+y+by;
                        if dist[o]^[x+bx,y+by]<>65535 then begin
			   {处理该结点已在某个链表中的情况，即从其所在链表中删除该结点}
                           k:=p[o]^[j].pred;l:=p[o]^[j].next;
                           if k=0 then begin
                              h[dist[o]^[x+bx,y+by]-time]:=l;
                              if l<>0 then
                                 p[l div 10000]^[l mod 10000].pred:=0;
                           end
                           else begin
                                     p[k div 10000]^[k mod 10000].next:=l;
                                     if l<>0 then
                                        p[l div 10000]^[l mod 10000].pred:=k;
                                end;
                        end;
			{将结点添加到时间为time+step的链表中}
                        with p[o]^[j] do begin
                             next:=h[step];pred:=0;
                        end;
                        k:=p[o]^[j].next;
                        if k<>0 then
                           p[k div 10000]^[k mod 10000].pred:=j+o*10000;
                        dist[o]^[x+bx,y+by]:=dist[d]^[x,y]+step;
                        h[step]:=j+o*10000;
                     end;
                 end;
                 i:=p[d]^[i mod 10000].next;
           end;
           inc(time);   {时间加1}
           can:=false;
           for i:=0 to min-1 do begin
               h[i]:=h[i+1];
               if h[i]<>0 then can:=true;
           end;
	   {如果在接下来的min秒内没有可扩展的路径，就表示选手的反应时间
	   大于或等于min时，必然不存在从起点到终点的路径}
           h[min]:=0;
     end;
     close(f);
     halt;  {无法找到路径，直接结束程序}
end;

begin
     readp;
     assign(f,st2);rewrite(f);
     min:=1;
     repeat
           main;
           inc(min);   {选手的反应时间加1}
     until min>10;
     close(f);
end.