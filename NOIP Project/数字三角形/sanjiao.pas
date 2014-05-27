program sanjiao;
var
 f1,f2:text;
 n:longint;
 sj:array[1..255,1..255] of longint;
 procedure init;                                 {��������}
 var
 j,k:longint;
 begin
	assign(f1,'sanjiao.txt');
	reset(f1);
	readln(f1,n);
	for j:=1 to n do begin
		for k:=1 to j do begin
			 read(f1,sj[j,k]);
		end;
        readln(f1);
    end;
    close(f1);
end;

function max(a,b:longint):longint;     {������ֵ����}
begin
max:=b;
if a>max then max:=a;
end;

function work(j,k:longint):longint;         {��̬�滮}
begin
if j=n then work:=sj[j,k]
else work:=max(work(j+1,k),work(j+1,k+1))+sj[j,k];
end;

procedure prints;
begin
	assign(f2,'output.txt');
	rewrite(f2);
        writeln(f2,work(1,1));
        close(f2);
end;
begin
	init;
        prints;
		readln;
end.
