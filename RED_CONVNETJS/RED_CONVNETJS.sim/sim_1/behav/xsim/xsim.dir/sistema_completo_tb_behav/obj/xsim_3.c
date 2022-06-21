/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
extern void execute_2(char*, char *);
extern void execute_3(char*, char *);
extern void execute_4(char*, char *);
extern void execute_5(char*, char *);
extern void execute_6(char*, char *);
extern void execute_7(char*, char *);
extern void execute_8(char*, char *);
extern void execute_9(char*, char *);
extern void execute_1115(char*, char *);
extern void execute_1116(char*, char *);
extern void execute_1117(char*, char *);
extern void execute_1118(char*, char *);
extern void execute_1119(char*, char *);
extern void execute_1120(char*, char *);
extern void execute_1121(char*, char *);
extern void execute_62(char*, char *);
extern void execute_94(char*, char *);
extern void execute_119(char*, char *);
extern void execute_380(char*, char *);
extern void execute_396(char*, char *);
extern void execute_414(char*, char *);
extern void execute_415(char*, char *);
extern void execute_420(char*, char *);
extern void execute_421(char*, char *);
extern void execute_742(char*, char *);
extern void execute_758(char*, char *);
extern void execute_775(char*, char *);
extern void execute_776(char*, char *);
extern void execute_781(char*, char *);
extern void execute_782(char*, char *);
extern void vlog_const_rhs_process_execute_0_fast_no_reg_no_agg(char*, char*, char*);
extern void execute_1254(char*, char *);
extern void execute_1255(char*, char *);
extern void execute_1264(char*, char *);
extern void execute_1265(char*, char *);
extern void execute_1266(char*, char *);
extern void execute_1267(char*, char *);
extern void execute_1268(char*, char *);
extern void execute_1270(char*, char *);
extern void execute_1275(char*, char *);
extern void execute_1276(char*, char *);
extern void execute_1277(char*, char *);
extern void execute_1278(char*, char *);
extern void execute_1279(char*, char *);
extern void execute_65(char*, char *);
extern void execute_93(char*, char *);
extern void vlog_simple_process_execute_0_fast_no_reg_no_agg(char*, char*, char*);
extern void execute_1159(char*, char *);
extern void execute_1240(char*, char *);
extern void execute_1241(char*, char *);
extern void execute_1242(char*, char *);
extern void execute_1243(char*, char *);
extern void execute_1244(char*, char *);
extern void execute_1245(char*, char *);
extern void execute_1246(char*, char *);
extern void execute_74(char*, char *);
extern void execute_75(char*, char *);
extern void execute_76(char*, char *);
extern void execute_90(char*, char *);
extern void execute_91(char*, char *);
extern void execute_92(char*, char *);
extern void execute_1172(char*, char *);
extern void execute_1173(char*, char *);
extern void execute_1174(char*, char *);
extern void execute_1175(char*, char *);
extern void execute_1176(char*, char *);
extern void execute_1177(char*, char *);
extern void execute_1178(char*, char *);
extern void execute_1180(char*, char *);
extern void execute_1181(char*, char *);
extern void execute_1182(char*, char *);
extern void execute_1183(char*, char *);
extern void execute_1187(char*, char *);
extern void execute_1191(char*, char *);
extern void execute_1192(char*, char *);
extern void execute_1193(char*, char *);
extern void execute_1194(char*, char *);
extern void execute_1195(char*, char *);
extern void execute_1196(char*, char *);
extern void execute_1199(char*, char *);
extern void execute_1201(char*, char *);
extern void execute_1202(char*, char *);
extern void execute_1203(char*, char *);
extern void execute_1204(char*, char *);
extern void execute_1205(char*, char *);
extern void execute_1206(char*, char *);
extern void execute_1207(char*, char *);
extern void execute_1208(char*, char *);
extern void execute_1209(char*, char *);
extern void execute_1210(char*, char *);
extern void execute_1211(char*, char *);
extern void execute_1212(char*, char *);
extern void execute_1213(char*, char *);
extern void execute_1214(char*, char *);
extern void execute_78(char*, char *);
extern void execute_79(char*, char *);
extern void execute_80(char*, char *);
extern void execute_81(char*, char *);
extern void execute_1184(char*, char *);
extern void execute_1185(char*, char *);
extern void execute_1186(char*, char *);
extern void execute_83(char*, char *);
extern void execute_84(char*, char *);
extern void execute_85(char*, char *);
extern void execute_86(char*, char *);
extern void execute_1188(char*, char *);
extern void execute_1189(char*, char *);
extern void execute_1190(char*, char *);
extern void execute_88(char*, char *);
extern void execute_89(char*, char *);
extern void execute_96(char*, char *);
extern void execute_97(char*, char *);
extern void execute_98(char*, char *);
extern void execute_99(char*, char *);
extern void execute_100(char*, char *);
extern void execute_101(char*, char *);
extern void execute_102(char*, char *);
extern void execute_103(char*, char *);
extern void execute_104(char*, char *);
extern void execute_105(char*, char *);
extern void execute_106(char*, char *);
extern void execute_108(char*, char *);
extern void execute_109(char*, char *);
extern void execute_110(char*, char *);
extern void execute_112(char*, char *);
extern void execute_113(char*, char *);
extern void execute_114(char*, char *);
extern void execute_115(char*, char *);
extern void execute_116(char*, char *);
extern void execute_117(char*, char *);
extern void execute_118(char*, char *);
extern void execute_121(char*, char *);
extern void execute_122(char*, char *);
extern void execute_123(char*, char *);
extern void execute_125(char*, char *);
extern void execute_126(char*, char *);
extern void execute_128(char*, char *);
extern void execute_129(char*, char *);
extern void execute_130(char*, char *);
extern void execute_131(char*, char *);
extern void execute_132(char*, char *);
extern void execute_133(char*, char *);
extern void execute_134(char*, char *);
extern void execute_136(char*, char *);
extern void execute_137(char*, char *);
extern void execute_138(char*, char *);
extern void execute_139(char*, char *);
extern void execute_141(char*, char *);
extern void execute_142(char*, char *);
extern void execute_157(char*, char *);
extern void execute_158(char*, char *);
extern void execute_173(char*, char *);
extern void execute_174(char*, char *);
extern void execute_189(char*, char *);
extern void execute_190(char*, char *);
extern void execute_205(char*, char *);
extern void execute_206(char*, char *);
extern void execute_221(char*, char *);
extern void execute_222(char*, char *);
extern void execute_237(char*, char *);
extern void execute_238(char*, char *);
extern void execute_253(char*, char *);
extern void execute_254(char*, char *);
extern void execute_269(char*, char *);
extern void execute_270(char*, char *);
extern void execute_285(char*, char *);
extern void execute_286(char*, char *);
extern void execute_301(char*, char *);
extern void execute_302(char*, char *);
extern void execute_317(char*, char *);
extern void execute_318(char*, char *);
extern void execute_333(char*, char *);
extern void execute_334(char*, char *);
extern void execute_349(char*, char *);
extern void execute_350(char*, char *);
extern void execute_365(char*, char *);
extern void execute_366(char*, char *);
extern void execute_382(char*, char *);
extern void execute_383(char*, char *);
extern void execute_384(char*, char *);
extern void execute_385(char*, char *);
extern void execute_386(char*, char *);
extern void execute_387(char*, char *);
extern void execute_388(char*, char *);
extern void execute_389(char*, char *);
extern void execute_390(char*, char *);
extern void execute_391(char*, char *);
extern void execute_392(char*, char *);
extern void execute_393(char*, char *);
extern void execute_394(char*, char *);
extern void execute_395(char*, char *);
extern void execute_398(char*, char *);
extern void execute_399(char*, char *);
extern void execute_400(char*, char *);
extern void execute_401(char*, char *);
extern void execute_402(char*, char *);
extern void execute_403(char*, char *);
extern void execute_404(char*, char *);
extern void execute_405(char*, char *);
extern void execute_406(char*, char *);
extern void execute_407(char*, char *);
extern void execute_409(char*, char *);
extern void execute_411(char*, char *);
extern void execute_412(char*, char *);
extern void execute_413(char*, char *);
extern void execute_423(char*, char *);
extern void execute_424(char*, char *);
extern void execute_439(char*, char *);
extern void execute_440(char*, char *);
extern void execute_455(char*, char *);
extern void execute_456(char*, char *);
extern void execute_471(char*, char *);
extern void execute_472(char*, char *);
extern void execute_487(char*, char *);
extern void execute_488(char*, char *);
extern void execute_503(char*, char *);
extern void execute_504(char*, char *);
extern void execute_519(char*, char *);
extern void execute_520(char*, char *);
extern void execute_535(char*, char *);
extern void execute_536(char*, char *);
extern void execute_551(char*, char *);
extern void execute_552(char*, char *);
extern void execute_567(char*, char *);
extern void execute_568(char*, char *);
extern void execute_583(char*, char *);
extern void execute_584(char*, char *);
extern void execute_599(char*, char *);
extern void execute_600(char*, char *);
extern void execute_615(char*, char *);
extern void execute_616(char*, char *);
extern void execute_631(char*, char *);
extern void execute_632(char*, char *);
extern void execute_647(char*, char *);
extern void execute_648(char*, char *);
extern void execute_663(char*, char *);
extern void execute_664(char*, char *);
extern void execute_679(char*, char *);
extern void execute_680(char*, char *);
extern void execute_695(char*, char *);
extern void execute_696(char*, char *);
extern void execute_711(char*, char *);
extern void execute_712(char*, char *);
extern void execute_727(char*, char *);
extern void execute_728(char*, char *);
extern void execute_744(char*, char *);
extern void execute_745(char*, char *);
extern void execute_746(char*, char *);
extern void execute_747(char*, char *);
extern void execute_748(char*, char *);
extern void execute_749(char*, char *);
extern void execute_750(char*, char *);
extern void execute_751(char*, char *);
extern void execute_752(char*, char *);
extern void execute_753(char*, char *);
extern void execute_754(char*, char *);
extern void execute_755(char*, char *);
extern void execute_756(char*, char *);
extern void execute_757(char*, char *);
extern void execute_760(char*, char *);
extern void execute_761(char*, char *);
extern void execute_762(char*, char *);
extern void execute_763(char*, char *);
extern void execute_764(char*, char *);
extern void execute_765(char*, char *);
extern void execute_766(char*, char *);
extern void execute_767(char*, char *);
extern void execute_768(char*, char *);
extern void execute_770(char*, char *);
extern void execute_784(char*, char *);
extern void execute_785(char*, char *);
extern void execute_800(char*, char *);
extern void execute_801(char*, char *);
extern void execute_816(char*, char *);
extern void execute_817(char*, char *);
extern void execute_832(char*, char *);
extern void execute_833(char*, char *);
extern void execute_848(char*, char *);
extern void execute_849(char*, char *);
extern void execute_864(char*, char *);
extern void execute_865(char*, char *);
extern void execute_880(char*, char *);
extern void execute_881(char*, char *);
extern void execute_896(char*, char *);
extern void execute_897(char*, char *);
extern void execute_912(char*, char *);
extern void execute_913(char*, char *);
extern void execute_928(char*, char *);
extern void execute_929(char*, char *);
extern void execute_944(char*, char *);
extern void execute_945(char*, char *);
extern void execute_960(char*, char *);
extern void execute_961(char*, char *);
extern void execute_976(char*, char *);
extern void execute_977(char*, char *);
extern void execute_992(char*, char *);
extern void execute_993(char*, char *);
extern void execute_1008(char*, char *);
extern void execute_1009(char*, char *);
extern void execute_1024(char*, char *);
extern void execute_1025(char*, char *);
extern void execute_1040(char*, char *);
extern void execute_1041(char*, char *);
extern void execute_1056(char*, char *);
extern void execute_1057(char*, char *);
extern void execute_1072(char*, char *);
extern void execute_1073(char*, char *);
extern void execute_1088(char*, char *);
extern void execute_1089(char*, char *);
extern void execute_1104(char*, char *);
extern void execute_1105(char*, char *);
extern void execute_1106(char*, char *);
extern void execute_1107(char*, char *);
extern void execute_1108(char*, char *);
extern void execute_1110(char*, char *);
extern void vlog_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
extern void transaction_32(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_34(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_35(char*, char*, unsigned, unsigned, unsigned);
extern void vhdl_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
extern void transaction_38(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_41(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_43(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_338(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_339(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_340(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_341(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_342(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_343(char*, char*, unsigned, unsigned, unsigned);
funcp funcTab[329] = {(funcp)execute_2, (funcp)execute_3, (funcp)execute_4, (funcp)execute_5, (funcp)execute_6, (funcp)execute_7, (funcp)execute_8, (funcp)execute_9, (funcp)execute_1115, (funcp)execute_1116, (funcp)execute_1117, (funcp)execute_1118, (funcp)execute_1119, (funcp)execute_1120, (funcp)execute_1121, (funcp)execute_62, (funcp)execute_94, (funcp)execute_119, (funcp)execute_380, (funcp)execute_396, (funcp)execute_414, (funcp)execute_415, (funcp)execute_420, (funcp)execute_421, (funcp)execute_742, (funcp)execute_758, (funcp)execute_775, (funcp)execute_776, (funcp)execute_781, (funcp)execute_782, (funcp)vlog_const_rhs_process_execute_0_fast_no_reg_no_agg, (funcp)execute_1254, (funcp)execute_1255, (funcp)execute_1264, (funcp)execute_1265, (funcp)execute_1266, (funcp)execute_1267, (funcp)execute_1268, (funcp)execute_1270, (funcp)execute_1275, (funcp)execute_1276, (funcp)execute_1277, (funcp)execute_1278, (funcp)execute_1279, (funcp)execute_65, (funcp)execute_93, (funcp)vlog_simple_process_execute_0_fast_no_reg_no_agg, (funcp)execute_1159, (funcp)execute_1240, (funcp)execute_1241, (funcp)execute_1242, (funcp)execute_1243, (funcp)execute_1244, (funcp)execute_1245, (funcp)execute_1246, (funcp)execute_74, (funcp)execute_75, (funcp)execute_76, (funcp)execute_90, (funcp)execute_91, (funcp)execute_92, (funcp)execute_1172, (funcp)execute_1173, (funcp)execute_1174, (funcp)execute_1175, (funcp)execute_1176, (funcp)execute_1177, (funcp)execute_1178, (funcp)execute_1180, (funcp)execute_1181, (funcp)execute_1182, (funcp)execute_1183, (funcp)execute_1187, (funcp)execute_1191, (funcp)execute_1192, (funcp)execute_1193, (funcp)execute_1194, (funcp)execute_1195, (funcp)execute_1196, (funcp)execute_1199, (funcp)execute_1201, (funcp)execute_1202, (funcp)execute_1203, (funcp)execute_1204, (funcp)execute_1205, (funcp)execute_1206, (funcp)execute_1207, (funcp)execute_1208, (funcp)execute_1209, (funcp)execute_1210, (funcp)execute_1211, (funcp)execute_1212, (funcp)execute_1213, (funcp)execute_1214, (funcp)execute_78, (funcp)execute_79, (funcp)execute_80, (funcp)execute_81, (funcp)execute_1184, (funcp)execute_1185, (funcp)execute_1186, (funcp)execute_83, (funcp)execute_84, (funcp)execute_85, (funcp)execute_86, (funcp)execute_1188, (funcp)execute_1189, (funcp)execute_1190, (funcp)execute_88, (funcp)execute_89, (funcp)execute_96, (funcp)execute_97, (funcp)execute_98, (funcp)execute_99, (funcp)execute_100, (funcp)execute_101, (funcp)execute_102, (funcp)execute_103, (funcp)execute_104, (funcp)execute_105, (funcp)execute_106, (funcp)execute_108, (funcp)execute_109, (funcp)execute_110, (funcp)execute_112, (funcp)execute_113, (funcp)execute_114, (funcp)execute_115, (funcp)execute_116, (funcp)execute_117, (funcp)execute_118, (funcp)execute_121, (funcp)execute_122, (funcp)execute_123, (funcp)execute_125, (funcp)execute_126, (funcp)execute_128, (funcp)execute_129, (funcp)execute_130, (funcp)execute_131, (funcp)execute_132, (funcp)execute_133, (funcp)execute_134, (funcp)execute_136, (funcp)execute_137, (funcp)execute_138, (funcp)execute_139, (funcp)execute_141, (funcp)execute_142, (funcp)execute_157, (funcp)execute_158, (funcp)execute_173, (funcp)execute_174, (funcp)execute_189, (funcp)execute_190, (funcp)execute_205, (funcp)execute_206, (funcp)execute_221, (funcp)execute_222, (funcp)execute_237, (funcp)execute_238, (funcp)execute_253, (funcp)execute_254, (funcp)execute_269, (funcp)execute_270, (funcp)execute_285, (funcp)execute_286, (funcp)execute_301, (funcp)execute_302, (funcp)execute_317, (funcp)execute_318, (funcp)execute_333, (funcp)execute_334, (funcp)execute_349, (funcp)execute_350, (funcp)execute_365, (funcp)execute_366, (funcp)execute_382, (funcp)execute_383, (funcp)execute_384, (funcp)execute_385, (funcp)execute_386, (funcp)execute_387, (funcp)execute_388, (funcp)execute_389, (funcp)execute_390, (funcp)execute_391, (funcp)execute_392, (funcp)execute_393, (funcp)execute_394, (funcp)execute_395, (funcp)execute_398, (funcp)execute_399, (funcp)execute_400, (funcp)execute_401, (funcp)execute_402, (funcp)execute_403, (funcp)execute_404, (funcp)execute_405, (funcp)execute_406, (funcp)execute_407, (funcp)execute_409, (funcp)execute_411, (funcp)execute_412, (funcp)execute_413, (funcp)execute_423, (funcp)execute_424, (funcp)execute_439, (funcp)execute_440, (funcp)execute_455, (funcp)execute_456, (funcp)execute_471, (funcp)execute_472, (funcp)execute_487, (funcp)execute_488, (funcp)execute_503, (funcp)execute_504, (funcp)execute_519, (funcp)execute_520, (funcp)execute_535, (funcp)execute_536, (funcp)execute_551, (funcp)execute_552, (funcp)execute_567, (funcp)execute_568, (funcp)execute_583, (funcp)execute_584, (funcp)execute_599, (funcp)execute_600, (funcp)execute_615, (funcp)execute_616, (funcp)execute_631, (funcp)execute_632, (funcp)execute_647, (funcp)execute_648, (funcp)execute_663, (funcp)execute_664, (funcp)execute_679, (funcp)execute_680, (funcp)execute_695, (funcp)execute_696, (funcp)execute_711, (funcp)execute_712, (funcp)execute_727, (funcp)execute_728, (funcp)execute_744, (funcp)execute_745, (funcp)execute_746, (funcp)execute_747, (funcp)execute_748, (funcp)execute_749, (funcp)execute_750, (funcp)execute_751, (funcp)execute_752, (funcp)execute_753, (funcp)execute_754, (funcp)execute_755, (funcp)execute_756, (funcp)execute_757, (funcp)execute_760, (funcp)execute_761, (funcp)execute_762, (funcp)execute_763, (funcp)execute_764, (funcp)execute_765, (funcp)execute_766, (funcp)execute_767, (funcp)execute_768, (funcp)execute_770, (funcp)execute_784, (funcp)execute_785, (funcp)execute_800, (funcp)execute_801, (funcp)execute_816, (funcp)execute_817, (funcp)execute_832, (funcp)execute_833, (funcp)execute_848, (funcp)execute_849, (funcp)execute_864, (funcp)execute_865, (funcp)execute_880, (funcp)execute_881, (funcp)execute_896, (funcp)execute_897, (funcp)execute_912, (funcp)execute_913, (funcp)execute_928, (funcp)execute_929, (funcp)execute_944, (funcp)execute_945, (funcp)execute_960, (funcp)execute_961, (funcp)execute_976, (funcp)execute_977, (funcp)execute_992, (funcp)execute_993, (funcp)execute_1008, (funcp)execute_1009, (funcp)execute_1024, (funcp)execute_1025, (funcp)execute_1040, (funcp)execute_1041, (funcp)execute_1056, (funcp)execute_1057, (funcp)execute_1072, (funcp)execute_1073, (funcp)execute_1088, (funcp)execute_1089, (funcp)execute_1104, (funcp)execute_1105, (funcp)execute_1106, (funcp)execute_1107, (funcp)execute_1108, (funcp)execute_1110, (funcp)vlog_transfunc_eventcallback, (funcp)transaction_32, (funcp)transaction_34, (funcp)transaction_35, (funcp)vhdl_transfunc_eventcallback, (funcp)transaction_38, (funcp)transaction_41, (funcp)transaction_43, (funcp)transaction_338, (funcp)transaction_339, (funcp)transaction_340, (funcp)transaction_341, (funcp)transaction_342, (funcp)transaction_343};
const int NumRelocateId= 329;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/sistema_completo_tb_behav/xsim.reloc",  (void **)funcTab, 329);
	iki_vhdl_file_variable_register(dp + 352832);
	iki_vhdl_file_variable_register(dp + 352888);


	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/sistema_completo_tb_behav/xsim.reloc");
}

	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net

void wrapper_func_0(char *dp)

{

	iki_vlog_schedule_transaction_signal_fast_vhdl_value_time_0(dp + 358776, dp + 376008, 0, 7, 0, 7, 8, 1);

	iki_vlog_schedule_transaction_signal_fast_vhdl_value_time_0(dp + 358440, dp + 375784, 0, 0, 0, 0, 1, 1);

	iki_vlog_schedule_transaction_signal_fast_vhdl_value_time_0(dp + 358552, dp + 375896, 0, 0, 0, 0, 1, 1);

	iki_vlog_schedule_transaction_signal_fast_vhdl_value_time_0(dp + 358608, dp + 375840, 0, 0, 0, 0, 1, 1);

	iki_vlog_schedule_transaction_signal_fast_vhdl_value_time_0(dp + 360728, dp + 375952, 0, 11, 0, 11, 12, 1);

}

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/sistema_completo_tb_behav/xsim.reloc");
	wrapper_func_0(dp);

	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern void implicit_HDL_SCinstantiate();

extern void implicit_HDL_SCcleanup();

extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/sistema_completo_tb_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/sistema_completo_tb_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/sistema_completo_tb_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
