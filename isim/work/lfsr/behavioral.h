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

#ifndef H_Work_lfsr_behavioral_H
#define H_Work_lfsr_behavioral_H
#ifdef __MINGW32__
#include "xsimMinGW.h"
#else
#include "xsim.h"
#endif


class Work_lfsr_behavioral: public HSim__s6 {
public:

    HSim__s4 PE[1];
    HSim__s1 SE[6];

HSim__s4 C8;
HSim__s4 Cb;
  HSimArrayType Std_arraybase;
  HSimArrayType Std_array;
  char *t0;
HSim__s4 CM;
  char *t1;
HSim__s4 C1L;
    HSim__s1 SA[3];
HSimConstraints *c2;
    Work_lfsr_behavioral(const char * name);
    ~Work_lfsr_behavioral();
    void constructObject();
    void constructPorts();
    void reset();
    void architectureInstantiate(HSimConfigDecl* cfg);
    virtual void vhdlArchImplement();
};



HSim__s6 *createWork_lfsr_behavioral(const char *name);

#endif
