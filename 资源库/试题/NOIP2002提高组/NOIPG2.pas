{$A-,B-,D-,E-,F-,G-,I-,L-,N-,O-,P-,Q-,R-,S-,T-,V-,X-,Y-}
{$M 8192,0,655360}
program NOIPG2;
  const maxn=2300;
  type
    node=record{����ڵ���������}
           str:string[115];dep:byte;
         end; {str��ʾ�ִ����䳤�Ȳ��ᳬ��115�����ȳ���115���ִ�
     ������ͨ���任��ΪĿ���ִ�����Ϊ��Ŀ�޶��任10��֮�ڣ��Ҵ���
     ������20������ʼ�����ɾ���5�α任ʱ�������м䴮����󳤶�
     Ϊ20+5*19=115�����򾭹����µĲ��������ܱ�Ϊ���Ȳ�����20��
     Ŀ�괮����dep��ʾ���}
    ctype=array[1..maxn]of ^node;
    bin=0..1;
  var
    maxk:byte;c:array [0..1]of ctype;
    x0:array[0..6,0..1]of string[20];
    filename:string;
    open,closed:array [0..1] of integer;
  procedure Init;{��ȡ���ݣ���ʼ��}
    var f:text;temp:string;i,j:integer;
    begin
      for i:=0 to 1 do
        for j:=1 to maxn do new(c[i,j]);
      write('Input filename:');readln(filename);
      assign(f,filename);reset(f);i:=0;
      while not eof(f) and (i<=6) do begin
        readln(f,temp);
        x0[i,0]:=copy(temp,1,pos(' ',temp)-1);
        x0[i,1]:=copy(temp,pos(' ',temp)+1,length(temp));
        inc(i);
      end;
      maxk:=i-1;close(f);
    end;
  procedure calc;
    var i,j,k:integer;st:bin;
        d:string;f:text;
    procedure bool(st:bin);{�ж��Ƿ񵽴�Ŀ��״̬��˫����������}
      var i:integer;
      begin
        if x0[0,1-st]=c[st,closed[st]]^.str then begin
          {�������Ŀ��״̬�������������˳�}
          writeln(c[st,closed[st]]^.dep);
          halt;
        end;
        for i:=1 to closed[1-st] do
          if c[st,closed[st]]^.str=c[1-st,i]^.str then begin
            {���˫���������������õ�ͬһ�ڵ㣩��
             ����������2�����������Ĳ���֮�ͣ����˳�}
            writeln(c[st,closed[st]]^.dep+c[1-st,i]^.dep);
            halt;
          end;
      end;
    procedure checkup(st:bin);{�жϽڵ��Ƿ���ǰ���ظ�}
      var i:integer;
      begin
        for i:=1 to closed[st]-1 do
          if c[st,i]^.str=c[st,closed[st]]^.str then begin
            dec(closed[st]);exit;{����ڵ��ظ�����ɾ�����ڵ�}
          end;
        bool(st);{����ڵ㲻�ظ������ж��Ƿ񵽴�Ŀ��״̬}
      end;
    procedure expand(st:bin);{��չ�����½ڵ�}
      var i,j,k,lx,ld:integer;
      begin
        inc(open[st]);d:=c[st,open[st]]^.str;{���׽ڵ����}
        k:=c[st,open[st]]^.dep;ld:=length(d);
        for i:=1 to maxk do begin
          {�Ӷ��׽ڵ㣨���ڵ㣩���������½ڵ㣨�ӽڵ㣩}
          lx:=length(x0[i,st]);
          for j:=1 to ld do begin
            if (copy(d,j,lx)=x0[i,st]) and (length(copy(d,1,j-1)+x0[i,1-st]
               +copy(d,j+lx,ld))<=115) then begin
            {����½ڵ�Ĵ�������115������չ����������֦}
              if closed[st]>=maxn then exit;{�������������ֻ���˳�}
              inc(closed[st]);{�½ڵ����}
              c[st,closed[st]]^.str:=copy(d,1,j-1)+x0[i,1-st]+copy(d,j+lx,ld);
              c[st,closed[st]]^.dep:=k+1;{�ӽڵ����=���ڵ����+1}
              checkup(st);{����½ڵ��Ƿ��ظ�}
            end;
          end;
        end;
      end;
    Begin
      for st:=0 to 1 do begin{����(st=0)����(st=1)�����ڵ���г�ʼ��}
        open[st]:=0;closed[st]:=1;
        c[st,closed[st]]^.str:=x0[0,st];c[st,closed[st]]^.dep:=0;
        bool(st);
      end;
      repeat
        {ѡ��ڵ��������Ҷ���δ�ա�δ�������δ�ﵽ10�ķ�������չ}
        if (open[0]<=open[1]) and not ((open[0]>=closed[0]) or
          (closed[0]>=maxn) or (c[0,closed[0]]^.dep>10)) then expand(0);
        if (open[1]<=open[0]) and not ((open[1]>=closed[1]) or
          (closed[1]>=maxn) or (c[1,closed[1]]^.dep>10)) then expand(1);
       {���һ��������ֹ��������һ����������ֱ������������ֹ}
       if not ((open[0]>=closed[0]) or (closed[0]>=maxn) or
          (c[0,closed[0]]^.dep>10)) then expand(0);
        if not ((open[1]>=closed[1]) or (closed[1]>=maxn) or
          (c[1,closed[1]]^.dep>10)) then expand(1);
      until (open[0]>=closed[0]) or (c[0,closed[0]]^.dep>10) or (closed[0]>=maxn)
          and (closed[1]>=maxn) or (open[1]>=closed[1]) or (c[1,closed[1]]^.dep>10);
       {��ֹ��������һ���ӿգ��޽⣩��������ȳ���10��10�����޽⣩
        ��˫��������������н�Ҳ�����޽⣬Ӧ�������⣬Ҫ�����ѽ�
        �����鿪��һ�㣬����˫����������ȡ��֦��ʩ�ȣ�}
    End;
  BEGIN
    init; calc; writeln('NO ANSWER!')
  END.