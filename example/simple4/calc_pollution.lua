--[==[
encoding: utf8
Файл: calc_pollution.lua
Программа расчета загрязнения приземного слоя атмосферного воздука CO
Язык: Lua v5.3 (https://www.lua.org/)

==== Для вызова кода из lualatex добавьте в *.tex - файл следующее ====
\usepackage{luacode}
...
\begin{luacode}
  function rnd(num, numDecimalPlaces)
    local negate = false

    if (num < 0) then
      negate = true
      num = -num
    end

    local mult = 10^(numDecimalPlaces or 0)
    num_fl = math.floor(num * mult + 0.5) / mult
    local fmt = "%."..numDecimalPlaces.."f"

    if (negate == true) then
      num_fl = -num_fl
    end

    str = string.format(fmt, num_fl):gsub('\%.', ',')
    str = str:gsub('[0]+$', '')
    str = str:gsub(',$', '')
    return tex.sprint(str)
  end

  function rnd2(num)
    return rnd(num, 2)
  end

  function rnd3(num)
    return rnd(num, 3)
  end


  local file = io.open("calc_pollution.lua", "r")
  local code = file:read("*all")
  file:close()
  local res, calc = pcall(load('return '..code))
  t = calc()
\end{luacode}
...
\directlua{rnd2(t.k_spartak.lg.Kti)}
]==]





function ()

local pattern_plt = 
[[
reset
set encoding cp1251
set term pdfcairo font "Times-New-Roman,10"
set terminal qt 1 noraise enhanced #отключить терминал
set grid
#set key box top right spacing 1.5  #место для легенды

name = "graph.csv"
file_name = "./graph"

set title "График функции из файла ".name." "
set xlabel "x"
set ylabel "y"

stats file_name.'.csv'  using 2 name "A"

#plot  file_name.'.csv'   using 1:2 with dots  title 'Исходная функция'
plot  file_name.'.csv'   using 1:2 with +  title 'Исходная функция'

#set label  "RMS = <RMS> V, \nTHD = <THD> %" at graph  0.1, graph  0.1


set terminal pdfcairo enhanced color notransparent
set output file_name.'.pdf'
#set output file_name.'_01.pdf'



replot
unset output
unset terminal 

]]


local t = {
-- table 1
  k_marks = {
    lg     = { Num = 714,    Pi = 0,    Kti = 2.3},
    sg     = { Num = 2,      Pi = 0,    Kti = 2.9},
    tg_diz = { Num = 5,      Pi = 0,    Kti = 0.2},
    tg_dvs = { Num = 58,     Pi = 0,    Kti = 3.7},
    l      = { Num = 338,    Pi = 0,    Kti = 1.0},
    summ   = { Num = 0,                 Kt  = 0,  Kco = 0, mul_PDK = 0},
  },
-- table 2
  k_spartak = {
    lg     = { Num = 139,    Pi = 0,    Kti = 2.3},
    sg     = { Num = 12,     Pi = 0,    Kti = 2.9},
    tg_diz = { Num = 14,     Pi = 0,    Kti = 0.2},
    tg_dvs = { Num = 14,     Pi = 0,    Kti = 3.7},
    l      = { Num = 319,    Pi = 0,    Kti = 1.0},
    summ   = { Num = 0,                 Kt  = 0,  Kco = 0, mul_PDK = 0},
  },
-- table 3
  k_tuz = {
    lg     = { Num = 6,      Pi = 0,    Kti = 2.3},
    sg     = { Num = 0,      Pi = 0,    Kti = 2.9},
    tg_diz = { Num = 12,     Pi = 0,    Kti = 0.2},
    tg_dvs = { Num = 0,      Pi = 0,    Kti = 3.7},
    l      = { Num = 109,    Pi = 0,    Kti = 1.0},
    summ   = { Num = 0,                 Kt  = 0,  Kco = 0, mul_PDK = 0},
  },

-- table A.1
  Ka = {
    tt  = 2.7,
    tg  = 1.5,
    mu  = 1.0,
    ghu = 0.6,
    gu  = 0.4,
  },
-- table A.2
  Ku = {
    g_0 = 1.0,
    g_2 = 1.06,
    g_4 = 1.07,
    g_6 = 1.18,
    g_8 = 1.55,
  },
-- table A.3
  Kp = {
    svet_auto         = 1.8,
    svet_direct       = 2.1,
    crossroads_simple = 1.9,
    crossroads_round  = 2.2,
    crossroads_stop   = 3.0,
  },
-- table A.4
  Kc = {
    v_1 = 2.7,
    v_2 = 2.0,
    v_3 = 1.5,
    v_4 = 1.2,
    v_5 = 1.05,
    v_6 = 1.00,
  },
-- table A.5
  Kv = {
    v_100 = 1.45,
    v_90  = 1.30,
    v_80  = 1.15,
    v_70  = 1.00,
    v_60  = 0.85,
    v_50  = 0.75,
    v_40  = 0.60,
  },
  
  
    Kv1 = {
    'v_100', 'v_90', 'v_80', 'v_70', 'v_60', 'v_50', 'v_40',
    v_100 = {100, 1.45},
    v_90  = {90, 1.30},
    v_80  = {80, 1.15},
    v_70  = {70, 1.00},
    v_60  = {60, 0.85},
    v_50  = {50, 0.75},
    v_40  = {40, 0.60},
  },
  
  
  PDK = 3,
}

  local function calc_table(ost)
    --local ost = t.k_marks
    local line = {}

    line[#line + 1] = ost.lg
    line[#line + 1] = ost.sg
    line[#line + 1] = ost.tg_diz
    line[#line + 1] = ost.tg_dvs
    line[#line + 1] = ost.l

    for i = 1, #line do 
      ost.summ.Num = ost.summ.Num + line[i].Num
    end

    for i = 1, #line do 
      line[i].Pi = line[i].Num / ost.summ.Num
      ost.summ.Kt = ost.summ.Kt + line[i].Pi * line[i].Kti
    end
  end

  calc_table(t.k_marks)
  calc_table(t.k_spartak)
  calc_table(t.k_tuz)

  t.k_marks.summ.Kco = (0.5 + 0.01 * t.k_marks.summ.Num * t.k_marks.summ.Kt) * t.Ka.mu * t.Kp.svet_auto * t.Ku.g_0 * t.Kc.v_4 * t.Kv.v_100

  t.k_spartak.summ.Kco = (0.5 + 0.01 * t.k_spartak.summ.Num * t.k_spartak.summ.Kt) * t.Ka.mu * t.Kp.svet_auto * t.Ku.g_0 * t.Kc.v_1 * t.Kv.v_100

  t.k_tuz.summ.Kco = (0.5 + 0.01 * t.k_tuz.summ.Num * t.k_tuz.summ.Kt) * t.Ka.mu * t.Kp.svet_auto * t.Ku.g_0 * t.Kc.v_1 * t.Kv.v_40


  t.k_marks.summ.mul_PDK = t.k_marks.summ.Kco/t.PDK
  t.k_spartak.summ.mul_PDK = t.k_spartak.summ.Kco/t.PDK
  t.k_tuz.summ.mul_PDK = t.k_tuz.summ.Kco/t.PDK



--[==[
  local file_plt = io.open('./graph/graph.plt', 'w')
  file_plt:write(pattern_plt)
  file_plt:close()

  local file_csv = io.open('./graph/graph.csv', 'w')

  for i, val in ipairs(t.Kv1) do
    file_csv:write(string.format('%f\t%f\n', t.Kv1[val][1], t.Kv1[val][2]))
  end

--[[
  for x = -3, 3, 0.1 do
    file_csv:write(string.format('%f\t%f\n', x, (x*x)))
  end
]]
  file_csv:close()


  os.execute('cd ./graph   &&    gnuplot ./graph.plt')
]==]

  return t

end