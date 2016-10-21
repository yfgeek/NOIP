{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S-,T-,V+,X+,Y+}
{$M 65520,0,655360}
program NOIPG4;
  const maxn=50;maxk=3;
  type  rect=record{����"����"��������}
          l,r,t,b:word;{���ε���ߣ��ұߣ��±ߣ��ϱ߾�������ľ���}
        end;
        vxy=record{����"��"��������}
          x,y:word;{��ĺᡢ������}
        end;
  var ju:array[1..maxk]of rect;
      v:array[1..maxn,0..2] of vxy;v0:vxy;
      n,k,i,j,ii,jj:byte;f:text;filename:string;
      Smin,temp:longint;
  function intersect(jui,juj:rect):boolean;{�ж��������Ƿ��й�����}
    var b1,b2,t1,t2,l1,l2,r1,r2:word;
    begin
      b1:=jui.b;b2:=juj.b;t1:=jui.t;t2:=juj.t;
      l1:=jui.l;l2:=juj.l;r1:=jui.r;r2:=juj.r;
      intersect:=((l2<=r1) and (l2>=l1) or (r2<=r1) and (r2>=l1) or (l2<=l1)
           and (r2>=r1)) and ((t2<=b1) and (t2>=t1) or (b2<=b1) and (b2>=t1)
           or (b2>=b1) and (t2<=t1));
    end;
  function area(ju:rect):longint;{����ε����}
    var temp:longint;
    begin
      temp:=ju.b-ju.t;
      area:=temp*(ju.r-ju.l);
    end;
  procedure insert(v:vxy;var ju:rect);{����������}
    begin
      if v.x<ju.l then ju.l:=v.x;
      if v.x>ju.r then ju.r:=v.x;
      if v.y<ju.t then ju.t:=v.y;
      if v.y>ju.b then ju.b:=v.y;
    end;
  procedure init;{��ʼ��}
    begin
      write('Input filename:');readln(filename);
      assign(f,filename);reset(f);readln(f,n,k);
      for i:=1 to n do begin
        read(f,v[i,0].x,v[i,0].y);
        v[i,1].x:=v[i,0].x;v[i,1].y:=v[i,0].y;
      end;
      for i:=1 to n-1 do{���������������и��㣬����v[i,0]}
        for j:=i+1 to n do
          if v[i,0].x>v[j,0].x then begin
            v0:=v[i,0];v[i,0]:=v[j,0];v[j,0]:=v0;
          end;
      for i:=1 to n-1 do{���������������и��㣬����v[i,1]}
        for j:=i+1 to n do
          if v[i,1].y>v[j,1].y then begin
            v0:=v[i,1];v[i,1]:=v[j,1];v[j,1]:=v0;
          end;
    end;
  procedure solve;{���ļ���}
    begin
      smin:=maxlongint;
      case k of
        1:begin{K=1������}
            ju[1].b:=v[n,1].y;ju[1].t:=v[1,1].y;
            ju[1].r:=v[n,0].x;ju[1].l:=v[1,0].x;
            smin:=area(ju[1]);
          end;
        2:for jj:=0 to 1 do begin{K=2������}
            {flag=0,1������}
            ju[1].b:=v[1,jj].y;ju[1].t:=v[1,jj].y;
            ju[1].r:=v[1,jj].x;ju[1].l:=v[1,jj].x;
            for i:=2 to n do begin
              insert(v[i-1,jj],ju[1]);{����i-1��������1}
              ju[2].b:=v[i,jj].y;ju[2].t:=v[i,jj].y;{����i��n��������2}
              ju[2].r:=v[i,jj].x;ju[2].l:=v[i,jj].x;
              for ii:=i+1 to n do insert(v[ii,jj],ju[2]);
              if not intersect(ju[1],ju[2]) then begin{��������β�����}
                temp:=0;for ii:=1 to k do temp:=temp+area(ju[ii]);
                if temp<smin then smin:=temp;
              end;
            end;
          end;
        3:begin
            for jj:=0 to 1 do begin {flag=0,1������}
              ju[1].b:=v[1,jj].y;ju[1].t:=v[1,jj].y;
              ju[1].r:=v[1,jj].x;ju[1].l:=v[1,jj].x;
              for i:=2 to n-1 do begin
                insert(v[i-1,jj],ju[1]);
                ju[2].b:=v[i,jj].y;ju[2].t:=v[i,jj].y;
                ju[2].r:=v[i,jj].x;ju[2].l:=v[i,jj].x;
                if intersect(ju[1],ju[2]) then continue;
                for j:=i+1 to n do begin
                  insert(v[j-1,jj],ju[2]);
                  ju[3].b:=v[j,jj].y;ju[3].t:=v[j,jj].y;
                  ju[3].r:=v[j,jj].x;ju[3].l:=v[j,jj].x;
                  for ii:=j+1 to n do insert(v[ii,jj],ju[3]);
                  if intersect(ju[2],ju[3]) then continue;
                  temp:=0;for ii:=1 to k do temp:=temp+area(ju[ii]);
                  if temp<smin then smin:=temp;
                end;
              end;
            end;

          {flag=2������:����ֱ���ִ���Σ������Ҿ�����ˮƽ����}
          ju[1].b:=v[1,0].y;ju[1].t:=v[1,0].y;
          ju[1].r:=v[1,0].x;ju[1].l:=v[1,0].x;
          for i:=2 to n-1 do begin
            for ii:=1 to n do v[ii,2]:=v[ii,0];{���е㰴�������������У�����v[i,2]}
            for ii:=i to n-1 do{����i��n���������������У�����v[i,2]}
              for jj:=ii+1 to n do
                if v[ii,2].y>v[jj,2].y then begin
                  v0:=v[ii,2];v[ii,2]:=v[jj,2];v[jj,2]:=v0;
                end;{��������е��Ȱ��������������У�Ȼ���i��n����������������}
            insert(v[i-1,2],ju[1]);{����i-1��������1}
            ju[2].b:=v[i,2].y;ju[2].t:=v[i,2].y;{����i��������2}
            ju[2].r:=v[i,2].x;ju[2].l:=v[i,2].x;
            if intersect(ju[1],ju[2]) then continue;
            for j:=i+1 to n do begin
              insert(v[j-1,2],ju[2]);{����j-1��������2}
              ju[3].b:=v[j,2].y;ju[3].t:=v[j,2].y;{����j��n��������3}
              ju[3].r:=v[j,2].x;ju[3].l:=v[j,2].x;
              for ii:=j+1 to n do insert(v[ii,2],ju[3]);
              if intersect(ju[2],ju[3]) then continue;
              temp:=0;for ii:=1 to k do temp:=temp+area(ju[ii]);
              if temp<smin then smin:=temp;
            end;
          end;

          {flag=3������}
          for j:=3 to n do begin
            for ii:=1 to n do v[ii,2]:=v[ii,0];
            for ii:=1 to j-2 do
              for jj:=ii+1 to j-1 do
                if v[ii,2].y>v[jj,2].y then begin
                  v0:=v[ii,2];v[ii,2]:=v[jj,2];v[jj,2]:=v0;
                end;
            ju[3].b:=v[j,2].y;ju[3].t:=v[j,2].y;
            ju[3].r:=v[j,2].x;ju[3].l:=v[j,2].x;
            for ii:=j+1 to n do insert(v[ii,2],ju[3]);
            for i:=2 to j-1 do begin
              ju[2].b:=v[i,2].y;ju[2].t:=v[i,2].y;
              ju[2].r:=v[i,2].x;ju[2].l:=v[i,2].x;
              for ii:=i+1 to j-1 do insert(v[ii,2],ju[2]);
              ju[1].b:=v[1,2].y;ju[1].t:=v[1,2].y;
              ju[1].r:=v[1,2].x;ju[1].l:=v[1,2].x;
              for ii:=2 to i-1 do insert(v[ii,2],ju[1]);
              if intersect(ju[1],ju[2]) or intersect(ju[2],ju[3]) or
                intersect(ju[1],ju[3]) then continue;
              temp:=0;for ii:=1 to k do temp:=temp+area(ju[ii]);
              if temp<smin then smin:=temp;
            end;
          end;

          {flag=4������}
          for j:=3 to n do begin
            for ii:=1 to n do v[ii,2]:=v[ii,1];
            for ii:=1 to j-2 do
              for jj:=ii+1 to j-1 do
                if v[ii,2].x>v[jj,2].x then begin
                  v0:=v[ii,2];v[ii,2]:=v[jj,2];v[jj,2]:=v0;
                end;
            ju[3].b:=v[j,2].y;ju[3].t:=v[j,2].y;
            ju[3].r:=v[j,2].x;ju[3].l:=v[j,2].x;
            for ii:=j+1 to n do insert(v[ii,2],ju[3]);
            for i:=2 to j-1 do begin
              ju[2].b:=v[i,2].y;ju[2].t:=v[i,2].y;
              ju[2].r:=v[i,2].x;ju[2].l:=v[i,2].x;
              for ii:=i+1 to j-1 do insert(v[ii,2],ju[2]);
              ju[1].b:=v[1,2].y;ju[1].t:=v[1,2].y;
              ju[1].r:=v[1,2].x;ju[1].l:=v[1,2].x;
              for ii:=2 to i-1 do insert(v[ii,2],ju[1]);
              if intersect(ju[1],ju[2]) or intersect(ju[2],ju[3]) or
                intersect(ju[1],ju[3]) then continue;
              temp:=0;for ii:=1 to k do temp:=temp+area(ju[ii]);
              if temp<smin then smin:=temp;
            end;
          end;

          {flag=5������}
          ju[1].b:=v[1,1].y;ju[1].t:=v[1,1].y;
          ju[1].r:=v[1,1].x;ju[1].l:=v[1,1].x;
          for i:=2 to n-1 do begin
            for ii:=1 to n do v[ii,2]:=v[ii,1];
            for ii:=i to n-1 do
              for jj:=ii+1 to n do
                if v[ii,2].x>v[jj,2].x then begin
                  v0:=v[ii,2];v[ii,2]:=v[jj,2];v[jj,2]:=v0;
                end;
            insert(v[i-1,2],ju[1]);
            ju[2].b:=v[i,2].y;ju[2].t:=v[i,2].y;
            ju[2].r:=v[i,2].x;ju[2].l:=v[i,2].x;
            if intersect(ju[1],ju[2]) then continue;
            for j:=i+1 to n do begin
              insert(v[j-1,2],ju[2]);
              ju[3].b:=v[j,2].y;ju[3].t:=v[j,2].y;
              ju[3].r:=v[j,2].x;ju[3].l:=v[j,2].x;
              for ii:=j+1 to n do insert(v[ii,2],ju[3]);
              if intersect(ju[2],ju[3]) then continue;
              temp:=0;for ii:=1 to k do temp:=temp+area(ju[ii]);
              if temp<smin then smin:=temp;
            end;
          end;
        end;
      end;
    end;
  BEGIN{������}
    init;
    solve;
    writeln(smin);
  END.
