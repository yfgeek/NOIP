Const
   Fin='City.Inp';				{�����ļ���}
   Fou='City.Out';				{����ļ���}
   Big=1000000;					{����ֵ}

Type
   Maps=array[1..50,1..50] of Real;		{��ͼ���Ͷ���}

Var
  Map:^maps;					{���е�ͼ}
  Val:array[0..10] of ^maps;			{�޸���K���ߺ�ľ����б�}
  F:text;					{�ļ�˵��}
  Way:array[0..10,1..50,1..50,1..2] of byte;	{��ӡ����õļ�¼�仯������}
  N,M:integer;

  Procedure  Init;				{��ʼ�����̣���������}
  Var
      i,j:integer;
    Begin
       assign(f,fin);
       Reset(f);
         ReadlN(f,n,m);
         new(map);
         For i:=1 to n do
          Begin
            for j:=1 to n do
               read(f,map^[i,j]);
            readln(f);
          end;
       CLose(f);
    end;

  Procedure main;				{Ӧ�á���̬�滮���㷨���Ĺ���}
  Var
    i,j,k,p,q:integer;
    R:real;
    Begin
      R:=1;
      Fillchar(way,sizeof(way),0);
      New(Val[0]);
      val[0]^:=map^;

      For k:=1 to n do				{��̬�滮�����ʼ��}
       for i:=1 to n do
        if val[0]^[i,k]>0 then
        for j:=1 to n do
          if (Val[0]^[k,j]>0) and (i<>j) then
           if (val[0]^[i,j]=0) or (Val[0]^[i,j]>Val[0]^[i,k]+Val[0]^[k,j]) then
            begin
              Val[0]^[i,j]:=Val[0]^[i,k]+Val[0]^[k,j];
              Way[0][i,j,1]:=0;
              Way[0][i,j,2]:=k;
            end;

      For p:=1 to m do
        Begin
          new(val[p]);				{��Ľ�P���ߺ�����ž����б�}
          For i:=1 to n do			{��һ�����޸�P�κ�ľ���}
            for j:=1 to n do
              map^[i,j]:=map^[i,j]/2;

          Val[p]^:=map^;			{��ʼ��}

          For k:=1 to n do			{����Folyd�㷨���}
           for i:=1 to n do
           if Val[0]^[i,k]>0 then
            for j:=1 to n do
            if (Val[0]^[k,j]>0) and (i<>j)then
              Begin
                  For q:=1 to p-1 do		{��̬�滮���̣�ѡȡ���ŵ��޸ķ���}
                    if (Val[p]^[i,j]=0) or  (Val[p]^[i,j]>Val[q]^[i,k]+Val[p-q]^[k,j]) then
                     Begin
                       Val[p]^[i,j]:=Val[q]^[i,k]+Val[p-q]^[k,j];
                       way[p,i,j,1]:=q;
                       way[p,i,j,2]:=k;
                     end;

                   if Val[p]^[k,j]>0 then
                     if (val[p]^[i,j]=0) or (Val[p]^[i,j]>Val[0]^[i,k]+Val[p]^[k,j]) then
                       Begin
                          Val[p]^[i,j]:=Val[0]^[i,k]+Val[p]^[k,j];
                          way[p,i,j,1]:=0;
                          way[p,i,j,2]:=k;
                       end;
                   if Val[p]^[i,k]>0 then
                     if (val[p]^[i,j]=0) or (Val[p]^[i,j]>Val[p]^[i,k]+Val[0]^[k,j]) then
                       Begin
                          Val[p]^[i,j]:=Val[p]^[i,k]+Val[0]^[k,j];
                          way[p,i,j,1]:=p;
                          way[p,i,j,2]:=k;
                       End;
              End;
        End;
    End;

 Procedure Print;			{������}
      Procedure Pr(l,r,k:integer);	{���õݹ鷽ʽ������}
        Var
          i:integer;
          Begin
            if way[k,l,r,2]=0 then
              Begin
                for i:=1 to k do
                  writelN(f,l,' ',r);
              end
             Else
               begin
                  pr(l,way[k,l,r,2],way[k,l,r,1]);
                  pr(way[k,l,r,2],r,k-way[k,l,r,1]);
               end;
          end;
   Begin
      assign(f,fou);
      rewrite(f);
        writeln(f,Val[m]^[1,n]:0:2);
        Pr(1,n,m);
      Close(f);
   End;

Begin	{������}
   Init;	{��������}
   Main;	{���}
   Print;	{�������}
End.