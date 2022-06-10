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

#ifndef H_Work_mux_74hc153n_behavioral_H
#define H_Work_mux_74hc153n_behavioral_H
#ifdef __MINGW32__
#include "xsimMinGW.h"
#else
#include "xsim.h"
#endif


class Work_mux_74hc153n_behavioral: public HSim__s6 {
public:

    HSim__s1 SE[8];

    HSim__s1 SA[1];
HSimConstraints *c0;
  char *t1;
  char t2;
    Work_mux_74hc153n_behavioral(const char * name);
    ~Work_mux_74hc153n_behavioral();
    void constructObject();
    void constructPorts();
    void reset();
    void architectureInstantiate(HSimConfigDecl* cfg);
    virtual void vhdlArchImplement();
    int ConvFunc0(HSim__s2 * drv, const char * src, int noOfBytes, const HSimConstraints * srcConstraints);
    int ConvFunc1(HSim__s2 * drv, const char * src, int noOfBytes, const HSimConstraints * srcConstraints);
};



HSim__s6 *createWork_mux_74hc153n_behavioral(const char *name);

#endif
