procedure Prim(n: integer; w: TGraph; var low: TArrOfInt);
var
  InSetT: array[1..MaxN]of boolean;
  i,j,k,min: integer;
begin 
  {��ʼ��}
  fillchar(InSetT,sizeof(InSetT),true); 
  InSetT[1]:=false;  // ��ʼʱ���нڵ���˽ڵ�1����T������
  low[1]:=0;
  for i:=2 to n do low[i]:=1; // ��ʼʱT���������нڵ��lowֵ����1
  {��ʼѰ��}
  for i:=1 to n-1 do begin 
    j:=0;          // j���ڼ�¼Ȩ��С�ı����ӵ�T�����еĽڵ�
    min:=Maxint;   // min���ڼ�¼��С�ıߵ�Ȩ
    for k:=1 to n do 
      if (InSetT[k]) and (w[low[k],k]<min) then begin 
        min:=w[low[k],k];
        j:=k;
      end;
    InSetT[j]:=false;  // ��ѡ���Ľڵ�ת����S������
    for k:=1 to n do   // ά��low����
      if w[j,k]<w[low[k],k] then low[k]:=j;
  end;
end;