program NOIPG3;
  const g=10{�������ٶ�};e=1E-5;{С������С��ļ��޾���}
  var H,s1,v,l,k,t1,t2,Vmin,Vmax:real;
      n2,n1,num,n:integer;
  begin
    readln(h,s1,v,l,k,n);num:=-1;
    t1:=sqrt(2*h/g);{С�����ʱ��}
    if h<=k+e then t2:=0 else t2:=sqrt(2*(h-k-e)/g);{С���䵽С���ϵ����ʱ��}
    if s1-v*t2+L+e<0 
      then num:=0
      else n2:=trunc(s1-v*t2+L+e);{С�����ܵ���������Ϊn2}
    if n2>n-1 then n2:=n-1;{n2ȡtrunc(s1-v*t2+L+e)��n-1�Ľ�Сֵ}
    if s1-v*t1-e<=0 
      then n1:=0
      else if s1-v*t1-e>n-1
             then num:=0
             else if (s1-v*t1-e)=trunc(s1-v*t1-e)
                    then n1:=trunc(s1-v*t1-e){С�����ܵ������С���Ϊn1}
                    else n1:=trunc(s1-v*t1-e)+1;
    if num=-1 then num:=n2-n1+1;{С�����ܵ���ĸ���Ϊnum}
    writeln(num);
  end.
