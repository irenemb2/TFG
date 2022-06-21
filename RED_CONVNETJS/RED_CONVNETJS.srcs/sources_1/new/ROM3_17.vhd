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
entity ROM3_17 is
	Port (address : in STD_LOGIC_VECTOR(log2c(mult3) + log2c(number_of_layers3) - 1 downto 0);
		    bias_term :out UNSIGNED(input_size + weight_size + 3 - 1  downto 0); 
		    weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end ROM3_17; 
architecture Behavioral of  ROM3_17 is
begin
bias_term<= "0000000011100010010" ;
	with address select weight <= 
		 "11110101" when "0000000000", -- 1 
		 "00010101" when "0000000001", -- 2 
		 "11111111" when "0000000010", -- 3 
		 "00000100" when "0000000011", -- 4 
		 "11111110" when "0000000100", -- 5 
		 "11111011" when "0000000101", -- 6 
		 "11111110" when "0000000110", -- 7 
		 "11111000" when "0000000111", -- 8 
		 "11111001" when "0000001000", -- 9 
		 "00000111" when "0000001001", -- 10 
		 "00000010" when "0000001010", -- 11 
		 "00000010" when "0000001011", -- 12 
		 "11111011" when "0000001100", -- 13 
		 "11111010" when "0000001101", -- 14 
		 "11110110" when "0000001110", -- 15 
		 "11111101" when "0000001111", -- 16 
		 "11110011" when "0000010000", -- 17 
		 "00001101" when "0000010001", -- 18 
		 "11111101" when "0000010010", -- 19 
		 "00000000" when "0000010011", -- 20 
		 "00000001" when "0000100000", -- 21 
		 "00000001" when "0000100001", -- 22 
		 "00000100" when "0000100010", -- 23 
		 "00000111" when "0000100011", -- 24 
		 "00001001" when "0000100100", -- 25 
		 "11110100" when "0000100101", -- 26 
		 "11101010" when "0000100110", -- 27 
		 "11101111" when "0000100111", -- 28 
		 "11110101" when "0000101000", -- 29 
		 "11010100" when "0000101001", -- 30 
		 "11111011" when "0000101010", -- 31 
		 "11110101" when "0000101011", -- 32 
		 "11101111" when "0000101100", -- 33 
		 "11100011" when "0000101101", -- 34 
		 "11111110" when "0000101110", -- 35 
		 "00001011" when "0000101111", -- 36 
		 "11111110" when "0000110000", -- 37 
		 "00000010" when "0000110001", -- 38 
		 "00000110" when "0000110010", -- 39 
		 "11111010" when "0000110011", -- 40 
		 "11111100" when "0001000000", -- 41 
		 "11101111" when "0001000001", -- 42 
		 "00001010" when "0001000010", -- 43 
		 "11111101" when "0001000011", -- 44 
		 "11110111" when "0001000100", -- 45 
		 "11101111" when "0001000101", -- 46 
		 "00000011" when "0001000110", -- 47 
		 "00000101" when "0001000111", -- 48 
		 "00000001" when "0001001000", -- 49 
		 "11100110" when "0001001001", -- 50 
		 "11110100" when "0001001010", -- 51 
		 "00001001" when "0001001011", -- 52 
		 "00000111" when "0001001100", -- 53 
		 "00011010" when "0001001101", -- 54 
		 "11111110" when "0001001110", -- 55 
		 "11111010" when "0001001111", -- 56 
		 "00000011" when "0001010000", -- 57 
		 "00010110" when "0001010001", -- 58 
		 "11111000" when "0001010010", -- 59 
		 "11110110" when "0001010011", -- 60 
		 "11111101" when "0001100000", -- 61 
		 "11111111" when "0001100001", -- 62 
		 "00001010" when "0001100010", -- 63 
		 "11111100" when "0001100011", -- 64 
		 "00000000" when "0001100100", -- 65 
		 "11111001" when "0001100101", -- 66 
		 "11111110" when "0001100110", -- 67 
		 "00000001" when "0001100111", -- 68 
		 "11110111" when "0001101000", -- 69 
		 "11110101" when "0001101001", -- 70 
		 "11110111" when "0001101010", -- 71 
		 "11111011" when "0001101011", -- 72 
		 "00000001" when "0001101100", -- 73 
		 "11111100" when "0001101101", -- 74 
		 "00000110" when "0001101110", -- 75 
		 "00000011" when "0001101111", -- 76 
		 "00001000" when "0001110000", -- 77 
		 "11110111" when "0001110001", -- 78 
		 "11111111" when "0001110010", -- 79 
		 "11110110" when "0001110011", -- 80 
		 "11111111" when "0010000000", -- 81 
		 "11111011" when "0010000001", -- 82 
		 "00000110" when "0010000010", -- 83 
		 "11111110" when "0010000011", -- 84 
		 "11111011" when "0010000100", -- 85 
		 "11110011" when "0010000101", -- 86 
		 "11110001" when "0010000110", -- 87 
		 "00001001" when "0010000111", -- 88 
		 "11110101" when "0010001000", -- 89 
		 "11101010" when "0010001001", -- 90 
		 "11110011" when "0010001010", -- 91 
		 "00000011" when "0010001011", -- 92 
		 "11111101" when "0010001100", -- 93 
		 "11101010" when "0010001101", -- 94 
		 "11101110" when "0010001110", -- 95 
		 "00010110" when "0010001111", -- 96 
		 "11101111" when "0010010000", -- 97 
		 "11110000" when "0010010001", -- 98 
		 "11110110" when "0010010010", -- 99 
		 "00010110" when "0010010011", -- 100 
		 "00001000" when "0010100000", -- 101 
		 "11111101" when "0010100001", -- 102 
		 "11110110" when "0010100010", -- 103 
		 "00001010" when "0010100011", -- 104 
		 "11111110" when "0010100100", -- 105 
		 "00000100" when "0010100101", -- 106 
		 "11101010" when "0010100110", -- 107 
		 "00000000" when "0010100111", -- 108 
		 "11111000" when "0010101000", -- 109 
		 "00000000" when "0010101001", -- 110 
		 "11111001" when "0010101010", -- 111 
		 "11101101" when "0010101011", -- 112 
		 "11111011" when "0010101100", -- 113 
		 "11101011" when "0010101101", -- 114 
		 "00000100" when "0010101110", -- 115 
		 "11110110" when "0010101111", -- 116 
		 "00001000" when "0010110000", -- 117 
		 "11110010" when "0010110001", -- 118 
		 "11111111" when "0010110010", -- 119 
		 "00010000" when "0010110011", -- 120 
		 "00000100" when "0011000000", -- 121 
		 "00010010" when "0011000001", -- 122 
		 "00001000" when "0011000010", -- 123 
		 "00000100" when "0011000011", -- 124 
		 "00000001" when "0011000100", -- 125 
		 "00000011" when "0011000101", -- 126 
		 "00000110" when "0011000110", -- 127 
		 "00000101" when "0011000111", -- 128 
		 "11110100" when "0011001000", -- 129 
		 "11111110" when "0011001001", -- 130 
		 "11110110" when "0011001010", -- 131 
		 "11110000" when "0011001011", -- 132 
		 "11111110" when "0011001100", -- 133 
		 "11111101" when "0011001101", -- 134 
		 "11110111" when "0011001110", -- 135 
		 "11101111" when "0011001111", -- 136 
		 "00010111" when "0011010000", -- 137 
		 "00000000" when "0011010001", -- 138 
		 "11110011" when "0011010010", -- 139 
		 "11100011" when "0011010011", -- 140 
		 "11100011" when "0011100000", -- 141 
		 "00001101" when "0011100001", -- 142 
		 "00000100" when "0011100010", -- 143 
		 "11110101" when "0011100011", -- 144 
		 "11110101" when "0011100100", -- 145 
		 "11110101" when "0011100101", -- 146 
		 "11111110" when "0011100110", -- 147 
		 "11111001" when "0011100111", -- 148 
		 "00001100" when "0011101000", -- 149 
		 "11110101" when "0011101001", -- 150 
		 "11111001" when "0011101010", -- 151 
		 "11111110" when "0011101011", -- 152 
		 "00011101" when "0011101100", -- 153 
		 "11111110" when "0011101101", -- 154 
		 "11111100" when "0011101110", -- 155 
		 "00001000" when "0011101111", -- 156 
		 "11111100" when "0011110000", -- 157 
		 "00000111" when "0011110001", -- 158 
		 "11110111" when "0011110010", -- 159 
		 "11111110" when "0011110011", -- 160 
		 "00000111" when "0100000000", -- 161 
		 "11110110" when "0100000001", -- 162 
		 "11110100" when "0100000010", -- 163 
		 "00000011" when "0100000011", -- 164 
		 "11111010" when "0100000100", -- 165 
		 "00000111" when "0100000101", -- 166 
		 "11111101" when "0100000110", -- 167 
		 "00000001" when "0100000111", -- 168 
		 "11111111" when "0100001000", -- 169 
		 "00000000" when "0100001001", -- 170 
		 "11111111" when "0100001010", -- 171 
		 "11111110" when "0100001011", -- 172 
		 "11111000" when "0100001100", -- 173 
		 "11110110" when "0100001101", -- 174 
		 "00000100" when "0100001110", -- 175 
		 "11111110" when "0100001111", -- 176 
		 "11110000" when "0100010000", -- 177 
		 "00000110" when "0100010001", -- 178 
		 "00001010" when "0100010010", -- 179 
		 "00001011" when "0100010011", -- 180 
		 "00000011" when "0100100000", -- 181 
		 "00001001" when "0100100001", -- 182 
		 "00000001" when "0100100010", -- 183 
		 "00000111" when "0100100011", -- 184 
		 "00000100" when "0100100100", -- 185 
		 "11111000" when "0100100101", -- 186 
		 "11111101" when "0100100110", -- 187 
		 "11111111" when "0100100111", -- 188 
		 "11110010" when "0100101000", -- 189 
		 "11111000" when "0100101001", -- 190 
		 "00000001" when "0100101010", -- 191 
		 "11111001" when "0100101011", -- 192 
		 "11101010" when "0100101100", -- 193 
		 "11111000" when "0100101101", -- 194 
		 "00000001" when "0100101110", -- 195 
		 "11101101" when "0100101111", -- 196 
		 "11111010" when "0100110000", -- 197 
		 "11110111" when "0100110001", -- 198 
		 "11101000" when "0100110010", -- 199 
		 "11111100" when "0100110011", -- 200 
		 "11110100" when "0101000000", -- 201 
		 "00001011" when "0101000001", -- 202 
		 "00001010" when "0101000010", -- 203 
		 "11111000" when "0101000011", -- 204 
		 "11111111" when "0101000100", -- 205 
		 "11110100" when "0101000101", -- 206 
		 "00000010" when "0101000110", -- 207 
		 "11111011" when "0101000111", -- 208 
		 "00000101" when "0101001000", -- 209 
		 "11111100" when "0101001001", -- 210 
		 "11110011" when "0101001010", -- 211 
		 "11101111" when "0101001011", -- 212 
		 "11110010" when "0101001100", -- 213 
		 "00001011" when "0101001101", -- 214 
		 "00000101" when "0101001110", -- 215 
		 "00000010" when "0101001111", -- 216 
		 "11111101" when "0101010000", -- 217 
		 "11111111" when "0101010001", -- 218 
		 "00001011" when "0101010010", -- 219 
		 "00000111" when "0101010011", -- 220 
		 "00010110" when "0101100000", -- 221 
		 "11111010" when "0101100001", -- 222 
		 "11111111" when "0101100010", -- 223 
		 "11110101" when "0101100011", -- 224 
		 "00010010" when "0101100100", -- 225 
		 "11111000" when "0101100101", -- 226 
		 "11111110" when "0101100110", -- 227 
		 "11111001" when "0101100111", -- 228 
		 "11111110" when "0101101000", -- 229 
		 "11111001" when "0101101001", -- 230 
		 "11110000" when "0101101010", -- 231 
		 "00000011" when "0101101011", -- 232 
		 "00000011" when "0101101100", -- 233 
		 "00001111" when "0101101101", -- 234 
		 "11111011" when "0101101110", -- 235 
		 "00001001" when "0101101111", -- 236 
		 "00000001" when "0101110000", -- 237 
		 "11110011" when "0101110001", -- 238 
		 "00000001" when "0101110010", -- 239 
		 "00000011" when "0101110011", -- 240 
		 "00010000" when "0110000000", -- 241 
		 "00000110" when "0110000001", -- 242 
		 "00000000" when "0110000010", -- 243 
		 "11110000" when "0110000011", -- 244 
		 "11110101" when "0110000100", -- 245 
		 "11111101" when "0110000101", -- 246 
		 "11101110" when "0110000110", -- 247 
		 "11101111" when "0110000111", -- 248 
		 "11101111" when "0110001000", -- 249 
		 "11110011" when "0110001001", -- 250 
		 "11101011" when "0110001010", -- 251 
		 "00000010" when "0110001011", -- 252 
		 "00000110" when "0110001100", -- 253 
		 "00001001" when "0110001101", -- 254 
		 "11110010" when "0110001110", -- 255 
		 "00101000" when "0110001111", -- 256 
		 "11111111" when "0110010000", -- 257 
		 "11110001" when "0110010001", -- 258 
		 "11110011" when "0110010010", -- 259 
		 "00000100" when "0110010011", -- 260 
		 "00000110" when "0110100000", -- 261 
		 "00000111" when "0110100001", -- 262 
		 "00000000" when "0110100010", -- 263 
		 "00000001" when "0110100011", -- 264 
		 "11111011" when "0110100100", -- 265 
		 "00000001" when "0110100101", -- 266 
		 "00001010" when "0110100110", -- 267 
		 "11111010" when "0110100111", -- 268 
		 "00000110" when "0110101000", -- 269 
		 "11111001" when "0110101001", -- 270 
		 "00000001" when "0110101010", -- 271 
		 "11110001" when "0110101011", -- 272 
		 "00001000" when "0110101100", -- 273 
		 "11110110" when "0110101101", -- 274 
		 "00000100" when "0110101110", -- 275 
		 "11100100" when "0110101111", -- 276 
		 "11111100" when "0110110000", -- 277 
		 "11111001" when "0110110001", -- 278 
		 "00000010" when "0110110010", -- 279 
		 "11101101" when "0110110011", -- 280 
		 "00000111" when "0111000000", -- 281 
		 "00000001" when "0111000001", -- 282 
		 "11111111" when "0111000010", -- 283 
		 "00000110" when "0111000011", -- 284 
		 "00000000" when "0111000100", -- 285 
		 "00000001" when "0111000101", -- 286 
		 "11101110" when "0111000110", -- 287 
		 "00001000" when "0111000111", -- 288 
		 "00000101" when "0111001000", -- 289 
		 "00001101" when "0111001001", -- 290 
		 "11111110" when "0111001010", -- 291 
		 "00001011" when "0111001011", -- 292 
		 "00000001" when "0111001100", -- 293 
		 "11111100" when "0111001101", -- 294 
		 "11111111" when "0111001110", -- 295 
		 "11110010" when "0111001111", -- 296 
		 "11111100" when "0111010000", -- 297 
		 "11101001" when "0111010001", -- 298 
		 "00001100" when "0111010010", -- 299 
		 "11110111" when "0111010011", -- 300 
		 "11110011" when "0111100000", -- 301 
		 "11111111" when "0111100001", -- 302 
		 "11110101" when "0111100010", -- 303 
		 "00000100" when "0111100011", -- 304 
		 "11111111" when "0111100100", -- 305 
		 "11110101" when "0111100101", -- 306 
		 "11100011" when "0111100110", -- 307 
		 "00000010" when "0111100111", -- 308 
		 "00000000" when "0111101000", -- 309 
		 "11111110" when "0111101001", -- 310 
		 "11110011" when "0111101010", -- 311 
		 "11111001" when "0111101011", -- 312 
		 "11110100" when "0111101100", -- 313 
		 "11101111" when "0111101101", -- 314 
		 "11111100" when "0111101110", -- 315 
		 "11101011" when "0111101111", -- 316 
		 "00000000" when "0111110000", -- 317 
		 "00001010" when "0111110001", -- 318 
		 "11111000" when "0111110010", -- 319 
		 "11110010" when "0111110011", -- 320 
		 "11111011" when "1000000000", -- 321 
		 "00000000" when "1000000001", -- 322 
		 "11111100" when "1000000010", -- 323 
		 "00001011" when "1000000011", -- 324 
		 "00001001" when "1000000100", -- 325 
		 "11111111" when "1000000101", -- 326 
		 "11111001" when "1000000110", -- 327 
		 "11101010" when "1000000111", -- 328 
		 "00001101" when "1000001000", -- 329 
		 "00000110" when "1000001001", -- 330 
		 "11101010" when "1000001010", -- 331 
		 "11110011" when "1000001011", -- 332 
		 "00001110" when "1000001100", -- 333 
		 "00000010" when "1000001101", -- 334 
		 "11110000" when "1000001110", -- 335 
		 "00000000" when "1000001111", -- 336 
		 "11101111" when "1000010000", -- 337 
		 "00010110" when "1000010001", -- 338 
		 "00001011" when "1000010010", -- 339 
		 "11111000" when "1000010011", -- 340 
		 "11111000" when "1000100000", -- 341 
		 "00000101" when "1000100001", -- 342 
		 "11111010" when "1000100010", -- 343 
		 "11111111" when "1000100011", -- 344 
		 "11110001" when "1000100100", -- 345 
		 "11101001" when "1000100101", -- 346 
		 "11011010" when "1000100110", -- 347 
		 "00000100" when "1000100111", -- 348 
		 "11110001" when "1000101000", -- 349 
		 "11100011" when "1000101001", -- 350 
		 "11101000" when "1000101010", -- 351 
		 "00000110" when "1000101011", -- 352 
		 "11111010" when "1000101100", -- 353 
		 "11111011" when "1000101101", -- 354 
		 "11111101" when "1000101110", -- 355 
		 "11110011" when "1000101111", -- 356 
		 "00010011" when "1000110000", -- 357 
		 "11111000" when "1000110001", -- 358 
		 "00000111" when "1000110010", -- 359 
		 "11110001" when "1000110011", -- 360 
		 "00000011" when "1001000000", -- 361 
		 "11111110" when "1001000001", -- 362 
		 "00000010" when "1001000010", -- 363 
		 "00001110" when "1001000011", -- 364 
		 "11110101" when "1001000100", -- 365 
		 "00001011" when "1001000101", -- 366 
		 "11111010" when "1001000110", -- 367 
		 "00000111" when "1001000111", -- 368 
		 "11110010" when "1001001000", -- 369 
		 "00001000" when "1001001001", -- 370 
		 "00000101" when "1001001010", -- 371 
		 "11111010" when "1001001011", -- 372 
		 "11111001" when "1001001100", -- 373 
		 "00001010" when "1001001101", -- 374 
		 "00001111" when "1001001110", -- 375 
		 "11101110" when "1001001111", -- 376 
		 "11111000" when "1001010000", -- 377 
		 "00000011" when "1001010001", -- 378 
		 "00000100" when "1001010010", -- 379 
		 "11011101" when "1001010011", -- 380 
		 "11111101" when "1001100000", -- 381 
		 "00000110" when "1001100001", -- 382 
		 "00001100" when "1001100010", -- 383 
		 "00001001" when "1001100011", -- 384 
		 "00000100" when "1001100100", -- 385 
		 "11111000" when "1001100101", -- 386 
		 "11111100" when "1001100110", -- 387 
		 "00000100" when "1001100111", -- 388 
		 "00000000" when "1001101000", -- 389 
		 "00001001" when "1001101001", -- 390 
		 "11111101" when "1001101010", -- 391 
		 "11110110" when "1001101011", -- 392 
		 "00001010" when "1001101100", -- 393 
		 "11110111" when "1001101101", -- 394 
		 "11101100" when "1001101110", -- 395 
		 "11111001" when "1001101111", -- 396 
		 "11110000" when "1001110000", -- 397 
		 "00000010" when "1001110001", -- 398 
		 "00001001" when "1001110010", -- 399 
		 "11111101" when "1001110011", -- 400 
		 "00001010" when "1010000000", -- 401 
		 "00000010" when "1010000001", -- 402 
		 "00000111" when "1010000010", -- 403 
		 "00000001" when "1010000011", -- 404 
		 "00001000" when "1010000100", -- 405 
		 "11110000" when "1010000101", -- 406 
		 "11111110" when "1010000110", -- 407 
		 "00010001" when "1010000111", -- 408 
		 "00001000" when "1010001000", -- 409 
		 "11111101" when "1010001001", -- 410 
		 "00000011" when "1010001010", -- 411 
		 "00010000" when "1010001011", -- 412 
		 "11101011" when "1010001100", -- 413 
		 "00000111" when "1010001101", -- 414 
		 "00000010" when "1010001110", -- 415 
		 "00001000" when "1010001111", -- 416 
		 "11110001" when "1010010000", -- 417 
		 "00000000" when "1010010001", -- 418 
		 "00001100" when "1010010010", -- 419 
		 "11110110" when "1010010011", -- 420 
		 "00000110" when "1010100000", -- 421 
		 "00001000" when "1010100001", -- 422 
		 "00000001" when "1010100010", -- 423 
		 "11110011" when "1010100011", -- 424 
		 "00001010" when "1010100100", -- 425 
		 "11111001" when "1010100101", -- 426 
		 "11011110" when "1010100110", -- 427 
		 "11101110" when "1010100111", -- 428 
		 "11111111" when "1010101000", -- 429 
		 "11011011" when "1010101001", -- 430 
		 "11110000" when "1010101010", -- 431 
		 "00010010" when "1010101011", -- 432 
		 "11111101" when "1010101100", -- 433 
		 "11011011" when "1010101101", -- 434 
		 "11110111" when "1010101110", -- 435 
		 "00001100" when "1010101111", -- 436 
		 "00001110" when "1010110000", -- 437 
		 "11111111" when "1010110001", -- 438 
		 "11110111" when "1010110010", -- 439 
		 "11110101" when "1010110011", -- 440 
		 "11111100" when "1011000000", -- 441 
		 "11110100" when "1011000001", -- 442 
		 "00000001" when "1011000010", -- 443 
		 "11111001" when "1011000011", -- 444 
		 "11101101" when "1011000100", -- 445 
		 "11010111" when "1011000101", -- 446 
		 "11111000" when "1011000110", -- 447 
		 "11110011" when "1011000111", -- 448 
		 "11111000" when "1011001000", -- 449 
		 "11111010" when "1011001001", -- 450 
		 "00001000" when "1011001010", -- 451 
		 "00000111" when "1011001011", -- 452 
		 "00010000" when "1011001100", -- 453 
		 "00000001" when "1011001101", -- 454 
		 "11111101" when "1011001110", -- 455 
		 "00000010" when "1011001111", -- 456 
		 "00001001" when "1011010000", -- 457 
		 "11100100" when "1011010001", -- 458 
		 "11110010" when "1011010010", -- 459 
		 "00001101" when "1011010011", -- 460 
		 "11111011" when "1011100000", -- 461 
		 "00000001" when "1011100001", -- 462 
		 "00001011" when "1011100010", -- 463 
		 "00000111" when "1011100011", -- 464 
		 "11111001" when "1011100100", -- 465 
		 "11110010" when "1011100101", -- 466 
		 "00000100" when "1011100110", -- 467 
		 "00001000" when "1011100111", -- 468 
		 "00000010" when "1011101000", -- 469 
		 "00001000" when "1011101001", -- 470 
		 "11111110" when "1011101010", -- 471 
		 "00000001" when "1011101011", -- 472 
		 "00000010" when "1011101100", -- 473 
		 "00011000" when "1011101101", -- 474 
		 "11111101" when "1011101110", -- 475 
		 "11110101" when "1011101111", -- 476 
		 "00000010" when "1011110000", -- 477 
		 "00010010" when "1011110001", -- 478 
		 "11111000" when "1011110010", -- 479 
		 "11101100" when "1011110011", -- 480 
		 "00000100" when "1100000000", -- 481 
		 "00000011" when "1100000001", -- 482 
		 "00001001" when "1100000010", -- 483 
		 "00000110" when "1100000011", -- 484 
		 "11111111" when "1100000100", -- 485 
		 "11111011" when "1100000101", -- 486 
		 "11111101" when "1100000110", -- 487 
		 "11110110" when "1100000111", -- 488 
		 "11110101" when "1100001000", -- 489 
		 "11110010" when "1100001001", -- 490 
		 "11111001" when "1100001010", -- 491 
		 "11101110" when "1100001011", -- 492 
		 "11101011" when "1100001100", -- 493 
		 "11111000" when "1100001101", -- 494 
		 "11110000" when "1100001110", -- 495 
		 "11110111" when "1100001111", -- 496 
		 "11111010" when "1100010000", -- 497 
		 "00000101" when "1100010001", -- 498 
		 "00000010" when "1100010010", -- 499 
		 "11111111" when "1100010011", -- 500 
		 "00000000" when others; 
 end Behavioral;

