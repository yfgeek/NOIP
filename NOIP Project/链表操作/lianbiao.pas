program lianbiao; type yf=^rec;
     rec=record
       data:integer;
       next:yf;
     end;
var y:integer;
    head:yf;
    p1,p2:yf ;

procedure build;                 {��������}
var i,q:integer;
begin
write(' ��ʼ��������...���������ݸ�����':30);
readln(q);
if q>1 then
    begin
     new(p1);
     writeln(' ��1������: ');
     readln(p1^.data);
     head:=p1;
      for i:=2 to q do begin
          new(p2);
          writeln(' ��',i,'������');
          readln(p2^.data);
          p1^.next:= p2;
          p1:=p2;
      end;
    end
else
begin
writeln(' ��������ݱ������1!');
exit;
end;
   p2^.next:=nil;
   writeln(' �������............');
end;
procedure writee;                          {�������}
begin
writeln(' ���������...���Ժ�.....':30);
p1:=head;
while p1<>nil do
   begin
    write(p1^.data,'->');
    p1:=p1^.next;
   end;
writeln;
end;
procedure delete ; {ɾ���ڵ�}
var x:integer;
begin
writeln(' ɾ��ĳ���ڵ�...���������ݣ�':30);
readln(x);
p1:=head;
while (p1^.data<>x ) and (p1^.next<>nil) do begin
   p2:=p1;
   p1:=p1^.next;
   end;
if x=p1^.data then begin
   if p1=head then begin head:=head^.next;writeln(' ɾ���ɹ���');end
      else begin p2^.next :=p1^.next; writeln(' ɾ���ɹ���');end
   end
else writeln(' û���������');
end;
procedure main(m:integer);
begin
while m<>4 do begin
case m of
1:build;
2:delete;
3:writee;
4:exit;
end;
writeln;
writeln('    ��ѡ��');
writeln(' 1����������');
writeln(' 2��ɾ��ĳ���ڵ�');
writeln(' 3���������');
writeln(' 4���˳�...');
write('    ���������:');
read(m);
main(m);
end;
if m=4 then begin halt; end;
readln;
end;
begin
writeln;
writeln('    ��ѡ��');
writeln(' 1����������');
writeln(' 2��ɾ��ĳ���ڵ�');
writeln(' 3���������');
writeln(' 4���˳�...');
write('    ���������:');
readln(y);
main(y);
writeln(' ��������...�����������');
end.
