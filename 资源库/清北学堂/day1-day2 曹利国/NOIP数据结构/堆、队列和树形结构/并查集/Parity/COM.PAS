program parity;
type answer=record
             range_from,range_to:longint;
             parity:boolean;
            end;
var answers:array[1..5000] of answer;
 {The array where will be stored your friend's answers.
  The answers will be sorted by the value of range_from.
  There will be no two answers beginning at the same position in the array.}
 procedure exchange(p,q:word);
 {Exchange two answers (on position p and q) in the array}
 var r:answer;
 begin
  r:=answers[p];
  answers[p]:=answers[q];
  answers[q]:=r
 end;
var contradiction:boolean; {Contradiction in the input?}
    length:longint; {The length of the sequence}
    answers_given:word; {How many answers are there in the input file?}
    answers_read:word; {How many answers has been already read?}
    answers_stored:word; {How many answers has been stored in the array?}
    i:word;
    s:string;
    f:text;
begin
 {Opening the input file}
 assign(f,'parity.in');
 reset(f);
 readln(f,length);
 readln(f,answers_given);
 {Initializing the variables}
 contradiction:=false;
 answers_read:=0; answers_stored:=0;
 {And reading the input file}
 if answers_given<>0 then
 repeat
  inc(answers_read); inc(answers_stored);
  readln(f,answers[answers_stored].range_from,answers[answers_stored].range_to,s);
  answers[answers_stored].parity:=s=' odd';
  {Where should the answer be stored in the array?}
  i:=answers_stored-1;
  while (i>0) and (answers[i].range_from>=answers[answers_stored].range_from) do dec(i);
  inc(i);
  {Some reductions needed?}
  while (i<>answers_stored) and (answers[i].range_from=answers[answers_stored].range_from) do
   begin
    if answers[i].range_to>answers[answers_stored].range_to then exchange(i,answers_stored);
    if answers[i].range_to=answers[answers_stored].range_to then
     begin
      {This answer is either useless or contradiction.}
      contradiction:=answers[i].parity<>answers[answers_stored].parity;
      dec(answers_stored); i:=answers_stored;
     end
    else
     begin {The only other possibility is "<".}
      {Making some reductions}
      answers[answers_stored].range_from:=answers[i].range_to+1;
      answers[answers_stored].parity:=answers[i].parity xor answers[answers_stored].parity;
     end;
    while (i<answers_stored) and (answers[i].range_from<answers[answers_stored].range_from) do inc(i);
   end;
  {Sorting the answers (bubblesort)}
  while (i<>answers_stored) do
   begin
    exchange(i,answers_stored);
    inc(i)
   end
 until contradiction or (answers_read=answers_given);
 close(f);
 {Writing results to the output file}
 assign(f,'parity.out');
 rewrite(f);
 if contradiction then writeln(f,answers_read-1) else writeln(f,answers_read);
 close(f);
end.
