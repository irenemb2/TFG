----------------------MODULO MEMORIA ROM---------------
--Este modulo almacena los pesos de cada uno de los filtros convolucionales
--estos pesos se eligen según la posición del filtro en la que se encuentre
--ENTRADAS
--address : un numero entre 0 - tamaño del filtro que corresponde con la posición del filtro que se este operando en el momento
--SALIDAS
--bias_term: termino de bias de la neurona
--weight : peso de la neurona correspondiente al address
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.tfg_irene_package.ALL;
entity ROM2_7 is
	Port (address : in STD_LOGIC_VECTOR(log2c(mult2) + log2c(number_of_layers2) - 1 downto 0);
		    bias_term :out UNSIGNED(input_size + weight_size + 3 - 1  downto 0); 
		    weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end ROM2_7; 
architecture Behavioral of  ROM2_7 is
begin
bias_term<= "1111111101001000001" ;
	with address select weight <= 
		 "11111101" when "000000000", -- 1 
		 "11110000" when "000000001", -- 2 
		 "11110011" when "000000010", -- 3 
		 "00100010" when "000000011", -- 4 
		 "11111110" when "000000100", -- 5 
		 "11111101" when "000000101", -- 6 
		 "11110001" when "000000110", -- 7 
		 "11111101" when "000000111", -- 8 
		 "11110000" when "000001000", -- 9 
		 "00010101" when "000001001", -- 10 
		 "11111110" when "000001010", -- 11 
		 "11110000" when "000001011", -- 12 
		 "11110010" when "000001100", -- 13 
		 "00000111" when "000001101", -- 14 
		 "00010011" when "000001110", -- 15 
		 "00001010" when "000001111", -- 16 
		 "11110101" when "000010000", -- 17 
		 "00000001" when "000010001", -- 18 
		 "00001001" when "000010010", -- 19 
		 "00000000" when "000010011", -- 20 
		 "00001101" when "000010100", -- 21 
		 "11110101" when "000010101", -- 22 
		 "11111111" when "000010110", -- 23 
		 "00000100" when "000010111", -- 24 
		 "00001100" when "000011000", -- 25 
		 "00001000" when "000011001", -- 26 
		 "00000011" when "000011010", -- 27 
		 "00001001" when "000011011", -- 28 
		 "11111000" when "000011100", -- 29 
		 "00001001" when "000011101", -- 30 
		 "00000011" when "000011110", -- 31 
		 "00000010" when "000011111", -- 32 
		 "11111110" when "000100000", -- 33 
		 "11110110" when "000100001", -- 34 
		 "00000010" when "000100010", -- 35 
		 "00000001" when "000100011", -- 36 
		 "00001010" when "000100100", -- 37 
		 "11110010" when "000100101", -- 38 
		 "00000011" when "000100110", -- 39 
		 "11101011" when "000100111", -- 40 
		 "11110001" when "000101000", -- 41 
		 "00010100" when "000101001", -- 42 
		 "00000000" when "000101010", -- 43 
		 "11110011" when "000101011", -- 44 
		 "11101011" when "000101100", -- 45 
		 "00000110" when "000101101", -- 46 
		 "00000101" when "000101110", -- 47 
		 "11110000" when "000101111", -- 48 
		 "00000100" when "000110000", -- 49 
		 "00000010" when "000110001", -- 50 
		 "00010010" when "000110010", -- 51 
		 "00011000" when "000110011", -- 52 
		 "11101101" when "000110100", -- 53 
		 "11111011" when "000110101", -- 54 
		 "00001100" when "000110110", -- 55 
		 "00011001" when "000110111", -- 56 
		 "11011111" when "000111000", -- 57 
		 "11110111" when "000111001", -- 58 
		 "00001010" when "000111010", -- 59 
		 "11110110" when "000111011", -- 60 
		 "11111001" when "000111100", -- 61 
		 "00001011" when "000111101", -- 62 
		 "11101001" when "000111110", -- 63 
		 "11111111" when "000111111", -- 64 
		 "00000010" when "001000000", -- 65 
		 "00000101" when "001000001", -- 66 
		 "11101111" when "001000010", -- 67 
		 "11110000" when "001000011", -- 68 
		 "00000111" when "001000100", -- 69 
		 "00001000" when "001000101", -- 70 
		 "11111010" when "001000110", -- 71 
		 "11111011" when "001000111", -- 72 
		 "11110100" when "001001000", -- 73 
		 "00001010" when "001001001", -- 74 
		 "11110111" when "001001010", -- 75 
		 "00000010" when "001001011", -- 76 
		 "11101100" when "001001100", -- 77 
		 "11110010" when "001001101", -- 78 
		 "11111100" when "001001110", -- 79 
		 "11111110" when "001001111", -- 80 
		 "00001001" when "001010000", -- 81 
		 "11111100" when "001010001", -- 82 
		 "00000010" when "001010010", -- 83 
		 "00000001" when "001010011", -- 84 
		 "11110111" when "001010100", -- 85 
		 "11111010" when "001010101", -- 86 
		 "00000001" when "001010110", -- 87 
		 "00001010" when "001010111", -- 88 
		 "11111100" when "001011000", -- 89 
		 "11100001" when "001011001", -- 90 
		 "00001011" when "001011010", -- 91 
		 "11111010" when "001011011", -- 92 
		 "00001000" when "001011100", -- 93 
		 "00000100" when "001011101", -- 94 
		 "11101101" when "001011110", -- 95 
		 "00001101" when "001011111", -- 96 
		 "00010100" when "001100000", -- 97 
		 "11111100" when "001100001", -- 98 
		 "00000010" when "001100010", -- 99 
		 "00000011" when "001100011", -- 100 
		 "00000001" when "001100100", -- 101 
		 "00001011" when "001100101", -- 102 
		 "11101101" when "001100110", -- 103 
		 "00001111" when "001100111", -- 104 
		 "11111010" when "001101000", -- 105 
		 "00000101" when "001101001", -- 106 
		 "11111011" when "001101010", -- 107 
		 "00000001" when "001101011", -- 108 
		 "11111000" when "001101100", -- 109 
		 "00000100" when "001101101", -- 110 
		 "00000000" when "001101110", -- 111 
		 "11111000" when "001101111", -- 112 
		 "11110000" when "001110000", -- 113 
		 "00000110" when "001110001", -- 114 
		 "00010000" when "001110010", -- 115 
		 "11111111" when "001110011", -- 116 
		 "11101100" when "001110100", -- 117 
		 "11101111" when "001110101", -- 118 
		 "11110110" when "001110110", -- 119 
		 "00000000" when "001110111", -- 120 
		 "11110011" when "001111000", -- 121 
		 "11111001" when "001111001", -- 122 
		 "11111010" when "001111010", -- 123 
		 "11111110" when "001111011", -- 124 
		 "00010101" when "001111100", -- 125 
		 "11111111" when "001111101", -- 126 
		 "11110101" when "001111110", -- 127 
		 "11111010" when "001111111", -- 128 
		 "11111101" when "010000000", -- 129 
		 "00010010" when "010000001", -- 130 
		 "00000000" when "010000010", -- 131 
		 "00000011" when "010000011", -- 132 
		 "00001000" when "010000100", -- 133 
		 "00001101" when "010000101", -- 134 
		 "00000011" when "010000110", -- 135 
		 "11110001" when "010000111", -- 136 
		 "11111100" when "010001000", -- 137 
		 "00001100" when "010001001", -- 138 
		 "00010111" when "010001010", -- 139 
		 "00000010" when "010001011", -- 140 
		 "11101011" when "010001100", -- 141 
		 "00000110" when "010001101", -- 142 
		 "00010110" when "010001110", -- 143 
		 "11111111" when "010001111", -- 144 
		 "11100111" when "010010000", -- 145 
		 "00000110" when "010010001", -- 146 
		 "00000100" when "010010010", -- 147 
		 "11111110" when "010010011", -- 148 
		 "00001001" when "010010100", -- 149 
		 "11110001" when "010010101", -- 150 
		 "11110111" when "010010110", -- 151 
		 "11111011" when "010010111", -- 152 
		 "00001110" when "010011000", -- 153 
		 "11110001" when "010011001", -- 154 
		 "11101100" when "010011010", -- 155 
		 "00001010" when "010011011", -- 156 
		 "00000001" when "010011100", -- 157 
		 "00011110" when "010011101", -- 158 
		 "00001100" when "010011110", -- 159 
		 "00001000" when "010011111", -- 160 
		 "11111111" when "010100000", -- 161 
		 "11111101" when "010100001", -- 162 
		 "11110010" when "010100010", -- 163 
		 "00010001" when "010100011", -- 164 
		 "11110110" when "010100100", -- 165 
		 "11101010" when "010100101", -- 166 
		 "00000100" when "010100110", -- 167 
		 "00000011" when "010100111", -- 168 
		 "00000000" when "010101000", -- 169 
		 "11111101" when "010101001", -- 170 
		 "00000000" when "010101010", -- 171 
		 "00001010" when "010101011", -- 172 
		 "11110101" when "010101100", -- 173 
		 "00000101" when "010101101", -- 174 
		 "00000000" when "010101110", -- 175 
		 "11111110" when "010101111", -- 176 
		 "11110111" when "010110000", -- 177 
		 "00000101" when "010110001", -- 178 
		 "11101110" when "010110010", -- 179 
		 "00000101" when "010110011", -- 180 
		 "00001010" when "010110100", -- 181 
		 "11110011" when "010110101", -- 182 
		 "11110111" when "010110110", -- 183 
		 "11111110" when "010110111", -- 184 
		 "00001000" when "010111000", -- 185 
		 "11110010" when "010111001", -- 186 
		 "11110100" when "010111010", -- 187 
		 "11110001" when "010111011", -- 188 
		 "00000000" when "010111100", -- 189 
		 "00000101" when "010111101", -- 190 
		 "11110011" when "010111110", -- 191 
		 "00000111" when "010111111", -- 192 
		 "11111011" when "011000000", -- 193 
		 "00001110" when "011000001", -- 194 
		 "11111010" when "011000010", -- 195 
		 "11110111" when "011000011", -- 196 
		 "11111001" when "011000100", -- 197 
		 "00001010" when "011000101", -- 198 
		 "00000010" when "011000110", -- 199 
		 "11101001" when "011000111", -- 200 
		 "11110010" when "011001000", -- 201 
		 "00000100" when "011001001", -- 202 
		 "00000111" when "011001010", -- 203 
		 "11111000" when "011001011", -- 204 
		 "11101100" when "011001100", -- 205 
		 "11111011" when "011001101", -- 206 
		 "00000101" when "011001110", -- 207 
		 "00000111" when "011001111", -- 208 
		 "11111011" when "011010000", -- 209 
		 "00001111" when "011010001", -- 210 
		 "11101100" when "011010010", -- 211 
		 "11110110" when "011010011", -- 212 
		 "00000010" when "011010100", -- 213 
		 "00000000" when "011010101", -- 214 
		 "00000101" when "011010110", -- 215 
		 "00000001" when "011010111", -- 216 
		 "00010010" when "011011000", -- 217 
		 "00010001" when "011011001", -- 218 
		 "00001111" when "011011010", -- 219 
		 "11101110" when "011011011", -- 220 
		 "11111010" when "011011100", -- 221 
		 "00000001" when "011011101", -- 222 
		 "11111101" when "011011110", -- 223 
		 "00000000" when "011011111", -- 224 
		 "00000110" when "011100000", -- 225 
		 "00000001" when "011100001", -- 226 
		 "00000010" when "011100010", -- 227 
		 "11111011" when "011100011", -- 228 
		 "00001011" when "011100100", -- 229 
		 "11101110" when "011100101", -- 230 
		 "00000001" when "011100110", -- 231 
		 "00001011" when "011100111", -- 232 
		 "11101010" when "011101000", -- 233 
		 "11101011" when "011101001", -- 234 
		 "11111011" when "011101010", -- 235 
		 "00001111" when "011101011", -- 236 
		 "11111001" when "011101100", -- 237 
		 "11100111" when "011101101", -- 238 
		 "00001111" when "011101110", -- 239 
		 "11110100" when "011101111", -- 240 
		 "00000011" when "011110000", -- 241 
		 "00001000" when "011110001", -- 242 
		 "11111010" when "011110010", -- 243 
		 "11111101" when "011110011", -- 244 
		 "00000101" when "011110100", -- 245 
		 "11011100" when "011110101", -- 246 
		 "00001010" when "011110110", -- 247 
		 "00000101" when "011110111", -- 248 
		 "11110001" when "011111000", -- 249 
		 "11111001" when "011111001", -- 250 
		 "11111100" when "011111010", -- 251 
		 "11111101" when "011111011", -- 252 
		 "00001011" when "011111100", -- 253 
		 "00000101" when "011111101", -- 254 
		 "00000110" when "011111110", -- 255 
		 "11111001" when "011111111", -- 256 
		 "00001011" when "100000000", -- 257 
		 "00010110" when "100000001", -- 258 
		 "11110000" when "100000010", -- 259 
		 "11110001" when "100000011", -- 260 
		 "00000110" when "100000100", -- 261 
		 "11011111" when "100000101", -- 262 
		 "00000101" when "100000110", -- 263 
		 "11111011" when "100000111", -- 264 
		 "11101010" when "100001000", -- 265 
		 "11110001" when "100001001", -- 266 
		 "00001100" when "100001010", -- 267 
		 "00000111" when "100001011", -- 268 
		 "00000100" when "100001100", -- 269 
		 "11111101" when "100001101", -- 270 
		 "11111110" when "100001110", -- 271 
		 "11111111" when "100001111", -- 272 
		 "11101101" when "100010000", -- 273 
		 "00000110" when "100010001", -- 274 
		 "00001100" when "100010010", -- 275 
		 "11111011" when "100010011", -- 276 
		 "00010001" when "100010100", -- 277 
		 "11110111" when "100010101", -- 278 
		 "11111010" when "100010110", -- 279 
		 "11111011" when "100010111", -- 280 
		 "00001101" when "100011000", -- 281 
		 "11111111" when "100011001", -- 282 
		 "11111110" when "100011010", -- 283 
		 "11110100" when "100011011", -- 284 
		 "00000010" when "100011100", -- 285 
		 "00011110" when "100011101", -- 286 
		 "00000100" when "100011110", -- 287 
		 "11111000" when "100011111", -- 288 
		 "00010011" when "100100000", -- 289 
		 "11110100" when "100100001", -- 290 
		 "11111110" when "100100010", -- 291 
		 "00000101" when "100100011", -- 292 
		 "11111100" when "100100100", -- 293 
		 "11100000" when "100100101", -- 294 
		 "11110110" when "100100110", -- 295 
		 "00000101" when "100100111", -- 296 
		 "11111101" when "100101000", -- 297 
		 "00000001" when "100101001", -- 298 
		 "00001011" when "100101010", -- 299 
		 "11111111" when "100101011", -- 300 
		 "00001001" when "100101100", -- 301 
		 "00001000" when "100101101", -- 302 
		 "11111101" when "100101110", -- 303 
		 "11110110" when "100101111", -- 304 
		 "11110001" when "100110000", -- 305 
		 "11110010" when "100110001", -- 306 
		 "00000001" when "100110010", -- 307 
		 "11110110" when "100110011", -- 308 
		 "11110101" when "100110100", -- 309 
		 "11111000" when "100110101", -- 310 
		 "00000111" when "100110110", -- 311 
		 "00010101" when "100110111", -- 312 
		 "11110100" when "100111000", -- 313 
		 "00001000" when "100111001", -- 314 
		 "00011001" when "100111010", -- 315 
		 "11101111" when "100111011", -- 316 
		 "00000111" when "100111100", -- 317 
		 "00000001" when "100111101", -- 318 
		 "11110101" when "100111110", -- 319 
		 "11110110" when "100111111", -- 320 
		 "00001011" when "101000000", -- 321 
		 "11110111" when "101000001", -- 322 
		 "11110101" when "101000010", -- 323 
		 "00000011" when "101000011", -- 324 
		 "00000110" when "101000100", -- 325 
		 "00000011" when "101000101", -- 326 
		 "11111110" when "101000110", -- 327 
		 "11110110" when "101000111", -- 328 
		 "11011010" when "101001000", -- 329 
		 "11111001" when "101001001", -- 330 
		 "11110101" when "101001010", -- 331 
		 "00001011" when "101001011", -- 332 
		 "00000100" when "101001100", -- 333 
		 "11110001" when "101001101", -- 334 
		 "11111100" when "101001110", -- 335 
		 "00001111" when "101001111", -- 336 
		 "00010100" when "101010000", -- 337 
		 "11111010" when "101010001", -- 338 
		 "00000100" when "101010010", -- 339 
		 "00000101" when "101010011", -- 340 
		 "00010010" when "101010100", -- 341 
		 "11111001" when "101010101", -- 342 
		 "11100101" when "101010110", -- 343 
		 "00000011" when "101010111", -- 344 
		 "11100100" when "101011000", -- 345 
		 "11111110" when "101011001", -- 346 
		 "00000001" when "101011010", -- 347 
		 "00001010" when "101011011", -- 348 
		 "00000101" when "101011100", -- 349 
		 "00001110" when "101011101", -- 350 
		 "11101100" when "101011110", -- 351 
		 "00000111" when "101011111", -- 352 
		 "00010001" when "101100000", -- 353 
		 "11111100" when "101100001", -- 354 
		 "11111101" when "101100010", -- 355 
		 "11110111" when "101100011", -- 356 
		 "00000111" when "101100100", -- 357 
		 "00010110" when "101100101", -- 358 
		 "00000011" when "101100110", -- 359 
		 "00010000" when "101100111", -- 360 
		 "11110000" when "101101000", -- 361 
		 "00000111" when "101101001", -- 362 
		 "11101111" when "101101010", -- 363 
		 "00000110" when "101101011", -- 364 
		 "11110101" when "101101100", -- 365 
		 "00000000" when "101101101", -- 366 
		 "11111110" when "101101110", -- 367 
		 "00000110" when "101101111", -- 368 
		 "11101011" when "101110000", -- 369 
		 "11111001" when "101110001", -- 370 
		 "11111000" when "101110010", -- 371 
		 "00000100" when "101110011", -- 372 
		 "11101010" when "101110100", -- 373 
		 "11111001" when "101110101", -- 374 
		 "11111100" when "101110110", -- 375 
		 "11110111" when "101110111", -- 376 
		 "11101000" when "101111000", -- 377 
		 "11111110" when "101111001", -- 378 
		 "11111011" when "101111010", -- 379 
		 "00000001" when "101111011", -- 380 
		 "11110001" when "101111100", -- 381 
		 "00000110" when "101111101", -- 382 
		 "11110101" when "101111110", -- 383 
		 "00000100" when "101111111", -- 384 
		 "11111111" when "110000000", -- 385 
		 "00000111" when "110000001", -- 386 
		 "11111111" when "110000010", -- 387 
		 "11110100" when "110000011", -- 388 
		 "11110010" when "110000100", -- 389 
		 "00001100" when "110000101", -- 390 
		 "11110010" when "110000110", -- 391 
		 "11111010" when "110000111", -- 392 
		 "11110100" when "110001000", -- 393 
		 "11111010" when "110001001", -- 394 
		 "00010100" when "110001010", -- 395 
		 "00000100" when "110001011", -- 396 
		 "00001101" when "110001100", -- 397 
		 "00000011" when "110001101", -- 398 
		 "11111101" when "110001110", -- 399 
		 "11111011" when "110001111", -- 400 
		 "00000000" when others; 
 end Behavioral;
