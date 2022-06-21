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
entity ROM3_14 is
	Port (address : in STD_LOGIC_VECTOR(log2c(mult3) + log2c(number_of_layers3) - 1 downto 0);
		    bias_term :out UNSIGNED(input_size + weight_size + 3 - 1  downto 0); 
		    weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end ROM3_14; 
architecture Behavioral of  ROM3_14 is
begin
bias_term<= "0000001100100011000" ;
	with address select weight <= 
		 "11110100" when "0000000000", -- 1 
		 "00000001" when "0000000001", -- 2 
		 "00000001" when "0000000010", -- 3 
		 "11111101" when "0000000011", -- 4 
		 "11111110" when "0000000100", -- 5 
		 "00000011" when "0000000101", -- 6 
		 "00001011" when "0000000110", -- 7 
		 "11111111" when "0000000111", -- 8 
		 "11111010" when "0000001000", -- 9 
		 "11110111" when "0000001001", -- 10 
		 "11111010" when "0000001010", -- 11 
		 "00000001" when "0000001011", -- 12 
		 "00000100" when "0000001100", -- 13 
		 "00001001" when "0000001101", -- 14 
		 "00000000" when "0000001110", -- 15 
		 "11111011" when "0000001111", -- 16 
		 "00000101" when "0000010000", -- 17 
		 "11111011" when "0000010001", -- 18 
		 "00000011" when "0000010010", -- 19 
		 "11110101" when "0000010011", -- 20 
		 "11111001" when "0000100000", -- 21 
		 "11110111" when "0000100001", -- 22 
		 "11110100" when "0000100010", -- 23 
		 "00000111" when "0000100011", -- 24 
		 "11111101" when "0000100100", -- 25 
		 "11111111" when "0000100101", -- 26 
		 "11101111" when "0000100110", -- 27 
		 "00000000" when "0000100111", -- 28 
		 "00000000" when "0000101000", -- 29 
		 "11110110" when "0000101001", -- 30 
		 "11110011" when "0000101010", -- 31 
		 "11111110" when "0000101011", -- 32 
		 "11111100" when "0000101100", -- 33 
		 "11111100" when "0000101101", -- 34 
		 "11110001" when "0000101110", -- 35 
		 "11111110" when "0000101111", -- 36 
		 "11101000" when "0000110000", -- 37 
		 "11111100" when "0000110001", -- 38 
		 "11111110" when "0000110010", -- 39 
		 "00000000" when "0000110011", -- 40 
		 "11110111" when "0001000000", -- 41 
		 "11111010" when "0001000001", -- 42 
		 "00001011" when "0001000010", -- 43 
		 "11110111" when "0001000011", -- 44 
		 "00010011" when "0001000100", -- 45 
		 "00000000" when "0001000101", -- 46 
		 "11101110" when "0001000110", -- 47 
		 "11111000" when "0001000111", -- 48 
		 "00001000" when "0001001000", -- 49 
		 "11111110" when "0001001001", -- 50 
		 "11101001" when "0001001010", -- 51 
		 "11101101" when "0001001011", -- 52 
		 "11111011" when "0001001100", -- 53 
		 "11111100" when "0001001101", -- 54 
		 "00000000" when "0001001110", -- 55 
		 "11110101" when "0001001111", -- 56 
		 "11111100" when "0001010000", -- 57 
		 "11110000" when "0001010001", -- 58 
		 "11111100" when "0001010010", -- 59 
		 "00001011" when "0001010011", -- 60 
		 "11111001" when "0001100000", -- 61 
		 "00000000" when "0001100001", -- 62 
		 "11101101" when "0001100010", -- 63 
		 "11111011" when "0001100011", -- 64 
		 "11110000" when "0001100100", -- 65 
		 "11110100" when "0001100101", -- 66 
		 "00000001" when "0001100110", -- 67 
		 "11101110" when "0001100111", -- 68 
		 "00001011" when "0001101000", -- 69 
		 "11111000" when "0001101001", -- 70 
		 "11111100" when "0001101010", -- 71 
		 "11101100" when "0001101011", -- 72 
		 "00000011" when "0001101100", -- 73 
		 "00000011" when "0001101101", -- 74 
		 "00000010" when "0001101110", -- 75 
		 "00000000" when "0001101111", -- 76 
		 "11111101" when "0001110000", -- 77 
		 "00001101" when "0001110001", -- 78 
		 "00000001" when "0001110010", -- 79 
		 "00000101" when "0001110011", -- 80 
		 "00000000" when "0010000000", -- 81 
		 "11111110" when "0010000001", -- 82 
		 "11111011" when "0010000010", -- 83 
		 "00001001" when "0010000011", -- 84 
		 "11110010" when "0010000100", -- 85 
		 "00001000" when "0010000101", -- 86 
		 "00000010" when "0010000110", -- 87 
		 "11111101" when "0010000111", -- 88 
		 "11111011" when "0010001000", -- 89 
		 "11111110" when "0010001001", -- 90 
		 "11111011" when "0010001010", -- 91 
		 "00000000" when "0010001011", -- 92 
		 "00000100" when "0010001100", -- 93 
		 "00000011" when "0010001101", -- 94 
		 "11111101" when "0010001110", -- 95 
		 "00001100" when "0010001111", -- 96 
		 "00000001" when "0010010000", -- 97 
		 "11110101" when "0010010001", -- 98 
		 "00000001" when "0010010010", -- 99 
		 "11111001" when "0010010011", -- 100 
		 "00001011" when "0010100000", -- 101 
		 "00000001" when "0010100001", -- 102 
		 "11110101" when "0010100010", -- 103 
		 "11111111" when "0010100011", -- 104 
		 "11111011" when "0010100100", -- 105 
		 "11111111" when "0010100101", -- 106 
		 "11111110" when "0010100110", -- 107 
		 "11111010" when "0010100111", -- 108 
		 "11111011" when "0010101000", -- 109 
		 "00000011" when "0010101001", -- 110 
		 "11111000" when "0010101010", -- 111 
		 "11111101" when "0010101011", -- 112 
		 "00000010" when "0010101100", -- 113 
		 "00000110" when "0010101101", -- 114 
		 "11111001" when "0010101110", -- 115 
		 "00000011" when "0010101111", -- 116 
		 "00000000" when "0010110000", -- 117 
		 "11110101" when "0010110001", -- 118 
		 "00000010" when "0010110010", -- 119 
		 "00000010" when "0010110011", -- 120 
		 "00011111" when "0011000000", -- 121 
		 "00010001" when "0011000001", -- 122 
		 "11111010" when "0011000010", -- 123 
		 "11111111" when "0011000011", -- 124 
		 "00000010" when "0011000100", -- 125 
		 "11110101" when "0011000101", -- 126 
		 "00000100" when "0011000110", -- 127 
		 "11110110" when "0011000111", -- 128 
		 "11101001" when "0011001000", -- 129 
		 "11110011" when "0011001001", -- 130 
		 "00001001" when "0011001010", -- 131 
		 "11110011" when "0011001011", -- 132 
		 "00000010" when "0011001100", -- 133 
		 "11111011" when "0011001101", -- 134 
		 "11111101" when "0011001110", -- 135 
		 "11110101" when "0011001111", -- 136 
		 "00000011" when "0011010000", -- 137 
		 "00000010" when "0011010001", -- 138 
		 "11111100" when "0011010010", -- 139 
		 "00000011" when "0011010011", -- 140 
		 "11111110" when "0011100000", -- 141 
		 "11110010" when "0011100001", -- 142 
		 "11110011" when "0011100010", -- 143 
		 "11111010" when "0011100011", -- 144 
		 "11111111" when "0011100100", -- 145 
		 "11110111" when "0011100101", -- 146 
		 "11111010" when "0011100110", -- 147 
		 "00001001" when "0011100111", -- 148 
		 "11111001" when "0011101000", -- 149 
		 "00000010" when "0011101001", -- 150 
		 "00000100" when "0011101010", -- 151 
		 "00000110" when "0011101011", -- 152 
		 "00000000" when "0011101100", -- 153 
		 "00010011" when "0011101101", -- 154 
		 "11111100" when "0011101110", -- 155 
		 "11111100" when "0011101111", -- 156 
		 "11111001" when "0011110000", -- 157 
		 "00000000" when "0011110001", -- 158 
		 "00001111" when "0011110010", -- 159 
		 "11111110" when "0011110011", -- 160 
		 "00000100" when "0100000000", -- 161 
		 "11111011" when "0100000001", -- 162 
		 "00000001" when "0100000010", -- 163 
		 "00000000" when "0100000011", -- 164 
		 "11111001" when "0100000100", -- 165 
		 "11111110" when "0100000101", -- 166 
		 "11101010" when "0100000110", -- 167 
		 "00000101" when "0100000111", -- 168 
		 "11111010" when "0100001000", -- 169 
		 "11111100" when "0100001001", -- 170 
		 "11100001" when "0100001010", -- 171 
		 "00000111" when "0100001011", -- 172 
		 "00000010" when "0100001100", -- 173 
		 "00000100" when "0100001101", -- 174 
		 "11111011" when "0100001110", -- 175 
		 "11111111" when "0100001111", -- 176 
		 "11111011" when "0100010000", -- 177 
		 "11111111" when "0100010001", -- 178 
		 "11111110" when "0100010010", -- 179 
		 "00000111" when "0100010011", -- 180 
		 "11111010" when "0100100000", -- 181 
		 "11110010" when "0100100001", -- 182 
		 "00001111" when "0100100010", -- 183 
		 "00000101" when "0100100011", -- 184 
		 "11111011" when "0100100100", -- 185 
		 "11101110" when "0100100101", -- 186 
		 "00000010" when "0100100110", -- 187 
		 "11111001" when "0100100111", -- 188 
		 "00000010" when "0100101000", -- 189 
		 "11101011" when "0100101001", -- 190 
		 "11111101" when "0100101010", -- 191 
		 "00000111" when "0100101011", -- 192 
		 "00000100" when "0100101100", -- 193 
		 "00000001" when "0100101101", -- 194 
		 "11110011" when "0100101110", -- 195 
		 "00000001" when "0100101111", -- 196 
		 "00000000" when "0100110000", -- 197 
		 "00001100" when "0100110001", -- 198 
		 "11110100" when "0100110010", -- 199 
		 "11111101" when "0100110011", -- 200 
		 "11110111" when "0101000000", -- 201 
		 "11110111" when "0101000001", -- 202 
		 "11111011" when "0101000010", -- 203 
		 "11100111" when "0101000011", -- 204 
		 "11111010" when "0101000100", -- 205 
		 "11110110" when "0101000101", -- 206 
		 "11111101" when "0101000110", -- 207 
		 "11110101" when "0101000111", -- 208 
		 "11111010" when "0101001000", -- 209 
		 "11110100" when "0101001001", -- 210 
		 "11111010" when "0101001010", -- 211 
		 "11111010" when "0101001011", -- 212 
		 "00000000" when "0101001100", -- 213 
		 "00000010" when "0101001101", -- 214 
		 "11111110" when "0101001110", -- 215 
		 "11111000" when "0101001111", -- 216 
		 "00000011" when "0101010000", -- 217 
		 "00000101" when "0101010001", -- 218 
		 "00000000" when "0101010010", -- 219 
		 "11110110" when "0101010011", -- 220 
		 "00001001" when "0101100000", -- 221 
		 "00010000" when "0101100001", -- 222 
		 "11111000" when "0101100010", -- 223 
		 "00001011" when "0101100011", -- 224 
		 "11101111" when "0101100100", -- 225 
		 "11111010" when "0101100101", -- 226 
		 "11110101" when "0101100110", -- 227 
		 "00000100" when "0101100111", -- 228 
		 "11111110" when "0101101000", -- 229 
		 "11101100" when "0101101001", -- 230 
		 "00000001" when "0101101010", -- 231 
		 "00000110" when "0101101011", -- 232 
		 "00001001" when "0101101100", -- 233 
		 "11111001" when "0101101101", -- 234 
		 "00001000" when "0101101110", -- 235 
		 "00000101" when "0101101111", -- 236 
		 "00000100" when "0101110000", -- 237 
		 "11110101" when "0101110001", -- 238 
		 "00011000" when "0101110010", -- 239 
		 "00000001" when "0101110011", -- 240 
		 "00001100" when "0110000000", -- 241 
		 "11110110" when "0110000001", -- 242 
		 "11111001" when "0110000010", -- 243 
		 "11110011" when "0110000011", -- 244 
		 "11110101" when "0110000100", -- 245 
		 "00001000" when "0110000101", -- 246 
		 "11111010" when "0110000110", -- 247 
		 "00000001" when "0110000111", -- 248 
		 "11110111" when "0110001000", -- 249 
		 "11111000" when "0110001001", -- 250 
		 "00000101" when "0110001010", -- 251 
		 "11111110" when "0110001011", -- 252 
		 "11110010" when "0110001100", -- 253 
		 "11111001" when "0110001101", -- 254 
		 "00001111" when "0110001110", -- 255 
		 "00000001" when "0110001111", -- 256 
		 "11101111" when "0110010000", -- 257 
		 "00000011" when "0110010001", -- 258 
		 "00000100" when "0110010010", -- 259 
		 "11111110" when "0110010011", -- 260 
		 "11111111" when "0110100000", -- 261 
		 "00001111" when "0110100001", -- 262 
		 "00000000" when "0110100010", -- 263 
		 "00000101" when "0110100011", -- 264 
		 "11110001" when "0110100100", -- 265 
		 "11111010" when "0110100101", -- 266 
		 "00000000" when "0110100110", -- 267 
		 "11111010" when "0110100111", -- 268 
		 "11111010" when "0110101000", -- 269 
		 "11100111" when "0110101001", -- 270 
		 "00000001" when "0110101010", -- 271 
		 "00000101" when "0110101011", -- 272 
		 "00000111" when "0110101100", -- 273 
		 "11111110" when "0110101101", -- 274 
		 "11110110" when "0110101110", -- 275 
		 "11111110" when "0110101111", -- 276 
		 "00000000" when "0110110000", -- 277 
		 "11111010" when "0110110001", -- 278 
		 "00001001" when "0110110010", -- 279 
		 "00000100" when "0110110011", -- 280 
		 "11110101" when "0111000000", -- 281 
		 "11110111" when "0111000001", -- 282 
		 "11111111" when "0111000010", -- 283 
		 "00000001" when "0111000011", -- 284 
		 "11110100" when "0111000100", -- 285 
		 "11111010" when "0111000101", -- 286 
		 "11110101" when "0111000110", -- 287 
		 "11110111" when "0111000111", -- 288 
		 "11111000" when "0111001000", -- 289 
		 "11110100" when "0111001001", -- 290 
		 "00000010" when "0111001010", -- 291 
		 "11111101" when "0111001011", -- 292 
		 "11111000" when "0111001100", -- 293 
		 "11110101" when "0111001101", -- 294 
		 "00000101" when "0111001110", -- 295 
		 "11111101" when "0111001111", -- 296 
		 "00000001" when "0111010000", -- 297 
		 "11111000" when "0111010001", -- 298 
		 "11111010" when "0111010010", -- 299 
		 "11101110" when "0111010011", -- 300 
		 "11110110" when "0111100000", -- 301 
		 "11110101" when "0111100001", -- 302 
		 "11111001" when "0111100010", -- 303 
		 "00000000" when "0111100011", -- 304 
		 "11101010" when "0111100100", -- 305 
		 "11110000" when "0111100101", -- 306 
		 "11111011" when "0111100110", -- 307 
		 "11110111" when "0111100111", -- 308 
		 "11110001" when "0111101000", -- 309 
		 "11111100" when "0111101001", -- 310 
		 "11110000" when "0111101010", -- 311 
		 "11110011" when "0111101011", -- 312 
		 "00001001" when "0111101100", -- 313 
		 "11111001" when "0111101101", -- 314 
		 "11111110" when "0111101110", -- 315 
		 "11111011" when "0111101111", -- 316 
		 "11111110" when "0111110000", -- 317 
		 "11110111" when "0111110001", -- 318 
		 "11110110" when "0111110010", -- 319 
		 "11110011" when "0111110011", -- 320 
		 "11101101" when "1000000000", -- 321 
		 "00000100" when "1000000001", -- 322 
		 "11111010" when "1000000010", -- 323 
		 "11101101" when "1000000011", -- 324 
		 "00000000" when "1000000100", -- 325 
		 "00000101" when "1000000101", -- 326 
		 "00000101" when "1000000110", -- 327 
		 "11110110" when "1000000111", -- 328 
		 "11110110" when "1000001000", -- 329 
		 "00000100" when "1000001001", -- 330 
		 "11111100" when "1000001010", -- 331 
		 "00001001" when "1000001011", -- 332 
		 "11110011" when "1000001100", -- 333 
		 "11111100" when "1000001101", -- 334 
		 "00000001" when "1000001110", -- 335 
		 "00010110" when "1000001111", -- 336 
		 "11110000" when "1000010000", -- 337 
		 "11111111" when "1000010001", -- 338 
		 "11111111" when "1000010010", -- 339 
		 "00000100" when "1000010011", -- 340 
		 "11111011" when "1000100000", -- 341 
		 "11111001" when "1000100001", -- 342 
		 "11101001" when "1000100010", -- 343 
		 "00001000" when "1000100011", -- 344 
		 "11111110" when "1000100100", -- 345 
		 "00000101" when "1000100101", -- 346 
		 "11110010" when "1000100110", -- 347 
		 "11110110" when "1000100111", -- 348 
		 "00000011" when "1000101000", -- 349 
		 "00001011" when "1000101001", -- 350 
		 "11111011" when "1000101010", -- 351 
		 "11101111" when "1000101011", -- 352 
		 "00001010" when "1000101100", -- 353 
		 "00000101" when "1000101101", -- 354 
		 "00000011" when "1000101110", -- 355 
		 "11110011" when "1000101111", -- 356 
		 "00000011" when "1000110000", -- 357 
		 "00000111" when "1000110001", -- 358 
		 "11110011" when "1000110010", -- 359 
		 "11110110" when "1000110011", -- 360 
		 "00010101" when "1001000000", -- 361 
		 "00000010" when "1001000001", -- 362 
		 "11110010" when "1001000010", -- 363 
		 "11101110" when "1001000011", -- 364 
		 "11111110" when "1001000100", -- 365 
		 "00000010" when "1001000101", -- 366 
		 "11111111" when "1001000110", -- 367 
		 "11101011" when "1001000111", -- 368 
		 "11111010" when "1001001000", -- 369 
		 "00001011" when "1001001001", -- 370 
		 "00001101" when "1001001010", -- 371 
		 "11110100" when "1001001011", -- 372 
		 "00000110" when "1001001100", -- 373 
		 "00001001" when "1001001101", -- 374 
		 "11111000" when "1001001110", -- 375 
		 "11111000" when "1001001111", -- 376 
		 "00000101" when "1001010000", -- 377 
		 "11111101" when "1001010001", -- 378 
		 "11110101" when "1001010010", -- 379 
		 "00000101" when "1001010011", -- 380 
		 "00001100" when "1001100000", -- 381 
		 "00001100" when "1001100001", -- 382 
		 "00000000" when "1001100010", -- 383 
		 "11110000" when "1001100011", -- 384 
		 "11111001" when "1001100100", -- 385 
		 "11111011" when "1001100101", -- 386 
		 "11111001" when "1001100110", -- 387 
		 "00000110" when "1001100111", -- 388 
		 "11101101" when "1001101000", -- 389 
		 "11111101" when "1001101001", -- 390 
		 "00000101" when "1001101010", -- 391 
		 "11111011" when "1001101011", -- 392 
		 "00001000" when "1001101100", -- 393 
		 "00000111" when "1001101101", -- 394 
		 "11110011" when "1001101110", -- 395 
		 "11111010" when "1001101111", -- 396 
		 "11111110" when "1001110000", -- 397 
		 "00000101" when "1001110001", -- 398 
		 "11111010" when "1001110010", -- 399 
		 "11111100" when "1001110011", -- 400 
		 "11101110" when "1010000000", -- 401 
		 "11111111" when "1010000001", -- 402 
		 "00000000" when "1010000010", -- 403 
		 "00000111" when "1010000011", -- 404 
		 "11111000" when "1010000100", -- 405 
		 "00000010" when "1010000101", -- 406 
		 "11111101" when "1010000110", -- 407 
		 "00000010" when "1010000111", -- 408 
		 "11111001" when "1010001000", -- 409 
		 "11101000" when "1010001001", -- 410 
		 "11110010" when "1010001010", -- 411 
		 "00000011" when "1010001011", -- 412 
		 "00000010" when "1010001100", -- 413 
		 "11111101" when "1010001101", -- 414 
		 "11110110" when "1010001110", -- 415 
		 "11111101" when "1010001111", -- 416 
		 "11111100" when "1010010000", -- 417 
		 "00000001" when "1010010001", -- 418 
		 "11111101" when "1010010010", -- 419 
		 "11111101" when "1010010011", -- 420 
		 "00001000" when "1010100000", -- 421 
		 "11111101" when "1010100001", -- 422 
		 "00000010" when "1010100010", -- 423 
		 "00001010" when "1010100011", -- 424 
		 "00000010" when "1010100100", -- 425 
		 "00000000" when "1010100101", -- 426 
		 "00000000" when "1010100110", -- 427 
		 "00000111" when "1010100111", -- 428 
		 "00001001" when "1010101000", -- 429 
		 "11110100" when "1010101001", -- 430 
		 "11111001" when "1010101010", -- 431 
		 "11111010" when "1010101011", -- 432 
		 "11111001" when "1010101100", -- 433 
		 "11111110" when "1010101101", -- 434 
		 "00000001" when "1010101110", -- 435 
		 "00000000" when "1010101111", -- 436 
		 "11111000" when "1010110000", -- 437 
		 "00000001" when "1010110001", -- 438 
		 "11110111" when "1010110010", -- 439 
		 "11111000" when "1010110011", -- 440 
		 "11110001" when "1011000000", -- 441 
		 "11101101" when "1011000001", -- 442 
		 "00000101" when "1011000010", -- 443 
		 "11101000" when "1011000011", -- 444 
		 "00001001" when "1011000100", -- 445 
		 "11111111" when "1011000101", -- 446 
		 "11110111" when "1011000110", -- 447 
		 "11110000" when "1011000111", -- 448 
		 "00000100" when "1011001000", -- 449 
		 "11111110" when "1011001001", -- 450 
		 "11111011" when "1011001010", -- 451 
		 "11110001" when "1011001011", -- 452 
		 "00000110" when "1011001100", -- 453 
		 "11111110" when "1011001101", -- 454 
		 "11111001" when "1011001110", -- 455 
		 "11110111" when "1011001111", -- 456 
		 "00000010" when "1011010000", -- 457 
		 "00000011" when "1011010001", -- 458 
		 "11101101" when "1011010010", -- 459 
		 "00000111" when "1011010011", -- 460 
		 "00001010" when "1011100000", -- 461 
		 "11111100" when "1011100001", -- 462 
		 "11110010" when "1011100010", -- 463 
		 "00000111" when "1011100011", -- 464 
		 "11110011" when "1011100100", -- 465 
		 "00000010" when "1011100101", -- 466 
		 "11110111" when "1011100110", -- 467 
		 "11110111" when "1011100111", -- 468 
		 "00001111" when "1011101000", -- 469 
		 "11110011" when "1011101001", -- 470 
		 "11110111" when "1011101010", -- 471 
		 "11111100" when "1011101011", -- 472 
		 "00000110" when "1011101100", -- 473 
		 "00000010" when "1011101101", -- 474 
		 "11111111" when "1011101110", -- 475 
		 "00000011" when "1011101111", -- 476 
		 "11110110" when "1011110000", -- 477 
		 "00000000" when "1011110001", -- 478 
		 "00000000" when "1011110010", -- 479 
		 "11111100" when "1011110011", -- 480 
		 "11110000" when "1100000000", -- 481 
		 "00000010" when "1100000001", -- 482 
		 "11111100" when "1100000010", -- 483 
		 "00001001" when "1100000011", -- 484 
		 "11110011" when "1100000100", -- 485 
		 "11111011" when "1100000101", -- 486 
		 "11111111" when "1100000110", -- 487 
		 "11111111" when "1100000111", -- 488 
		 "11111001" when "1100001000", -- 489 
		 "00000010" when "1100001001", -- 490 
		 "00000000" when "1100001010", -- 491 
		 "00000101" when "1100001011", -- 492 
		 "11111101" when "1100001100", -- 493 
		 "00000101" when "1100001101", -- 494 
		 "11111110" when "1100001110", -- 495 
		 "00001100" when "1100001111", -- 496 
		 "11111110" when "1100010000", -- 497 
		 "00000010" when "1100010001", -- 498 
		 "00000101" when "1100010010", -- 499 
		 "00000010" when "1100010011", -- 500 
		 "00000000" when others; 
 end Behavioral;

