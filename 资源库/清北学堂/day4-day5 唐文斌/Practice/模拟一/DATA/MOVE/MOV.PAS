{*************************************************************************}
{*                                                                       *}
{*                  III Olimpiada Informatyczna                          *}
{*                                                                       *}
{*   Rozwiazanie zadania: KULE                                           *}
{*   Plik:                KUL.PAS                                        *}
{*   Autor:               Grzegorz Jakacki                               *}
{*************************************************************************}

{$M 65500,0,655360}
program Kule;
 var
  Polozenie         :array[1..8000] of integer;
                     {Polozenie[i] jest numerem i-tego niepustego pudelka.}
  Zawartosc         :array[1..8000] of integer;
                     {Poczatkowe zawartosci niepustych pudelek; Zawartosc[i]
                      jest liczba kul w pudelku o numerze polozenie[i]}
  LewaKula,PrawaKula:array[1..8000] of integer;
                      {Polozenie skrajnie lewej i skrajnie prawej
                       kuli w bloku kul z tego samego pudelka.}
  n                 :integer; 	{liczba pudelek}
  np                :integer;	{liczba niepustych pudelek}
  We,Wy             :text;      {plik wejsciowy i wyjsciowy}

 procedure OtworzPliki;
 begin
  assign(We,'MOV1.IN');  reset(We);
           {'MOV1.out'}
  assign(Wy,'MOV.OUT');
  rewrite(Wy)
 end; {OtworzPliki}

 procedure ZamknijPliki;
 begin
  close(Wy);
  close(We)
 end; {ZamknijPliki}

 procedure WczytajDane;
  var
   p  :integer;	{numer kolejnego pudelka}
   r  :integer;	{numer kolejnego niepustego pudelka}
   Ile:integer;	{liczba kulek w pudelku p}
 begin
  readln(We,n);
  np:=0;
  for p:=1 to n do begin
   readln(We,Ile);
   if Ile>0 then begin
    np:=np+1;
    Zawartosc[np]:=Ile;
    Polozenie[np]:=p
   end {if Ile>0}
  end {for p }
 end; {WczytajDane}

 function Min(a,b:integer):integer;
 begin
  if a<b then Min:=a
  else min:=b
 end; {Min}

 function Odleglosc(a,b:integer):integer;
  {Odleglosc miedzy pudelkami o numerach a i b.}
 begin
  Odleglosc:=Min(abs(a-b),n-abs(a-b))
 end; {Odleglosc}

 function IncMod(a,m:integer):integer;
  {Zwieksza a o jeden; jezeli jest wieksze od m, to ustawia na 1.}
 begin
  IncMod:=(a mod m)+1
 end; {IncMod}

 function DecMod(a,m:integer):integer;
  {Zmniejsza a o jeden; jezeli jest mniejsze od 1, to ustawia na m.}
 begin
  DecMod:=((a+m-2) mod m)+1
 end; {DecMod}

 function ObliczKosztL(Pudelko:integer):longint;
   {Oblicza wartosc, o jaka zmieni sie koszt ulozenia kul, jezeli do
    bloku kul z pudelka o numerze Pudelko dolozymy jedna kule z lewej
    strony, ew. robiac miejsce poprzez przesuniecie juz ulozonych kul.}
  var
   p    :integer;  {pudelko zwiazane z aktualnym blokiem kul}
   pL   :integer;  {pudelko zwiazane z nastepnym z lewej strony blokiem kul}
   Koszt:longint;  {przyrost kosztu}
 begin
  Koszt:=Odleglosc(DecMod(LewaKula[Pudelko],n),Polozenie[Pudelko]);
   {Tyle trzeba zaplacic za dostawienie nowej kuli do bloku z lewej strony.}
   {Teraz korygujemy przyrost kosztu w przypadku przesuwania innych kul.}
  p:=Pudelko;
  pL:=DecMod(p,np);
  while PrawaKula[pL]=DecMod(LewaKula[p],n) do begin
   Koszt:=Koszt-Odleglosc(PrawaKula[pL],Polozenie[pL]);
   Koszt:=Koszt+Odleglosc(DecMod(LewaKula[pL],n),Polozenie[pL]);
   p:=DecMod(p,np);
   pL:=DecMod(p,np)
  end; {while }
  ObliczKosztL:=Koszt
 end; {ObliczKosztL}

 function ObliczKosztP(Pudelko:integer):integer;
   {symetrycznie do ObliczKosztL}
  var
   p,pP :integer;
   Koszt:longint;
 begin
  Koszt:=Odleglosc(IncMod(PrawaKula[Pudelko],n),Polozenie[Pudelko]);
   {Tyle trzeba zaplacic za dostawienie kuli z prawej strony bloku.}
   {Teraz bedziemy liczyc zmiane kosztu po przesunieciu.}
  p:=Pudelko;
  pP:=IncMod(p,np);
  while LewaKula[pP]=IncMod(PrawaKula[p],n) do begin
   Koszt:=Koszt-Odleglosc(LewaKula[pP],Polozenie[pP]);
   Koszt:=Koszt+Odleglosc(IncMod(PrawaKula[pP],n),Polozenie[pP]);
   p:=IncMod(p,np);
   pP:=IncMod(p,np)
  end; {while }
  ObliczKosztP:=Koszt
 end; {ObliczKosztP}

 procedure PostawZLewej(Pudelko:integer);
   {Dostawia kule z lewej strony bloku kul z pudeka Pudelko
    (ew. przesuwajac inne kulki w lewo).}
  var
   p :integer;	{pudelko zwiazane z aktualnym blokiem kulek}
   pL:integer;	{pudelko zwiazane z nastepnym po lewej blokiem kulek}
 begin
  p:=Pudelko;
  pL:=DecMod(p,np);
  LewaKula[p]:=DecMod(LewaKula[p],n);
  while LewaKula[p]=PrawaKula[pL] do begin
   PrawaKula[pL]:=DecMod(PrawaKula[pL],n);
   LewaKula[pL]:=DecMod(LewaKula[pL],n);
   p:=DecMod(p,np);
   pL:=DecMod(pL,np)
  end {while }
 end; {PostawZLewej}

 procedure PostawZPrawej(Pudelko:integer);
   {symetrycznie do PostawZLewej}
  var p,pP:integer;
 begin
  p:=Pudelko;
  pP:=IncMod(p,np);
  PrawaKula[p]:=IncMod(PrawaKula[p],n);
  while PrawaKula[p]=LewaKula[pP] do begin
   LewaKula[pP]:=IncMod(LewaKula[pP],n);
   PrawaKula[pP]:=IncMod(PrawaKula[pP],n);
   p:=IncMod(p,np);
   pP:=IncMod(pP,np)
  end {while }
 end; {PostawZPrawej}

 function MinimalnyKoszt:longint;
   {Oblicza minimalny koszt rozmieszczenia kul.}
  var
   i,q                :integer;
   Koszt,KosztL,KosztR:longint;
 begin
  for i:=1 to np do begin
   LewaKula[i]:=Polozenie[i];
   PrawaKula[i]:=Polozenie[i];
   Zawartosc[i]:=Zawartosc[i]-1
  end; {for i }
  for i:=1 to np do
   while Zawartosc[i]>0 do begin
    KosztL:=ObliczKosztL(i);
    KosztR:=ObliczKosztP(i);
    if KosztL<KosztR then postawZLewej(i)
    else postawZPrawej(i);
    Zawartosc[i]:=Zawartosc[i]-1
   end; {while, for i }
  Koszt:=0;
  for i:=1 to np do begin
   q:=LewaKula[i];
   Koszt:=Koszt+Odleglosc(LewaKula[i],Polozenie[i]);
   while q<>PrawaKula[i] do begin
    q:=IncMod(q,n);
    Koszt:=Koszt+Odleglosc(q,Polozenie[i])
   end {while}
  end; {for i }
  MinimalnyKoszt:=Koszt
 end; {MinimalnyKoszt}

begin {Program glowny}
 OtworzPliki;
 WczytajDane;
 writeln(Wy,MinimalnyKoszt);
 ZamknijPliki
end. {Kule}


