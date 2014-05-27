program bag1;
type            {定义背包}
 bag=record
  number:integer;
  weight:integer;
  value:integer;
  ratio:real;
end;
 
var
bags:array[0..255] of bag;
best,search:array[1..255] of 0..1;
sumvalue,sumweight,max:integer;
nnn,www,maxvalue,k:integer;
procedure work(a,b:integer);   {主要}
begin
 search[a]:=b;
 sumweight:=sumweight +bags[a].weight*b ;
 if sumweight<=www then begin
  sumvalue:=sumweight+bags[a].value*b;
  if a=nnn then
   begin
    best:=search;
    maxvalue:=sumvalue;
   end
  else begin
   if sumvalue+bag[a+1].ratio*(www-sumweight)>maxvalue then
    begin
     work(a+1,0);
     work(a+1,1);
    end;
   end;
   sumvalue:=sumvalue-bag[a].value*b;
   end;
  sumweight:=weithgt-bag[a].weight*b
 end;
procedure swap(var num1,num2:integer);      {交换}
var
 tmp:integer;
begin
 tmp:=num1;
 num1:=num2;
 num2:=tmp;
end;
procedure init;   {读入数据}
begin
assign(input,'input.txt');
reset(input);
for k:=1 to 10 do
read(bags[k]);
close(input);
end;

procedure print;     {输出结果}
begin
assign(output,'output.txt');
rewrite(output);
for k:=1 to 10 do
write(a[k],' ');
close(output);
end;

procedure sort(left,right:integer); {排序}
var
mid,i,j:integer;
begin
i:=left;
j:=right;
mid:=a[(left+right) div 2] ;
repeat
 while a[i]<mid do inc(i);
 while a[j]>mid do dec(j);
 if i<=j then
  begin
   swap(a[i],a[j]);
   inc(i);
   dec(j);
  end;
 if i<right then sort(i,right);
 if j>left then sort(left,j);
until i>j;
end;
begin              {主程序}
  init;
  sort(1,10);
  print;
end.
