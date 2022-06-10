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

#ifndef H_Work_testvectorgenerator_tb_vhd_behavior_H
#define H_Work_testvectorgenerator_tb_vhd_behavior_H
#ifdef __MINGW32__
#include "xsimMinGW.h"
#else
#include "xsim.h"
#endif


class Work_testvectorgenerator_tb_vhd_behavior: public HSim__s6 {
public:


HSim__s4 C8;
HSim__s4 CS;
  char *t0;
    HSim__s1 SA[8];
    Work_testvectorgenerator_tb_vhd_behavior(const char * name);
    ~Work_testvectorgenerator_tb_vhd_behavior();
    void constructObject();
    void constructPorts();
    void reset();
    void architectureInstantiate(HSimConfigDecl* cfg);
    virtual void vhdlArchImplement();
};



HSim__s6 *createWork_testvectorgenerator_tb_vhd_behavior(const char *name);

#endif
