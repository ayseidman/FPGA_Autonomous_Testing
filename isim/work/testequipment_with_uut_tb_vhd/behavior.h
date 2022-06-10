////////////////////////////////////////////////////////////////////////////////
//   ____  ____   
//  /   /\/   /  
// /___/  \  /   
// \   \   \/  
//  \   \        Copyright (c) 2003-2004 Xilinx, Inc.
//  /   /        All Right Reserved. 
// /---/   /\     
// \   \  /  \  
//  \___\/\___\
////////////////////////////////////////////////////////////////////////////////

#ifndef H_Work_testequipment_with_uut_tb_vhd_behavior_H
#define H_Work_testequipment_with_uut_tb_vhd_behavior_H
#ifdef __MINGW32__
#include "xsimMinGW.h"
#else
#include "xsim.h"
#endif


class Work_testequipment_with_uut_tb_vhd_behavior: public HSim__s6 {
public:


HSim__s4 C8;
HSim__s4 Cb;
HSim__s4 Ce;
HSim__s4 Ch;
HSim__s4 Ck;
HSim__s4 Cp;
HSim__s4 Cs;
HSim__s4 Cv;
HSim__s4 Cy;
HSim__s4 CB;
HSim__s4 CE;
HSim__s4 CH;
HSim__s4 CK;
HSim__s4 CN;
HSim__s4 CR;
HSim__s4 CU;
HSim__s4 CX;
HSim__s4 C2T;
    HSim__s1 SA[23];
    Work_testequipment_with_uut_tb_vhd_behavior(const char * name);
    ~Work_testequipment_with_uut_tb_vhd_behavior();
    void constructObject();
    void constructPorts();
    void reset();
    void architectureInstantiate(HSimConfigDecl* cfg);
    virtual void vhdlArchImplement();
};



HSim__s6 *createWork_testequipment_with_uut_tb_vhd_behavior(const char *name);

#endif
