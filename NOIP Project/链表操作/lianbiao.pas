program lianbiao; type yf=^rec;
     rec=record
       data:integer;
       next:yf;
     end;
var y:integer;
    head:yf;
    p1,p2:yf ;

procedure build;                 {建立链表}
var i,q:integer;
begin
write(' 开始建立链表...请输入数据个数：':30);
readln(q);
if q>1 then
    begin
     new(p1);
     writeln(' 第1个数据: ');
     readln(p1^.data);
     head:=p1;
      for i:=2 to q do begin
          new(p2);
          writeln(' 第',i,'个数据');
          readln(p2^.data);
          p1^.next:= p2;
          p1:=p2;
      end;
    end
else
begin
writeln(' 输入的数据必须大于1!');
exit;
end;
   p2^.next:=nil;
   writeln(' 输入结束............');
end;
procedure writee;                          {输出链表}
begin
writeln(' 输出链表中...请稍后.....':30);
p1:=head;
while p1<>nil do
   begin
    write(p1^.data,'->');
    p1:=p1^.next;
   end;
writeln;
end;
procedure delete ; {删除节点}
var x:integer;
begin
writeln(' 删除某个节点...请输入数据：':30);
readln(x);
p1:=head;
while (p1^.data<>x ) and (p1^.next<>nil) do begin
   p2:=p1;
   p1:=p1^.next;
   end;
if x=p1^.data then begin
   if p1=head then begin head:=head^.next;writeln(' 删除成功！');end
      else begin p2^.next :=p1^.next; writeln(' 删除成功！');end
   end
else writeln(' 没有这个数据');
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
writeln('    请选择：');
writeln(' 1：建立链表');
writeln(' 2：删除某个节点');
writeln(' 3：输出链表');
writeln(' 4：退出...');
write('    请输入序号:');
read(m);
main(m);
end;
if m=4 then begin halt; end;
readln;
end;
begin
writeln;
writeln('    请选择：');
writeln(' 1：建立链表');
writeln(' 2：删除某个节点');
writeln(' 3：输出链表');
writeln(' 4：退出...');
write('    请输入序号:');
readln(y);
main(y);
writeln(' 操作结束...按任意键返回');
end.
