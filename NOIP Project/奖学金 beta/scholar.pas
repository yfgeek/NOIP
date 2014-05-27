program scholar;
type
 stu=record
  name:string;
  ascroe:integer;
  cscroe:integer;
  gb:boolean;
  xb:boolean;
  num:integer;
 end;

var
 f1,f2:text;
 i,n,m:integer;
 stt:array[1..100] of string;
 stus:array[1..100] of ;
 temp:string;
 nn,l,ok,j:integer;
procedure init;
begin
assign(f1,'scholar.in');
reset(f1);
readln(f1,n);
for i:=1 to n do
 begin
  readln(f1,stt[i]);
 end;
close(f1);
end;
procedure dot;
begin
 for i:=1 to n do
 begin
  temp:=stt[i];
  nn:=length(temp);
  j:=1;
  l:=pos(' ',temp);
  stus[i].name:=copy(temp,1,l-1);   //读入姓名
  temp:=copy(temp,l+1,nn);
  l:=pos(' ',temp);
  val(copy(temp,1,l-1),stus[i].ascroe,ok); //读入期末平均成绩
  temp:=copy(temp,l+1,nn);
  l:=pos(' ',temp);
  val(copy(temp,1,l-1),stus[i].cscroe,ok); //读入班级评议分数
  temp:=copy(temp,l+1,nn);
  l:=pos(' ',temp);
  if temp[1]='Y'  then stus[i].gb:=true else
  stus[i].gb:=false;                                       //是否是干部
  if temp[l+1]='Y' then stus[i].xb:=true else
  stus[i].xb:=false;                                       //是否是西部学生
  temp:=copy(temp,l+2,nn-1);
  val(temp,stus[i].num,ok);                               //读入写过的论文数
  inc(j);
 end;
 end;

procedure work;
var

begin

end;
procedure retest;
begin
assign(f2,'out.txt');
rewrite(f2);
for i:=1 to n do begin
 writeln(f2,stus[i].name,' ',stus[i].ascroe,'->>',stus[i].cscroe,'->>',stus[i].num);
 if stus[i].gb then writeln(f2,'T');
 if stus[i].xb then writeln(f2,'T');
 writeln(f2,' ')
end;
close(f2);
end;

begin
init;
dot;
retest;
end.



