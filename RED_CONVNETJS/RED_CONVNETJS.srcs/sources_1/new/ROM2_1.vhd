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
entity ROM2_1 is
	Port (address : in STD_LOGIC_VECTOR(log2c(mult2) + log2c(number_of_layers2) - 1 downto 0);
		    bias_term :out UNSIGNED(input_size + weight_size + 3 - 1  downto 0); 
		    weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end ROM2_1; 
architecture Behavioral of  ROM2_1 is
begin
bias_term<= "1111111110011111100" ;
	with address select weight <= 
		 "00001100" when "000000000", -- 1 
		 "00000001" when "000000001", -- 2 
		 "00000101" when "000000010", -- 3 
		 "11110111" when "000000011", -- 4 
		 "11111110" when "000000100", -- 5 
		 "00010000" when "000000101", -- 6 
		 "00001101" when "000000110", -- 7 
		 "11110000" when "000000111", -- 8 
		 "11111100" when "000001000", -- 9 
		 "00000111" when "000001001", -- 10 
		 "11110110" when "000001010", -- 11 
		 "11110100" when "000001011", -- 12 
		 "11100110" when "000001100", -- 13 
		 "11111010" when "000001101", -- 14 
		 "00001011" when "000001110", -- 15 
		 "00000100" when "000001111", -- 16 
		 "00000110" when "000010000", -- 17 
		 "00000011" when "000010001", -- 18 
		 "00000001" when "000010010", -- 19 
		 "11110110" when "000010011", -- 20 
		 "11110010" when "000010100", -- 21 
		 "11111101" when "000010101", -- 22 
		 "11110100" when "000010110", -- 23 
		 "11110011" when "000010111", -- 24 
		 "11111101" when "000011000", -- 25 
		 "11110101" when "000011001", -- 26 
		 "00000110" when "000011010", -- 27 
		 "11111001" when "000011011", -- 28 
		 "00000101" when "000011100", -- 29 
		 "11111000" when "000011101", -- 30 
		 "00001001" when "000011110", -- 31 
		 "11111010" when "000011111", -- 32 
		 "00000100" when "000100000", -- 33 
		 "11111000" when "000100001", -- 34 
		 "00001000" when "000100010", -- 35 
		 "11111011" when "000100011", -- 36 
		 "11110100" when "000100100", -- 37 
		 "11101100" when "000100101", -- 38 
		 "11110110" when "000100110", -- 39 
		 "11111101" when "000100111", -- 40 
		 "00001011" when "000101000", -- 41 
		 "11111110" when "000101001", -- 42 
		 "00010010" when "000101010", -- 43 
		 "11110110" when "000101011", -- 44 
		 "11111100" when "000101100", -- 45 
		 "00000110" when "000101101", -- 46 
		 "00011010" when "000101110", -- 47 
		 "11111011" when "000101111", -- 48 
		 "00000001" when "000110000", -- 49 
		 "11110101" when "000110001", -- 50 
		 "00001001" when "000110010", -- 51 
		 "00000101" when "000110011", -- 52 
		 "11011110" when "000110100", -- 53 
		 "00000001" when "000110101", -- 54 
		 "11111110" when "000110110", -- 55 
		 "11111100" when "000110111", -- 56 
		 "11111101" when "000111000", -- 57 
		 "00001000" when "000111001", -- 58 
		 "11110100" when "000111010", -- 59 
		 "00000000" when "000111011", -- 60 
		 "11101111" when "000111100", -- 61 
		 "00010101" when "000111101", -- 62 
		 "11111100" when "000111110", -- 63 
		 "00000000" when "000111111", -- 64 
		 "00001011" when "001000000", -- 65 
		 "00001100" when "001000001", -- 66 
		 "11101100" when "001000010", -- 67 
		 "11111000" when "001000011", -- 68 
		 "00001000" when "001000100", -- 69 
		 "11111111" when "001000101", -- 70 
		 "00001010" when "001000110", -- 71 
		 "00001001" when "001000111", -- 72 
		 "00000010" when "001001000", -- 73 
		 "00000101" when "001001001", -- 74 
		 "11101111" when "001001010", -- 75 
		 "11111011" when "001001011", -- 76 
		 "00010000" when "001001100", -- 77 
		 "11111100" when "001001101", -- 78 
		 "00001000" when "001001110", -- 79 
		 "11111101" when "001001111", -- 80 
		 "00000100" when "001010000", -- 81 
		 "00000011" when "001010001", -- 82 
		 "11110010" when "001010010", -- 83 
		 "11110110" when "001010011", -- 84 
		 "11111010" when "001010100", -- 85 
		 "11110111" when "001010101", -- 86 
		 "11110100" when "001010110", -- 87 
		 "11110001" when "001010111", -- 88 
		 "11111001" when "001011000", -- 89 
		 "00001011" when "001011001", -- 90 
		 "11111110" when "001011010", -- 91 
		 "11101001" when "001011011", -- 92 
		 "11111111" when "001011100", -- 93 
		 "00000111" when "001011101", -- 94 
		 "11110100" when "001011110", -- 95 
		 "00000000" when "001011111", -- 96 
		 "00001100" when "001100000", -- 97 
		 "11110100" when "001100001", -- 98 
		 "11111101" when "001100010", -- 99 
		 "00001101" when "001100011", -- 100 
		 "11110011" when "001100100", -- 101 
		 "00011111" when "001100101", -- 102 
		 "11110101" when "001100110", -- 103 
		 "11101111" when "001100111", -- 104 
		 "11110001" when "001101000", -- 105 
		 "11111111" when "001101001", -- 106 
		 "00000110" when "001101010", -- 107 
		 "11111100" when "001101011", -- 108 
		 "00000010" when "001101100", -- 109 
		 "11110010" when "001101101", -- 110 
		 "00000100" when "001101110", -- 111 
		 "00000000" when "001101111", -- 112 
		 "11111000" when "001110000", -- 113 
		 "11110110" when "001110001", -- 114 
		 "11111111" when "001110010", -- 115 
		 "00001001" when "001110011", -- 116 
		 "00100010" when "001110100", -- 117 
		 "11110100" when "001110101", -- 118 
		 "11101001" when "001110110", -- 119 
		 "11110110" when "001110111", -- 120 
		 "11100111" when "001111000", -- 121 
		 "11110110" when "001111001", -- 122 
		 "11111000" when "001111010", -- 123 
		 "00000011" when "001111011", -- 124 
		 "00000000" when "001111100", -- 125 
		 "11111111" when "001111101", -- 126 
		 "00000011" when "001111110", -- 127 
		 "00000000" when "001111111", -- 128 
		 "11110111" when "010000000", -- 129 
		 "00001111" when "010000001", -- 130 
		 "00001011" when "010000010", -- 131 
		 "00000011" when "010000011", -- 132 
		 "00000101" when "010000100", -- 133 
		 "11110111" when "010000101", -- 134 
		 "11110101" when "010000110", -- 135 
		 "11001100" when "010000111", -- 136 
		 "00000010" when "010001000", -- 137 
		 "00000110" when "010001001", -- 138 
		 "11111100" when "010001010", -- 139 
		 "00000100" when "010001011", -- 140 
		 "11111100" when "010001100", -- 141 
		 "11110010" when "010001101", -- 142 
		 "00001001" when "010001110", -- 143 
		 "11110101" when "010001111", -- 144 
		 "00000100" when "010010000", -- 145 
		 "00000100" when "010010001", -- 146 
		 "00010101" when "010010010", -- 147 
		 "00010001" when "010010011", -- 148 
		 "11111011" when "010010100", -- 149 
		 "11111001" when "010010101", -- 150 
		 "11111101" when "010010110", -- 151 
		 "00000101" when "010010111", -- 152 
		 "00001001" when "010011000", -- 153 
		 "11111011" when "010011001", -- 154 
		 "00010101" when "010011010", -- 155 
		 "00001001" when "010011011", -- 156 
		 "11111100" when "010011100", -- 157 
		 "00010010" when "010011101", -- 158 
		 "00001101" when "010011110", -- 159 
		 "11111101" when "010011111", -- 160 
		 "00001001" when "010100000", -- 161 
		 "11111111" when "010100001", -- 162 
		 "11111001" when "010100010", -- 163 
		 "11111000" when "010100011", -- 164 
		 "00010100" when "010100100", -- 165 
		 "11111000" when "010100101", -- 166 
		 "11111000" when "010100110", -- 167 
		 "11111110" when "010100111", -- 168 
		 "00000001" when "010101000", -- 169 
		 "00001111" when "010101001", -- 170 
		 "11101100" when "010101010", -- 171 
		 "11111101" when "010101011", -- 172 
		 "11111001" when "010101100", -- 173 
		 "11111101" when "010101101", -- 174 
		 "11111111" when "010101110", -- 175 
		 "00000011" when "010101111", -- 176 
		 "00001101" when "010110000", -- 177 
		 "00000110" when "010110001", -- 178 
		 "11111110" when "010110010", -- 179 
		 "00000110" when "010110011", -- 180 
		 "11100001" when "010110100", -- 181 
		 "11110110" when "010110101", -- 182 
		 "00000111" when "010110110", -- 183 
		 "11110100" when "010110111", -- 184 
		 "11111010" when "010111000", -- 185 
		 "11110011" when "010111001", -- 186 
		 "11110011" when "010111010", -- 187 
		 "00000001" when "010111011", -- 188 
		 "00000001" when "010111100", -- 189 
		 "00001000" when "010111101", -- 190 
		 "11111000" when "010111110", -- 191 
		 "11111111" when "010111111", -- 192 
		 "00001011" when "011000000", -- 193 
		 "00000100" when "011000001", -- 194 
		 "00001000" when "011000010", -- 195 
		 "11110110" when "011000011", -- 196 
		 "11110101" when "011000100", -- 197 
		 "00000001" when "011000101", -- 198 
		 "00000111" when "011000110", -- 199 
		 "00011100" when "011000111", -- 200 
		 "11111101" when "011001000", -- 201 
		 "11101110" when "011001001", -- 202 
		 "00000011" when "011001010", -- 203 
		 "11110001" when "011001011", -- 204 
		 "11111000" when "011001100", -- 205 
		 "11110110" when "011001101", -- 206 
		 "00000000" when "011001110", -- 207 
		 "11111101" when "011001111", -- 208 
		 "00000011" when "011010000", -- 209 
		 "11110111" when "011010001", -- 210 
		 "11110100" when "011010010", -- 211 
		 "00000111" when "011010011", -- 212 
		 "11110100" when "011010100", -- 213 
		 "00001011" when "011010101", -- 214 
		 "00000000" when "011010110", -- 215 
		 "00010010" when "011010111", -- 216 
		 "00000000" when "011011000", -- 217 
		 "11110100" when "011011001", -- 218 
		 "11111000" when "011011010", -- 219 
		 "00001100" when "011011011", -- 220 
		 "11111101" when "011011100", -- 221 
		 "11111111" when "011011101", -- 222 
		 "11111110" when "011011110", -- 223 
		 "11111100" when "011011111", -- 224 
		 "11110000" when "011100000", -- 225 
		 "11110011" when "011100001", -- 226 
		 "11111101" when "011100010", -- 227 
		 "11111011" when "011100011", -- 228 
		 "11111000" when "011100100", -- 229 
		 "11110000" when "011100101", -- 230 
		 "00010010" when "011100110", -- 231 
		 "00011010" when "011100111", -- 232 
		 "00000010" when "011101000", -- 233 
		 "11110000" when "011101001", -- 234 
		 "11110111" when "011101010", -- 235 
		 "00000110" when "011101011", -- 236 
		 "11111111" when "011101100", -- 237 
		 "11111111" when "011101101", -- 238 
		 "00000001" when "011101110", -- 239 
		 "00000011" when "011101111", -- 240 
		 "11111010" when "011110000", -- 241 
		 "00001101" when "011110001", -- 242 
		 "11110100" when "011110010", -- 243 
		 "11110010" when "011110011", -- 244 
		 "11111000" when "011110100", -- 245 
		 "11111101" when "011110101", -- 246 
		 "11101110" when "011110110", -- 247 
		 "11110111" when "011110111", -- 248 
		 "11101111" when "011111000", -- 249 
		 "11110011" when "011111001", -- 250 
		 "11111010" when "011111010", -- 251 
		 "00000100" when "011111011", -- 252 
		 "00000101" when "011111100", -- 253 
		 "00000101" when "011111101", -- 254 
		 "11111101" when "011111110", -- 255 
		 "11110111" when "011111111", -- 256 
		 "00000000" when "100000000", -- 257 
		 "11111111" when "100000001", -- 258 
		 "11111010" when "100000010", -- 259 
		 "00001001" when "100000011", -- 260 
		 "11110111" when "100000100", -- 261 
		 "00000011" when "100000101", -- 262 
		 "00000101" when "100000110", -- 263 
		 "11100001" when "100000111", -- 264 
		 "11111010" when "100001000", -- 265 
		 "11111111" when "100001001", -- 266 
		 "11111010" when "100001010", -- 267 
		 "11101111" when "100001011", -- 268 
		 "11101011" when "100001100", -- 269 
		 "11111010" when "100001101", -- 270 
		 "11110111" when "100001110", -- 271 
		 "00000010" when "100001111", -- 272 
		 "00010011" when "100010000", -- 273 
		 "00000001" when "100010001", -- 274 
		 "00000011" when "100010010", -- 275 
		 "00010011" when "100010011", -- 276 
		 "00000010" when "100010100", -- 277 
		 "11110011" when "100010101", -- 278 
		 "11110000" when "100010110", -- 279 
		 "00001010" when "100010111", -- 280 
		 "00000001" when "100011000", -- 281 
		 "11101111" when "100011001", -- 282 
		 "11110010" when "100011010", -- 283 
		 "00000000" when "100011011", -- 284 
		 "11110010" when "100011100", -- 285 
		 "11111111" when "100011101", -- 286 
		 "00001010" when "100011110", -- 287 
		 "11111110" when "100011111", -- 288 
		 "00000110" when "100100000", -- 289 
		 "00010111" when "100100001", -- 290 
		 "00000101" when "100100010", -- 291 
		 "00001010" when "100100011", -- 292 
		 "11110100" when "100100100", -- 293 
		 "11111011" when "100100101", -- 294 
		 "00010000" when "100100110", -- 295 
		 "00000101" when "100100111", -- 296 
		 "00000011" when "100101000", -- 297 
		 "00000100" when "100101001", -- 298 
		 "00000111" when "100101010", -- 299 
		 "00000011" when "100101011", -- 300 
		 "11111011" when "100101100", -- 301 
		 "00011100" when "100101101", -- 302 
		 "00000110" when "100101110", -- 303 
		 "11111001" when "100101111", -- 304 
		 "00010000" when "100110000", -- 305 
		 "00000001" when "100110001", -- 306 
		 "00000001" when "100110010", -- 307 
		 "00010011" when "100110011", -- 308 
		 "11100101" when "100110100", -- 309 
		 "00000110" when "100110101", -- 310 
		 "00000110" when "100110110", -- 311 
		 "11111101" when "100110111", -- 312 
		 "00001100" when "100111000", -- 313 
		 "11101101" when "100111001", -- 314 
		 "11110111" when "100111010", -- 315 
		 "00000001" when "100111011", -- 316 
		 "11110110" when "100111100", -- 317 
		 "00000110" when "100111101", -- 318 
		 "11111110" when "100111110", -- 319 
		 "11110101" when "100111111", -- 320 
		 "00000001" when "101000000", -- 321 
		 "11111100" when "101000001", -- 322 
		 "11111010" when "101000010", -- 323 
		 "11101110" when "101000011", -- 324 
		 "11111010" when "101000100", -- 325 
		 "11111011" when "101000101", -- 326 
		 "11101011" when "101000110", -- 327 
		 "00101100" when "101000111", -- 328 
		 "11110011" when "101001000", -- 329 
		 "00000010" when "101001001", -- 330 
		 "11111101" when "101001010", -- 331 
		 "11111000" when "101001011", -- 332 
		 "11110011" when "101001100", -- 333 
		 "11111001" when "101001101", -- 334 
		 "11111011" when "101001110", -- 335 
		 "00001100" when "101001111", -- 336 
		 "00001000" when "101010000", -- 337 
		 "00010100" when "101010001", -- 338 
		 "11111000" when "101010010", -- 339 
		 "11101111" when "101010011", -- 340 
		 "00000010" when "101010100", -- 341 
		 "11111000" when "101010101", -- 342 
		 "00001111" when "101010110", -- 343 
		 "11101111" when "101010111", -- 344 
		 "11101111" when "101011000", -- 345 
		 "11111010" when "101011001", -- 346 
		 "11110101" when "101011010", -- 347 
		 "11111110" when "101011011", -- 348 
		 "11111011" when "101011100", -- 349 
		 "00000010" when "101011101", -- 350 
		 "11111001" when "101011110", -- 351 
		 "00000100" when "101011111", -- 352 
		 "11111001" when "101100000", -- 353 
		 "11101110" when "101100001", -- 354 
		 "11101110" when "101100010", -- 355 
		 "00000111" when "101100011", -- 356 
		 "11110010" when "101100100", -- 357 
		 "11111011" when "101100101", -- 358 
		 "00010110" when "101100110", -- 359 
		 "11110100" when "101100111", -- 360 
		 "11110000" when "101101000", -- 361 
		 "00000000" when "101101001", -- 362 
		 "00001000" when "101101010", -- 363 
		 "11111110" when "101101011", -- 364 
		 "11111100" when "101101100", -- 365 
		 "11101100" when "101101101", -- 366 
		 "00000100" when "101101110", -- 367 
		 "11111110" when "101101111", -- 368 
		 "11111110" when "101110000", -- 369 
		 "00000010" when "101110001", -- 370 
		 "11111001" when "101110010", -- 371 
		 "00000100" when "101110011", -- 372 
		 "00011000" when "101110100", -- 373 
		 "00000100" when "101110101", -- 374 
		 "00100101" when "101110110", -- 375 
		 "11111010" when "101110111", -- 376 
		 "11101010" when "101111000", -- 377 
		 "00001010" when "101111001", -- 378 
		 "00001110" when "101111010", -- 379 
		 "00000101" when "101111011", -- 380 
		 "00010010" when "101111100", -- 381 
		 "11110101" when "101111101", -- 382 
		 "11111111" when "101111110", -- 383 
		 "00000011" when "101111111", -- 384 
		 "00000010" when "110000000", -- 385 
		 "00000100" when "110000001", -- 386 
		 "00000100" when "110000010", -- 387 
		 "11111010" when "110000011", -- 388 
		 "00000000" when "110000100", -- 389 
		 "11111101" when "110000101", -- 390 
		 "00000100" when "110000110", -- 391 
		 "11100000" when "110000111", -- 392 
		 "00000100" when "110001000", -- 393 
		 "11110100" when "110001001", -- 394 
		 "00000011" when "110001010", -- 395 
		 "00001001" when "110001011", -- 396 
		 "00000100" when "110001100", -- 397 
		 "00000000" when "110001101", -- 398 
		 "00000100" when "110001110", -- 399 
		 "11111101" when "110001111", -- 400 
		 "00000000" when others; 
 end Behavioral;

