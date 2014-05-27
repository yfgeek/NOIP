program BigY;
const
 data='data.txt';
 history='history.txt';
 setting='setting.txt';
var
 f1,f2,f3,f4,f5,f6,f7:text;
 oua,oub:string;
 s,name:string;
 j:integer;
  procedure delhistory;
begin
 assign(f6,history);
 rewrite(f6);
 close(f6);
end;

procedure setit(na:string;qr:integer;qk:integer);
var
 yn:char;
begin
 if qk<>-1 then begin
  assign(f5,setting);
  rewrite(f5);
  writeln(f5,na);
  writeln(qr);
  end
 else begin
  write('确认要清空',na,'的聊天记录吗？ ');
  readln(yn);
 end;
  if yn='Y' then delhistory
  else exit;
end;
procedure readset;
var
 na1:string;
 qr1:integer;
begin
 assign(f7,setting);
 reset(f7);
 readln(f7,name);
 if name='' then begin
  write('您的名字：');
  readln(na1);
  write('历史记录显示次数：');
  read(qr1);
  close(f7);
  setit(na1,qr1,0);
 end;
 readln(f7,j);
 close(f7);
end;
procedure shwh(i:integer);
var
 q,n:integer;
begin
 q:=1;
 n:=1;
 assign(f4,history);
 reset(f4);
 while not eof(f4) do begin
  inc(n);
  readln(oua,oub);
 end;
 j:=n-i;
 while not eof(f4) do begin
  inc(q);
  if q>=j then
   writeln(oua,' ',oub);
 end;
 writeln('----------------以上为最近',i,'次的聊天记录------------------');
end;

procedure learn(a,b:string);
begin
 assign(f1,data);
 append(f1);
 writeln(f1);
 writeln(f1,a,b);
 close(f1);
end;
procedure histroyit(a,b:string);
begin
 assign(f2,data);
 append(f2);
 writeln(f2);
 writeln(f2,a,'大Y：',b);
 close(f2);
end;
procedure search(m:string);
begin
 assign(f3,data);
 reset(f3);
 while not eof(f3) do begin
  readln(oua,oub);
  if m='delhistroy' then begin
   setit(name,j,-1);
   exit;
  end;
  if oua=m then begin
   writeln(oub);
   histroyit(oua,oub);
   close(f3);
   exit;
  end
  else begin
   writeln('我的词库里没有你说的话，请输入回答：');
   readln(s);
   learn(m,s);
   close(f3);
   exit;
  end;
end;

begin
 readset;
 shwh(j);
 writeln('我们开始聊天吧！');
 readln(s);
 while s<>'exit' do begin
  search(s);
  readln(s);
 end;
 writeln('好吧，再见！');
 
end.

  

