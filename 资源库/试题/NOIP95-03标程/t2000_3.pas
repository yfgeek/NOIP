program t2000_3(input,output);
const maxn=20;
type arr=array[1..maxn] of 0..2;
var
   h:string;{h�д洢��������Ŀ�ʼ�ַ�;}
   s:array[1..maxn] of string;{s[1..n]�洢�����n������}
   max,I,j,n,total:integer;{max��󳤶ȣ�total��ĳ�����ʿ�ʼ����󳤶�;n���ʸ���}
   ad:array[1..maxn,1..maxn] of integer;
   count:arr;   {ÿ��������ʹ�õ����������Ϊ2}

function addition(I,j:integer):integer;{����s[I]�����s[j]�������ӵĳ���}
var Li,Lj,tj:integer;{Li����s[I]�ĳ��ȣ�Lj����s[j]�ĳ��ȣ�tj����s[I]�����һ���ַ���ͬ�ģ�����s[j]�е��ַ�λ�ã�}
     hi,hj:integer;{hi����s[I]�е�ָ�룬�����һ��λ�ó�ǰ��hj����s[j]�е�ָ�룬��tjλ�ó�ǰ}
     find:boolean;{findΪtrue���ҵ�ƥ��}
begin
    Li:=length(s[I]);Lj:=length(s[j]);
    tj:=1;find:=false;
    while (tj<Lj) and (tj<Li) and not find do begin{tj=Liʱ�����ܳ��ְ�����ϵ}
        while (tj<Lj) and (tj<Li) and (s[I][Li]<>s[j][tj]) do
                      tj:=tj+1;
        if (tj<Lj) and (tj<Li) then begin
            hj:=tj;hi:=Li;
            while (hj>0) and (s[I][hi]=s[j][hj]) do begin
                  hi:=hi-1;
                  hj:=hj-1;
            end;
            if hj=0 then find:=true{��s[j]�ӵ�tj������1������s[I]������ֵͬ����s[I]�ɽ�s[j]}
               else tj:=tj+1;{׼��Ѱ����һ����s[I]���һ���ַ���ͬ��tjλ��}
        end;
   end;
   if find then addition:=Lj-tj{������}
       else addition:=0;
end;

function try(count:arr;i:integer):integer;
var total,max,j:integer;
begin
   max:=0;
   for j:=1 to n do
   if (count[j]<2) and (ad[i,j]<>0) then begin
      count[j]:=count[j]+1;
      total:=try(count,j)+ad[i,j];
      if max<total then max:=total;
      count[j]:=count[j]-1;
   end;
   try:=max;
end;

begin
    assIgn(input,'4.in');reset(input);
    readln(n);
    for I:=1 to n do readln(s[I]);
    readln(h);
    close(input);
    for I:=1 to n do
      for j:=1 to n do ad[I,j]:=addition(I,j);
    max:=0;
    for I:=1 to n do begin
       for j:=1 to n do count[j]:=0;
       count[i]:=1;
       if s[I][1]=h[1] then begin
            total:=try(count,i)+length(s[i]);
            if max<total then max:=total;end;
    end;
    assign(output,'4.out');
    rewrite(output);
    writeln(max);
    close(output);
end.
