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

#ifndef H_Work_controller_behavioral_H
#define H_Work_controller_behavioral_H
#ifdef __MINGW32__
#include "xsimMinGW.h"
#else
#include "xsim.h"
#endif


class Work_controller_behavioral: public HSim__s6 {
public:

    HSim__s4 PE[2];
    HSim__s1 SE[7];

  HSimEnumType State_type;
    HSim__s1 SA[4];
  char t0;
    Work_controller_behavioral(const char * name);
    ~Work_controller_behavioral();
    void constructObject();
    void constructPorts();
    void reset();
    void architectureInstantiate(HSimConfigDecl* cfg);
    virtual void vhdlArchImplement();
    int ConvFunc0(HSim__s2 * drv, const char * src, int noOfBytes, const HSimConstraints * srcConstraints);
};



HSim__s6 *createWork_controller_behavioral(const char *name);

#endif
