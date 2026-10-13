; ModuleID = 'test'
source_filename = "test"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"

define void @dofstuff_CGInitializeSizes(ptr %S_0) {
dofstuff_CGInitializeSizes_entry:
  %S_0_ = alloca ptr, align 8
  store ptr %S_0, ptr %S_0_, align 1
  %tmp_ = alloca [4 x i32], align 4
  call void @dofstuff_Checksum(ptr nonnull %tmp_)
  %tmp__el = load i32, ptr %tmp_, align 1
  call void @vm_ssSetChecksumVal(ptr %S_0, i32 0, i32 %tmp__el)
  %0 = getelementptr inbounds i8, ptr %tmp_, i64 4
  %tmp__el3 = load i32, ptr %0, align 1
  call void @vm_ssSetChecksumVal(ptr %S_0, i32 1, i32 %tmp__el3)
  %1 = getelementptr inbounds i8, ptr %tmp_, i64 8
  %tmp__el5 = load i32, ptr %1, align 1
  call void @vm_ssSetChecksumVal(ptr %S_0, i32 2, i32 %tmp__el5)
  %2 = getelementptr inbounds i8, ptr %tmp_, i64 12
  %tmp__el7 = load i32, ptr %2, align 1
  call void @vm_ssSetChecksumVal(ptr %S_0, i32 3, i32 %tmp__el7)
  call void @vm_blockIOSizeCheck(ptr %S_0, i64 2765144)
  call void @vm_dworkSizeCheck(ptr %S_0, i64 80)
  call void @vm_paramSizeCheck(ptr %S_0, i64 544)
  ret void
}

define void @dofstuff_Checksum(ptr %y) {
dofstuff_Checksum_entry:
  store i32 773940450, ptr %y, align 1
  %0 = getelementptr inbounds i8, ptr %y, i64 4
  store i32 668079131, ptr %0, align 1
  %1 = getelementptr inbounds i8, ptr %y, i64 8
  store i32 628473591, ptr %1, align 1
  %2 = getelementptr inbounds i8, ptr %y, i64 12
  store i32 1842805077, ptr %2, align 1
  ret void
}

declare void @vm_ssSetChecksumVal(ptr, i32 zeroext, i32 zeroext)

declare void @vm_blockIOSizeCheck(ptr, i64 zeroext)

declare void @vm_dworkSizeCheck(ptr, i64 zeroext)

declare void @vm_paramSizeCheck(ptr, i64 zeroext)

define void @ForcingFunction(ptr %S) {
ForcingFunction_entry:
  %S_ = alloca ptr, align 8
  store ptr %S, ptr %S_, align 1
  %pData_idx_4_ = alloca double, align 8
  %pData_idx_7_ = alloca double, align 8
  %pData_idx_5_ = alloca double, align 8
  %pData_idx_8_ = alloca double, align 8
  %pData_idx_0_ = alloca double, align 8
  %pData_idx_6_ = alloca double, align 8
  %pData_idx_2_ = alloca double, align 8
  %pData_idx_8_0_ = alloca double, align 8
  %pData_idx_0_0_ = alloca double, align 8
  %pData_idx_6_0_ = alloca double, align 8
  %pData_idx_1_ = alloca double, align 8
  %pData_idx_4_0_ = alloca double, align 8
  %pData_idx_5_0_ = alloca double, align 8
  %_rtB_ = alloca ptr, align 8
  %_rtP_ = alloca ptr, align 8
  %_rtX_ = alloca ptr, align 8
  %_rtXdot_ = alloca ptr, align 8
  %0 = call ptr @vm_ssGetdX(ptr %S)
  store ptr %0, ptr %_rtXdot_, align 1
  %1 = call ptr @vm_ssGetX(ptr %S)
  store ptr %1, ptr %_rtX_, align 1
  %2 = call ptr @vm_ssGetModelRtp(ptr %S)
  store ptr %2, ptr %_rtP_, align 1
  %3 = call ptr @vm__ssGetModelBlockIO(ptr %S)
  store ptr %3, ptr %_rtB_, align 1
  %4 = call ptr @memset(ptr %0, i32 0, i32 96)
  %5 = getelementptr inbounds i8, ptr %3, i64 184
  %_rtB__Add1_el = load double, ptr %5, align 1
  %6 = getelementptr inbounds i8, ptr %2, i64 272
  %_rtP__uDOFEulerAngles_mass_0 = load double, ptr %6, align 1
  %tmp1 = fdiv double %_rtB__Add1_el, %_rtP__uDOFEulerAngles_mass_0
  %7 = getelementptr inbounds i8, ptr %1, i64 16
  %_rtX__uDOFEulerAngles_CSTATE_el = load double, ptr %7, align 1
  %8 = getelementptr inbounds i8, ptr %1, i64 56
  %_rtX__uDOFEulerAngles_CSTATE_el13 = load double, ptr %8, align 1
  %tmp2 = fmul double %_rtX__uDOFEulerAngles_CSTATE_el, %_rtX__uDOFEulerAngles_CSTATE_el13
  %9 = getelementptr inbounds i8, ptr %1, i64 8
  %_rtX__uDOFEulerAngles_CSTATE_el15 = load double, ptr %9, align 1
  %10 = getelementptr inbounds i8, ptr %1, i64 64
  %_rtX__uDOFEulerAngles_CSTATE_el17 = load double, ptr %10, align 1
  %tmp3 = fmul double %_rtX__uDOFEulerAngles_CSTATE_el15, %_rtX__uDOFEulerAngles_CSTATE_el17
  %tmp4 = fsub double %tmp2, %tmp3
  %tmp5 = fsub double %tmp1, %tmp4
  store double %tmp5, ptr %0, align 1
  %11 = getelementptr inbounds i8, ptr %3, i64 192
  %_rtB__Add1_el20 = load double, ptr %11, align 1
  %_rtP__uDOFEulerAngles_mass_022 = load double, ptr %6, align 1
  %tmp6 = fdiv double %_rtB__Add1_el20, %_rtP__uDOFEulerAngles_mass_022
  %_rtX__uDOFEulerAngles_CSTATE_el24 = load double, ptr %1, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el26 = load double, ptr %10, align 1
  %tmp7 = fmul double %_rtX__uDOFEulerAngles_CSTATE_el24, %_rtX__uDOFEulerAngles_CSTATE_el26
  %_rtX__uDOFEulerAngles_CSTATE_el28 = load double, ptr %7, align 1
  %12 = getelementptr inbounds i8, ptr %1, i64 48
  %_rtX__uDOFEulerAngles_CSTATE_el30 = load double, ptr %12, align 1
  %tmp8 = fmul double %_rtX__uDOFEulerAngles_CSTATE_el28, %_rtX__uDOFEulerAngles_CSTATE_el30
  %tmp9 = fsub double %tmp7, %tmp8
  %tmp10 = fsub double %tmp6, %tmp9
  %13 = getelementptr inbounds i8, ptr %0, i64 8
  store double %tmp10, ptr %13, align 1
  %14 = getelementptr inbounds i8, ptr %3, i64 200
  %_rtB__Add1_el33 = load double, ptr %14, align 1
  %_rtP__uDOFEulerAngles_mass_035 = load double, ptr %6, align 1
  %tmp11 = fdiv double %_rtB__Add1_el33, %_rtP__uDOFEulerAngles_mass_035
  %_rtX__uDOFEulerAngles_CSTATE_el37 = load double, ptr %9, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el39 = load double, ptr %12, align 1
  %tmp12 = fmul double %_rtX__uDOFEulerAngles_CSTATE_el37, %_rtX__uDOFEulerAngles_CSTATE_el39
  %_rtX__uDOFEulerAngles_CSTATE_el41 = load double, ptr %1, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el43 = load double, ptr %8, align 1
  %tmp13 = fmul double %_rtX__uDOFEulerAngles_CSTATE_el41, %_rtX__uDOFEulerAngles_CSTATE_el43
  %tmp14 = fsub double %tmp12, %tmp13
  %tmp15 = fsub double %tmp11, %tmp14
  %15 = getelementptr inbounds i8, ptr %0, i64 16
  store double %tmp15, ptr %15, align 1
  %16 = getelementptr inbounds i8, ptr %1, i64 72
  %_rtX__uDOFEulerAngles_CSTATE_el46 = load double, ptr %16, align 1
  %17 = call double @muDoubleScalarCos(double %_rtX__uDOFEulerAngles_CSTATE_el46)
  store double %17, ptr %pData_idx_4_, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el48 = load double, ptr %16, align 1
  %18 = call double @muDoubleScalarSin(double %_rtX__uDOFEulerAngles_CSTATE_el48)
  store double %18, ptr %pData_idx_7_, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el50 = load double, ptr %16, align 1
  %19 = call double @muDoubleScalarSin(double %_rtX__uDOFEulerAngles_CSTATE_el50)
  %tmp16 = fneg double %19
  store double %tmp16, ptr %pData_idx_5_, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el52 = load double, ptr %16, align 1
  %20 = call double @muDoubleScalarCos(double %_rtX__uDOFEulerAngles_CSTATE_el52)
  store double %20, ptr %pData_idx_8_, align 1
  %21 = getelementptr inbounds i8, ptr %1, i64 80
  %_rtX__uDOFEulerAngles_CSTATE_el54 = load double, ptr %21, align 1
  %22 = call double @muDoubleScalarCos(double %_rtX__uDOFEulerAngles_CSTATE_el54)
  store double %22, ptr %pData_idx_0_, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el56 = load double, ptr %21, align 1
  %23 = call double @muDoubleScalarSin(double %_rtX__uDOFEulerAngles_CSTATE_el56)
  %tmp17 = fneg double %23
  store double %tmp17, ptr %pData_idx_6_, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el58 = load double, ptr %21, align 1
  %24 = call double @muDoubleScalarSin(double %_rtX__uDOFEulerAngles_CSTATE_el58)
  store double %24, ptr %pData_idx_2_, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el60 = load double, ptr %21, align 1
  %25 = call double @muDoubleScalarCos(double %_rtX__uDOFEulerAngles_CSTATE_el60)
  store double %25, ptr %pData_idx_8_0_, align 1
  %tmp18 = fmul double %24, 0.000000e+00
  %tmp19 = fadd double %tmp18, %22
  store double %tmp19, ptr %pData_idx_0_0_, align 1
  %tmp20 = fmul double %25, 0.000000e+00
  %tmp21 = fadd double %tmp20, %tmp17
  store double %tmp21, ptr %pData_idx_6_0_, align 1
  %tmp22 = fmul double %22, 0.000000e+00
  %tmp23 = fmul double %17, 0.000000e+00
  %tmp24 = fadd double %tmp22, %tmp23
  %tmp25 = fmul double %18, %24
  %tmp26 = fadd double %tmp24, %tmp25
  store double %tmp26, ptr %pData_idx_1_, align 1
  %tmp27 = fmul double %18, 0.000000e+00
  %tmp28 = fadd double %tmp27, %17
  store double %tmp28, ptr %pData_idx_4_0_, align 1
  %tmp29 = fmul double %tmp17, 0.000000e+00
  %tmp31 = fadd double %tmp23, %tmp29
  %tmp32 = fmul double %18, %25
  %tmp33 = fadd double %tmp31, %tmp32
  store double %tmp33, ptr %pData_idx_7_, align 1
  %tmp35 = fmul double %tmp16, 0.000000e+00
  %tmp36 = fadd double %tmp22, %tmp35
  %tmp37 = fmul double %24, %20
  %tmp38 = fadd double %tmp36, %tmp37
  store double %tmp38, ptr %pData_idx_2_, align 1
  %tmp39 = fmul double %20, 0.000000e+00
  %tmp40 = fadd double %tmp39, %tmp16
  store double %tmp40, ptr %pData_idx_5_0_, align 1
  %tmp43 = fadd double %tmp35, %tmp29
  %tmp44 = fmul double %20, %25
  %tmp45 = fadd double %tmp43, %tmp44
  store double %tmp45, ptr %pData_idx_8_, align 1
  %_rtX_85 = load ptr, ptr %_rtX_, align 1
  %26 = getelementptr inbounds i8, ptr %_rtX_85, i64 88
  %_rtX__uDOFEulerAngles_CSTATE_el86 = load double, ptr %26, align 1
  %27 = call double @muDoubleScalarCos(double %_rtX__uDOFEulerAngles_CSTATE_el86)
  store double %27, ptr %pData_idx_0_, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el88 = load double, ptr %26, align 1
  %28 = call double @muDoubleScalarSin(double %_rtX__uDOFEulerAngles_CSTATE_el88)
  store double %28, ptr %pData_idx_6_, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el90 = load double, ptr %26, align 1
  %29 = call double @muDoubleScalarSin(double %_rtX__uDOFEulerAngles_CSTATE_el90)
  %tmp46 = fneg double %29
  store double %tmp46, ptr %pData_idx_5_, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el92 = load double, ptr %26, align 1
  %30 = call double @muDoubleScalarCos(double %_rtX__uDOFEulerAngles_CSTATE_el92)
  store double %30, ptr %pData_idx_4_, align 1
  %tmp47 = fmul double %tmp19, %27
  %tmp48 = fmul double %tmp46, 0.000000e+00
  %tmp49 = fadd double %tmp47, %tmp48
  %tmp50 = fmul double %tmp21, 0.000000e+00
  %tmp51 = fadd double %tmp49, %tmp50
  %_rtX__uDOFEulerAngles_CSTATE_el98 = load double, ptr %_rtX_85, align 1
  %tmp52 = fmul double %tmp51, %_rtX__uDOFEulerAngles_CSTATE_el98
  %tmp53 = fmul double %27, %tmp26
  %tmp54 = fmul double %tmp46, %tmp28
  %tmp55 = fadd double %tmp53, %tmp54
  %tmp56 = fmul double %tmp33, 0.000000e+00
  %tmp57 = fadd double %tmp55, %tmp56
  %31 = getelementptr inbounds i8, ptr %_rtX_85, i64 8
  %_rtX__uDOFEulerAngles_CSTATE_el105 = load double, ptr %31, align 1
  %tmp58 = fmul double %tmp57, %_rtX__uDOFEulerAngles_CSTATE_el105
  %tmp59 = fadd double %tmp52, %tmp58
  %tmp60 = fmul double %27, %tmp38
  %tmp61 = fmul double %tmp46, %tmp40
  %tmp62 = fadd double %tmp60, %tmp61
  %tmp63 = fmul double %tmp45, 0.000000e+00
  %tmp64 = fadd double %tmp62, %tmp63
  %32 = getelementptr inbounds i8, ptr %_rtX_85, i64 16
  %_rtX__uDOFEulerAngles_CSTATE_el112 = load double, ptr %32, align 1
  %tmp65 = fmul double %tmp64, %_rtX__uDOFEulerAngles_CSTATE_el112
  %tmp66 = fadd double %tmp59, %tmp65
  %_rtXdot_113 = load ptr, ptr %_rtXdot_, align 1
  %33 = getelementptr inbounds i8, ptr %_rtXdot_113, i64 24
  store double %tmp66, ptr %33, align 1
  %tmp67 = fmul double %tmp19, %28
  %tmp68 = fmul double %30, 0.000000e+00
  %tmp69 = fadd double %tmp67, %tmp68
  %tmp71 = fadd double %tmp69, %tmp50
  %_rtX__uDOFEulerAngles_CSTATE_el119 = load double, ptr %_rtX_85, align 1
  %tmp72 = fmul double %tmp71, %_rtX__uDOFEulerAngles_CSTATE_el119
  %tmp73 = fmul double %28, %tmp26
  %tmp74 = fmul double %tmp28, %30
  %tmp75 = fadd double %tmp73, %tmp74
  %tmp77 = fadd double %tmp75, %tmp56
  %_rtX__uDOFEulerAngles_CSTATE_el126 = load double, ptr %31, align 1
  %tmp78 = fmul double %tmp77, %_rtX__uDOFEulerAngles_CSTATE_el126
  %tmp79 = fadd double %tmp72, %tmp78
  %tmp80 = fmul double %28, %tmp38
  %tmp81 = fmul double %30, %tmp40
  %tmp82 = fadd double %tmp80, %tmp81
  %tmp84 = fadd double %tmp82, %tmp63
  %_rtX__uDOFEulerAngles_CSTATE_el133 = load double, ptr %32, align 1
  %tmp85 = fmul double %tmp84, %_rtX__uDOFEulerAngles_CSTATE_el133
  %tmp86 = fadd double %tmp79, %tmp85
  %34 = getelementptr inbounds i8, ptr %_rtXdot_113, i64 32
  store double %tmp86, ptr %34, align 1
  %tmp87 = fmul double %tmp26, 0.000000e+00
  %tmp88 = fmul double %tmp28, 0.000000e+00
  %tmp89 = fadd double %tmp87, %tmp88
  %tmp90 = fadd double %tmp33, %tmp89
  %_rtX__uDOFEulerAngles_CSTATE_el139 = load double, ptr %31, align 1
  %tmp91 = fmul double %tmp90, %_rtX__uDOFEulerAngles_CSTATE_el139
  %pData_idx_0_0_140 = load double, ptr %pData_idx_0_0_, align 1
  %tmp92 = fmul double %pData_idx_0_0_140, 0.000000e+00
  %pData_idx_6_0_141 = load double, ptr %pData_idx_6_0_, align 1
  %tmp93 = fadd double %tmp92, %pData_idx_6_0_141
  %_rtX__uDOFEulerAngles_CSTATE_el143 = load double, ptr %_rtX_85, align 1
  %tmp94 = fmul double %tmp93, %_rtX__uDOFEulerAngles_CSTATE_el143
  %tmp95 = fadd double %tmp91, %tmp94
  %tmp96 = fmul double %tmp38, 0.000000e+00
  %tmp97 = fmul double %tmp40, 0.000000e+00
  %tmp98 = fadd double %tmp96, %tmp97
  %tmp99 = fadd double %tmp45, %tmp98
  %_rtX__uDOFEulerAngles_CSTATE_el148 = load double, ptr %32, align 1
  %tmp100 = fmul double %tmp99, %_rtX__uDOFEulerAngles_CSTATE_el148
  %tmp101 = fadd double %tmp95, %tmp100
  %35 = getelementptr inbounds i8, ptr %_rtXdot_113, i64 40
  store double %tmp101, ptr %35, align 1
  %_rtP_150 = load ptr, ptr %_rtP_, align 1
  %36 = getelementptr inbounds i8, ptr %_rtP_150, i64 280
  %_rtP__uDOFEulerAngles_inertia_el = load double, ptr %36, align 1
  %37 = getelementptr inbounds i8, ptr %_rtX_85, i64 48
  %_rtX__uDOFEulerAngles_CSTATE_el152 = load double, ptr %37, align 1
  %tmp102 = fmul double %_rtP__uDOFEulerAngles_inertia_el, %_rtX__uDOFEulerAngles_CSTATE_el152
  %38 = getelementptr inbounds i8, ptr %_rtP_150, i64 304
  %_rtP__uDOFEulerAngles_inertia_el154 = load double, ptr %38, align 1
  %39 = getelementptr inbounds i8, ptr %_rtX_85, i64 56
  %_rtX__uDOFEulerAngles_CSTATE_el156 = load double, ptr %39, align 1
  %tmp103 = fmul double %_rtP__uDOFEulerAngles_inertia_el154, %_rtX__uDOFEulerAngles_CSTATE_el156
  %tmp104 = fadd double %tmp102, %tmp103
  %40 = getelementptr inbounds i8, ptr %_rtP_150, i64 328
  %_rtP__uDOFEulerAngles_inertia_el158 = load double, ptr %40, align 1
  %_rtX_159 = load ptr, ptr %_rtX_, align 1
  %41 = getelementptr inbounds i8, ptr %_rtX_159, i64 64
  %_rtX__uDOFEulerAngles_CSTATE_el160 = load double, ptr %41, align 1
  %tmp105 = fmul double %_rtP__uDOFEulerAngles_inertia_el158, %_rtX__uDOFEulerAngles_CSTATE_el160
  %tmp106 = fadd double %tmp104, %tmp105
  store double %tmp106, ptr %pData_idx_0_, align 1
  %42 = getelementptr inbounds i8, ptr %_rtP_150, i64 288
  %_rtP__uDOFEulerAngles_inertia_el162 = load double, ptr %42, align 1
  %43 = getelementptr inbounds i8, ptr %_rtX_159, i64 48
  %_rtX__uDOFEulerAngles_CSTATE_el164 = load double, ptr %43, align 1
  %tmp107 = fmul double %_rtP__uDOFEulerAngles_inertia_el162, %_rtX__uDOFEulerAngles_CSTATE_el164
  %44 = getelementptr inbounds i8, ptr %_rtP_150, i64 312
  %_rtP__uDOFEulerAngles_inertia_el166 = load double, ptr %44, align 1
  %45 = getelementptr inbounds i8, ptr %_rtX_159, i64 56
  %_rtX__uDOFEulerAngles_CSTATE_el168 = load double, ptr %45, align 1
  %tmp108 = fmul double %_rtP__uDOFEulerAngles_inertia_el166, %_rtX__uDOFEulerAngles_CSTATE_el168
  %tmp109 = fadd double %tmp107, %tmp108
  %46 = getelementptr inbounds i8, ptr %_rtP_150, i64 336
  %_rtP__uDOFEulerAngles_inertia_el170 = load double, ptr %46, align 1
  %tmp110 = fmul double %_rtP__uDOFEulerAngles_inertia_el170, %_rtX__uDOFEulerAngles_CSTATE_el160
  %tmp111 = fadd double %tmp109, %tmp110
  store double %tmp111, ptr %pData_idx_1_, align 1
  %47 = getelementptr inbounds i8, ptr %_rtP_150, i64 296
  %_rtP__uDOFEulerAngles_inertia_el174 = load double, ptr %47, align 1
  %tmp112 = fmul double %_rtP__uDOFEulerAngles_inertia_el174, %_rtX__uDOFEulerAngles_CSTATE_el164
  %48 = getelementptr inbounds i8, ptr %_rtP_150, i64 320
  %_rtP__uDOFEulerAngles_inertia_el178 = load double, ptr %48, align 1
  %tmp113 = fmul double %_rtP__uDOFEulerAngles_inertia_el178, %_rtX__uDOFEulerAngles_CSTATE_el168
  %tmp114 = fadd double %tmp112, %tmp113
  %49 = getelementptr inbounds i8, ptr %_rtP_150, i64 344
  %_rtP__uDOFEulerAngles_inertia_el184 = load double, ptr %49, align 1
  %tmp115 = fmul double %_rtX__uDOFEulerAngles_CSTATE_el160, %_rtP__uDOFEulerAngles_inertia_el184
  %tmp116 = fadd double %tmp114, %tmp115
  store double %tmp116, ptr %pData_idx_2_, align 1
  %tmp117 = fmul double %_rtP__uDOFEulerAngles_inertia_el166, %_rtP__uDOFEulerAngles_inertia_el184
  %tmp118 = fmul double %_rtP__uDOFEulerAngles_inertia_el178, %_rtP__uDOFEulerAngles_inertia_el170
  %tmp119 = fsub double %tmp117, %tmp118
  %tmp120 = fmul double %tmp119, %_rtP__uDOFEulerAngles_inertia_el
  %tmp121 = fmul double %_rtP__uDOFEulerAngles_inertia_el162, %_rtP__uDOFEulerAngles_inertia_el184
  %tmp122 = fmul double %_rtP__uDOFEulerAngles_inertia_el174, %_rtP__uDOFEulerAngles_inertia_el170
  %tmp123 = fsub double %tmp121, %tmp122
  %tmp124 = fmul double %tmp123, %_rtP__uDOFEulerAngles_inertia_el154
  %tmp125 = fsub double %tmp120, %tmp124
  %tmp126 = fmul double %_rtP__uDOFEulerAngles_inertia_el162, %_rtP__uDOFEulerAngles_inertia_el178
  %tmp127 = fmul double %_rtP__uDOFEulerAngles_inertia_el174, %_rtP__uDOFEulerAngles_inertia_el166
  %tmp128 = fsub double %tmp126, %tmp127
  %tmp129 = fmul double %tmp128, %_rtP__uDOFEulerAngles_inertia_el158
  %tmp130 = fadd double %tmp125, %tmp129
  store double %tmp130, ptr %pData_idx_4_, align 1
  %_rtB_215 = load ptr, ptr %_rtB_, align 1
  %50 = getelementptr inbounds i8, ptr %_rtB_215, i64 216
  %_rtB__TmpSignalConversionAt6DOFEulerAnglesInport2_el = load double, ptr %50, align 1
  %tmp131 = fmul double %_rtX__uDOFEulerAngles_CSTATE_el168, %tmp116
  %tmp132 = fmul double %tmp111, %_rtX__uDOFEulerAngles_CSTATE_el160
  %tmp133 = fsub double %tmp131, %tmp132
  %tmp134 = fsub double %_rtB__TmpSignalConversionAt6DOFEulerAnglesInport2_el, %tmp133
  %tmp135 = fmul double %_rtX__uDOFEulerAngles_CSTATE_el164, 0.000000e+00
  %tmp136 = fmul double %_rtX__uDOFEulerAngles_CSTATE_el168, 0.000000e+00
  %tmp137 = fadd double %tmp135, %tmp136
  %tmp138 = fmul double %_rtX__uDOFEulerAngles_CSTATE_el160, 0.000000e+00
  %tmp139 = fadd double %tmp137, %tmp138
  %tmp140 = fsub double %tmp134, %tmp139
  store double %tmp140, ptr %pData_idx_0_0_, align 1
  %51 = getelementptr inbounds i8, ptr %_rtB_215, i64 224
  %_rtB__TmpSignalConversionAt6DOFEulerAnglesInport2_el229 = load double, ptr %51, align 1
  %tmp141 = fmul double %tmp106, %_rtX__uDOFEulerAngles_CSTATE_el160
  %tmp142 = fmul double %_rtX__uDOFEulerAngles_CSTATE_el164, %tmp116
  %tmp143 = fsub double %tmp141, %tmp142
  %tmp144 = fsub double %_rtB__TmpSignalConversionAt6DOFEulerAnglesInport2_el229, %tmp143
  %tmp150 = fsub double %tmp144, %tmp139
  store double %tmp150, ptr %pData_idx_5_, align 1
  %52 = getelementptr inbounds i8, ptr %_rtB_215, i64 232
  %_rtB__TmpSignalConversionAt6DOFEulerAnglesInport2_el243 = load double, ptr %52, align 1
  %tmp151 = fmul double %_rtX__uDOFEulerAngles_CSTATE_el164, %tmp111
  %tmp152 = fmul double %tmp106, %_rtX__uDOFEulerAngles_CSTATE_el168
  %tmp153 = fsub double %tmp151, %tmp152
  %tmp154 = fsub double %_rtB__TmpSignalConversionAt6DOFEulerAnglesInport2_el243, %tmp153
  %tmp160 = fsub double %tmp154, %tmp139
  store double %tmp160, ptr %pData_idx_2_, align 1
  %tmp164 = fdiv double 1.000000e+00, %tmp130
  %tmp165 = fmul double %tmp119, %tmp164
  %tmp166 = fmul double %tmp140, %tmp165
  %tmp167 = fmul double %_rtP__uDOFEulerAngles_inertia_el154, %_rtP__uDOFEulerAngles_inertia_el184
  %tmp168 = fmul double %_rtP__uDOFEulerAngles_inertia_el178, %_rtP__uDOFEulerAngles_inertia_el158
  %tmp169 = fsub double %tmp167, %tmp168
  %tmp170 = fneg double %tmp169
  %tmp172 = fmul double %tmp164, %tmp170
  %tmp173 = fmul double %tmp150, %tmp172
  %tmp174 = fadd double %tmp166, %tmp173
  %_rtP_276 = load ptr, ptr %_rtP_, align 1
  %53 = getelementptr inbounds i8, ptr %_rtP_276, i64 304
  %_rtP__uDOFEulerAngles_inertia_el277 = load double, ptr %53, align 1
  %54 = getelementptr inbounds i8, ptr %_rtP_276, i64 336
  %_rtP__uDOFEulerAngles_inertia_el279 = load double, ptr %54, align 1
  %tmp175 = fmul double %_rtP__uDOFEulerAngles_inertia_el277, %_rtP__uDOFEulerAngles_inertia_el279
  %55 = getelementptr inbounds i8, ptr %_rtP_276, i64 312
  %_rtP__uDOFEulerAngles_inertia_el281 = load double, ptr %55, align 1
  %56 = getelementptr inbounds i8, ptr %_rtP_276, i64 328
  %_rtP__uDOFEulerAngles_inertia_el283 = load double, ptr %56, align 1
  %tmp176 = fmul double %_rtP__uDOFEulerAngles_inertia_el281, %_rtP__uDOFEulerAngles_inertia_el283
  %tmp177 = fsub double %tmp175, %tmp176
  %tmp179 = fmul double %tmp177, %tmp164
  %tmp180 = fmul double %tmp160, %tmp179
  %tmp181 = fadd double %tmp174, %tmp180
  %_rtXdot_286 = load ptr, ptr %_rtXdot_, align 1
  %57 = getelementptr inbounds i8, ptr %_rtXdot_286, i64 48
  store double %tmp181, ptr %57, align 1
  %58 = getelementptr inbounds i8, ptr %_rtP_276, i64 288
  %_rtP__uDOFEulerAngles_inertia_el288 = load double, ptr %58, align 1
  %59 = getelementptr inbounds i8, ptr %_rtP_276, i64 344
  %_rtP__uDOFEulerAngles_inertia_el290 = load double, ptr %59, align 1
  %tmp182 = fmul double %_rtP__uDOFEulerAngles_inertia_el288, %_rtP__uDOFEulerAngles_inertia_el290
  %60 = getelementptr inbounds i8, ptr %_rtP_276, i64 296
  %_rtP__uDOFEulerAngles_inertia_el292 = load double, ptr %60, align 1
  %_rtP__uDOFEulerAngles_inertia_el294 = load double, ptr %54, align 1
  %tmp183 = fmul double %_rtP__uDOFEulerAngles_inertia_el292, %_rtP__uDOFEulerAngles_inertia_el294
  %tmp184 = fsub double %tmp182, %tmp183
  %tmp185 = fneg double %tmp184
  %tmp187 = fmul double %tmp164, %tmp185
  %tmp188 = fmul double %tmp140, %tmp187
  %61 = getelementptr inbounds i8, ptr %_rtP_276, i64 280
  %_rtP__uDOFEulerAngles_inertia_el298 = load double, ptr %61, align 1
  %tmp189 = fmul double %_rtP__uDOFEulerAngles_inertia_el298, %_rtP__uDOFEulerAngles_inertia_el290
  %_rtP__uDOFEulerAngles_inertia_el304 = load double, ptr %56, align 1
  %tmp190 = fmul double %_rtP__uDOFEulerAngles_inertia_el292, %_rtP__uDOFEulerAngles_inertia_el304
  %tmp191 = fsub double %tmp189, %tmp190
  %tmp193 = fmul double %tmp191, %tmp164
  %tmp194 = fmul double %tmp150, %tmp193
  %tmp195 = fadd double %tmp188, %tmp194
  %tmp196 = fmul double %_rtP__uDOFEulerAngles_inertia_el298, %_rtP__uDOFEulerAngles_inertia_el294
  %tmp197 = fmul double %_rtP__uDOFEulerAngles_inertia_el288, %_rtP__uDOFEulerAngles_inertia_el304
  %tmp198 = fsub double %tmp196, %tmp197
  %tmp199 = fneg double %tmp198
  %tmp201 = fmul double %tmp164, %tmp199
  %tmp202 = fmul double %tmp160, %tmp201
  %tmp203 = fadd double %tmp195, %tmp202
  %62 = getelementptr inbounds i8, ptr %_rtXdot_286, i64 56
  store double %tmp203, ptr %62, align 1
  %_rtP__uDOFEulerAngles_inertia_el319 = load double, ptr %58, align 1
  %63 = getelementptr inbounds i8, ptr %_rtP_276, i64 320
  %_rtP__uDOFEulerAngles_inertia_el321 = load double, ptr %63, align 1
  %tmp204 = fmul double %_rtP__uDOFEulerAngles_inertia_el319, %_rtP__uDOFEulerAngles_inertia_el321
  %_rtP__uDOFEulerAngles_inertia_el323 = load double, ptr %60, align 1
  %_rtP__uDOFEulerAngles_inertia_el325 = load double, ptr %55, align 1
  %tmp205 = fmul double %_rtP__uDOFEulerAngles_inertia_el323, %_rtP__uDOFEulerAngles_inertia_el325
  %tmp206 = fsub double %tmp204, %tmp205
  %tmp208 = fmul double %tmp206, %tmp164
  %tmp209 = fmul double %tmp140, %tmp208
  %_rtP__uDOFEulerAngles_inertia_el329 = load double, ptr %61, align 1
  %tmp210 = fmul double %_rtP__uDOFEulerAngles_inertia_el329, %_rtP__uDOFEulerAngles_inertia_el321
  %_rtP__uDOFEulerAngles_inertia_el335 = load double, ptr %53, align 1
  %tmp211 = fmul double %_rtP__uDOFEulerAngles_inertia_el323, %_rtP__uDOFEulerAngles_inertia_el335
  %tmp212 = fsub double %tmp210, %tmp211
  %tmp213 = fneg double %tmp212
  %pData_idx_4_336 = load double, ptr %pData_idx_4_, align 1
  %tmp214 = fdiv double 1.000000e+00, %pData_idx_4_336
  %tmp215 = fmul double %tmp214, %tmp213
  %tmp216 = fmul double %tmp150, %tmp215
  %tmp217 = fadd double %tmp209, %tmp216
  %tmp218 = fmul double %_rtP__uDOFEulerAngles_inertia_el329, %_rtP__uDOFEulerAngles_inertia_el325
  %tmp219 = fmul double %_rtP__uDOFEulerAngles_inertia_el319, %_rtP__uDOFEulerAngles_inertia_el335
  %tmp220 = fsub double %tmp218, %tmp219
  %tmp222 = fmul double %tmp220, %tmp214
  %tmp223 = fmul double %tmp160, %tmp222
  %tmp224 = fadd double %tmp217, %tmp223
  %64 = getelementptr inbounds i8, ptr %_rtXdot_286, i64 64
  store double %tmp224, ptr %64, align 1
  %_rtX_349 = load ptr, ptr %_rtX_, align 1
  %65 = getelementptr inbounds i8, ptr %_rtX_349, i64 72
  %_rtX__uDOFEulerAngles_CSTATE_el350 = load double, ptr %65, align 1
  %66 = call double @muDoubleScalarSin(double %_rtX__uDOFEulerAngles_CSTATE_el350)
  %67 = getelementptr inbounds i8, ptr %_rtX_349, i64 80
  %_rtX__uDOFEulerAngles_CSTATE_el352 = load double, ptr %67, align 1
  %68 = call double @muDoubleScalarSin(double %_rtX__uDOFEulerAngles_CSTATE_el352)
  %tmp225 = fmul double %66, %68
  %_rtX__uDOFEulerAngles_CSTATE_el354 = load double, ptr %67, align 1
  %69 = call double @muDoubleScalarCos(double %_rtX__uDOFEulerAngles_CSTATE_el354)
  %tmp226 = fdiv double %tmp225, %69
  %70 = getelementptr inbounds i8, ptr %_rtX_349, i64 56
  %_rtX__uDOFEulerAngles_CSTATE_el356 = load double, ptr %70, align 1
  %tmp227 = fmul double %tmp226, %_rtX__uDOFEulerAngles_CSTATE_el356
  %71 = getelementptr inbounds i8, ptr %_rtX_349, i64 48
  %_rtX__uDOFEulerAngles_CSTATE_el358 = load double, ptr %71, align 1
  %tmp228 = fadd double %tmp227, %_rtX__uDOFEulerAngles_CSTATE_el358
  %_rtX__uDOFEulerAngles_CSTATE_el360 = load double, ptr %65, align 1
  %72 = call double @muDoubleScalarCos(double %_rtX__uDOFEulerAngles_CSTATE_el360)
  %_rtX__uDOFEulerAngles_CSTATE_el362 = load double, ptr %67, align 1
  %73 = call double @muDoubleScalarSin(double %_rtX__uDOFEulerAngles_CSTATE_el362)
  %tmp229 = fmul double %72, %73
  %_rtX__uDOFEulerAngles_CSTATE_el364 = load double, ptr %67, align 1
  %74 = call double @muDoubleScalarCos(double %_rtX__uDOFEulerAngles_CSTATE_el364)
  %tmp230 = fdiv double %tmp229, %74
  %75 = getelementptr inbounds i8, ptr %_rtX_349, i64 64
  %_rtX__uDOFEulerAngles_CSTATE_el366 = load double, ptr %75, align 1
  %tmp231 = fmul double %tmp230, %_rtX__uDOFEulerAngles_CSTATE_el366
  %tmp232 = fadd double %tmp228, %tmp231
  %76 = getelementptr inbounds i8, ptr %_rtXdot_286, i64 72
  store double %tmp232, ptr %76, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el369 = load double, ptr %71, align 1
  %tmp233 = fmul double %_rtX__uDOFEulerAngles_CSTATE_el369, 0.000000e+00
  %_rtX__uDOFEulerAngles_CSTATE_el371 = load double, ptr %70, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el373 = load double, ptr %65, align 1
  %77 = call double @muDoubleScalarCos(double %_rtX__uDOFEulerAngles_CSTATE_el373)
  %tmp234 = fmul double %_rtX__uDOFEulerAngles_CSTATE_el371, %77
  %tmp235 = fadd double %tmp233, %tmp234
  %_rtX__uDOFEulerAngles_CSTATE_el375 = load double, ptr %65, align 1
  %78 = call double @muDoubleScalarSin(double %_rtX__uDOFEulerAngles_CSTATE_el375)
  %_rtX__uDOFEulerAngles_CSTATE_el377 = load double, ptr %75, align 1
  %79 = fmul double %78, %_rtX__uDOFEulerAngles_CSTATE_el377
  %tmp238 = fsub double %tmp235, %79
  %_rtXdot_378 = load ptr, ptr %_rtXdot_, align 1
  %80 = getelementptr inbounds i8, ptr %_rtXdot_378, i64 80
  store double %tmp238, ptr %80, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el380 = load double, ptr %65, align 1
  %81 = call double @muDoubleScalarSin(double %_rtX__uDOFEulerAngles_CSTATE_el380)
  %_rtX__uDOFEulerAngles_CSTATE_el382 = load double, ptr %67, align 1
  %82 = call double @muDoubleScalarCos(double %_rtX__uDOFEulerAngles_CSTATE_el382)
  %tmp239 = fdiv double %81, %82
  %_rtX__uDOFEulerAngles_CSTATE_el384 = load double, ptr %70, align 1
  %tmp240 = fmul double %tmp239, %_rtX__uDOFEulerAngles_CSTATE_el384
  %_rtX__uDOFEulerAngles_CSTATE_el386 = load double, ptr %71, align 1
  %tmp241 = fmul double %_rtX__uDOFEulerAngles_CSTATE_el386, 0.000000e+00
  %tmp242 = fadd double %tmp240, %tmp241
  %_rtX__uDOFEulerAngles_CSTATE_el388 = load double, ptr %65, align 1
  %83 = call double @muDoubleScalarCos(double %_rtX__uDOFEulerAngles_CSTATE_el388)
  %_rtX__uDOFEulerAngles_CSTATE_el390 = load double, ptr %67, align 1
  %84 = call double @muDoubleScalarCos(double %_rtX__uDOFEulerAngles_CSTATE_el390)
  %tmp243 = fdiv double %83, %84
  %_rtX__uDOFEulerAngles_CSTATE_el392 = load double, ptr %75, align 1
  %tmp244 = fmul double %tmp243, %_rtX__uDOFEulerAngles_CSTATE_el392
  %tmp245 = fadd double %tmp242, %tmp244
  %85 = getelementptr inbounds i8, ptr %_rtXdot_378, i64 88
  store double %tmp245, ptr %85, align 1
  %86 = getelementptr inbounds i8, ptr %_rtX_349, i64 96
  %_rtX__Integrator_CSTATE = load double, ptr %86, align 1
  %_rtP_395 = load ptr, ptr %_rtP_, align 1
  %87 = getelementptr inbounds i8, ptr %_rtP_395, i64 392
  %_rtP__Integrator_LowerSat = load double, ptr %87, align 1
  %88 = fcmp ogt double %_rtX__Integrator_CSTATE, %_rtP__Integrator_LowerSat
  %89 = getelementptr inbounds i8, ptr %_rtP_395, i64 384
  %_rtP__Integrator_UpperSat = load double, ptr %89, align 1
  %90 = fcmp olt double %_rtX__Integrator_CSTATE, %_rtP__Integrator_UpperSat
  %91 = and i1 %88, %90
  %92 = fcmp ole double %_rtX__Integrator_CSTATE, %_rtP__Integrator_LowerSat
  %_rtB_403 = load ptr, ptr %_rtB_, align 1
  %93 = getelementptr inbounds i8, ptr %_rtB_403, i64 144
  %_rtB__Add = load double, ptr %93, align 1
  %94 = fcmp ogt double %_rtB__Add, 0.000000e+00
  %95 = and i1 %92, %94
  %96 = or i1 %91, %95
  %97 = fcmp oge double %_rtX__Integrator_CSTATE, %_rtP__Integrator_UpperSat
  %98 = fcmp olt double %_rtB__Add, 0.000000e+00
  %99 = and i1 %97, %98
  %100 = or i1 %96, %99
  br i1 %100, label %true, label %false

true:                                             ; preds = %ForcingFunction_entry
  %101 = getelementptr inbounds i8, ptr %_rtXdot_378, i64 96
  store double %_rtB__Add, ptr %101, align 1
  br label %merge

false:                                            ; preds = %ForcingFunction_entry
  %102 = getelementptr inbounds i8, ptr %_rtXdot_378, i64 96
  store double 0.000000e+00, ptr %102, align 1
  br label %merge

true1:                                            ; preds = %merge
  %103 = getelementptr inbounds i8, ptr %_rtXdot_378, i64 104
  store double %_rtB__Add2, ptr %103, align 1
  br label %merge3

false2:                                           ; preds = %merge
  %104 = getelementptr inbounds i8, ptr %_rtXdot_378, i64 104
  store double 0.000000e+00, ptr %104, align 1
  br label %merge3

merge:                                            ; preds = %true, %false
  %105 = getelementptr inbounds i8, ptr %_rtX_349, i64 104
  %_rtX__Integrator_CSTATE_p = load double, ptr %105, align 1
  %106 = getelementptr inbounds i8, ptr %_rtP_395, i64 448
  %_rtP__Integrator_LowerSat_g = load double, ptr %106, align 1
  %107 = fcmp ogt double %_rtX__Integrator_CSTATE_p, %_rtP__Integrator_LowerSat_g
  %108 = getelementptr inbounds i8, ptr %_rtP_395, i64 440
  %_rtP__Integrator_UpperSat_n = load double, ptr %108, align 1
  %109 = fcmp olt double %_rtX__Integrator_CSTATE_p, %_rtP__Integrator_UpperSat_n
  %110 = and i1 %107, %109
  %111 = fcmp ole double %_rtX__Integrator_CSTATE_p, %_rtP__Integrator_LowerSat_g
  %112 = getelementptr inbounds i8, ptr %_rtB_403, i64 208
  %_rtB__Add2 = load double, ptr %112, align 1
  %113 = fcmp ogt double %_rtB__Add2, 0.000000e+00
  %114 = and i1 %111, %113
  %115 = or i1 %110, %114
  %116 = fcmp oge double %_rtX__Integrator_CSTATE_p, %_rtP__Integrator_UpperSat_n
  %117 = fcmp olt double %_rtB__Add2, 0.000000e+00
  %118 = and i1 %116, %117
  %119 = or i1 %115, %118
  br i1 %119, label %true1, label %false2

merge3:                                           ; preds = %true1, %false2
  ret void
}

declare ptr @vm_ssGetdX(ptr)

declare ptr @vm_ssGetX(ptr)

declare ptr @vm_ssGetModelRtp(ptr)

declare ptr @vm__ssGetModelBlockIO(ptr)

declare ptr @memset(ptr, i32 signext, i32 zeroext)

declare double @muDoubleScalarCos(double)

declare double @muDoubleScalarSin(double)

define void @Projection(ptr %S) {
Projection_entry:
  %newangle_ = alloca double, align 8
  %_rtX_ = alloca ptr, align 8
  %0 = call ptr @vm_ssGetX(ptr %S)
  store ptr %0, ptr %_rtX_, align 1
  %1 = getelementptr inbounds i8, ptr %0, i64 72
  %_rtX__uDOFEulerAngles_CSTATE_el = load double, ptr %1, align 1
  store double %_rtX__uDOFEulerAngles_CSTATE_el, ptr %newangle_, align 1
  %2 = call double @muDoubleScalarAbs(double %_rtX__uDOFEulerAngles_CSTATE_el)
  %3 = fcmp ogt double %2, 0x400921FB54442D18
  br i1 %3, label %true, label %false

true:                                             ; preds = %Projection_entry
  %_rtX__uDOFEulerAngles_CSTATE_el10 = load double, ptr %1, align 1
  %4 = call double @muDoubleScalarRem(double %_rtX__uDOFEulerAngles_CSTATE_el10, double 0x401921FB54442D18)
  %_rtX__uDOFEulerAngles_CSTATE_el12 = load double, ptr %1, align 1
  %5 = call double @muDoubleScalarRem(double %_rtX__uDOFEulerAngles_CSTATE_el12, double 0x401921FB54442D18)
  %tmp0 = fdiv double %5, 0x400921FB54442D18
  %6 = call double @llvm.trunc.f64(double %tmp0)
  %tmp1 = fmul double %6, 0x401921FB54442D18
  %tmp2 = fsub double %4, %tmp1
  store double %tmp2, ptr %newangle_, align 1
  br label %false

false:                                            ; preds = %true, %Projection_entry
  %newangle_13 = phi double [ %tmp2, %true ], [ %_rtX__uDOFEulerAngles_CSTATE_el, %Projection_entry ]
  store double %newangle_13, ptr %1, align 1
  %7 = getelementptr inbounds i8, ptr %0, i64 80
  %_rtX__uDOFEulerAngles_CSTATE_el16 = load double, ptr %7, align 1
  store double %_rtX__uDOFEulerAngles_CSTATE_el16, ptr %newangle_, align 1
  %8 = call double @muDoubleScalarAbs(double %_rtX__uDOFEulerAngles_CSTATE_el16)
  %9 = fcmp ogt double %8, 0x400921FB54442D18
  br i1 %9, label %true1, label %false2

true1:                                            ; preds = %false
  %_rtX__uDOFEulerAngles_CSTATE_el20 = load double, ptr %7, align 1
  %10 = call double @muDoubleScalarRem(double %_rtX__uDOFEulerAngles_CSTATE_el20, double 0x401921FB54442D18)
  %_rtX__uDOFEulerAngles_CSTATE_el22 = load double, ptr %7, align 1
  %11 = call double @muDoubleScalarRem(double %_rtX__uDOFEulerAngles_CSTATE_el22, double 0x401921FB54442D18)
  %tmp3 = fdiv double %11, 0x400921FB54442D18
  %12 = call double @llvm.trunc.f64(double %tmp3)
  %tmp4 = fmul double %12, 0x401921FB54442D18
  %tmp5 = fsub double %10, %tmp4
  store double %tmp5, ptr %newangle_, align 1
  br label %false2

false2:                                           ; preds = %true1, %false
  %newangle_23 = phi double [ %tmp5, %true1 ], [ %_rtX__uDOFEulerAngles_CSTATE_el16, %false ]
  store double %newangle_23, ptr %7, align 1
  %13 = getelementptr inbounds i8, ptr %0, i64 88
  %_rtX__uDOFEulerAngles_CSTATE_el26 = load double, ptr %13, align 1
  store double %_rtX__uDOFEulerAngles_CSTATE_el26, ptr %newangle_, align 1
  %14 = call double @muDoubleScalarAbs(double %_rtX__uDOFEulerAngles_CSTATE_el26)
  %15 = fcmp ogt double %14, 0x400921FB54442D18
  br i1 %15, label %true3, label %false4

true3:                                            ; preds = %false2
  %_rtX__uDOFEulerAngles_CSTATE_el30 = load double, ptr %13, align 1
  %16 = call double @muDoubleScalarRem(double %_rtX__uDOFEulerAngles_CSTATE_el30, double 0x401921FB54442D18)
  %_rtX__uDOFEulerAngles_CSTATE_el32 = load double, ptr %13, align 1
  %17 = call double @muDoubleScalarRem(double %_rtX__uDOFEulerAngles_CSTATE_el32, double 0x401921FB54442D18)
  %tmp6 = fdiv double %17, 0x400921FB54442D18
  %18 = call double @llvm.trunc.f64(double %tmp6)
  %tmp7 = fmul double %18, 0x401921FB54442D18
  %tmp8 = fsub double %16, %tmp7
  store double %tmp8, ptr %newangle_, align 1
  br label %false4

false4:                                           ; preds = %true3, %false2
  %newangle_33 = phi double [ %tmp8, %true3 ], [ %_rtX__uDOFEulerAngles_CSTATE_el26, %false2 ]
  store double %newangle_33, ptr %13, align 1
  ret void
}

declare double @muDoubleScalarAbs(double)

declare double @muDoubleScalarRem(double, double)

declare double @trunc(double)

define void @Derivatives(ptr %S) {
Derivatives_entry:
  %S_ = alloca ptr, align 8
  store ptr %S, ptr %S_, align 1
  %pData_idx_4_ = alloca double, align 8
  %pData_idx_7_ = alloca double, align 8
  %pData_idx_5_ = alloca double, align 8
  %pData_idx_8_ = alloca double, align 8
  %pData_idx_0_ = alloca double, align 8
  %pData_idx_6_ = alloca double, align 8
  %pData_idx_2_ = alloca double, align 8
  %pData_idx_8_0_ = alloca double, align 8
  %pData_idx_0_0_ = alloca double, align 8
  %pData_idx_6_0_ = alloca double, align 8
  %pData_idx_1_ = alloca double, align 8
  %pData_idx_4_0_ = alloca double, align 8
  %pData_idx_5_0_ = alloca double, align 8
  %_rtB_ = alloca ptr, align 8
  %_rtP_ = alloca ptr, align 8
  %_rtX_ = alloca ptr, align 8
  %_rtXdot_ = alloca ptr, align 8
  %0 = call ptr @vm_ssGetdX(ptr %S)
  store ptr %0, ptr %_rtXdot_, align 1
  %1 = call ptr @vm_ssGetX(ptr %S)
  store ptr %1, ptr %_rtX_, align 1
  %2 = call ptr @vm_ssGetModelRtp(ptr %S)
  store ptr %2, ptr %_rtP_, align 1
  %3 = call ptr @vm__ssGetModelBlockIO(ptr %S)
  store ptr %3, ptr %_rtB_, align 1
  %4 = call ptr @memset(ptr %0, i32 0, i32 96)
  %5 = getelementptr inbounds i8, ptr %3, i64 184
  %_rtB__Add1_el = load double, ptr %5, align 1
  %6 = getelementptr inbounds i8, ptr %2, i64 272
  %_rtP__uDOFEulerAngles_mass_0 = load double, ptr %6, align 1
  %tmp1 = fdiv double %_rtB__Add1_el, %_rtP__uDOFEulerAngles_mass_0
  %7 = getelementptr inbounds i8, ptr %1, i64 16
  %_rtX__uDOFEulerAngles_CSTATE_el = load double, ptr %7, align 1
  %8 = getelementptr inbounds i8, ptr %1, i64 56
  %_rtX__uDOFEulerAngles_CSTATE_el13 = load double, ptr %8, align 1
  %tmp2 = fmul double %_rtX__uDOFEulerAngles_CSTATE_el, %_rtX__uDOFEulerAngles_CSTATE_el13
  %9 = getelementptr inbounds i8, ptr %1, i64 8
  %_rtX__uDOFEulerAngles_CSTATE_el15 = load double, ptr %9, align 1
  %10 = getelementptr inbounds i8, ptr %1, i64 64
  %_rtX__uDOFEulerAngles_CSTATE_el17 = load double, ptr %10, align 1
  %tmp3 = fmul double %_rtX__uDOFEulerAngles_CSTATE_el15, %_rtX__uDOFEulerAngles_CSTATE_el17
  %tmp4 = fsub double %tmp2, %tmp3
  %tmp5 = fsub double %tmp1, %tmp4
  store double %tmp5, ptr %0, align 1
  %11 = getelementptr inbounds i8, ptr %3, i64 192
  %_rtB__Add1_el20 = load double, ptr %11, align 1
  %_rtP__uDOFEulerAngles_mass_022 = load double, ptr %6, align 1
  %tmp6 = fdiv double %_rtB__Add1_el20, %_rtP__uDOFEulerAngles_mass_022
  %_rtX__uDOFEulerAngles_CSTATE_el24 = load double, ptr %1, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el26 = load double, ptr %10, align 1
  %tmp7 = fmul double %_rtX__uDOFEulerAngles_CSTATE_el24, %_rtX__uDOFEulerAngles_CSTATE_el26
  %_rtX__uDOFEulerAngles_CSTATE_el28 = load double, ptr %7, align 1
  %12 = getelementptr inbounds i8, ptr %1, i64 48
  %_rtX__uDOFEulerAngles_CSTATE_el30 = load double, ptr %12, align 1
  %tmp8 = fmul double %_rtX__uDOFEulerAngles_CSTATE_el28, %_rtX__uDOFEulerAngles_CSTATE_el30
  %tmp9 = fsub double %tmp7, %tmp8
  %tmp10 = fsub double %tmp6, %tmp9
  %13 = getelementptr inbounds i8, ptr %0, i64 8
  store double %tmp10, ptr %13, align 1
  %14 = getelementptr inbounds i8, ptr %3, i64 200
  %_rtB__Add1_el33 = load double, ptr %14, align 1
  %_rtP__uDOFEulerAngles_mass_035 = load double, ptr %6, align 1
  %tmp11 = fdiv double %_rtB__Add1_el33, %_rtP__uDOFEulerAngles_mass_035
  %_rtX__uDOFEulerAngles_CSTATE_el37 = load double, ptr %9, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el39 = load double, ptr %12, align 1
  %tmp12 = fmul double %_rtX__uDOFEulerAngles_CSTATE_el37, %_rtX__uDOFEulerAngles_CSTATE_el39
  %_rtX__uDOFEulerAngles_CSTATE_el41 = load double, ptr %1, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el43 = load double, ptr %8, align 1
  %tmp13 = fmul double %_rtX__uDOFEulerAngles_CSTATE_el41, %_rtX__uDOFEulerAngles_CSTATE_el43
  %tmp14 = fsub double %tmp12, %tmp13
  %tmp15 = fsub double %tmp11, %tmp14
  %15 = getelementptr inbounds i8, ptr %0, i64 16
  store double %tmp15, ptr %15, align 1
  %16 = getelementptr inbounds i8, ptr %1, i64 72
  %_rtX__uDOFEulerAngles_CSTATE_el46 = load double, ptr %16, align 1
  %17 = call double @muDoubleScalarCos(double %_rtX__uDOFEulerAngles_CSTATE_el46)
  store double %17, ptr %pData_idx_4_, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el48 = load double, ptr %16, align 1
  %18 = call double @muDoubleScalarSin(double %_rtX__uDOFEulerAngles_CSTATE_el48)
  store double %18, ptr %pData_idx_7_, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el50 = load double, ptr %16, align 1
  %19 = call double @muDoubleScalarSin(double %_rtX__uDOFEulerAngles_CSTATE_el50)
  %tmp16 = fneg double %19
  store double %tmp16, ptr %pData_idx_5_, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el52 = load double, ptr %16, align 1
  %20 = call double @muDoubleScalarCos(double %_rtX__uDOFEulerAngles_CSTATE_el52)
  store double %20, ptr %pData_idx_8_, align 1
  %21 = getelementptr inbounds i8, ptr %1, i64 80
  %_rtX__uDOFEulerAngles_CSTATE_el54 = load double, ptr %21, align 1
  %22 = call double @muDoubleScalarCos(double %_rtX__uDOFEulerAngles_CSTATE_el54)
  store double %22, ptr %pData_idx_0_, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el56 = load double, ptr %21, align 1
  %23 = call double @muDoubleScalarSin(double %_rtX__uDOFEulerAngles_CSTATE_el56)
  %tmp17 = fneg double %23
  store double %tmp17, ptr %pData_idx_6_, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el58 = load double, ptr %21, align 1
  %24 = call double @muDoubleScalarSin(double %_rtX__uDOFEulerAngles_CSTATE_el58)
  store double %24, ptr %pData_idx_2_, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el60 = load double, ptr %21, align 1
  %25 = call double @muDoubleScalarCos(double %_rtX__uDOFEulerAngles_CSTATE_el60)
  store double %25, ptr %pData_idx_8_0_, align 1
  %tmp18 = fmul double %24, 0.000000e+00
  %tmp19 = fadd double %tmp18, %22
  store double %tmp19, ptr %pData_idx_0_0_, align 1
  %tmp20 = fmul double %25, 0.000000e+00
  %tmp21 = fadd double %tmp20, %tmp17
  store double %tmp21, ptr %pData_idx_6_0_, align 1
  %tmp22 = fmul double %22, 0.000000e+00
  %tmp23 = fmul double %17, 0.000000e+00
  %tmp24 = fadd double %tmp22, %tmp23
  %tmp25 = fmul double %18, %24
  %tmp26 = fadd double %tmp24, %tmp25
  store double %tmp26, ptr %pData_idx_1_, align 1
  %tmp27 = fmul double %18, 0.000000e+00
  %tmp28 = fadd double %tmp27, %17
  store double %tmp28, ptr %pData_idx_4_0_, align 1
  %tmp29 = fmul double %tmp17, 0.000000e+00
  %tmp31 = fadd double %tmp23, %tmp29
  %tmp32 = fmul double %18, %25
  %tmp33 = fadd double %tmp31, %tmp32
  store double %tmp33, ptr %pData_idx_7_, align 1
  %tmp35 = fmul double %tmp16, 0.000000e+00
  %tmp36 = fadd double %tmp22, %tmp35
  %tmp37 = fmul double %24, %20
  %tmp38 = fadd double %tmp36, %tmp37
  store double %tmp38, ptr %pData_idx_2_, align 1
  %tmp39 = fmul double %20, 0.000000e+00
  %tmp40 = fadd double %tmp39, %tmp16
  store double %tmp40, ptr %pData_idx_5_0_, align 1
  %tmp43 = fadd double %tmp35, %tmp29
  %tmp44 = fmul double %20, %25
  %tmp45 = fadd double %tmp43, %tmp44
  store double %tmp45, ptr %pData_idx_8_, align 1
  %_rtX_85 = load ptr, ptr %_rtX_, align 1
  %26 = getelementptr inbounds i8, ptr %_rtX_85, i64 88
  %_rtX__uDOFEulerAngles_CSTATE_el86 = load double, ptr %26, align 1
  %27 = call double @muDoubleScalarCos(double %_rtX__uDOFEulerAngles_CSTATE_el86)
  store double %27, ptr %pData_idx_0_, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el88 = load double, ptr %26, align 1
  %28 = call double @muDoubleScalarSin(double %_rtX__uDOFEulerAngles_CSTATE_el88)
  store double %28, ptr %pData_idx_6_, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el90 = load double, ptr %26, align 1
  %29 = call double @muDoubleScalarSin(double %_rtX__uDOFEulerAngles_CSTATE_el90)
  %tmp46 = fneg double %29
  store double %tmp46, ptr %pData_idx_5_, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el92 = load double, ptr %26, align 1
  %30 = call double @muDoubleScalarCos(double %_rtX__uDOFEulerAngles_CSTATE_el92)
  store double %30, ptr %pData_idx_4_, align 1
  %tmp47 = fmul double %tmp19, %27
  %tmp48 = fmul double %tmp46, 0.000000e+00
  %tmp49 = fadd double %tmp47, %tmp48
  %tmp50 = fmul double %tmp21, 0.000000e+00
  %tmp51 = fadd double %tmp49, %tmp50
  %_rtX__uDOFEulerAngles_CSTATE_el98 = load double, ptr %_rtX_85, align 1
  %tmp52 = fmul double %tmp51, %_rtX__uDOFEulerAngles_CSTATE_el98
  %tmp53 = fmul double %27, %tmp26
  %tmp54 = fmul double %tmp46, %tmp28
  %tmp55 = fadd double %tmp53, %tmp54
  %tmp56 = fmul double %tmp33, 0.000000e+00
  %tmp57 = fadd double %tmp55, %tmp56
  %31 = getelementptr inbounds i8, ptr %_rtX_85, i64 8
  %_rtX__uDOFEulerAngles_CSTATE_el105 = load double, ptr %31, align 1
  %tmp58 = fmul double %tmp57, %_rtX__uDOFEulerAngles_CSTATE_el105
  %tmp59 = fadd double %tmp52, %tmp58
  %tmp60 = fmul double %27, %tmp38
  %tmp61 = fmul double %tmp46, %tmp40
  %tmp62 = fadd double %tmp60, %tmp61
  %tmp63 = fmul double %tmp45, 0.000000e+00
  %tmp64 = fadd double %tmp62, %tmp63
  %32 = getelementptr inbounds i8, ptr %_rtX_85, i64 16
  %_rtX__uDOFEulerAngles_CSTATE_el112 = load double, ptr %32, align 1
  %tmp65 = fmul double %tmp64, %_rtX__uDOFEulerAngles_CSTATE_el112
  %tmp66 = fadd double %tmp59, %tmp65
  %_rtXdot_113 = load ptr, ptr %_rtXdot_, align 1
  %33 = getelementptr inbounds i8, ptr %_rtXdot_113, i64 24
  store double %tmp66, ptr %33, align 1
  %tmp67 = fmul double %tmp19, %28
  %tmp68 = fmul double %30, 0.000000e+00
  %tmp69 = fadd double %tmp67, %tmp68
  %tmp71 = fadd double %tmp69, %tmp50
  %_rtX__uDOFEulerAngles_CSTATE_el119 = load double, ptr %_rtX_85, align 1
  %tmp72 = fmul double %tmp71, %_rtX__uDOFEulerAngles_CSTATE_el119
  %tmp73 = fmul double %28, %tmp26
  %tmp74 = fmul double %tmp28, %30
  %tmp75 = fadd double %tmp73, %tmp74
  %tmp77 = fadd double %tmp75, %tmp56
  %_rtX__uDOFEulerAngles_CSTATE_el126 = load double, ptr %31, align 1
  %tmp78 = fmul double %tmp77, %_rtX__uDOFEulerAngles_CSTATE_el126
  %tmp79 = fadd double %tmp72, %tmp78
  %tmp80 = fmul double %28, %tmp38
  %tmp81 = fmul double %30, %tmp40
  %tmp82 = fadd double %tmp80, %tmp81
  %tmp84 = fadd double %tmp82, %tmp63
  %_rtX__uDOFEulerAngles_CSTATE_el133 = load double, ptr %32, align 1
  %tmp85 = fmul double %tmp84, %_rtX__uDOFEulerAngles_CSTATE_el133
  %tmp86 = fadd double %tmp79, %tmp85
  %34 = getelementptr inbounds i8, ptr %_rtXdot_113, i64 32
  store double %tmp86, ptr %34, align 1
  %tmp87 = fmul double %tmp26, 0.000000e+00
  %tmp88 = fmul double %tmp28, 0.000000e+00
  %tmp89 = fadd double %tmp87, %tmp88
  %tmp90 = fadd double %tmp33, %tmp89
  %_rtX__uDOFEulerAngles_CSTATE_el139 = load double, ptr %31, align 1
  %tmp91 = fmul double %tmp90, %_rtX__uDOFEulerAngles_CSTATE_el139
  %pData_idx_0_0_140 = load double, ptr %pData_idx_0_0_, align 1
  %tmp92 = fmul double %pData_idx_0_0_140, 0.000000e+00
  %pData_idx_6_0_141 = load double, ptr %pData_idx_6_0_, align 1
  %tmp93 = fadd double %tmp92, %pData_idx_6_0_141
  %_rtX__uDOFEulerAngles_CSTATE_el143 = load double, ptr %_rtX_85, align 1
  %tmp94 = fmul double %tmp93, %_rtX__uDOFEulerAngles_CSTATE_el143
  %tmp95 = fadd double %tmp91, %tmp94
  %tmp96 = fmul double %tmp38, 0.000000e+00
  %tmp97 = fmul double %tmp40, 0.000000e+00
  %tmp98 = fadd double %tmp96, %tmp97
  %tmp99 = fadd double %tmp45, %tmp98
  %_rtX__uDOFEulerAngles_CSTATE_el148 = load double, ptr %32, align 1
  %tmp100 = fmul double %tmp99, %_rtX__uDOFEulerAngles_CSTATE_el148
  %tmp101 = fadd double %tmp95, %tmp100
  %35 = getelementptr inbounds i8, ptr %_rtXdot_113, i64 40
  store double %tmp101, ptr %35, align 1
  %_rtP_150 = load ptr, ptr %_rtP_, align 1
  %36 = getelementptr inbounds i8, ptr %_rtP_150, i64 280
  %_rtP__uDOFEulerAngles_inertia_el = load double, ptr %36, align 1
  %37 = getelementptr inbounds i8, ptr %_rtX_85, i64 48
  %_rtX__uDOFEulerAngles_CSTATE_el152 = load double, ptr %37, align 1
  %tmp102 = fmul double %_rtP__uDOFEulerAngles_inertia_el, %_rtX__uDOFEulerAngles_CSTATE_el152
  %38 = getelementptr inbounds i8, ptr %_rtP_150, i64 304
  %_rtP__uDOFEulerAngles_inertia_el154 = load double, ptr %38, align 1
  %39 = getelementptr inbounds i8, ptr %_rtX_85, i64 56
  %_rtX__uDOFEulerAngles_CSTATE_el156 = load double, ptr %39, align 1
  %tmp103 = fmul double %_rtP__uDOFEulerAngles_inertia_el154, %_rtX__uDOFEulerAngles_CSTATE_el156
  %tmp104 = fadd double %tmp102, %tmp103
  %40 = getelementptr inbounds i8, ptr %_rtP_150, i64 328
  %_rtP__uDOFEulerAngles_inertia_el158 = load double, ptr %40, align 1
  %_rtX_159 = load ptr, ptr %_rtX_, align 1
  %41 = getelementptr inbounds i8, ptr %_rtX_159, i64 64
  %_rtX__uDOFEulerAngles_CSTATE_el160 = load double, ptr %41, align 1
  %tmp105 = fmul double %_rtP__uDOFEulerAngles_inertia_el158, %_rtX__uDOFEulerAngles_CSTATE_el160
  %tmp106 = fadd double %tmp104, %tmp105
  store double %tmp106, ptr %pData_idx_0_, align 1
  %42 = getelementptr inbounds i8, ptr %_rtP_150, i64 288
  %_rtP__uDOFEulerAngles_inertia_el162 = load double, ptr %42, align 1
  %43 = getelementptr inbounds i8, ptr %_rtX_159, i64 48
  %_rtX__uDOFEulerAngles_CSTATE_el164 = load double, ptr %43, align 1
  %tmp107 = fmul double %_rtP__uDOFEulerAngles_inertia_el162, %_rtX__uDOFEulerAngles_CSTATE_el164
  %44 = getelementptr inbounds i8, ptr %_rtP_150, i64 312
  %_rtP__uDOFEulerAngles_inertia_el166 = load double, ptr %44, align 1
  %45 = getelementptr inbounds i8, ptr %_rtX_159, i64 56
  %_rtX__uDOFEulerAngles_CSTATE_el168 = load double, ptr %45, align 1
  %tmp108 = fmul double %_rtP__uDOFEulerAngles_inertia_el166, %_rtX__uDOFEulerAngles_CSTATE_el168
  %tmp109 = fadd double %tmp107, %tmp108
  %46 = getelementptr inbounds i8, ptr %_rtP_150, i64 336
  %_rtP__uDOFEulerAngles_inertia_el170 = load double, ptr %46, align 1
  %tmp110 = fmul double %_rtP__uDOFEulerAngles_inertia_el170, %_rtX__uDOFEulerAngles_CSTATE_el160
  %tmp111 = fadd double %tmp109, %tmp110
  store double %tmp111, ptr %pData_idx_1_, align 1
  %47 = getelementptr inbounds i8, ptr %_rtP_150, i64 296
  %_rtP__uDOFEulerAngles_inertia_el174 = load double, ptr %47, align 1
  %tmp112 = fmul double %_rtP__uDOFEulerAngles_inertia_el174, %_rtX__uDOFEulerAngles_CSTATE_el164
  %48 = getelementptr inbounds i8, ptr %_rtP_150, i64 320
  %_rtP__uDOFEulerAngles_inertia_el178 = load double, ptr %48, align 1
  %tmp113 = fmul double %_rtP__uDOFEulerAngles_inertia_el178, %_rtX__uDOFEulerAngles_CSTATE_el168
  %tmp114 = fadd double %tmp112, %tmp113
  %49 = getelementptr inbounds i8, ptr %_rtP_150, i64 344
  %_rtP__uDOFEulerAngles_inertia_el184 = load double, ptr %49, align 1
  %tmp115 = fmul double %_rtX__uDOFEulerAngles_CSTATE_el160, %_rtP__uDOFEulerAngles_inertia_el184
  %tmp116 = fadd double %tmp114, %tmp115
  store double %tmp116, ptr %pData_idx_2_, align 1
  %tmp117 = fmul double %_rtP__uDOFEulerAngles_inertia_el166, %_rtP__uDOFEulerAngles_inertia_el184
  %tmp118 = fmul double %_rtP__uDOFEulerAngles_inertia_el178, %_rtP__uDOFEulerAngles_inertia_el170
  %tmp119 = fsub double %tmp117, %tmp118
  %tmp120 = fmul double %tmp119, %_rtP__uDOFEulerAngles_inertia_el
  %tmp121 = fmul double %_rtP__uDOFEulerAngles_inertia_el162, %_rtP__uDOFEulerAngles_inertia_el184
  %tmp122 = fmul double %_rtP__uDOFEulerAngles_inertia_el174, %_rtP__uDOFEulerAngles_inertia_el170
  %tmp123 = fsub double %tmp121, %tmp122
  %tmp124 = fmul double %tmp123, %_rtP__uDOFEulerAngles_inertia_el154
  %tmp125 = fsub double %tmp120, %tmp124
  %tmp126 = fmul double %_rtP__uDOFEulerAngles_inertia_el162, %_rtP__uDOFEulerAngles_inertia_el178
  %tmp127 = fmul double %_rtP__uDOFEulerAngles_inertia_el174, %_rtP__uDOFEulerAngles_inertia_el166
  %tmp128 = fsub double %tmp126, %tmp127
  %tmp129 = fmul double %tmp128, %_rtP__uDOFEulerAngles_inertia_el158
  %tmp130 = fadd double %tmp125, %tmp129
  store double %tmp130, ptr %pData_idx_4_, align 1
  %_rtB_215 = load ptr, ptr %_rtB_, align 1
  %50 = getelementptr inbounds i8, ptr %_rtB_215, i64 216
  %_rtB__TmpSignalConversionAt6DOFEulerAnglesInport2_el = load double, ptr %50, align 1
  %tmp131 = fmul double %_rtX__uDOFEulerAngles_CSTATE_el168, %tmp116
  %tmp132 = fmul double %tmp111, %_rtX__uDOFEulerAngles_CSTATE_el160
  %tmp133 = fsub double %tmp131, %tmp132
  %tmp134 = fsub double %_rtB__TmpSignalConversionAt6DOFEulerAnglesInport2_el, %tmp133
  %tmp135 = fmul double %_rtX__uDOFEulerAngles_CSTATE_el164, 0.000000e+00
  %tmp136 = fmul double %_rtX__uDOFEulerAngles_CSTATE_el168, 0.000000e+00
  %tmp137 = fadd double %tmp135, %tmp136
  %tmp138 = fmul double %_rtX__uDOFEulerAngles_CSTATE_el160, 0.000000e+00
  %tmp139 = fadd double %tmp137, %tmp138
  %tmp140 = fsub double %tmp134, %tmp139
  store double %tmp140, ptr %pData_idx_0_0_, align 1
  %51 = getelementptr inbounds i8, ptr %_rtB_215, i64 224
  %_rtB__TmpSignalConversionAt6DOFEulerAnglesInport2_el229 = load double, ptr %51, align 1
  %tmp141 = fmul double %tmp106, %_rtX__uDOFEulerAngles_CSTATE_el160
  %tmp142 = fmul double %_rtX__uDOFEulerAngles_CSTATE_el164, %tmp116
  %tmp143 = fsub double %tmp141, %tmp142
  %tmp144 = fsub double %_rtB__TmpSignalConversionAt6DOFEulerAnglesInport2_el229, %tmp143
  %tmp150 = fsub double %tmp144, %tmp139
  store double %tmp150, ptr %pData_idx_5_, align 1
  %52 = getelementptr inbounds i8, ptr %_rtB_215, i64 232
  %_rtB__TmpSignalConversionAt6DOFEulerAnglesInport2_el243 = load double, ptr %52, align 1
  %tmp151 = fmul double %_rtX__uDOFEulerAngles_CSTATE_el164, %tmp111
  %tmp152 = fmul double %tmp106, %_rtX__uDOFEulerAngles_CSTATE_el168
  %tmp153 = fsub double %tmp151, %tmp152
  %tmp154 = fsub double %_rtB__TmpSignalConversionAt6DOFEulerAnglesInport2_el243, %tmp153
  %tmp160 = fsub double %tmp154, %tmp139
  store double %tmp160, ptr %pData_idx_2_, align 1
  %tmp164 = fdiv double 1.000000e+00, %tmp130
  %tmp165 = fmul double %tmp119, %tmp164
  %tmp166 = fmul double %tmp140, %tmp165
  %tmp167 = fmul double %_rtP__uDOFEulerAngles_inertia_el154, %_rtP__uDOFEulerAngles_inertia_el184
  %tmp168 = fmul double %_rtP__uDOFEulerAngles_inertia_el178, %_rtP__uDOFEulerAngles_inertia_el158
  %tmp169 = fsub double %tmp167, %tmp168
  %tmp170 = fneg double %tmp169
  %tmp172 = fmul double %tmp164, %tmp170
  %tmp173 = fmul double %tmp150, %tmp172
  %tmp174 = fadd double %tmp166, %tmp173
  %_rtP_276 = load ptr, ptr %_rtP_, align 1
  %53 = getelementptr inbounds i8, ptr %_rtP_276, i64 304
  %_rtP__uDOFEulerAngles_inertia_el277 = load double, ptr %53, align 1
  %54 = getelementptr inbounds i8, ptr %_rtP_276, i64 336
  %_rtP__uDOFEulerAngles_inertia_el279 = load double, ptr %54, align 1
  %tmp175 = fmul double %_rtP__uDOFEulerAngles_inertia_el277, %_rtP__uDOFEulerAngles_inertia_el279
  %55 = getelementptr inbounds i8, ptr %_rtP_276, i64 312
  %_rtP__uDOFEulerAngles_inertia_el281 = load double, ptr %55, align 1
  %56 = getelementptr inbounds i8, ptr %_rtP_276, i64 328
  %_rtP__uDOFEulerAngles_inertia_el283 = load double, ptr %56, align 1
  %tmp176 = fmul double %_rtP__uDOFEulerAngles_inertia_el281, %_rtP__uDOFEulerAngles_inertia_el283
  %tmp177 = fsub double %tmp175, %tmp176
  %tmp179 = fmul double %tmp177, %tmp164
  %tmp180 = fmul double %tmp160, %tmp179
  %tmp181 = fadd double %tmp174, %tmp180
  %_rtXdot_286 = load ptr, ptr %_rtXdot_, align 1
  %57 = getelementptr inbounds i8, ptr %_rtXdot_286, i64 48
  store double %tmp181, ptr %57, align 1
  %58 = getelementptr inbounds i8, ptr %_rtP_276, i64 288
  %_rtP__uDOFEulerAngles_inertia_el288 = load double, ptr %58, align 1
  %59 = getelementptr inbounds i8, ptr %_rtP_276, i64 344
  %_rtP__uDOFEulerAngles_inertia_el290 = load double, ptr %59, align 1
  %tmp182 = fmul double %_rtP__uDOFEulerAngles_inertia_el288, %_rtP__uDOFEulerAngles_inertia_el290
  %60 = getelementptr inbounds i8, ptr %_rtP_276, i64 296
  %_rtP__uDOFEulerAngles_inertia_el292 = load double, ptr %60, align 1
  %_rtP__uDOFEulerAngles_inertia_el294 = load double, ptr %54, align 1
  %tmp183 = fmul double %_rtP__uDOFEulerAngles_inertia_el292, %_rtP__uDOFEulerAngles_inertia_el294
  %tmp184 = fsub double %tmp182, %tmp183
  %tmp185 = fneg double %tmp184
  %tmp187 = fmul double %tmp164, %tmp185
  %tmp188 = fmul double %tmp140, %tmp187
  %61 = getelementptr inbounds i8, ptr %_rtP_276, i64 280
  %_rtP__uDOFEulerAngles_inertia_el298 = load double, ptr %61, align 1
  %tmp189 = fmul double %_rtP__uDOFEulerAngles_inertia_el298, %_rtP__uDOFEulerAngles_inertia_el290
  %_rtP__uDOFEulerAngles_inertia_el304 = load double, ptr %56, align 1
  %tmp190 = fmul double %_rtP__uDOFEulerAngles_inertia_el292, %_rtP__uDOFEulerAngles_inertia_el304
  %tmp191 = fsub double %tmp189, %tmp190
  %tmp193 = fmul double %tmp191, %tmp164
  %tmp194 = fmul double %tmp150, %tmp193
  %tmp195 = fadd double %tmp188, %tmp194
  %tmp196 = fmul double %_rtP__uDOFEulerAngles_inertia_el298, %_rtP__uDOFEulerAngles_inertia_el294
  %tmp197 = fmul double %_rtP__uDOFEulerAngles_inertia_el288, %_rtP__uDOFEulerAngles_inertia_el304
  %tmp198 = fsub double %tmp196, %tmp197
  %tmp199 = fneg double %tmp198
  %tmp201 = fmul double %tmp164, %tmp199
  %tmp202 = fmul double %tmp160, %tmp201
  %tmp203 = fadd double %tmp195, %tmp202
  %62 = getelementptr inbounds i8, ptr %_rtXdot_286, i64 56
  store double %tmp203, ptr %62, align 1
  %_rtP__uDOFEulerAngles_inertia_el319 = load double, ptr %58, align 1
  %63 = getelementptr inbounds i8, ptr %_rtP_276, i64 320
  %_rtP__uDOFEulerAngles_inertia_el321 = load double, ptr %63, align 1
  %tmp204 = fmul double %_rtP__uDOFEulerAngles_inertia_el319, %_rtP__uDOFEulerAngles_inertia_el321
  %_rtP__uDOFEulerAngles_inertia_el323 = load double, ptr %60, align 1
  %_rtP__uDOFEulerAngles_inertia_el325 = load double, ptr %55, align 1
  %tmp205 = fmul double %_rtP__uDOFEulerAngles_inertia_el323, %_rtP__uDOFEulerAngles_inertia_el325
  %tmp206 = fsub double %tmp204, %tmp205
  %tmp208 = fmul double %tmp206, %tmp164
  %tmp209 = fmul double %tmp140, %tmp208
  %_rtP__uDOFEulerAngles_inertia_el329 = load double, ptr %61, align 1
  %tmp210 = fmul double %_rtP__uDOFEulerAngles_inertia_el329, %_rtP__uDOFEulerAngles_inertia_el321
  %_rtP__uDOFEulerAngles_inertia_el335 = load double, ptr %53, align 1
  %tmp211 = fmul double %_rtP__uDOFEulerAngles_inertia_el323, %_rtP__uDOFEulerAngles_inertia_el335
  %tmp212 = fsub double %tmp210, %tmp211
  %tmp213 = fneg double %tmp212
  %pData_idx_4_336 = load double, ptr %pData_idx_4_, align 1
  %tmp214 = fdiv double 1.000000e+00, %pData_idx_4_336
  %tmp215 = fmul double %tmp214, %tmp213
  %tmp216 = fmul double %tmp150, %tmp215
  %tmp217 = fadd double %tmp209, %tmp216
  %tmp218 = fmul double %_rtP__uDOFEulerAngles_inertia_el329, %_rtP__uDOFEulerAngles_inertia_el325
  %tmp219 = fmul double %_rtP__uDOFEulerAngles_inertia_el319, %_rtP__uDOFEulerAngles_inertia_el335
  %tmp220 = fsub double %tmp218, %tmp219
  %tmp222 = fmul double %tmp220, %tmp214
  %tmp223 = fmul double %tmp160, %tmp222
  %tmp224 = fadd double %tmp217, %tmp223
  %64 = getelementptr inbounds i8, ptr %_rtXdot_286, i64 64
  store double %tmp224, ptr %64, align 1
  %_rtX_349 = load ptr, ptr %_rtX_, align 1
  %65 = getelementptr inbounds i8, ptr %_rtX_349, i64 72
  %_rtX__uDOFEulerAngles_CSTATE_el350 = load double, ptr %65, align 1
  %66 = call double @muDoubleScalarSin(double %_rtX__uDOFEulerAngles_CSTATE_el350)
  %67 = getelementptr inbounds i8, ptr %_rtX_349, i64 80
  %_rtX__uDOFEulerAngles_CSTATE_el352 = load double, ptr %67, align 1
  %68 = call double @muDoubleScalarSin(double %_rtX__uDOFEulerAngles_CSTATE_el352)
  %tmp225 = fmul double %66, %68
  %_rtX__uDOFEulerAngles_CSTATE_el354 = load double, ptr %67, align 1
  %69 = call double @muDoubleScalarCos(double %_rtX__uDOFEulerAngles_CSTATE_el354)
  %tmp226 = fdiv double %tmp225, %69
  %70 = getelementptr inbounds i8, ptr %_rtX_349, i64 56
  %_rtX__uDOFEulerAngles_CSTATE_el356 = load double, ptr %70, align 1
  %tmp227 = fmul double %tmp226, %_rtX__uDOFEulerAngles_CSTATE_el356
  %71 = getelementptr inbounds i8, ptr %_rtX_349, i64 48
  %_rtX__uDOFEulerAngles_CSTATE_el358 = load double, ptr %71, align 1
  %tmp228 = fadd double %tmp227, %_rtX__uDOFEulerAngles_CSTATE_el358
  %_rtX__uDOFEulerAngles_CSTATE_el360 = load double, ptr %65, align 1
  %72 = call double @muDoubleScalarCos(double %_rtX__uDOFEulerAngles_CSTATE_el360)
  %_rtX__uDOFEulerAngles_CSTATE_el362 = load double, ptr %67, align 1
  %73 = call double @muDoubleScalarSin(double %_rtX__uDOFEulerAngles_CSTATE_el362)
  %tmp229 = fmul double %72, %73
  %_rtX__uDOFEulerAngles_CSTATE_el364 = load double, ptr %67, align 1
  %74 = call double @muDoubleScalarCos(double %_rtX__uDOFEulerAngles_CSTATE_el364)
  %tmp230 = fdiv double %tmp229, %74
  %75 = getelementptr inbounds i8, ptr %_rtX_349, i64 64
  %_rtX__uDOFEulerAngles_CSTATE_el366 = load double, ptr %75, align 1
  %tmp231 = fmul double %tmp230, %_rtX__uDOFEulerAngles_CSTATE_el366
  %tmp232 = fadd double %tmp228, %tmp231
  %76 = getelementptr inbounds i8, ptr %_rtXdot_286, i64 72
  store double %tmp232, ptr %76, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el369 = load double, ptr %71, align 1
  %tmp233 = fmul double %_rtX__uDOFEulerAngles_CSTATE_el369, 0.000000e+00
  %_rtX__uDOFEulerAngles_CSTATE_el371 = load double, ptr %70, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el373 = load double, ptr %65, align 1
  %77 = call double @muDoubleScalarCos(double %_rtX__uDOFEulerAngles_CSTATE_el373)
  %tmp234 = fmul double %_rtX__uDOFEulerAngles_CSTATE_el371, %77
  %tmp235 = fadd double %tmp233, %tmp234
  %_rtX__uDOFEulerAngles_CSTATE_el375 = load double, ptr %65, align 1
  %78 = call double @muDoubleScalarSin(double %_rtX__uDOFEulerAngles_CSTATE_el375)
  %_rtX__uDOFEulerAngles_CSTATE_el377 = load double, ptr %75, align 1
  %79 = fmul double %78, %_rtX__uDOFEulerAngles_CSTATE_el377
  %tmp238 = fsub double %tmp235, %79
  %_rtXdot_378 = load ptr, ptr %_rtXdot_, align 1
  %80 = getelementptr inbounds i8, ptr %_rtXdot_378, i64 80
  store double %tmp238, ptr %80, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el380 = load double, ptr %65, align 1
  %81 = call double @muDoubleScalarSin(double %_rtX__uDOFEulerAngles_CSTATE_el380)
  %_rtX__uDOFEulerAngles_CSTATE_el382 = load double, ptr %67, align 1
  %82 = call double @muDoubleScalarCos(double %_rtX__uDOFEulerAngles_CSTATE_el382)
  %tmp239 = fdiv double %81, %82
  %_rtX__uDOFEulerAngles_CSTATE_el384 = load double, ptr %70, align 1
  %tmp240 = fmul double %tmp239, %_rtX__uDOFEulerAngles_CSTATE_el384
  %_rtX__uDOFEulerAngles_CSTATE_el386 = load double, ptr %71, align 1
  %tmp241 = fmul double %_rtX__uDOFEulerAngles_CSTATE_el386, 0.000000e+00
  %tmp242 = fadd double %tmp240, %tmp241
  %_rtX__uDOFEulerAngles_CSTATE_el388 = load double, ptr %65, align 1
  %83 = call double @muDoubleScalarCos(double %_rtX__uDOFEulerAngles_CSTATE_el388)
  %_rtX__uDOFEulerAngles_CSTATE_el390 = load double, ptr %67, align 1
  %84 = call double @muDoubleScalarCos(double %_rtX__uDOFEulerAngles_CSTATE_el390)
  %tmp243 = fdiv double %83, %84
  %_rtX__uDOFEulerAngles_CSTATE_el392 = load double, ptr %75, align 1
  %tmp244 = fmul double %tmp243, %_rtX__uDOFEulerAngles_CSTATE_el392
  %tmp245 = fadd double %tmp242, %tmp244
  %85 = getelementptr inbounds i8, ptr %_rtXdot_378, i64 88
  store double %tmp245, ptr %85, align 1
  %86 = getelementptr inbounds i8, ptr %_rtX_349, i64 96
  %_rtX__Integrator_CSTATE = load double, ptr %86, align 1
  %_rtP_395 = load ptr, ptr %_rtP_, align 1
  %87 = getelementptr inbounds i8, ptr %_rtP_395, i64 392
  %_rtP__Integrator_LowerSat = load double, ptr %87, align 1
  %88 = fcmp ogt double %_rtX__Integrator_CSTATE, %_rtP__Integrator_LowerSat
  %89 = getelementptr inbounds i8, ptr %_rtP_395, i64 384
  %_rtP__Integrator_UpperSat = load double, ptr %89, align 1
  %90 = fcmp olt double %_rtX__Integrator_CSTATE, %_rtP__Integrator_UpperSat
  %91 = and i1 %88, %90
  %92 = fcmp ole double %_rtX__Integrator_CSTATE, %_rtP__Integrator_LowerSat
  %_rtB_403 = load ptr, ptr %_rtB_, align 1
  %93 = getelementptr inbounds i8, ptr %_rtB_403, i64 144
  %_rtB__Add = load double, ptr %93, align 1
  %94 = fcmp ogt double %_rtB__Add, 0.000000e+00
  %95 = and i1 %92, %94
  %96 = or i1 %91, %95
  %97 = fcmp oge double %_rtX__Integrator_CSTATE, %_rtP__Integrator_UpperSat
  %98 = fcmp olt double %_rtB__Add, 0.000000e+00
  %99 = and i1 %97, %98
  %100 = or i1 %96, %99
  br i1 %100, label %true, label %false

true:                                             ; preds = %Derivatives_entry
  %101 = getelementptr inbounds i8, ptr %_rtXdot_378, i64 96
  store double %_rtB__Add, ptr %101, align 1
  br label %merge

false:                                            ; preds = %Derivatives_entry
  %102 = getelementptr inbounds i8, ptr %_rtXdot_378, i64 96
  store double 0.000000e+00, ptr %102, align 1
  br label %merge

true1:                                            ; preds = %merge
  %103 = getelementptr inbounds i8, ptr %_rtXdot_378, i64 104
  store double %_rtB__Add2, ptr %103, align 1
  br label %merge3

false2:                                           ; preds = %merge
  %104 = getelementptr inbounds i8, ptr %_rtXdot_378, i64 104
  store double 0.000000e+00, ptr %104, align 1
  br label %merge3

merge:                                            ; preds = %true, %false
  %105 = getelementptr inbounds i8, ptr %_rtX_349, i64 104
  %_rtX__Integrator_CSTATE_p = load double, ptr %105, align 1
  %106 = getelementptr inbounds i8, ptr %_rtP_395, i64 448
  %_rtP__Integrator_LowerSat_g = load double, ptr %106, align 1
  %107 = fcmp ogt double %_rtX__Integrator_CSTATE_p, %_rtP__Integrator_LowerSat_g
  %108 = getelementptr inbounds i8, ptr %_rtP_395, i64 440
  %_rtP__Integrator_UpperSat_n = load double, ptr %108, align 1
  %109 = fcmp olt double %_rtX__Integrator_CSTATE_p, %_rtP__Integrator_UpperSat_n
  %110 = and i1 %107, %109
  %111 = fcmp ole double %_rtX__Integrator_CSTATE_p, %_rtP__Integrator_LowerSat_g
  %112 = getelementptr inbounds i8, ptr %_rtB_403, i64 208
  %_rtB__Add2 = load double, ptr %112, align 1
  %113 = fcmp ogt double %_rtB__Add2, 0.000000e+00
  %114 = and i1 %111, %113
  %115 = or i1 %110, %114
  %116 = fcmp oge double %_rtX__Integrator_CSTATE_p, %_rtP__Integrator_UpperSat_n
  %117 = fcmp olt double %_rtB__Add2, 0.000000e+00
  %118 = and i1 %116, %117
  %119 = or i1 %115, %118
  br i1 %119, label %true1, label %false2

merge3:                                           ; preds = %true1, %false2
  ret void
}

define void @Outputs1(ptr %S, i32 signext %controlPortIdx) {
Outputs1_entry:
  %_rtB_ = alloca ptr, align 8
  %_rtP_ = alloca ptr, align 8
  %0 = call ptr @vm_ssGetModelRtp(ptr %S)
  store ptr %0, ptr %_rtP_, align 1
  %1 = call ptr @vm__ssGetModelBlockIO(ptr %S)
  store ptr %1, ptr %_rtB_, align 1
  %2 = getelementptr inbounds i8, ptr %0, i64 472
  %_rtP__Constant_Value = load double, ptr %2, align 1
  %3 = getelementptr inbounds i8, ptr %1, i64 240
  store double %_rtP__Constant_Value, ptr %3, align 1
  %4 = getelementptr inbounds i8, ptr %0, i64 504
  %_rtP__q_des_Value = load double, ptr %4, align 1
  %5 = getelementptr inbounds i8, ptr %1, i64 272
  store double %_rtP__q_des_Value, ptr %5, align 1
  %6 = getelementptr inbounds i8, ptr %0, i64 480
  %_rtP__Constant_Value_k_el = load double, ptr %6, align 1
  %7 = getelementptr inbounds i8, ptr %1, i64 248
  store double %_rtP__Constant_Value_k_el, ptr %7, align 1
  %8 = getelementptr inbounds i8, ptr %0, i64 512
  %_rtP__Constant_Value_c_el = load double, ptr %8, align 1
  %9 = getelementptr inbounds i8, ptr %1, i64 280
  store double %_rtP__Constant_Value_c_el, ptr %9, align 1
  %10 = getelementptr inbounds i8, ptr %0, i64 488
  %_rtP__Constant_Value_k_el12 = load double, ptr %10, align 1
  %11 = getelementptr inbounds i8, ptr %1, i64 256
  store double %_rtP__Constant_Value_k_el12, ptr %11, align 1
  %12 = getelementptr inbounds i8, ptr %0, i64 520
  %_rtP__Constant_Value_c_el15 = load double, ptr %12, align 1
  %13 = getelementptr inbounds i8, ptr %1, i64 288
  store double %_rtP__Constant_Value_c_el15, ptr %13, align 1
  %14 = getelementptr inbounds i8, ptr %0, i64 496
  %_rtP__Constant_Value_k_el18 = load double, ptr %14, align 1
  %15 = getelementptr inbounds i8, ptr %1, i64 264
  store double %_rtP__Constant_Value_k_el18, ptr %15, align 1
  %16 = getelementptr inbounds i8, ptr %0, i64 528
  %_rtP__Constant_Value_c_el21 = load double, ptr %16, align 1
  %17 = getelementptr inbounds i8, ptr %1, i64 296
  store double %_rtP__Constant_Value_c_el21, ptr %17, align 1
  %18 = getelementptr inbounds i8, ptr %0, i64 536
  %_rtP__w_des_Value = load double, ptr %18, align 1
  %19 = getelementptr inbounds i8, ptr %1, i64 304
  store double %_rtP__w_des_Value, ptr %19, align 1
  ret void
}

define void @Outputs0(ptr %S) {
Outputs0_entry:
  %S_ = alloca ptr, align 8
  store ptr %S, ptr %S_, align 1
  %rtb_uDOFEulerAngles_o4_ = alloca [9 x double], align 8
  %rtb_Gain1_ = alloca double, align 8
  %rtb_Integrator_ = alloca double, align 8
  %rtb_uDOFEulerAngles_o3_idx_1_ = alloca double, align 8
  %pData_idx_5_ = alloca double, align 8
  %pData_idx_8_ = alloca double, align 8
  %pData_idx_0_ = alloca double, align 8
  %pData_idx_6_ = alloca double, align 8
  %pData_idx_2_ = alloca double, align 8
  %pData_idx_8_0_ = alloca double, align 8
  %pData_idx_0_0_ = alloca double, align 8
  %pData_idx_6_0_ = alloca double, align 8
  %pData_idx_1_ = alloca double, align 8
  %pData_idx_4_ = alloca double, align 8
  %pData_idx_5_0_ = alloca double, align 8
  %isHit_ = alloca i32, align 4
  %_rtB_ = alloca ptr, align 8
  %_rtP_ = alloca ptr, align 8
  %_rtX_ = alloca ptr, align 8
  %vm_ssIsSampleHitVar0_ = alloca i32, align 4
  %0 = call i32 @vm_ssIsSampleHit(ptr %S, i32 1, i32 0)
  store i32 %0, ptr %vm_ssIsSampleHitVar0_, align 1
  %1 = call ptr @vm_ssGetRootDWork(ptr %S)
  %2 = call ptr @vm_ssGetX(ptr %S)
  store ptr %2, ptr %_rtX_, align 1
  %3 = call ptr @vm_ssGetModelRtp(ptr %S)
  store ptr %3, ptr %_rtP_, align 1
  %4 = call ptr @vm__ssGetModelBlockIO(ptr %S)
  store ptr %4, ptr %_rtB_, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el = load double, ptr %2, align 1
  %5 = getelementptr inbounds i8, ptr %4, i64 24
  store double %_rtX__uDOFEulerAngles_CSTATE_el, ptr %5, align 1
  %6 = getelementptr inbounds i8, ptr %2, i64 8
  %_rtX__uDOFEulerAngles_CSTATE_el50 = load double, ptr %6, align 1
  %7 = getelementptr inbounds i8, ptr %4, i64 32
  store double %_rtX__uDOFEulerAngles_CSTATE_el50, ptr %7, align 1
  %8 = getelementptr inbounds i8, ptr %2, i64 16
  %_rtX__uDOFEulerAngles_CSTATE_el53 = load double, ptr %8, align 1
  %9 = getelementptr inbounds i8, ptr %4, i64 40
  store double %_rtX__uDOFEulerAngles_CSTATE_el53, ptr %9, align 1
  %10 = getelementptr inbounds i8, ptr %2, i64 24
  %_rtX__uDOFEulerAngles_CSTATE_el56 = load double, ptr %10, align 1
  store double %_rtX__uDOFEulerAngles_CSTATE_el56, ptr %4, align 1
  %11 = getelementptr inbounds i8, ptr %2, i64 32
  %_rtX__uDOFEulerAngles_CSTATE_el59 = load double, ptr %11, align 1
  %12 = getelementptr inbounds i8, ptr %4, i64 8
  store double %_rtX__uDOFEulerAngles_CSTATE_el59, ptr %12, align 1
  %13 = getelementptr inbounds i8, ptr %2, i64 40
  %_rtX__uDOFEulerAngles_CSTATE_el62 = load double, ptr %13, align 1
  %14 = getelementptr inbounds i8, ptr %4, i64 16
  store double %_rtX__uDOFEulerAngles_CSTATE_el62, ptr %14, align 1
  %15 = getelementptr inbounds i8, ptr %2, i64 48
  %_rtX__uDOFEulerAngles_CSTATE_el65 = load double, ptr %15, align 1
  %16 = getelementptr inbounds i8, ptr %4, i64 48
  store double %_rtX__uDOFEulerAngles_CSTATE_el65, ptr %16, align 1
  %17 = getelementptr inbounds i8, ptr %2, i64 56
  %_rtX__uDOFEulerAngles_CSTATE_el68 = load double, ptr %17, align 1
  %18 = getelementptr inbounds i8, ptr %4, i64 56
  store double %_rtX__uDOFEulerAngles_CSTATE_el68, ptr %18, align 1
  %19 = getelementptr inbounds i8, ptr %2, i64 64
  %_rtX__uDOFEulerAngles_CSTATE_el71 = load double, ptr %19, align 1
  %20 = getelementptr inbounds i8, ptr %4, i64 64
  store double %_rtX__uDOFEulerAngles_CSTATE_el71, ptr %20, align 1
  %21 = getelementptr inbounds i8, ptr %2, i64 80
  %_rtX__uDOFEulerAngles_CSTATE_el74 = load double, ptr %21, align 1
  store double %_rtX__uDOFEulerAngles_CSTATE_el74, ptr %rtb_uDOFEulerAngles_o3_idx_1_, align 1
  %22 = getelementptr inbounds i8, ptr %2, i64 72
  %_rtX__uDOFEulerAngles_CSTATE_el76 = load double, ptr %22, align 1
  %23 = call double @muDoubleScalarCos(double %_rtX__uDOFEulerAngles_CSTATE_el76)
  store double %23, ptr %rtb_Gain1_, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el78 = load double, ptr %22, align 1
  %24 = call double @muDoubleScalarSin(double %_rtX__uDOFEulerAngles_CSTATE_el78)
  store double %24, ptr %rtb_Integrator_, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el80 = load double, ptr %22, align 1
  %25 = call double @muDoubleScalarSin(double %_rtX__uDOFEulerAngles_CSTATE_el80)
  %tmp0 = fneg double %25
  store double %tmp0, ptr %pData_idx_5_, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el82 = load double, ptr %22, align 1
  %26 = call double @muDoubleScalarCos(double %_rtX__uDOFEulerAngles_CSTATE_el82)
  store double %26, ptr %pData_idx_8_, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el84 = load double, ptr %21, align 1
  %27 = call double @muDoubleScalarCos(double %_rtX__uDOFEulerAngles_CSTATE_el84)
  store double %27, ptr %pData_idx_0_, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el86 = load double, ptr %21, align 1
  %28 = call double @muDoubleScalarSin(double %_rtX__uDOFEulerAngles_CSTATE_el86)
  %tmp1 = fneg double %28
  store double %tmp1, ptr %pData_idx_6_, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el88 = load double, ptr %21, align 1
  %29 = call double @muDoubleScalarSin(double %_rtX__uDOFEulerAngles_CSTATE_el88)
  store double %29, ptr %pData_idx_2_, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el90 = load double, ptr %21, align 1
  %30 = call double @muDoubleScalarCos(double %_rtX__uDOFEulerAngles_CSTATE_el90)
  store double %30, ptr %pData_idx_8_0_, align 1
  %tmp2 = fmul double %29, 0.000000e+00
  %tmp3 = fadd double %tmp2, %27
  store double %tmp3, ptr %pData_idx_0_0_, align 1
  %tmp4 = fmul double %30, 0.000000e+00
  %tmp5 = fadd double %tmp4, %tmp1
  store double %tmp5, ptr %pData_idx_6_0_, align 1
  %tmp6 = fmul double %27, 0.000000e+00
  %tmp7 = fmul double %23, 0.000000e+00
  %tmp8 = fadd double %tmp6, %tmp7
  %tmp9 = fmul double %24, %29
  %tmp10 = fadd double %tmp8, %tmp9
  store double %tmp10, ptr %pData_idx_1_, align 1
  %tmp11 = fmul double %24, 0.000000e+00
  %tmp12 = fadd double %tmp11, %23
  store double %tmp12, ptr %pData_idx_4_, align 1
  %tmp13 = fmul double %tmp1, 0.000000e+00
  %tmp15 = fadd double %tmp7, %tmp13
  %tmp16 = fmul double %24, %30
  %tmp17 = fadd double %tmp15, %tmp16
  store double %tmp17, ptr %rtb_Integrator_, align 1
  %tmp19 = fmul double %tmp0, 0.000000e+00
  %tmp20 = fadd double %tmp6, %tmp19
  %tmp21 = fmul double %29, %26
  %tmp22 = fadd double %tmp20, %tmp21
  store double %tmp22, ptr %pData_idx_2_, align 1
  %tmp23 = fmul double %26, 0.000000e+00
  %tmp24 = fadd double %tmp23, %tmp0
  store double %tmp24, ptr %pData_idx_5_0_, align 1
  %tmp27 = fadd double %tmp19, %tmp13
  %tmp28 = fmul double %26, %30
  %tmp29 = fadd double %tmp27, %tmp28
  store double %tmp29, ptr %pData_idx_8_, align 1
  %_rtX_115 = load ptr, ptr %_rtX_, align 1
  %31 = getelementptr inbounds i8, ptr %_rtX_115, i64 88
  %_rtX__uDOFEulerAngles_CSTATE_el116 = load double, ptr %31, align 1
  %32 = call double @muDoubleScalarCos(double %_rtX__uDOFEulerAngles_CSTATE_el116)
  store double %32, ptr %pData_idx_0_, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el118 = load double, ptr %31, align 1
  %33 = call double @muDoubleScalarSin(double %_rtX__uDOFEulerAngles_CSTATE_el118)
  store double %33, ptr %pData_idx_5_, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el120 = load double, ptr %31, align 1
  %34 = call double @muDoubleScalarSin(double %_rtX__uDOFEulerAngles_CSTATE_el120)
  %tmp30 = fneg double %34
  store double %tmp30, ptr %pData_idx_6_, align 1
  %_rtX__uDOFEulerAngles_CSTATE_el122 = load double, ptr %31, align 1
  %35 = call double @muDoubleScalarCos(double %_rtX__uDOFEulerAngles_CSTATE_el122)
  store double %35, ptr %rtb_Gain1_, align 1
  %tmp31 = fmul double %tmp3, %32
  %tmp32 = fmul double %tmp30, 0.000000e+00
  %tmp33 = fadd double %tmp31, %tmp32
  %tmp34 = fmul double %tmp5, 0.000000e+00
  %tmp35 = fadd double %tmp33, %tmp34
  store double %tmp35, ptr %rtb_uDOFEulerAngles_o4_, align 1
  %tmp36 = fmul double %32, %tmp10
  %tmp37 = fmul double %tmp30, %tmp12
  %tmp38 = fadd double %tmp36, %tmp37
  %tmp39 = fmul double %tmp17, 0.000000e+00
  %tmp40 = fadd double %tmp38, %tmp39
  %36 = getelementptr inbounds i8, ptr %rtb_uDOFEulerAngles_o4_, i64 8
  store double %tmp40, ptr %36, align 1
  %tmp41 = fmul double %32, %tmp22
  %tmp42 = fmul double %tmp30, %tmp24
  %tmp43 = fadd double %tmp41, %tmp42
  %tmp44 = fmul double %tmp29, 0.000000e+00
  %tmp45 = fadd double %tmp43, %tmp44
  %37 = getelementptr inbounds i8, ptr %rtb_uDOFEulerAngles_o4_, i64 16
  store double %tmp45, ptr %37, align 1
  %tmp46 = fmul double %tmp3, %33
  %tmp47 = fmul double %35, 0.000000e+00
  %tmp48 = fadd double %tmp46, %tmp47
  %tmp50 = fadd double %tmp48, %tmp34
  %38 = getelementptr inbounds i8, ptr %rtb_uDOFEulerAngles_o4_, i64 24
  store double %tmp50, ptr %38, align 1
  %tmp51 = fmul double %33, %tmp10
  %tmp52 = fmul double %tmp12, %35
  %tmp53 = fadd double %tmp51, %tmp52
  %tmp55 = fadd double %tmp53, %tmp39
  %39 = getelementptr inbounds i8, ptr %rtb_uDOFEulerAngles_o4_, i64 32
  store double %tmp55, ptr %39, align 1
  %tmp56 = fmul double %33, %tmp22
  %tmp57 = fmul double %35, %tmp24
  %tmp58 = fadd double %tmp56, %tmp57
  %tmp60 = fadd double %tmp58, %tmp44
  %40 = getelementptr inbounds i8, ptr %rtb_uDOFEulerAngles_o4_, i64 40
  store double %tmp60, ptr %40, align 1
  %tmp61 = fmul double %tmp3, 0.000000e+00
  %tmp62 = fadd double %tmp61, %tmp5
  %41 = getelementptr inbounds i8, ptr %rtb_uDOFEulerAngles_o4_, i64 48
  store double %tmp62, ptr %41, align 1
  %tmp63 = fmul double %tmp10, 0.000000e+00
  %tmp64 = fmul double %tmp12, 0.000000e+00
  %tmp65 = fadd double %tmp63, %tmp64
  %tmp66 = fadd double %tmp17, %tmp65
  %42 = getelementptr inbounds i8, ptr %rtb_uDOFEulerAngles_o4_, i64 56
  store double %tmp66, ptr %42, align 1
  %tmp67 = fmul double %tmp22, 0.000000e+00
  %tmp68 = fmul double %tmp24, 0.000000e+00
  %tmp69 = fadd double %tmp67, %tmp68
  %tmp70 = fadd double %tmp29, %tmp69
  %43 = getelementptr inbounds i8, ptr %rtb_uDOFEulerAngles_o4_, i64 64
  store double %tmp70, ptr %43, align 1
  %_rtP_159 = load ptr, ptr %_rtP_, align 1
  %44 = getelementptr inbounds i8, ptr %_rtP_159, i64 352
  %_rtP__Gain_Gain = load double, ptr %44, align 1
  %_rtB_160 = load ptr, ptr %_rtB_, align 1
  %45 = getelementptr inbounds i8, ptr %_rtB_160, i64 16
  %_rtB__uDOFEulerAngles_o2_el = load double, ptr %45, align 1
  %tmp71 = fmul double %_rtP__Gain_Gain, %_rtB__uDOFEulerAngles_o2_el
  %46 = getelementptr inbounds i8, ptr %_rtB_160, i64 72
  store double %tmp71, ptr %46, align 1
  %vm_ssIsSampleHitVar0_162 = load i32, ptr %vm_ssIsSampleHitVar0_, align 1
  store i32 %vm_ssIsSampleHitVar0_162, ptr %isHit_, align 1
  %.not = icmp eq i32 %vm_ssIsSampleHitVar0_162, 0
  br i1 %.not, label %false, label %true

true:                                             ; preds = %Outputs0_entry
  %_rtB__uDOFEulerAngles_o2_el165 = load double, ptr %_rtB_160, align 1
  %47 = getelementptr inbounds i8, ptr %_rtB_160, i64 80
  store double %_rtB__uDOFEulerAngles_o2_el165, ptr %47, align 1
  %48 = getelementptr inbounds i8, ptr %_rtB_160, i64 8
  %_rtB__uDOFEulerAngles_o2_el168 = load double, ptr %48, align 1
  %49 = getelementptr inbounds i8, ptr %_rtB_160, i64 88
  store double %_rtB__uDOFEulerAngles_o2_el168, ptr %49, align 1
  %50 = getelementptr inbounds i8, ptr %_rtB_160, i64 96
  store double %tmp71, ptr %50, align 1
  br label %false

false:                                            ; preds = %true, %Outputs0_entry
  %51 = getelementptr inbounds i8, ptr %_rtP_159, i64 360
  %_rtP__Gain_Gain_p = load double, ptr %51, align 1
  %52 = getelementptr inbounds i8, ptr %_rtB_160, i64 64
  %_rtB__uDOFEulerAngles_o6_el = load double, ptr %52, align 1
  %tmp72 = fmul double %_rtP__Gain_Gain_p, %_rtB__uDOFEulerAngles_o6_el
  %53 = getelementptr inbounds i8, ptr %_rtB_160, i64 104
  store double %tmp72, ptr %53, align 1
  store i32 %vm_ssIsSampleHitVar0_162, ptr %isHit_, align 1
  %S_191.pre = load ptr, ptr %S_, align 1
  br i1 %.not, label %false2, label %true1

true1:                                            ; preds = %false
  %54 = getelementptr inbounds i8, ptr %_rtB_160, i64 48
  %_rtB__uDOFEulerAngles_o6_el178 = load double, ptr %54, align 1
  %55 = getelementptr inbounds i8, ptr %_rtB_160, i64 112
  store double %_rtB__uDOFEulerAngles_o6_el178, ptr %55, align 1
  %56 = getelementptr inbounds i8, ptr %_rtB_160, i64 56
  %_rtB__uDOFEulerAngles_o6_el181 = load double, ptr %56, align 1
  %57 = getelementptr inbounds i8, ptr %_rtB_160, i64 120
  store double %_rtB__uDOFEulerAngles_o6_el181, ptr %57, align 1
  %58 = getelementptr inbounds i8, ptr %_rtB_160, i64 128
  store double %tmp72, ptr %58, align 1
  call void @vm_ssCallAccelRunBlock(ptr %S_191.pre, i32 2, i32 0, i32 104)
  %59 = call i8 @vm_getHasError(ptr %S_191.pre)
  %60 = trunc i8 %59 to i1
  br i1 %60, label %true3, label %false4

false2:                                           ; preds = %false5, %false
  call void @vm_ssCallAccelRunBlock(ptr %S_191.pre, i32 3, i32 8, i32 104)
  %61 = call i8 @vm_getHasError(ptr %S_191.pre)
  %62 = trunc i8 %61 to i1
  br i1 %62, label %true3, label %false6

true3:                                            ; preds = %false39, %false38, %true37, %false36, %true35, %true19, %false2, %false5, %false4, %true1
  ret void

false4:                                           ; preds = %true1
  call void @vm_ssCallAccelRunBlock(ptr %S_191.pre, i32 3, i32 6, i32 104)
  %63 = call i8 @vm_getHasError(ptr %S_191.pre)
  %64 = trunc i8 %63 to i1
  br i1 %64, label %true3, label %false5

false5:                                           ; preds = %false4
  call void @vm_ssCallAccelRunBlock(ptr %S_191.pre, i32 3, i32 7, i32 104)
  %65 = call i8 @vm_getHasError(ptr %S_191.pre)
  %66 = trunc i8 %65 to i1
  br i1 %66, label %true3, label %false2

false6:                                           ; preds = %false2
  %67 = getelementptr inbounds i8, ptr %_rtB_160, i64 136
  %_rtB__FromWorkspace = load double, ptr %67, align 1
  %_rtB__uDOFEulerAngles_o2_el195 = load double, ptr %45, align 1
  %tmp73 = fsub double %_rtB__FromWorkspace, %_rtB__uDOFEulerAngles_o2_el195
  %68 = getelementptr inbounds i8, ptr %_rtB_160, i64 144
  store double %tmp73, ptr %68, align 1
  %69 = getelementptr inbounds i8, ptr %_rtP_159, i64 368
  %_rtP__Gain1_Gain = load double, ptr %69, align 1
  %tmp74 = fmul double %_rtP__Gain1_Gain, %tmp73
  store double %tmp74, ptr %rtb_Gain1_, align 1
  %70 = call i8 @vm_ssIsModeUpdateTimeStep(ptr %S_191.pre)
  %71 = trunc i8 %70 to i1
  br i1 %71, label %true7, label %false8

true7:                                            ; preds = %false6
  %72 = getelementptr inbounds i8, ptr %_rtX_115, i64 96
  %_rtX__Integrator_CSTATE212 = load double, ptr %72, align 1
  %73 = getelementptr inbounds i8, ptr %_rtP_159, i64 384
  %_rtP__Integrator_UpperSat214 = load double, ptr %73, align 1
  %74 = fcmp ult double %_rtX__Integrator_CSTATE212, %_rtP__Integrator_UpperSat214
  br i1 %74, label %false14, label %true13

false8:                                           ; preds = %false6
  %75 = getelementptr inbounds i8, ptr %_rtX_115, i64 96
  %_rtX__Integrator_CSTATE = load double, ptr %75, align 1
  %76 = getelementptr inbounds i8, ptr %_rtP_159, i64 384
  %_rtP__Integrator_UpperSat = load double, ptr %76, align 1
  %77 = fcmp ult double %_rtX__Integrator_CSTATE, %_rtP__Integrator_UpperSat
  br i1 %77, label %false10, label %true9

true9:                                            ; preds = %false8
  store double %_rtP__Integrator_UpperSat, ptr %rtb_Integrator_, align 1
  br label %merge

false10:                                          ; preds = %false8
  %78 = getelementptr inbounds i8, ptr %_rtP_159, i64 392
  %_rtP__Integrator_LowerSat = load double, ptr %78, align 1
  %79 = fcmp ugt double %_rtX__Integrator_CSTATE, %_rtP__Integrator_LowerSat
  br i1 %79, label %false12, label %true11

true11:                                           ; preds = %false10
  store double %_rtP__Integrator_LowerSat, ptr %rtb_Integrator_, align 1
  br label %merge

false12:                                          ; preds = %false10
  store double %_rtX__Integrator_CSTATE, ptr %rtb_Integrator_, align 1
  br label %merge

true13:                                           ; preds = %true7
  %80 = fcmp une double %_rtX__Integrator_CSTATE212, %_rtP__Integrator_UpperSat214
  br i1 %80, label %true18, label %false16

false14:                                          ; preds = %true7
  %81 = getelementptr inbounds i8, ptr %_rtP_159, i64 392
  %_rtP__Integrator_LowerSat218 = load double, ptr %81, align 1
  %82 = fcmp ole double %_rtX__Integrator_CSTATE212, %_rtP__Integrator_LowerSat218
  %83 = fcmp une double %_rtX__Integrator_CSTATE212, %_rtP__Integrator_LowerSat218
  %or.cond = and i1 %82, %83
  br i1 %or.cond, label %true17, label %false16

false16:                                          ; preds = %true18, %true13, %true17, %false14
  %_rtX__Integrator_CSTATE236 = load double, ptr %72, align 1
  store double %_rtX__Integrator_CSTATE236, ptr %rtb_Integrator_, align 1
  br label %merge

true17:                                           ; preds = %false14
  store double %_rtP__Integrator_LowerSat218, ptr %72, align 1
  call void @vm_ssSetBlockStateForSolverChangedAtMajorStep(ptr %S_191.pre)
  br label %false16

true18:                                           ; preds = %true13
  store double %_rtP__Integrator_UpperSat214, ptr %72, align 1
  call void @vm_ssSetBlockStateForSolverChangedAtMajorStep(ptr %S_191.pre)
  br label %false16

true19:                                           ; preds = %merge
  %84 = getelementptr inbounds i8, ptr %_rtB_160, i64 312
  store double 0.000000e+00, ptr %84, align 1
  %85 = getelementptr inbounds i8, ptr %_rtB_160, i64 320
  store double 0.000000e+00, ptr %85, align 1
  %86 = getelementptr inbounds i8, ptr %_rtB_160, i64 328
  store double %tmp79, ptr %86, align 1
  call void @vm_ssCallAccelRunBlock(ptr %S_191.pre, i32 3, i32 17, i32 104)
  %87 = call i8 @vm_getHasError(ptr %S_191.pre)
  %88 = trunc i8 %87 to i1
  br i1 %88, label %true3, label %false20

false20:                                          ; preds = %true19, %merge
  store double 0.000000e+00, ptr %rtb_Gain1_, align 1
  store double 0.000000e+00, ptr %rtb_Integrator_, align 1
  store double 0.000000e+00, ptr %pData_idx_8_, align 1
  br label %merge40

true21:                                           ; preds = %merge40
  %89 = getelementptr inbounds i8, ptr %_rtB_160, i64 248
  %90 = sext i32 %isHit_353 to i64
  %91 = getelementptr inbounds [3 x double], ptr %89, i64 0, i64 %90
  %_rtB__Constant_c_el = load double, ptr %91, align 1
  store double %_rtB__Constant_c_el, ptr %pData_idx_0_, align 1
  %tmp91 = mul i32 %isHit_353, 3
  %92 = sext i32 %tmp91 to i64
  %93 = getelementptr inbounds [9 x double], ptr %rtb_uDOFEulerAngles_o4_, i64 0, i64 %92
  %rtb_uDOFEulerAngles_o4__el = load double, ptr %93, align 1
  %tmp92 = fmul double %_rtB__Constant_c_el, %rtb_uDOFEulerAngles_o4__el
  %tmp93 = fadd double %tmp92, %rtb_Gain1_335
  store double %tmp93, ptr %rtb_Gain1_, align 1
  %tmp95 = add i32 %tmp91, 1
  %94 = sext i32 %tmp95 to i64
  %95 = getelementptr inbounds [9 x double], ptr %rtb_uDOFEulerAngles_o4_, i64 0, i64 %94
  %rtb_uDOFEulerAngles_o4__el337 = load double, ptr %95, align 1
  %tmp96 = fmul double %rtb_uDOFEulerAngles_o4__el337, %_rtB__Constant_c_el
  %tmp97 = fadd double %tmp96, %rtb_Integrator_339
  store double %tmp97, ptr %rtb_Integrator_, align 1
  %tmp99 = add i32 %tmp91, 2
  %96 = sext i32 %tmp99 to i64
  %97 = getelementptr inbounds [9 x double], ptr %rtb_uDOFEulerAngles_o4_, i64 0, i64 %96
  %rtb_uDOFEulerAngles_o4__el341 = load double, ptr %97, align 1
  %tmp100 = fmul double %rtb_uDOFEulerAngles_o4__el341, %_rtB__Constant_c_el
  %tmp101 = fadd double %tmp100, %pData_idx_8_343
  store double %tmp101, ptr %pData_idx_8_, align 1
  %98 = getelementptr inbounds i8, ptr %_rtB_160, i64 24
  %99 = getelementptr inbounds [3 x double], ptr %98, i64 0, i64 %90
  %_rtB__uDOFEulerAngles_o5_el346 = load double, ptr %99, align 1
  store double %_rtB__uDOFEulerAngles_o5_el346, ptr %pData_idx_0_, align 1
  %100 = getelementptr inbounds i8, ptr %_rtP_159, i64 416
  %_rtP__Gain_Gain_j = load double, ptr %100, align 1
  %tmp102 = fmul double %_rtB__uDOFEulerAngles_o5_el346, %_rtP__Gain_Gain_j
  %101 = getelementptr inbounds i8, ptr %_rtB_160, i64 280
  %102 = getelementptr inbounds [3 x double], ptr %101, i64 0, i64 %90
  %_rtB__Constant_cj_el = load double, ptr %102, align 1
  %tmp103 = fmul double %tmp102, %_rtB__Constant_cj_el
  %tmp104 = fmul double %tmp103, %_rtB__uDOFEulerAngles_o5_el346
  %103 = getelementptr inbounds i8, ptr %_rtB_160, i64 160
  %104 = getelementptr inbounds [3 x double], ptr %103, i64 0, i64 %90
  store double %tmp104, ptr %104, align 1
  %tmp105 = add i32 %isHit_353, 1
  br label %merge40

false22:                                          ; preds = %merge40
  %105 = getelementptr inbounds i8, ptr %_rtB_160, i64 160
  %_rtB__MatrixMultiply1_el = load double, ptr %105, align 1
  %tmp80 = fadd double %rtb_Gain1_335, %_rtB__MatrixMultiply1_el
  %106 = getelementptr inbounds i8, ptr %_rtB_160, i64 184
  store double %tmp80, ptr %106, align 1
  %107 = getelementptr inbounds i8, ptr %_rtB_160, i64 168
  %_rtB__MatrixMultiply1_el258 = load double, ptr %107, align 1
  %tmp81 = fadd double %rtb_Integrator_339, %_rtB__MatrixMultiply1_el258
  %108 = getelementptr inbounds i8, ptr %_rtB_160, i64 192
  store double %tmp81, ptr %108, align 1
  %_rtB__Zc261 = load double, ptr %146, align 1
  %tmp82 = fadd double %_rtB__Zc261, %pData_idx_8_343
  %109 = getelementptr inbounds i8, ptr %_rtB_160, i64 176
  %_rtB__MatrixMultiply1_el264 = load double, ptr %109, align 1
  %tmp83 = fadd double %tmp82, %_rtB__MatrixMultiply1_el264
  %110 = getelementptr inbounds i8, ptr %_rtB_160, i64 200
  store double %tmp83, ptr %110, align 1
  %111 = getelementptr inbounds i8, ptr %_rtB_160, i64 240
  %_rtB__Constant = load double, ptr %111, align 1
  %rtb_uDOFEulerAngles_o3_idx_1_267 = load double, ptr %rtb_uDOFEulerAngles_o3_idx_1_, align 1
  %tmp84 = fsub double %_rtB__Constant, %rtb_uDOFEulerAngles_o3_idx_1_267
  %112 = getelementptr inbounds i8, ptr %_rtB_160, i64 208
  store double %tmp84, ptr %112, align 1
  %113 = getelementptr inbounds i8, ptr %_rtP_159, i64 424
  %_rtP__Gain_Gain_f = load double, ptr %113, align 1
  %tmp85 = fmul double %tmp84, %_rtP__Gain_Gain_f
  store double %tmp85, ptr %rtb_Gain1_, align 1
  %114 = call i8 @vm_ssIsModeUpdateTimeStep(ptr %S_191.pre)
  %115 = trunc i8 %114 to i1
  br i1 %115, label %true23, label %false24

true23:                                           ; preds = %false22
  %116 = getelementptr inbounds i8, ptr %_rtX_115, i64 104
  %_rtX__Integrator_CSTATE_p284 = load double, ptr %116, align 1
  %117 = getelementptr inbounds i8, ptr %_rtP_159, i64 440
  %_rtP__Integrator_UpperSat_n286 = load double, ptr %117, align 1
  %118 = fcmp ult double %_rtX__Integrator_CSTATE_p284, %_rtP__Integrator_UpperSat_n286
  br i1 %118, label %false30, label %true29

false24:                                          ; preds = %false22
  %119 = getelementptr inbounds i8, ptr %_rtX_115, i64 104
  %_rtX__Integrator_CSTATE_p = load double, ptr %119, align 1
  %120 = getelementptr inbounds i8, ptr %_rtP_159, i64 440
  %_rtP__Integrator_UpperSat_n = load double, ptr %120, align 1
  %121 = fcmp ult double %_rtX__Integrator_CSTATE_p, %_rtP__Integrator_UpperSat_n
  br i1 %121, label %false26, label %true25

true25:                                           ; preds = %false24
  store double %_rtP__Integrator_UpperSat_n, ptr %rtb_Integrator_, align 1
  br label %merge41

false26:                                          ; preds = %false24
  %122 = getelementptr inbounds i8, ptr %_rtP_159, i64 448
  %_rtP__Integrator_LowerSat_g = load double, ptr %122, align 1
  %123 = fcmp ugt double %_rtX__Integrator_CSTATE_p, %_rtP__Integrator_LowerSat_g
  br i1 %123, label %false28, label %true27

true27:                                           ; preds = %false26
  store double %_rtP__Integrator_LowerSat_g, ptr %rtb_Integrator_, align 1
  br label %merge41

false28:                                          ; preds = %false26
  store double %_rtX__Integrator_CSTATE_p, ptr %rtb_Integrator_, align 1
  br label %merge41

true29:                                           ; preds = %true23
  %124 = fcmp une double %_rtX__Integrator_CSTATE_p284, %_rtP__Integrator_UpperSat_n286
  br i1 %124, label %true34, label %false32

false30:                                          ; preds = %true23
  %125 = getelementptr inbounds i8, ptr %_rtP_159, i64 448
  %_rtP__Integrator_LowerSat_g290 = load double, ptr %125, align 1
  %126 = fcmp ole double %_rtX__Integrator_CSTATE_p284, %_rtP__Integrator_LowerSat_g290
  %127 = fcmp une double %_rtX__Integrator_CSTATE_p284, %_rtP__Integrator_LowerSat_g290
  %or.cond366 = and i1 %126, %127
  br i1 %or.cond366, label %true33, label %false32

false32:                                          ; preds = %true34, %true29, %true33, %false30
  %_rtX__Integrator_CSTATE_p308 = load double, ptr %116, align 1
  store double %_rtX__Integrator_CSTATE_p308, ptr %rtb_Integrator_, align 1
  br label %merge41

true33:                                           ; preds = %false30
  store double %_rtP__Integrator_LowerSat_g290, ptr %116, align 1
  call void @vm_ssSetBlockStateForSolverChangedAtMajorStep(ptr %S_191.pre)
  br label %false32

true34:                                           ; preds = %true29
  store double %_rtP__Integrator_UpperSat_n286, ptr %116, align 1
  call void @vm_ssSetBlockStateForSolverChangedAtMajorStep(ptr %S_191.pre)
  br label %false32

true35:                                           ; preds = %merge41
  call void @vm_ssCallAccelRunBlock(ptr %S_191.pre, i32 3, i32 30, i32 104)
  %128 = call i8 @vm_getHasError(ptr %S_191.pre)
  %129 = trunc i8 %128 to i1
  br i1 %129, label %true3, label %false36

false36:                                          ; preds = %true35, %merge41
  %130 = getelementptr inbounds i8, ptr %_rtB_160, i64 216
  store double 0.000000e+00, ptr %130, align 1
  %131 = getelementptr inbounds i8, ptr %_rtP_159, i64 456
  %_rtP__Gain1_Gain_h = load double, ptr %131, align 1
  %tmp86 = fmul double %_rtP__Gain1_Gain_h, %rtb_Integrator_315
  %tmp87 = fadd double %tmp86, %tmp85
  %132 = getelementptr inbounds i8, ptr %_rtB_160, i64 272
  %_rtB__q_des = load double, ptr %132, align 1
  %133 = getelementptr inbounds i8, ptr %_rtB_160, i64 56
  %_rtB__uDOFEulerAngles_o6_el319 = load double, ptr %133, align 1
  %tmp88 = fsub double %_rtB__q_des, %_rtB__uDOFEulerAngles_o6_el319
  %134 = getelementptr inbounds i8, ptr %_rtP_159, i64 464
  %_rtP__Gain2_Gain_p = load double, ptr %134, align 1
  %tmp89 = fmul double %tmp88, %_rtP__Gain2_Gain_p
  %tmp90 = fadd double %tmp87, %tmp89
  %135 = getelementptr inbounds i8, ptr %_rtB_160, i64 224
  store double %tmp90, ptr %135, align 1
  %136 = getelementptr inbounds i8, ptr %_rtB_160, i64 232
  store double 0.000000e+00, ptr %136, align 1
  store i32 %vm_ssIsSampleHitVar0_162, ptr %isHit_, align 1
  br i1 %.not, label %true3, label %true37

true37:                                           ; preds = %false36
  call void @vm_ssCallAccelRunBlock(ptr %S_191.pre, i32 0, i32 0, i32 104)
  %137 = call i8 @vm_getHasError(ptr %S_191.pre)
  %138 = trunc i8 %137 to i1
  br i1 %138, label %true3, label %false38

false38:                                          ; preds = %true37
  call void @vm_ssCallAccelRunBlock(ptr %S_191.pre, i32 1, i32 0, i32 104)
  %139 = call i8 @vm_getHasError(ptr %S_191.pre)
  %140 = trunc i8 %139 to i1
  br i1 %140, label %true3, label %false39

false39:                                          ; preds = %false38
  call void @vm_ssCallAccelRunBlock(ptr %S_191.pre, i32 3, i32 34, i32 104)
  %141 = call i8 @vm_getHasError(ptr %S_191.pre)
  br label %true3

merge:                                            ; preds = %false16, %true9, %true11, %false12
  %rtb_Integrator_238 = phi double [ %_rtX__Integrator_CSTATE236, %false16 ], [ %_rtP__Integrator_UpperSat, %true9 ], [ %_rtP__Integrator_LowerSat, %true11 ], [ %_rtX__Integrator_CSTATE, %false12 ]
  %142 = getelementptr inbounds i8, ptr %_rtP_159, i64 400
  %_rtP__Gain_Gain_b = load double, ptr %142, align 1
  %tmp75 = fmul double %_rtP__Gain_Gain_b, %rtb_Integrator_238
  %tmp76 = fadd double %tmp75, %tmp74
  %143 = getelementptr inbounds i8, ptr %_rtB_160, i64 304
  %_rtB__w_des = load double, ptr %143, align 1
  %144 = getelementptr inbounds i8, ptr %_rtB_160, i64 40
  %_rtB__uDOFEulerAngles_o5_el = load double, ptr %144, align 1
  %tmp77 = fsub double %_rtB__w_des, %_rtB__uDOFEulerAngles_o5_el
  %145 = getelementptr inbounds i8, ptr %_rtP_159, i64 408
  %_rtP__Gain2_Gain = load double, ptr %145, align 1
  %tmp78 = fmul double %tmp77, %_rtP__Gain2_Gain
  %tmp79 = fadd double %tmp76, %tmp78
  %146 = getelementptr inbounds i8, ptr %_rtB_160, i64 152
  store double %tmp79, ptr %146, align 1
  store i32 %vm_ssIsSampleHitVar0_162, ptr %isHit_, align 1
  br i1 %.not, label %false20, label %true19

merge40:                                          ; preds = %true21, %false20
  %pData_idx_8_343 = phi double [ 0.000000e+00, %false20 ], [ %tmp101, %true21 ]
  %rtb_Integrator_339 = phi double [ 0.000000e+00, %false20 ], [ %tmp97, %true21 ]
  %rtb_Gain1_335 = phi double [ 0.000000e+00, %false20 ], [ %tmp93, %true21 ]
  %isHit_353 = phi i32 [ 0, %false20 ], [ %tmp105, %true21 ]
  store i32 %isHit_353, ptr %isHit_, align 1
  %147 = icmp slt i32 %isHit_353, 3
  br i1 %147, label %true21, label %false22

merge41:                                          ; preds = %false32, %true25, %true27, %false28
  %rtb_Integrator_315 = phi double [ %_rtX__Integrator_CSTATE_p308, %false32 ], [ %_rtP__Integrator_UpperSat_n, %true25 ], [ %_rtP__Integrator_LowerSat_g, %true27 ], [ %_rtX__Integrator_CSTATE_p, %false28 ]
  store i32 %vm_ssIsSampleHitVar0_162, ptr %isHit_, align 1
  br i1 %.not, label %false36, label %true35
}

declare signext i32 @vm_ssIsSampleHit(ptr, i32 signext, i32 signext)

declare ptr @vm_ssGetRootDWork(ptr)

declare void @vm_ssCallAccelRunBlock(ptr, i32 signext, i32 signext, i32 signext)

declare zeroext i8 @vm_getHasError(ptr)

declare zeroext i8 @vm_ssIsModeUpdateTimeStep(ptr)

declare void @vm_ssSetBlockStateForSolverChangedAtMajorStep(ptr)

define void @SystemInitialize(ptr %S) {
SystemInitialize_entry:
  %S_ = alloca ptr, align 8
  store ptr %S, ptr %S_, align 1
  %_rtP_ = alloca ptr, align 8
  %_rtX_ = alloca ptr, align 8
  %0 = call ptr @vm_ssGetX(ptr %S)
  store ptr %0, ptr %_rtX_, align 1
  %1 = call ptr @vm_ssGetModelRtp(ptr %S)
  store ptr %1, ptr %_rtP_, align 1
  %2 = getelementptr inbounds i8, ptr %1, i64 200
  %_rtP__uDOFEulerAngles_Vm_0_el = load double, ptr %2, align 1
  store double %_rtP__uDOFEulerAngles_Vm_0_el, ptr %0, align 1
  %3 = getelementptr inbounds i8, ptr %1, i64 176
  %_rtP__uDOFEulerAngles_xme_0_el = load double, ptr %3, align 1
  %4 = getelementptr inbounds i8, ptr %0, i64 24
  store double %_rtP__uDOFEulerAngles_xme_0_el, ptr %4, align 1
  %5 = getelementptr inbounds i8, ptr %1, i64 248
  %_rtP__uDOFEulerAngles_pm_0_el = load double, ptr %5, align 1
  %6 = getelementptr inbounds i8, ptr %0, i64 48
  store double %_rtP__uDOFEulerAngles_pm_0_el, ptr %6, align 1
  %7 = getelementptr inbounds i8, ptr %1, i64 224
  %_rtP__uDOFEulerAngles_eul_0_el = load double, ptr %7, align 1
  %8 = getelementptr inbounds i8, ptr %0, i64 72
  store double %_rtP__uDOFEulerAngles_eul_0_el, ptr %8, align 1
  %9 = getelementptr inbounds i8, ptr %1, i64 208
  %_rtP__uDOFEulerAngles_Vm_0_el13 = load double, ptr %9, align 1
  %10 = getelementptr inbounds i8, ptr %0, i64 8
  store double %_rtP__uDOFEulerAngles_Vm_0_el13, ptr %10, align 1
  %11 = getelementptr inbounds i8, ptr %1, i64 184
  %_rtP__uDOFEulerAngles_xme_0_el16 = load double, ptr %11, align 1
  %12 = getelementptr inbounds i8, ptr %0, i64 32
  store double %_rtP__uDOFEulerAngles_xme_0_el16, ptr %12, align 1
  %13 = getelementptr inbounds i8, ptr %1, i64 256
  %_rtP__uDOFEulerAngles_pm_0_el19 = load double, ptr %13, align 1
  %14 = getelementptr inbounds i8, ptr %0, i64 56
  store double %_rtP__uDOFEulerAngles_pm_0_el19, ptr %14, align 1
  %15 = getelementptr inbounds i8, ptr %1, i64 232
  %_rtP__uDOFEulerAngles_eul_0_el22 = load double, ptr %15, align 1
  %16 = getelementptr inbounds i8, ptr %0, i64 80
  store double %_rtP__uDOFEulerAngles_eul_0_el22, ptr %16, align 1
  %17 = getelementptr inbounds i8, ptr %1, i64 216
  %_rtP__uDOFEulerAngles_Vm_0_el25 = load double, ptr %17, align 1
  %18 = getelementptr inbounds i8, ptr %0, i64 16
  store double %_rtP__uDOFEulerAngles_Vm_0_el25, ptr %18, align 1
  %19 = getelementptr inbounds i8, ptr %1, i64 192
  %_rtP__uDOFEulerAngles_xme_0_el28 = load double, ptr %19, align 1
  %20 = getelementptr inbounds i8, ptr %0, i64 40
  store double %_rtP__uDOFEulerAngles_xme_0_el28, ptr %20, align 1
  %21 = getelementptr inbounds i8, ptr %1, i64 264
  %_rtP__uDOFEulerAngles_pm_0_el31 = load double, ptr %21, align 1
  %22 = getelementptr inbounds i8, ptr %0, i64 64
  store double %_rtP__uDOFEulerAngles_pm_0_el31, ptr %22, align 1
  %23 = getelementptr inbounds i8, ptr %1, i64 240
  %_rtP__uDOFEulerAngles_eul_0_el34 = load double, ptr %23, align 1
  %24 = getelementptr inbounds i8, ptr %0, i64 88
  store double %_rtP__uDOFEulerAngles_eul_0_el34, ptr %24, align 1
  %25 = getelementptr inbounds i8, ptr %1, i64 376
  %_rtP__Integrator_IC = load double, ptr %25, align 1
  %26 = getelementptr inbounds i8, ptr %0, i64 96
  store double %_rtP__Integrator_IC, ptr %26, align 1
  %27 = getelementptr inbounds i8, ptr %1, i64 432
  %_rtP__Integrator_IC_n = load double, ptr %27, align 1
  %28 = getelementptr inbounds i8, ptr %0, i64 104
  store double %_rtP__Integrator_IC_n, ptr %28, align 1
  call void @vm_ssCallAccelRunBlock(ptr %S, i32 2, i32 0, i32 102)
  %29 = call i8 @vm_getHasError(ptr %S)
  %30 = trunc i8 %29 to i1
  br i1 %30, label %true, label %false

true:                                             ; preds = %false1, %false, %SystemInitialize_entry
  ret void

false:                                            ; preds = %SystemInitialize_entry
  call void @vm_ssCallAccelRunBlock(ptr %S, i32 0, i32 0, i32 102)
  %31 = call i8 @vm_getHasError(ptr %S)
  %32 = trunc i8 %31 to i1
  br i1 %32, label %true, label %false1

false1:                                           ; preds = %false
  call void @vm_ssCallAccelRunBlock(ptr %S, i32 1, i32 0, i32 102)
  %33 = call i8 @vm_getHasError(ptr %S)
  br label %true
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.trunc.f64(double) #0

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

