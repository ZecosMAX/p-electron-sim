program electron;
Uses sysutils;

type vector = record
  x: single;
  y: single;
  z: single;
end;

// Фунцкции - операции над векторами
function dist(r1, r2: vector): single; begin
    dist := Sqrt(Sqr(r1.x - r2.x) + Sqr(r1.y-r2.y) + Sqr(r1.z-r2.z));
end;

function len(v: vector): single; begin
  len := Sqrt(Sqr(v.x) + Sqr(v.y) + Sqr(v.z))
end;

function add(v1, v2: vector): vector; begin
  add.x := v1.x + v2.x;
  add.y := v1.y + v2.y;
  add.z := v1.z + v2.z;
end;

function sub(v1, v2: vector): vector; begin
  sub.x := v1.x - v2.x;
  sub.y := v1.y - v2.y;
  sub.z := v1.z - v2.z;
end;

function mult(k : single; v : vector): vector; begin
  mult.x := k * v.x;
  mult.y := k * v.y;
  mult.z := k * v.z;
end;

function dot(v1, v2 : vector): single; begin
  dot := v1.x*v2.x + v1.y*v2.y + v1.z*v2.z;
end;

function cross(v1, v2 : vector): vector; begin
  cross.x := v1.y*v2.z - v1.z*v2.y;
  cross.y := v1.z*v2.x - v1.x*v2.z;
  cross.z := v1.x*v2.y - v1.y*v2.x;
end;

function norm(v1:vector ): vector; 
var
  c : single;
begin
  c := 1 / len(v1);
  norm := mult(c, v1);
end;

function vecToString(v: vector): string;
var
  result : string = '';
  temp : string = '';
begin

  temp := '{ X: ';
  insert(temp, result, length(result) + 1);

  temp := FloatToStr(v.x);
  insert(temp, result, length(result) + 1);

  temp := '  Y: ';
  insert(temp, result, length(result) + 1);

  temp := FloatToStr(v.y);
  insert(temp, result, length(result) + 1);

  temp := '  Z: ';
  insert(temp, result, length(result) + 1);

  temp := FloatToStr(v.z);
  insert(temp, result, length(result) + 1);

  temp := ' }';
  insert(temp, result, length(result) + 1);

  vecToString := result;
end;

// Функции симуляции
function tension(r: vector): vector; 
var
  c : single;
begin
  c := 2*k*lambda/Sqr(len(r));
  tension := mult(c, k);
end;

const
  dt: single =    1.0E-6;                   // Шаг в секундах
  k: single =     8.9875517873681764E+09;   // Константа кулона
  m_e: single =   9.10938356E-31;           // Масса электрона
  q_e: single =   1.60217662E-19;           // Элементарный заряд

var
  // Переменные электрического поля и силы
  electric_tension : vector;

  // Переменные параметры электрона
  electron_pos : vector;
  electron_vel : vector;
  electron_acc : vector;

  // Переменные параметры нити
  lambda : single; 

  // Ориентация нити в пространстве
  line_point : vector;
  line_vector: vector;

  info : string = '';

  distToRod : single = 0;

begin
  write('electron start x: ');
  readln(electron_pos.x);

  write('electron start y: ');
  readln(electron_pos.y);

  write('electron start z: ');
  readln(electron_pos.z);

  write('rod start x: ');
  readln(line_point.x);

  write('rod start y: ');
  readln(line_point.y);

  write('rod start z: ');
  readln(line_point.z);

  write('rod orientation x: ');
  readln(line_vector.x);

  write('rod orientation y: ');
  readln(line_vector.y);

  write('rod orientation z: ');
  readln(line_vector.z);

  line_vector := norm(line_vector);

  electron_vel := cross(electron_pos, line_vector);
  distToRod := len(electron_vel) / len(line_vector);

  info := vecToString(electron_vel);

  writeln(info, ' || => ', distToRod);
end.